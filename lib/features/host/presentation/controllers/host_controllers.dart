import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../listing/domain/listing_detail.dart';
import '../../data/host_repository.dart';
import '../../domain/listing_draft.dart';

part 'host_controllers.g.dart';

/// Ev sahibinin taslağı / ilanı. Sihirbaz ekranları değişiklikleri önce
/// yerelde tutar ([edit]); adım değişince ya da "Kaydet ve çık"ta [save].
@Riverpod(keepAlive: true)
class HostDraft extends _$HostDraft {
  @override
  Future<ListingDraft?> build() {
    // Hesap değişince (çıkış/başka hesapla giriş) taslak yeniden okunur.
    ref.watch(authSessionProvider.select((u) => u?.id));
    return _repo.current();
  }

  /// Sunucudaki son hali okur (ör. inceleme sonucu, İlan Yönetimi açılınca).
  Future<void> refresh() async {
    final d = await _repo.current();
    if (ref.mounted) state = AsyncData(d);
  }

  HostRepository get _repo => ref.read(hostRepositoryProvider);

  ListingDraft get _value => state.requireValue!;

  void _set(ListingDraft d) {
    if (ref.mounted) state = AsyncData(d);
  }

  /// Taslak yoksa oluşturur.
  Future<ListingDraft> start() async {
    final existing = state.value;
    if (existing != null) return existing;
    final d = await _repo.start();
    _set(d);
    return d;
  }

  /// Yerel düzenleme (kaydetmez).
  void edit(ListingDraft Function(ListingDraft d) change) =>
      _set(change(_value));

  Future<void> save({WizardStep? resumeAt}) async {
    final d = resumeAt == null ? _value : _value.copyWith(resumeStep: resumeAt);
    _set(await _repo.save(d));
  }

  Future<void> addPhotos(RoomKind room, List<String> paths) async {
    for (final p in paths) {
      final photo = await _repo.uploadPhoto(room, p);
      edit(
        (d) => d.copyWith(
          photos: [...d.photos, photo],
          coverPhotoId: d.coverPhotoId ?? photo.id,
        ),
      );
    }
  }

  void removePhoto(String id) => edit(
    (d) => d.copyWith(
      photos: [
        for (final p in d.photos)
          if (p.id != id) p,
      ],
      coverPhotoId: d.coverPhotoId == id ? null : d.coverPhotoId,
    ),
  );

  void setCover(String id) => edit((d) => d.copyWith(coverPhotoId: id));

  /// Odadaki fotoğrafı bir öne/arkaya taşır (Sırala).
  void movePhoto(String id, int delta) => edit((d) {
    final list = [...d.photos];
    final i = list.indexWhere((p) => p.id == id);
    final room = list[i].room;
    var j = i + delta;
    while (j >= 0 && j < list.length && list[j].room != room) {
      j += delta;
    }
    if (j < 0 || j >= list.length) return d;
    final tmp = list[i];
    list[i] = list[j];
    list[j] = tmp;
    return d.copyWith(photos: list);
  });

  Future<void> uploadDocument(HostDocKind kind, String path) async {
    final doc = await _repo.uploadDocument(kind, path);
    edit((d) => d.copyWith(documents: {...d.documents, kind: doc}));
  }

  Future<void> verifyIdentity(IdentityStep step, String path) async {
    final server = await _repo.verifyIdentity(step, path);
    edit(
      (d) => d.copyWith(
        identityDone: server.identityDone,
        identityStatus: server.identityStatus,
        verifiedName: server.verifiedName,
        accountHolder: d.accountHolder.isEmpty && server.verifiedName != null
            ? server.verifiedName!
            : d.accountHolder,
      ),
    );
  }

  Future<void> submit() async {
    await _repo.save(_value);
    _set(await _repo.submitForReview());
  }

  Future<void> setPaused(bool paused) async =>
      _set(await _repo.setPaused(paused));

  Future<void> unpublish() async => _set(await _repo.unpublish());
}

/// 89 · Kazanç tahmini (oranlar backend'den).
@riverpod
Future<EarningsEstimate> hostEarnings(
  Ref ref, {
  required int nightly,
  required int cleaningFee,
  required String city,
}) => ref
    .watch(hostRepositoryProvider)
    .earnings(nightly: nightly, cleaningFee: cleaningFee, city: city);
