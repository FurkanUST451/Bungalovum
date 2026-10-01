/// Uygulamanın rota haritası (Figma ekran numaralarıyla). Ekranlar rota
/// adreslerini buradan alır; router.dart ekranları bu adreslere bağlar.
abstract final class AppRoutes {
  // 01–12 · Giriş ve kayıt
  static const welcome = '/hos-geldin';
  static const signIn = '/giris';
  static const smsVerify = '/giris/sms';
  static const register = '/kayit';
  static const verifyEmail = '/kayit/dogrula';
  static const forgotPassword = '/sifre/unuttum';
  static const resetCode = '/sifre/kod';
  static const newPassword = '/sifre/yeni';
  static const passwordUpdated = '/sifre/guncellendi';

  // Sekmeler: 13 Keşfet, 56 Kaydettiklerim, 44 Seyahatler, 61 Sohbetler,
  // 65 Hesabım
  static const explore = '/kesfet';
  static const saved = '/kayitli';
  static const trips = '/seyahatler';
  static const chats = '/sohbetler';
  static const account = '/hesabim';

  // 14–18 · Arama
  static const search = '/arama';
  static const filters = '/arama/filtreler';
  static const results = '/arama/sonuclar';
  static const map = '/arama/harita';

  // 31–32 · Seçiciler (arama ve rezervasyon ortak)
  static const dates = '/tarih';
  static const guests = '/misafirler';

  // 19–30 · İlan
  static String listing(String id) => '/ilan/$id';
  static String listingPhotos(String id) => '/ilan/$id/fotograflar';
  static String listingPhoto(String id, int index) =>
      '/ilan/$id/fotograflar/$index';
  static String listingReviews(String id) => '/ilan/$id/degerlendirmeler';
  static String listingAmenities(String id) => '/ilan/$id/olanaklar';
  static String listingRules(String id) => '/ilan/$id/kurallar';
  static String listingLocation(String id) => '/ilan/$id/konum';
  static String listingReport(String id) => '/ilan/$id/bildir';
  static String host(String id, {required String listingId}) =>
      '/ev-sahibi/$id?ilan=$listingId';

  // 33–43 · Rezervasyon
  static String bookingConfirm(String listingId) =>
      '/ilan/$listingId/rezervasyon';
  static String bookingRequest(String listingId) => '/ilan/$listingId/talep';
  static const payment = '/odeme';
  static const paymentNewCard = '/odeme/yeni-kart';
  static const payment3ds = '/odeme/3d-secure';
  static const paymentFailed = '/odeme/basarisiz';
  static String bookingDone(String bookingId) =>
      '/rezervasyon/$bookingId/tamam';
  static String requestSent(String bookingId) =>
      '/rezervasyon/$bookingId/talep-gonderildi';
  static String requestApproved(String bookingId) =>
      '/rezervasyon/$bookingId/onaylandi';
  static String requestDeclined(String bookingId) =>
      '/rezervasyon/$bookingId/reddedildi';
  static String guestDetails(String bookingId) =>
      '/rezervasyon/$bookingId/misafir-bilgileri';

  // 44–55 · Seyahatler
  static String trip(String id) => '/seyahat/$id';
  static String houseGuide(String id) => '/seyahat/$id/ev-kilavuzu';
  static String reportIssue(String id) => '/seyahat/$id/sorun';
  static String receipt(String id) => '/seyahat/$id/makbuz';
  static String billing(String id) => '/seyahat/$id/fatura';
  static String cancelBooking(String id) => '/seyahat/$id/iptal';
  static String writeReview(String id) => '/seyahat/$id/degerlendir';

  // 56–60 · Kaydedilenler
  static String wishlist(String id) => '/liste/$id';
  static String wishlistEdit(String id) => '/liste/$id/duzenle';
  static const recentlyViewed = '/son-baktiklarin';

  // 61–64 · Sohbet ve bildirimler
  static String chat(String id) => '/sohbet/$id';
  static const notifications = '/bildirimler';

  // 65–72 · Hesap
  static const personalInfo = '/hesap/bilgilerim';
  static const security = '/hesap/giris-guvenlik';
  static const closeAccount = '/hesap/kapat';
  static const notificationPrefs = '/hesap/bildirim-tercihleri';
  static const privacy = '/hesap/gizlilik';
  static const help = '/hesap/yardim';
  static const legal = '/hesap/hukuki';

  // 73–77 · Cüzdan
  static const wallet = '/cuzdan';
  static const paymentMethods = '/cuzdan/odeme-yontemleri';
  static const paymentHistory = '/cuzdan/odeme-gecmisi';
  static const coupons = '/cuzdan/kuponlar';

  // 79–81 · Durum ekranları
  static const offline = '/baglanti-yok';
  static const locationPermission = '/izin/konum';
  static const notificationPermission = '/izin/bildirim';

  // 82–95 · Ev sahibi
  static const becomeHost = '/ev-sahibi-ol';
  static String hostWizard(int step) => '/ilan-olustur/$step';
  static const hostPreview = '/ilan-olustur/onizleme';
  static const hostInReview = '/ilan-olustur/incelemede';
  static const hostListings = '/ilan-yonetimi';
}
