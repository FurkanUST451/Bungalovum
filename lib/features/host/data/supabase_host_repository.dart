import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/painting.dart' show decodeImageFromList;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Headers;

import '../../booking/domain/booking.dart' show IdValidators;
import '../../listing/domain/listing.dart';
import '../../listing/domain/listing_detail.dart';
import '../domain/listing_draft.dart';
import 'host_repository.dart';

/// 82–95 · Ev sahibi ilanı Supabase'te (§14).
///
/// - İlan alanları `listings` + `listing_private` tablolarına yazılır;
///   durum değişiklikleri (incelemeye gönder, durdur, yayından kaldır) RPC'dir.
/// - Fotoğraflar Cloudflare R2'ye imzalı adresle yüklenir (`r2-upload-url`),
///   kaldırılanlar `r2-delete-photo` ile silinir.
/// - Belge ve kimlik dosyaları Supabase Storage'ın gizli bucket'larına gider;
///   yüklenince cihazdaki geçici kopya silinir (KVKK).
/// - TCKN/VKN ve IBAN yalnızca RPC ile yazılır, geri maskeli okunur; düz hali
///   kaydedildikten sonra taslaktan silinir.
class SupabaseHostRepository implements HostRepository {
  SupabaseHostRepository(this._client, {Dio? http}) : _http = http ?? Dio();

  final SupabaseClient _client;
  final Dio _http;

  /// Son okunan/kaydedilen sunucu hali; fotoğraf ve hassas alan farkları
  /// buna göre bulunur.
  ListingDraft? _last;

  /// Hangi kullanıcının ilanı önbellekte (hesap değişirse sıfırlanır).
  String? _owner;

  /// Fotoğraf kimliği → sunucudaki sıra.
  final _positions = <String, int>{};

  /// Belge türü → Storage yolu (değiştirilince eskisi silinir).
  final _docPaths = <HostDocKind, String>{};

  /// Üçü tamamlanana kadar yüklenen kimlik fotoğrafları (yalnızca bellekte).
  final _identityPaths = <IdentityStep, String>{};

  static const _photoQuality = 85;
  static const _photoMaxSide = 2048;
  static const _jpeg = 'image/jpeg';

  // ---------------------------------------------------------------------------
  // Okuma
  // ---------------------------------------------------------------------------

  String _requireUser() {
    final user = _client.auth.currentUser;
    if (user == null) throw const HostFailure('auth_required');
    if (_owner != user.id) {
      _owner = user.id;
      _last = null;
      _positions.clear();
      _docPaths.clear();
      _identityPaths.clear();
    }
    return user.id;
  }

  String get _listingId {
    final id = _last?.id;
    if (id == null) throw const HostFailure('not_found');
    return id;
  }

  @override
  Future<ListingDraft?> current() => _guard(() async {
    if (_client.auth.currentUser == null) return null;
    final row = await _client
        .from('listings')
        .select()
        .eq('host_id', _requireUser())
        .order('created_at', ascending: false)
        .limit(1)
        .maybeSingle();
    if (row == null) return null;
    return _load(row);
  });

  @override
  Future<ListingDraft> start() => _guard(() async {
    final existing = await current();
    if (existing != null) return existing;
    _requireUser();
    final row = await _client
        .from('listings')
        .insert({'resume_step': 'type_and_location'})
        .select()
        .single();
    return _load(row);
  });

