import '../domain/account_models.dart';
import 'account_repository.dart';

/// Sahte hesap verisi (Figma 65–72 içeriği). Hukuki metinler gerçekte
/// backend/CMS'ten gelir; buradakiler yalnızca yer tutucudur.
class MockAccountRepository implements AccountRepository {
  MockAccountRepository({
    this.latency = const Duration(milliseconds: 250),
    DateTime Function()? clock,
    this.hasUpcomingBooking = true,
  }) : _clock = clock ?? DateTime.now;

  final Duration latency;
  final DateTime Function() _clock;

  /// Yaklaşan rezervasyon varken hesap kapatılamaz.
  final bool hasUpcomingBooking;

  /// Mock'ta doğru kabul edilen geçerli şifre.
  static const samplePassword = 'bungalovum2026';

  Future<void> _wait() => Future<void>.delayed(latency);

  late UserProfile _profile = UserProfile(
    id: 'u1',
    firstName: 'Deniz',
    lastName: 'Yılmaz',
    email: 'deniz@gmail.com',
    memberSince: DateTime(2024, 3, 1),
  );

  late SecuritySettings _security = SecuritySettings(
    passwordUpdatedAt: _clock().subtract(const Duration(hours: 2)),
    devices: [
      Device(
        id: 'd1',
        name: 'Android',
        city: 'İstanbul',
        lastActive: _clock().subtract(const Duration(minutes: 3)),
        current: true,
      ),
      Device(
        id: 'd2',
        name: 'iPad',
        city: 'Sakarya',
        lastActive: _clock().subtract(const Duration(days: 12)),
      ),
    ],
  );

  NotificationPrefs _prefs = NotificationPrefs(
    topics: {
      NotifTopic.promotions: {NotifChannel.push, NotifChannel.email},
      NotifTopic.stayReminders: {NotifChannel.push, NotifChannel.email},
      NotifTopic.news: {NotifChannel.push},
      NotifTopic.surveys: const {},
      NotifTopic.ruleUpdates: {NotifChannel.email},
    },
  );

  PrivacySettings _privacy = const PrivacySettings();

  @override
  Future<UserProfile> profile() async {
    await _wait();
    return _profile;
  }

  @override
  Future<UserProfile> updateProfile(UserProfile profile) async {
    await _wait();
    return _profile = profile;
  }

  @override
  Future<UserProfile> updateAvatar(String localPath) async {
    await _wait();
    return _profile = _profile.copyWith(avatarUrl: localPath);
  }

  @override
  Future<SecuritySettings> security() async {
    await _wait();
    return _security;
  }

  @override
  Future<SecuritySettings> setBiometric(bool on) async {
    await _wait();
    return _security = _security.copyWith(biometric: on);
  }

  @override
  Future<SecuritySettings> changePassword(String current, String next) async {
    await _wait();
    if (current != samplePassword) {
      throw const PasswordChangeRejected(PasswordChangeError.wrongCurrent);
    }
    return _security = _security.copyWith(passwordUpdatedAt: _clock());
  }

  @override
  Future<SecuritySettings> signOutDevice(String deviceId) async {
    await _wait();
    return _security = _security.copyWith(
      devices: [
        for (final d in _security.devices)
          if (d.id != deviceId) d,
      ],
    );
  }

  @override
  Future<NotificationPrefs> notificationPrefs() async {
    await _wait();
    return _prefs;
  }

  @override
  Future<NotificationPrefs> saveNotificationPrefs(NotificationPrefs p) async {
    await _wait();
    return _prefs = p;
  }

  @override
  Future<PrivacySettings> privacy() async {
    await _wait();
    return _privacy;
  }

  @override
  Future<PrivacySettings> savePrivacy(PrivacySettings s) async {
    await _wait();
    return _privacy = s;
  }

  @override
  Future<void> requestDataExport() => _wait();

  @override
  Future<CloseAccountImpact> closeAccountImpact() async {
    await _wait();
    return CloseAccountImpact(
      upcomingBooking: hasUpcomingBooking ? 'Göl Esintisi · 6–8 Kas' : null,
      lists: 3,
      savedListings: 9,
    );
  }

  @override
  Future<void> closeAccount(String password) async {
    await _wait();
    if (password != samplePassword) {
      throw const CloseAccountRejected(CloseAccountError.wrongPassword);
    }
    if (hasUpcomingBooking) {
      throw const CloseAccountRejected(CloseAccountError.upcomingBooking);
    }
  }

  static const _titles = {
    LegalDoc.terms: 'Kullanım Koşulları',
    LegalDoc.kvkk: 'KVKK Aydınlatma Metni',
    LegalDoc.privacy: 'Gizlilik Politikası',
    LegalDoc.cookies: 'Çerez Politikası',
    LegalDoc.distanceSales: 'Mesafeli Satış Sözleşmesi',
    LegalDoc.cancellation: 'İptal ve İade Koşulları',
  };

  @override
  Future<LegalDocument> legalDocument(LegalDoc doc) async {
    await _wait();
    return LegalDocument(
      doc: doc,
      updatedAt: DateTime(2026, 10, 1),
      paragraphs: [
        '## 1. Taraflar ve kapsam',
        'Bu metin, ${_titles[doc]} kapsamında Bungalovum Seyahat ile '
            'kullanıcı arasındaki esasları düzenler.',
        '## 2. Açıklamalar',
        'Metnin güncel ve bağlayıcı sürümü yayın öncesinde hukuk ekibi '
            'tarafından sağlanacaktır.',
      ],
    );
  }

  @override
  Future<List<FaqItem>> faq() async {
    await _wait();
    return const [
      FaqItem(
        id: 'iptal',
        question: 'Rezervasyonumu nasıl iptal ederim?',
        answer:
            'Seyahatler’de konaklamanı aç, “Rezervasyonu yönet” altından '
            '“Rezervasyonu iptal et”e dokun. İade tutarını onaylamadan önce '
            'görürsün.',
      ),
      FaqItem(
        id: 'odeme',
        question: 'Ödeme ne zaman çekilir?',
        answer:
            'Anında onaylı ilanlarda ödeme rezervasyonla birlikte çekilir. '
            'Ev sahibi onaylı ilanlarda yalnızca provizyon tutulur; ev sahibi '
            'onaylarsa çekilir.',
      ),
      FaqItem(
        id: 'ev-sahibi',
        question: 'Ev sahibine nasıl ulaşırım?',
        answer:
            'İlan sayfasındaki ya da konaklama detayındaki mesaj butonunu '
            'kullan. Tüm yazışmalar Sohbetler’de durur.',
      ),
      FaqItem(
        id: 'adres',
        question: 'Tam adresi ne zaman görürüm?',
        answer:
            'Onaylı rezervasyonlarda tam adres ve giriş bilgileri girişten '
            '1 gün önce açılır.',
      ),
    ];
  }

  @override
  Future<void> sendFeedback(String text) => _wait();
}
