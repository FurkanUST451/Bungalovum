import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_models.freezed.dart';

/// 66 · Bilgilerim. KVKK: e-posta/telefon ekranda maskeli gösterilir.
@freezed
abstract class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required String id,
    required String firstName,
    required String lastName,

    /// Ev sahiplerine görünen kısa ad ("Deniz"); boşsa ad kullanılır.
    String? displayName,
    required String email,

    /// 10 haneli TR cep numarası.
    String? phone,
    String? address,
    EmergencyContact? emergencyContact,

    /// Yerel dosya yolu ya da sunucu adresi.
    String? avatarUrl,
    required DateTime memberSince,
  }) = _UserProfile;

  String get fullName => '$firstName $lastName';
}

@freezed
abstract class EmergencyContact with _$EmergencyContact {
  const factory EmergencyContact({
    required String name,
    required String phone,
  }) = _EmergencyContact;
}

/// 65 · Hesabım istatistikleri.
@freezed
abstract class AccountStats with _$AccountStats {
  const factory AccountStats({
    required int stays,
    required int reviews,
    required int saved,
  }) = _AccountStats;
}

/// 67 · Oturum açık cihaz.
@freezed
abstract class Device with _$Device {
  const factory Device({
    required String id,

    /// "Android", "iPhone 15"
    required String name,
    required String city,
    required DateTime lastActive,
    @Default(false) bool current,
  }) = _Device;
}

@freezed
abstract class SecuritySettings with _$SecuritySettings {
  const factory SecuritySettings({
    @Default(false) bool biometric,
    required DateTime passwordUpdatedAt,
    @Default(<Device>[]) List<Device> devices,
  }) = _SecuritySettings;
}

/// 69 · Bildirim konuları.
enum NotifTopic { promotions, stayReminders, news, surveys, ruleUpdates }

enum NotifChannel { push, email, sms }

extension NotifTopicX on NotifTopic {
  /// Pazarlama izni (İYS) gerektiren konular; "Tümünü kapat" bunları kapatır.
  bool get isMarketing => switch (this) {
    NotifTopic.promotions || NotifTopic.news || NotifTopic.surveys => true,
    _ => false,
  };

  /// Açıldığında varsayılan kanallar.
  Set<NotifChannel> get defaultChannels => switch (this) {
    NotifTopic.promotions ||
    NotifTopic.stayReminders => {NotifChannel.push, NotifChannel.email},
    NotifTopic.news || NotifTopic.surveys => {NotifChannel.push},
    NotifTopic.ruleUpdates => {NotifChannel.email},
  };
}

@freezed
abstract class NotificationPrefs with _$NotificationPrefs {
  const NotificationPrefs._();

  const factory NotificationPrefs({
    @Default(<NotifTopic, Set<NotifChannel>>{})
    Map<NotifTopic, Set<NotifChannel>> topics,
  }) = _NotificationPrefs;

  Set<NotifChannel> channels(NotifTopic t) => topics[t] ?? const {};

  bool isOn(NotifTopic t) => channels(t).isNotEmpty;

  bool get anyMarketingOn =>
      NotifTopic.values.any((t) => t.isMarketing && isOn(t));
}

/// 70 · Gizlilik.
@freezed
abstract class PrivacySettings with _$PrivacySettings {
  const factory PrivacySettings({
    @Default(true) bool showProfileToHosts,
    @Default(true) bool showNameInReviews,
    @Default(false) bool locationAccess,
    @Default(true) bool personalizedRecs,
  }) = _PrivacySettings;
}

/// 68 · Hesap kapatılınca neler olacağı.
@freezed
abstract class CloseAccountImpact with _$CloseAccountImpact {
  const factory CloseAccountImpact({
    /// "Göl Esintisi · 6–8 Kas" — varsa hesap kapatılamaz.
    String? upcomingBooking,
    required int lists,
    required int savedListings,
  }) = _CloseAccountImpact;
}

enum CloseAccountError { wrongPassword, upcomingBooking }

class CloseAccountRejected implements Exception {
  const CloseAccountRejected(this.error);

  final CloseAccountError error;

  @override
  String toString() => 'CloseAccountRejected($error)';
}

enum PasswordChangeError { wrongCurrent, weak }

class PasswordChangeRejected implements Exception {
  const PasswordChangeRejected(this.error);

  final PasswordChangeError error;
}

/// 72 · Hukuki belgeler.
enum LegalDoc { terms, kvkk, privacy, cookies, distanceSales, cancellation }

@freezed
abstract class LegalDocument with _$LegalDocument {
  const factory LegalDocument({
    required LegalDoc doc,
    required DateTime updatedAt,

    /// Paragraflar; başlıklar "## " ile başlar.
    required List<String> paragraphs,
  }) = _LegalDocument;
}

/// 71 · Sık sorulanlar.
@freezed
abstract class FaqItem with _$FaqItem {
  const factory FaqItem({
    required String id,
    required String question,
    required String answer,
  }) = _FaqItem;
}

abstract final class AppInfo {
  static const version = '1.0.0';
  static const companyName = 'Bungalovum Seyahat';
}