  Future<ListingDraft> _load(Map<String, dynamic> row) async {
    final id = row['id'] as String;
    final results = await Future.wait<dynamic>([
      _client
          .from('listing_private')
          .select()
          .eq('listing_id', id)
          .maybeSingle(),
      _client
          .from('listing_photos')
          .select('id, room, url, position')
          .eq('listing_id', id)
          .order('position'),
      _client
          .from('listing_documents')
          .select('id, kind, status, storage_path')
          .eq('listing_id', id),
      _client.rpc<dynamic>('get_host_account'),
    ]);
    final priv = results[0] as Map<String, dynamic>?;
    final photos = (results[1] as List).cast<Map<String, dynamic>>();
    final docs = (results[2] as List).cast<Map<String, dynamic>>();
    final account = results[3] as Map<String, dynamic>?;

    _positions
      ..clear()
      ..addAll({
        for (final p in photos)
          p['id'] as String: (p['position'] as num).toInt(),
      });
    _docPaths
      ..clear()
      ..addAll({
        for (final d in docs)
          _enum(HostDocKind.values, d['kind']): d['storage_path'] as String,
      });

    final draft = _toDraft(row, priv, photos, docs, account);
    // Yarım kalan kimlik adımları yalnızca bu oturumda bilinir.
    _last = draft.identityStatus == VerificationStatus.notStarted
        ? draft.copyWith(identityDone: _identityPaths.keys.toSet())
        : draft;
    return _last!;
  }

  // ---------------------------------------------------------------------------
  // Kaydetme
  // ---------------------------------------------------------------------------

  @override
  Future<ListingDraft> save(ListingDraft draft) => _guard(() async {
    _requireUser();
    final before = _last ?? draft;
    var next = draft;

    await _deleteRemovedPhotos(before, draft);
    await _savePhotoOrder(draft);
    next = await _saveSensitive(before, next);
    next = await _savePrivate(before, next);

    final row = await _client
        .from('listings')
        .update(_listingRow(next))
        .eq('id', next.id)
        .select()
        .single();
    next = _withServerState(next, row);
    return _last = next;
  });

  Future<void> _deleteRemovedPhotos(ListingDraft before, ListingDraft d) async {
    final keep = {for (final p in d.photos) p.id};
    for (final p in before.photos) {
      if (keep.contains(p.id)) continue;
      await _client.functions.invoke(
        'r2-delete-photo',
        body: {'photo_id': p.id},
      );
      _positions.remove(p.id);
    }
  }

  Future<void> _savePhotoOrder(ListingDraft d) async {
    for (final (i, p) in d.photos.indexed) {
      if (_positions[p.id] == i) continue;
      await _client
          .from('listing_photos')
          .update({'position': i})
          .eq('id', p.id);
      _positions[p.id] = i;
    }
  }

  /// Vergi, iletişim ve ödeme hesabı RPC'leri. Yarım yazılmış (geçersiz)
  /// TCKN/IBAN gönderilmez; adım "Devam"ı zaten geçerli değer ister.
  Future<ListingDraft> _saveSensitive(
    ListingDraft before,
    ListingDraft d,
  ) async {
    var next = d;

    final taxId = d.taxId.trim();
    if (taxId.isNotEmpty && _taxIdLooksValid(d.taxType, taxId)) {
      final masked = await _client.rpc<String>(
        'save_host_tax_id',
        params: {
          'p_tax_type': _snake(d.taxType.name),
          'p_tax_id': taxId,
          'p_tax_office': d.taxOffice.trim(),
        },
      );
      next = next.copyWith(taxId: '', taxIdMasked: masked);
    } else if (d.taxOffice.trim() != before.taxOffice.trim()) {
      await _client.rpc<void>(
        'save_host_tax_office',
        params: {'p_tax_office': d.taxOffice.trim()},
      );
    }

    final phone = d.emergencyPhone.replaceAll(RegExp(r'\D'), '');
    final contactChanged =
        d.billingAddress.trim() != before.billingAddress.trim() ||
        phone != before.emergencyPhone.replaceAll(RegExp(r'\D'), '') ||
        d.reachableDuringStay != before.reachableDuringStay;
    if (contactChanged && (phone.isEmpty || _trMobile.hasMatch(phone))) {
      await _client.rpc<void>(
        'save_host_contact',
        params: {
          'p_billing_address': d.billingAddress.trim(),
          'p_emergency_phone': phone,
          'p_reachable_during_stay': d.reachableDuringStay,
        },
      );
    }

    final holder = d.accountHolder.trim();
    if (d.iban.isNotEmpty &&
        IbanValidator.isValidTr(d.iban) &&
        holder.isNotEmpty) {
      final masked = await _client.rpc<String>(
        'set_payout_account',
        params: {'p_account_holder': holder, 'p_iban': d.iban},
      );
      next = next.copyWith(iban: '', ibanMasked: masked);
    } else if (d.iban.isEmpty &&
        d.ibanMasked != null &&
        holder.isNotEmpty &&
        holder != before.accountHolder.trim()) {
      // Hesap sahibi IBAN olmadan değiştirilemez (RPC ikisini birlikte ister).
      throw const HostFailure('iban_required');
    }
    return next;
  }

