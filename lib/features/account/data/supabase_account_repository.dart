import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/account_models.dart';
import 'account_repository.dart';

/// Profil, avatar, bildirim ve gizlilik tercihleri Supabase'ten gelir.
/// Backend karşılığı henüz olmayan işler (cihaz listesi, SSS, hukuki metinler,
/// hesap kapatma…) [_fallback]'e devredilir; karşılıkları bağlandıkça buradan
/// çıkarılır.
class SupabaseAccountRepository implements AccountRepository {
  SupabaseAccountRepository(this._client, this._fallback);

  final SupabaseClient _client;
  final AccountRepository _fallback;

  /// Konum izni cihaz ayarıdır, veritabanında tutulmaz.
  bool _locationAccess = false;

  String get _uid {
    final user = _client.auth.currentUser;
    if (user == null) throw StateError('Oturum açık değil.');
    return user.id;
  }

  // ---------------------------------------------------------------------------
  // Profil
  // ---------------------------------------------------------------------------

  @override
  Future<UserProfile> profile() async {
    final uid = _uid;
    final rows = await Future.wait([
      _client.from('profiles').select().eq('id', uid).single(),
      _client.from('account_details').select().eq('user_id', uid).single(),
    ]);
    return _toProfile(rows[0], rows[1]);
  }

  @override
  Future<UserProfile> updateProfile(UserProfile profile) async {
    final uid = _uid;
    final display = profile.displayName?.trim();
    await _client
        .from('profiles')
        .update({
          'first_name': profile.firstName.trim(),
          'display_name': display == null || display.isEmpty ? null : display,
        })
        .eq('id', uid);
    final emergency = profile.emergencyContact;
    await _client
        .from('account_details')
        .update({
          'last_name': profile.lastName.trim(),
          'phone': _trPhone(profile.phone),
          'address': _blankToNull(profile.address),
          'emergency_contact_name': _blankToNull(emergency?.name),
          'emergency_contact_phone': _trPhone(emergency?.phone),
        })
        .eq('user_id', uid);
    // E-posta değişimi yeniden doğrulama ister (CLAUDE.md §9); burada
    // değiştirilmez, kayıtlı adres geri döner.
    return this.profile();
  }

  @override
  Future<UserProfile> updateAvatar(String localPath) async {
    final uid = _uid;
    final bytes = await _compressAvatar(localPath);
    final path = '$uid/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final storage = _client.storage.from('avatars');
    await storage.uploadBinary(
      path,
      bytes,
      fileOptions: const FileOptions(contentType: 'image/jpeg'),
    );
    await _client
        .from('profiles')
        .update({'avatar_url': storage.getPublicUrl(path)})
        .eq('id', uid);
    return profile();
  }

  /// En fazla 512 px, JPEG: avatar küçük kalsın (ücretsiz depolama).
  Future<Uint8List> _compressAvatar(String localPath) async {
    final compressed = await FlutterImageCompress.compressWithFile(
      localPath,
      minWidth: 512,
      minHeight: 512,
      quality: 80,
      format: CompressFormat.jpeg,
    );
    return compressed ?? await File(localPath).readAsBytes();
  }

  UserProfile _toProfile(Map<String, dynamic> p, Map<String, dynamic> d) {
    final emergencyName = d['emergency_contact_name'] as String?;
    final emergencyPhone = d['emergency_contact_phone'] as String?;
    final display = p['display_name'] as String?;
    return UserProfile(
      id: p['id'] as String,
      firstName: (p['first_name'] as String?) ?? '',
      lastName: (d['last_name'] as String?) ?? '',
      displayName: display == null || display.isEmpty ? null : display,
      email: _client.auth.currentUser?.email ?? '',
      phone: d['phone'] as String?,
      address: d['address'] as String?,
      emergencyContact:
          emergencyName == null || emergencyPhone == null
          ? null
          : EmergencyContact(name: emergencyName, phone: emergencyPhone),
      avatarUrl: p['avatar_url'] as String?,
      memberSince: DateTime.parse(p['created_at'] as String).toLocal(),
    );
  }

