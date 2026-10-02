import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/account_models.dart';
import 'mock_account_repository.dart';

part 'account_repository.g.dart';

abstract interface class AccountRepository {
  Future<UserProfile> profile();

  Future<UserProfile> updateProfile(UserProfile profile);

  /// Yerel fotoğrafı yükler; yeni adresi döner.
  Future<UserProfile> updateAvatar(String localPath);

  Future<SecuritySettings> security();

  Future<SecuritySettings> setBiometric(bool on);

  /// Geçerli şifre yanlışsa [PasswordChangeRejected] fırlatır.
  Future<SecuritySettings> changePassword(String current, String next);

  Future<SecuritySettings> signOutDevice(String deviceId);

  Future<NotificationPrefs> notificationPrefs();

  Future<NotificationPrefs> saveNotificationPrefs(NotificationPrefs prefs);

  Future<PrivacySettings> privacy();

  Future<PrivacySettings> savePrivacy(PrivacySettings settings);

  /// KVKK m.11 veri kopyası talebi; e-postaya gönderilir.
  Future<void> requestDataExport();

  Future<CloseAccountImpact> closeAccountImpact();

  Future<void> closeAccount(String password);

  Future<LegalDocument> legalDocument(LegalDoc doc);

  Future<List<FaqItem>> faq();

  Future<void> sendFeedback(String text);
}

@Riverpod(keepAlive: true)
AccountRepository accountRepository(Ref ref) => MockAccountRepository();