  /// Adresten otomatik konum şimdilik kapalı: adres olduğu gibi kaydedilir,
  /// konum boş kalır. Açınca `geocode-address` fonksiyonunun yüklü olması ve
  /// `private.listing_missing_steps`'te konum şartının geri gelmesi gerekir.
  static const _geocodeEnabled = false;

  /// Adres, giriş bilgileri ve ev kılavuzu. Adres değişince konum yeniden
  /// bulunur (adresten otomatik konum).
  Future<ListingDraft> _savePrivate(ListingDraft before, ListingDraft d) async {
    var next = d;
    final addressChanged =
        d.address.trim() != before.address.trim() ||
        d.city.trim() != before.city.trim() ||
        d.district.trim() != before.district.trim();
    final canLocate = d.city.trim().isNotEmpty && d.district.trim().isNotEmpty;
    if (_geocodeEnabled &&
        canLocate &&
        (addressChanged || d.latitude == null)) {
      final at = await _geocode(d);
      next = next.copyWith(latitude: at?.$1, longitude: at?.$2);
      if (at == null && d.address.trim().isNotEmpty) {
        throw const HostFailure('address_not_found');
      }
    }

    await _client
        .from('listing_private')
        .update({
          'address': next.address.trim(),
          'latitude': next.latitude,
          'longitude': next.longitude,
          'lockbox_code': next.lockboxCode.trim(),
          'lockbox_hint': next.lockboxHint.trim(),
          'wifi_name': next.wifiName.trim(),
          'wifi_password': next.wifiPassword,
          'pool_instructions': next.poolInstructions.trim(),
          'house_instructions': next.houseInstructions.trim(),
          'checkout_tasks': next.checkoutTasks,
        })
        .eq('listing_id', next.id);
    return next;
  }

  /// (enlem, boylam); bulunamazsa null.
  Future<(double, double)?> _geocode(ListingDraft d) async {
    try {
      final res = await _client.functions.invoke(
        'geocode-address',
        body: {
          'address': d.address.trim(),
          'district': d.district.trim(),
          'city': d.city.trim(),
        },
      );
      final data = res.data as Map<String, dynamic>;
      return (
        (data['latitude'] as num).toDouble(),
        (data['longitude'] as num).toDouble(),
      );
    } on FunctionException catch (e) {
      if (e.status == HttpStatus.notFound) return null;
      rethrow;
    }
  }