  /// "0532 111 22 33" / "+90 532…" → "5321112233"; geçersizse null.
  static String? _trPhone(String? input) {
    if (input == null) return null;
    var digits = input.replaceAll(RegExp('[^0-9]'), '');
    if (digits.length > 10) digits = digits.substring(digits.length - 10);
    return RegExp('^5[0-9]{9}\$').hasMatch(digits) ? digits : null;
  }

  static String? _blankToNull(String? s) {
    final t = s?.trim();
    return t == null || t.isEmpty ? null : t;
  }

  // ---------------------------------------------------------------------------
  // Bildirim ve gizlilik tercihleri (user_settings)
  // ---------------------------------------------------------------------------

  static const _topicKeys = {
    NotifTopic.promotions: 'promotions',
    NotifTopic.stayReminders: 'stay_reminders',
    NotifTopic.news: 'news',
    NotifTopic.surveys: 'surveys',
    NotifTopic.ruleUpdates: 'rule_updates',
  };

  @override
  Future<NotificationPrefs> notificationPrefs() async {
    final row = await _client
        .from('user_settings')
        .select('notification_prefs')
        .eq('user_id', _uid)
        .single();
    return _toPrefs(row['notification_prefs'] as Map<String, dynamic>);
  }

  @override
  Future<NotificationPrefs> saveNotificationPrefs(
    NotificationPrefs prefs,
  ) async {
    final json = {
      for (final topic in NotifTopic.values)
        _topicKeys[topic]!: [
          for (final c in NotifChannel.values)
            if (prefs.channels(topic).contains(c)) c.name,
        ],
    };
    await _client
        .from('user_settings')
        .update({'notification_prefs': json})
        .eq('user_id', _uid);
    return notificationPrefs();
  }

  NotificationPrefs _toPrefs(Map<String, dynamic> json) => NotificationPrefs(
    topics: {
      for (final topic in NotifTopic.values)
        topic: {
          for (final name in (json[_topicKeys[topic]] as List? ?? const []))
            ...NotifChannel.values.where((c) => c.name == name),
        },
    },
  );

  @override
  Future<PrivacySettings> privacy() async {
    final row = await _client
        .from('user_settings')
        .select('show_profile_to_hosts, show_name_in_reviews, personalized_recs')
        .eq('user_id', _uid)
        .single();
    return PrivacySettings(
      showProfileToHosts: row['show_profile_to_hosts'] as bool,
      showNameInReviews: row['show_name_in_reviews'] as bool,
      personalizedRecs: row['personalized_recs'] as bool,
      locationAccess: _locationAccess,
    );
  }

  @override
  Future<PrivacySettings> savePrivacy(PrivacySettings settings) async {
    _locationAccess = settings.locationAccess;
    await _client
        .from('user_settings')
        .update({
          'show_profile_to_hosts': settings.showProfileToHosts,
          'show_name_in_reviews': settings.showNameInReviews,
          'personalized_recs': settings.personalizedRecs,
        })
        .eq('user_id', _uid);
    return privacy();
  }

  // ---------------------------------------------------------------------------
  // Henüz backend'e bağlanmayanlar
  // ---------------------------------------------------------------------------

  @override
  Future<SecuritySettings> security() => _fallback.security();

  @override
  Future<SecuritySettings> setBiometric(bool on) => _fallback.setBiometric(on);

  @override
  Future<SecuritySettings> changePassword(String current, String next) =>
      _fallback.changePassword(current, next);

  @override
  Future<SecuritySettings> signOutDevice(String deviceId) =>
      _fallback.signOutDevice(deviceId);

  @override
  Future<void> requestDataExport() => _fallback.requestDataExport();

  @override
  Future<CloseAccountImpact> closeAccountImpact() =>
      _fallback.closeAccountImpact();

  @override
  Future<void> closeAccount(String password) => _fallback.closeAccount(password);

  @override
  Future<LegalDocument> legalDocument(LegalDoc doc) =>
      _fallback.legalDocument(doc);

  @override
  Future<List<FaqItem>> faq() => _fallback.faq();

  @override
  Future<void> sendFeedback(String text) => _fallback.sendFeedback(text);
}
