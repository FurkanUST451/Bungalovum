import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../listing/domain/listing_offer.dart';
import '../../trips/domain/trip_models.dart';
import '../../search/domain/search_query.dart';
import '../domain/booking.dart';
import '../domain/payment.dart';
import '../domain/price_calculator.dart';
import 'mock_booking_repository.dart';

part 'booking_repository.g.dart';

/// Anında onaylı rezervasyonun ödeme isteği. Tutar backend'de yeniden
/// hesaplanır; istemci yalnızca seçimleri gönderir.
class PaymentRequest {
  const PaymentRequest({
    required this.listingId,
    required this.dates,
    required this.guests,
    required this.method,
    this.installments = 1,
    this.couponCode,
    this.messageToHost,
  });

  final String listingId;
  final StayDates dates;
  final GuestCount guests;
  final PaymentMethod method;
  final int installments;
  final String? couponCode;

  /// Ev sahibi onaylı ilanlarda zorunlu tanışma mesajı. Varsa ödeme
  /// provizyon olarak tutulur, onayda çekilir.
  final String? messageToHost;

  bool get isRequest => messageToHost != null;
}

abstract interface class BookingRepository {
  /// Kartın (BIN) desteklediği taksit sayıları; 1 = tek çekim.
  Future<List<int>> installmentOptions({String? cardId, String? bin});

  /// Kuponu doğrular ve indirimli fiyat kalemlerini döner; geçersizse
  /// [CouponRejected] fırlatır. İndirim tutarını backend hesaplar.
  Future<PriceBreakdown> applyCoupon({
    required String listingId,
    required int nights,
    required String code,
  });

  /// Tarihleri tutar ve banka doğrulamasını başlatır.
  Future<ThreeDsChallenge> startPayment(PaymentRequest request);

  /// SMS şifresini doğrular; onaylanmazsa [PaymentDeclined] fırlatır.
  Future<Booking> confirmPayment(String challengeId, String code);

  /// Yeni şifre gönderir; yeni son geçerlilik anını döner.
  Future<DateTime> resendPaymentCode(String challengeId);

  /// Kullanıcı doğrulamayı kapattı; tutma süresi devam eder.
  Future<void> cancelPayment(String challengeId);

  Future<Booking> booking(String id);

  /// Kullanıcının tüm rezervasyon ve talepleri (Seyahatler).
  Future<List<Booking>> myBookings();

  /// Onay bekleyen talebi geri çeker; provizyon kaldırılır.
  Future<Booking> withdrawRequest(String bookingId);

  /// Adres ve giriş bilgileri; açılma anına kadar hassas alanlar boş gelir.
  Future<TripAccess> tripAccess(String bookingId);

  Future<void> reportIssue(String bookingId, IssueReport report);

  /// Makbuz PDF bağlantısı (backend üretir).
  Future<Uri> receiptPdf(String bookingId);

  /// Makbuzu kayıtlı e-postaya gönderir; maskeli adresi döner.
  Future<String> emailReceipt(String bookingId);

  Future<BillingInfo> billingInfo();

  Future<BillingInfo> saveBillingInfo(BillingInput input);

  Future<CancellationQuote> cancellationQuote(String bookingId);

  Future<Booking> cancelBooking(String bookingId, CancelReason reason);

  Future<Booking> submitReview(String bookingId, ReviewInput review);

  /// Reddedilen talebin tarihlerinde boş, anında onaylı benzer ilanlar.
  Future<List<ListingOffer>> similarAvailable(String bookingId);

  Future<StayGuestList> stayGuests(String bookingId);

  Future<StayGuestList> addStayGuest(String bookingId, StayGuestInput input);
}

@Riverpod(keepAlive: true)
BookingRepository bookingRepository(Ref ref) => MockBookingRepository();

@riverpod
Future<List<Booking>> myBookings(Ref ref) =>
    ref.watch(bookingRepositoryProvider).myBookings();

@riverpod
Future<TripAccess> tripAccess(Ref ref, String bookingId) =>
    ref.watch(bookingRepositoryProvider).tripAccess(bookingId);

@riverpod
Future<CancellationQuote> cancellationQuote(Ref ref, String bookingId) =>
    ref.watch(bookingRepositoryProvider).cancellationQuote(bookingId);

@riverpod
Future<BillingInfo> billingInfo(Ref ref) =>
    ref.watch(bookingRepositoryProvider).billingInfo();

@riverpod
Future<Booking> booking(Ref ref, String id) =>
    ref.watch(bookingRepositoryProvider).booking(id);

@riverpod
Future<List<int>> installmentOptions(Ref ref, {String? cardId, String? bin}) =>
    ref
        .watch(bookingRepositoryProvider)
        .installmentOptions(cardId: cardId, bin: bin);

@riverpod
Future<List<ListingOffer>> similarAvailable(Ref ref, String bookingId) =>
    ref.watch(bookingRepositoryProvider).similarAvailable(bookingId);