  Map<String, dynamic> _listingRow(ListingDraft d) => {
    'resume_step': _snake(d.resumeStep.name),
    // 1 · Tür ve konum. İlçe aynı zamanda arama bölgesidir ("Sapanca").
    'property_type': d.propertyType == null
        ? null
        : _snake(d.propertyType!.name),
    'settings': [for (final s in d.settings) _snake(s.name)],
    'region': d.district.trim(),
    'city': d.city.trim(),
    'district': d.district.trim(),
    // 2 · Temel bilgiler
    'max_guests': d.maxGuests,
    'bedrooms': d.bedrooms,
    'beds': d.beds,
    'bathrooms': d.bathrooms,
    'bed_types': [
      for (final b in d.bedTypes)
        {'type': _snake(b.type.name), 'count': b.count},
    ],
    'indoor_m2': d.indoorM2,
    'garden_m2': d.gardenM2,
    'whole_place': d.wholePlace,
    // 3 · Havuz ve olanaklar
    'has_pool': d.hasPool,
    'pool_private': d.poolPrivate,
    'pool_heated': d.poolHeated,
    'pool_temp_c': d.poolTempC,
    'pool_width_m': d.poolWidthM,
    'pool_length_m': d.poolLengthM,
    'pool_depth_min_m': d.poolDepthMinM,
    'pool_depth_max_m': d.poolDepthMaxM,
    'pool_season_start': d.poolSeasonStart,
    'pool_season_end': d.poolSeasonEnd,
    'amenities': [for (final a in d.amenities) _snake(a.name)],
    // 4 · Kapak (yoksa ilk fotoğraf)
    'cover_photo_id': d.cover?.id,
    // 5 · Başlık ve açıklama
    'title': d.title.trim(),
    'highlights': [for (final h in d.highlights) _snake(h.name)],
    'space': d.space.trim(),
    'guest_access': d.guestAccess.trim(),
    'other_notes': d.otherNotes.trim(),
    // 6 · Güvenlik ve kurallar
    'safety': [for (final s in d.safety) _snake(s.name)],
    'outdoor_camera_note': d.outdoorCameraNote.trim(),
    'pool_no_lifeguard_ack': d.poolNoLifeguardAck,
    'pool_depth_marked': d.poolDepthMarked,
    'check_in_from': d.checkInFrom,
    'check_out_by': d.checkOutBy,
    'pets_allowed': d.petsAllowed,
    'smoking_allowed': d.smokingAllowed,
    'events_allowed': d.eventsAllowed,
    'quiet_hours': d.quietHours,
    'quiet_from': d.quietFrom,
    'quiet_to': d.quietTo,
    // 7 · Fiyat ve rezervasyon (0 = belirlenmedi)
    'nightly_price': _positiveOrNull(d.nightlyPrice),
    'weekend_price': _positiveOrNull(d.weekendPrice),
    'cleaning_fee': d.cleaningFee,
    'weekly_discount_percent': d.weeklyDiscountPercent,
    'min_nights': d.minNights,
    'instant_book': d.instantBook,
    'cancellation_policy': _snake(d.cancellation.name),
    // 8 · Giriş
    'self_check_in': _snake(d.checkInMethod.name),
    // 9 · Yasal
    'permit_type': d.permitType == null ? null : _snake(d.permitType!.name),
    'permit_no': d.permitNo.trim(),
    'multi_unit_parcel': d.multiUnitParcel,
    'on_behalf_of_owner': d.onBehalfOfOwner,
    'kbs_declaration': d.kbsDeclaration,
    'permit_holder_declaration': d.permitHolderDeclaration,
    'update_declaration': d.updateDeclaration,
    // 93 · Onaylar
    'accuracy_consent': d.accuracyConsent,
    'agreement_consent': d.agreementConsent,
    'ministry_consent': d.ministryConsent,
  };

  /// Yalnızca sunucunun değiştirdiği alanlar (durum, inceleme bölümleri).
  ListingDraft _withServerState(ListingDraft d, Map<String, dynamic> row) =>
      d.copyWith(
        status: _enum(ListingStatus.values, row['status']),
        sectionsInReview: _enumSet(
          WizardStep.values,
          row['sections_in_review'],
        ),
        submittedAt: _date(row['submitted_at']),
        reviewNote: row['review_note'] as String?,
      );

  // ---------------------------------------------------------------------------
  // Dosyalar
  // ---------------------------------------------------------------------------

  @override
  Future<DraftPhoto> uploadPhoto(RoomKind room, String localPath) =>
      _guard(() async {
        _requireUser();
        final listingId = _listingId;
        final bytes = await FlutterImageCompress.compressWithFile(
          localPath,
          minWidth: _photoMaxSide,
          minHeight: _photoMaxSide,
          quality: _photoQuality,
        );
        if (bytes == null) throw const HostFailure('unsupported_type');
        final image = await decodeImageFromList(bytes);

        final res = await _client.functions.invoke(
          'r2-upload-url',
          body: {
            'purpose': 'listing_photo',
            'listing_id': listingId,
            'content_type': _jpeg,
            'size': bytes.length,
          },
        );
        final signed = res.data as Map<String, dynamic>;
        await _http.put<void>(
          signed['upload_url'] as String,
          data: Stream<List<int>>.value(bytes),
          options: Options(
            headers: {
              Headers.contentTypeHeader: _jpeg,
              Headers.contentLengthHeader: bytes.length,
            },
          ),
        );

        final position = _positions.length;
        final row = await _client
            .from('listing_photos')
            .insert({
              'listing_id': listingId,
              'room': _snake(room.name),
              'storage_key': signed['key'],
              'url': signed['public_url'],
              'width': image.width,
              'height': image.height,
              'position': position,
            })
            .select('id')
            .single();
        image.dispose();
        final id = row['id'] as String;
        _positions[id] = position;
        final photo = DraftPhoto(
          id: id,
          room: room,
          url: signed['public_url'] as String,
        );
        _last = _last?.copyWith(photos: [..._last!.photos, photo]);
        return photo;
      });

  @override
  Future<HostDocument> uploadDocument(HostDocKind kind, String localPath) =>
      _guard(() async {
        final uid = _requireUser();
        final listingId = _listingId;
        final ext = _extension(localPath);
        final path = '$uid/$listingId/${_snake(kind.name)}-${_random()}.$ext';
        await _uploadPrivate('host-documents', path, localPath, ext);

        final row = await _client
            .from('listing_documents')
            .upsert({
              'listing_id': listingId,
              'kind': _snake(kind.name),
              'storage_path': path,
            }, onConflict: 'listing_id,kind')
            .select('id, status')
            .single();

        final old = _docPaths[kind];
        _docPaths[kind] = path;
        if (old != null && old != path) {
          await _client.storage
              .from('host-documents')
              .remove([old])
              .catchError((_) => <FileObject>[]);
        }
        final doc = HostDocument(
          id: row['id'] as String,
          status: _enum(DocStatus.values, row['status']),
        );
        _last = _last?.copyWith(documents: {..._last!.documents, kind: doc});
        return doc;
      });

  @override
  Future<ListingDraft> verifyIdentity(
    IdentityStep step,
    String localPath,
  ) => _guard(() async {
    final uid = _requireUser();
    final ext = _extension(localPath);
    final name = switch (step) {
      IdentityStep.idFront => 'front',
      IdentityStep.idBack => 'back',
      IdentityStep.selfie => 'selfie',
    };
    final path = '$uid/$name-${_random()}.$ext';
    await _uploadPrivate('identity-documents', path, localPath, ext);
    _identityPaths[step] = path;

    final base = _last ?? ListingDraft(id: _listingId);
    if (_identityPaths.length < IdentityStep.values.length) {
      return _last = base.copyWith(identityDone: _identityPaths.keys.toSet());
    }

    await _client.rpc<void>(
      'submit_identity_documents',
      params: {
        'p_front_path': _identityPaths[IdentityStep.idFront],
        'p_back_path': _identityPaths[IdentityStep.idBack],
        'p_selfie_path': _identityPaths[IdentityStep.selfie],
      },
    );
    _identityPaths.clear();
    final account =
        await _client.rpc<dynamic>('get_host_account') as Map<String, dynamic>?;
    return _last = base.copyWith(
      identityDone: IdentityStep.values.toSet(),
      identityStatus: _enum(
        VerificationStatus.values,
        account?['identity_status'] ?? 'pending',
      ),
      verifiedName: account?['verified_name'] as String?,
    );
  });

  /// Gizli bucket'a yükler, ardından cihazdaki geçici kopyayı siler (KVKK).
  Future<void> _uploadPrivate(
    String bucket,
    String path,
    String localPath,
    String ext,
  ) async {
    final file = File(localPath);
    try {
      final Uint8List bytes = await file.readAsBytes();
      await _client.storage
          .from(bucket)
          .uploadBinary(
            path,
            bytes,
            fileOptions: FileOptions(contentType: _mime(ext)),
          );
    } finally {
      unawaited(file.delete().then<void>((_) {}, onError: (_) {}));
    }
  }

  // ---------------------------------------------------------------------------
  // Fiyat ve durum
  // ---------------------------------------------------------------------------

  @override
  Future<EarningsEstimate> earnings({
    required int nightly,
    required int cleaningFee,
    required String city,
  }) => _guard(() async {
    final r =
        await _client.rpc<dynamic>(
              'estimate_host_earnings',
              params: {
                'p_nightly': nightly,
                'p_cleaning_fee': cleaningFee,
                'p_region': city.trim().isEmpty ? null : city.trim(),
              },
            )
            as Map<String, dynamic>;
    int n(String k) => (r[k] as num).toInt();
    int? nn(String k) => (r[k] as num?)?.toInt();
    return EarningsEstimate(
      nights: n('nights'),
      nightly: n('nightly'),
      stayTotal: n('stay_total'),
      cleaningFee: n('cleaning_fee'),
      serviceFee: n('service_fee'),
      hostEarns: n('host_earns'),
      similarMin: nn('similar_min'),
      similarMax: nn('similar_max'),
    );
  });

  @override
  Future<ListingDraft> submitForReview() =>
      _statusRpc('submit_listing_for_review', {});

  @override
  Future<ListingDraft> setPaused(bool paused) =>
      _statusRpc('set_listing_paused', {'p_paused': paused});

  @override
  Future<ListingDraft> unpublish() => _statusRpc('unpublish_listing', {});

  Future<ListingDraft> _statusRpc(String fn, Map<String, dynamic> params) =>
      _guard(() async {
        _requireUser();
        final row =
            await _client.rpc<dynamic>(
                  fn,
                  params: {'p_listing': _listingId, ...params},
                )
                as Map<String, dynamic>;
        return _last = _withServerState(_last!, row);
      });

  // ---------------------------------------------------------------------------
  // Yardımcılar
  // ---------------------------------------------------------------------------

  /// Backend hatalarını [HostFailure]'a çevirir.
  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on HostFailure {
      rethrow;
    } on PostgrestException catch (e) {
      // RPC hataları (P0001) ve korunan kolon (42501) sabit koddur.
      if (e.code == 'P0001' || e.code == '42501') {
        throw HostFailure(e.message, e.details?.toString());
      }
      if (e.code == 'PGRST301' || e.code == '401') {
        throw const HostFailure('auth_required');
      }
      rethrow;
    } on FunctionException catch (e) {
      final details = e.details;
      final code = details is Map ? details['error'] as String? : null;
      throw HostFailure(code ?? 'function_error');
    } on StorageException catch (e) {
      throw HostFailure('storage_error', e.message);
    } on AuthException {
      throw const HostFailure('auth_required');
    }
  }

  ListingDraft _toDraft(
    Map<String, dynamic> row,
    Map<String, dynamic>? priv,
    List<Map<String, dynamic>> photos,
    List<Map<String, dynamic>> docs,
    Map<String, dynamic>? account,
  ) {
    final identity = _enum(
      VerificationStatus.values,
      account?['identity_status'] ?? 'not_started',
    );
    final identitySent =
        identity == VerificationStatus.pending ||
        identity == VerificationStatus.approved;
    return ListingDraft(
      id: row['id'] as String,
      status: _enum(ListingStatus.values, row['status']),
      resumeStep: _enum(WizardStep.values, row['resume_step']),
      submittedAt: _date(row['submitted_at']),
      sectionsInReview: _enumSet(WizardStep.values, row['sections_in_review']),
      reviewNote: row['review_note'] as String?,
      // 1
      propertyType: _enumOrNull(PropertyType.values, row['property_type']),
      settings: _enumSet(ListingSetting.values, row['settings']),
      address: priv?['address'] as String? ?? '',
      city: row['city'] as String,
      district: row['district'] as String,
      latitude: (priv?['latitude'] as num?)?.toDouble(),
      longitude: (priv?['longitude'] as num?)?.toDouble(),
      // 2
      maxGuests: row['max_guests'] as int,
      bedrooms: row['bedrooms'] as int,
      beds: row['beds'] as int,
      bathrooms: row['bathrooms'] as int,
      bedTypes: [
        for (final b in (row['bed_types'] as List).cast<Map<String, dynamic>>())
          BedCount(
            type: _enum(BedType.values, b['type']),
            count: (b['count'] as num).toInt(),
          ),
      ],
      indoorM2: row['indoor_m2'] as int?,
      gardenM2: row['garden_m2'] as int?,
      wholePlace: row['whole_place'] as bool,
      // 3
      hasPool: row['has_pool'] as bool,
      poolPrivate: row['pool_private'] as bool,
      poolHeated: row['pool_heated'] as bool,
      poolTempC: row['pool_temp_c'] as int?,
      poolWidthM: (row['pool_width_m'] as num?)?.toDouble(),
      poolLengthM: (row['pool_length_m'] as num?)?.toDouble(),
      poolDepthMinM: (row['pool_depth_min_m'] as num?)?.toDouble(),
      poolDepthMaxM: (row['pool_depth_max_m'] as num?)?.toDouble(),
      poolSeasonStart: row['pool_season_start'] as int?,
      poolSeasonEnd: row['pool_season_end'] as int?,
      amenities: _enumSet(AmenityKind.values, row['amenities']),
      // 4
      photos: [
        for (final p in photos)
          DraftPhoto(
            id: p['id'] as String,
            room: _enum(RoomKind.values, p['room']),
            url: p['url'] as String,
          ),
      ],
      coverPhotoId: row['cover_photo_id'] as String?,
      // 5
      title: row['title'] as String,
      highlights: _enumSet(HighlightTag.values, row['highlights']),
      space: row['space'] as String,
      guestAccess: row['guest_access'] as String,
      otherNotes: row['other_notes'] as String,
      // 6
      safety: _enumSet(SafetyKind.values, row['safety']),
      outdoorCameraNote: row['outdoor_camera_note'] as String,
      poolNoLifeguardAck: row['pool_no_lifeguard_ack'] as bool,
      poolDepthMarked: row['pool_depth_marked'] as bool,
      checkInFrom: _hhmm(row['check_in_from']),
      checkOutBy: _hhmm(row['check_out_by']),
      petsAllowed: row['pets_allowed'] as bool,
      smokingAllowed: row['smoking_allowed'] as bool,
      eventsAllowed: row['events_allowed'] as bool,
      quietHours: row['quiet_hours'] as bool,
      quietFrom: _hhmm(row['quiet_from']),
      quietTo: _hhmm(row['quiet_to']),
      // 7
      nightlyPrice: row['nightly_price'] as int?,
      weekendPrice: row['weekend_price'] as int?,
      cleaningFee: row['cleaning_fee'] as int,
      weeklyDiscountPercent: row['weekly_discount_percent'] as int,
      minNights: row['min_nights'] as int,
      instantBook: row['instant_book'] as bool,
      cancellation: _enum(
        CancellationPolicy.values,
        row['cancellation_policy'],
      ),
      // 8
      checkInMethod: _enum(SelfCheckIn.values, row['self_check_in']),
      lockboxCode: priv?['lockbox_code'] as String? ?? '',
      lockboxHint: priv?['lockbox_hint'] as String? ?? '',
      wifiName: priv?['wifi_name'] as String? ?? '',
      wifiPassword: priv?['wifi_password'] as String? ?? '',
      poolInstructions: priv?['pool_instructions'] as String? ?? '',
      houseInstructions: priv?['house_instructions'] as String? ?? '',
      checkoutTasks: [
        for (final t in (priv?['checkout_tasks'] as List?) ?? const []) '$t',
      ],
      // 9
      permitType: _enumOrNull(PermitType.values, row['permit_type']),
      permitNo: row['permit_no'] as String,
      documents: {
        for (final d in docs)
          _enum(HostDocKind.values, d['kind']): HostDocument(
            id: d['id'] as String,
            status: _enum(DocStatus.values, d['status']),
          ),
      },
      multiUnitParcel: row['multi_unit_parcel'] as bool,
      onBehalfOfOwner: row['on_behalf_of_owner'] as bool,
      kbsDeclaration: row['kbs_declaration'] as bool,
      permitHolderDeclaration: row['permit_holder_declaration'] as bool,
      updateDeclaration: row['update_declaration'] as bool,
      taxType: _enum(TaxType.values, account?['tax_type'] ?? 'individual'),
      taxIdMasked: account?['tax_id_masked'] as String?,
      taxOffice: account?['tax_office'] as String? ?? '',
      // 10
      identityStatus: identity,
      identityDone: identitySent ? IdentityStep.values.toSet() : const {},
      verifiedName: account?['verified_name'] as String?,
      accountHolder: account?['account_holder'] as String? ?? '',
      ibanMasked: account?['iban_masked'] as String?,
      billingAddress: account?['billing_address'] as String? ?? '',
      emergencyPhone: account?['emergency_phone'] as String? ?? '',
      reachableDuringStay: account?['reachable_during_stay'] as bool? ?? true,
      // 93
      accuracyConsent: row['accuracy_consent'] as bool,
      agreementConsent: row['agreement_consent'] as bool,
      ministryConsent: row['ministry_consent'] as bool,
    );
  }

  static final _trMobile = RegExp(r'^5\d{9}$');

  static bool _taxIdLooksValid(TaxType type, String v) => switch (type) {
    TaxType.individual => IdValidators.isTckn(v),
    TaxType.company => RegExp(r'^\d{10}$').hasMatch(v),
  };

  static int? _positiveOrNull(int? v) => v == null || v <= 0 ? null : v;

  /// Dart `camelCase` ↔ veritabanı `snake_case` (§14).
  static String _snake(String camel) =>
      camel.replaceAllMapped(RegExp('[A-Z]'), (m) => '_${m[0]!.toLowerCase()}');

  static T _enum<T extends Enum>(List<T> values, Object? db) =>
      values.firstWhere((v) => _snake(v.name) == db);

  static T? _enumOrNull<T extends Enum>(List<T> values, Object? db) =>
      db == null ? null : _enum(values, db);

  static Set<T> _enumSet<T extends Enum>(List<T> values, Object? db) => {
    for (final s in (db as List?) ?? const []) _enum(values, s),
  };

  static DateTime? _date(Object? v) =>
      v == null ? null : DateTime.parse(v as String).toLocal();

  /// "14:00:00" → "14:00"
  static String _hhmm(Object? v) => (v as String).substring(0, 5);

  static String _extension(String path) {
    final dot = path.lastIndexOf('.');
    final ext = dot < 0 ? '' : path.substring(dot + 1).toLowerCase();
    return ext == 'jpeg' ? 'jpg' : ext;
  }

  static String _mime(String ext) => switch (ext) {
    'png' => 'image/png',
    'webp' => 'image/webp',
    'heic' => 'image/heic',
    'pdf' => 'application/pdf',
    _ => _jpeg,
  };

  static final _rng = Random.secure();

  /// Dosya adı için tahmin edilemez kısa kimlik.
  static String _random() => [
    for (var i = 0; i < 12; i++)
      _rng.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ].join();
}
