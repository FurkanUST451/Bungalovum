import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/booking_repository.dart';
import '../../domain/booking.dart';
import '../../domain/payment.dart';
import '../../domain/price_calculator.dart';
import 'booking_draft.dart';

part 'checkout_controller.freezed.dart';
part 'checkout_controller.g.dart';

/// Rezervasyonu Onayla → Ödeme → 3D Secure → Tamam / Başarısız akışının
/// ortak durumu.
@freezed
abstract class CheckoutState with _$CheckoutState {
  const factory CheckoutState({
    String? listingId,

    /// Seçili kayıtlı kart; null ise varsayılan kart.
    String? cardId,
    @Default(1) int installments,
    ThreeDsChallenge? challenge,

    /// Son reddin bilgisi (37 · Ödeme Başarısız).
    PaymentDeclined? declined,

    /// Uygulanan kupon ve onunla hesaplanan fiyat kalemleri.
    String? couponCode,
    PriceBreakdown? couponQuote,

    /// Ev sahibi onaylı talepte tanışma mesajı (40); null = anında onay.
    String? messageToHost,
  }) = _CheckoutState;

  const CheckoutState._();

  bool get isRequest => messageToHost != null;
}

/// Ödeme ekranında gösterilecek fiyat: kupon varsa kuponlu, yoksa taslak.
@riverpod
Future<PriceBreakdown> checkoutQuote(Ref ref) async {
  final s = ref.watch(checkoutControllerProvider);
  if (s.couponQuote != null) return s.couponQuote!;
  return ref.watch(bookingQuoteProvider(s.listingId!).future);
}

@Riverpod(keepAlive: true)
class CheckoutController extends _$CheckoutController {
  /// Son denenen kart. Yeni kart bilgisi yalnızca burada, bellekte durur ve
  /// akış bitince silinir.
  PaymentMethod? _method;

  @override
  CheckoutState build() => const CheckoutState();

  BookingRepository get _repo => ref.read(bookingRepositoryProvider);

  /// 33'ten ödemeye geçerken akışı sıfırlar.
  /// [messageToHost] verilirse ev sahibi onaylı talep akışıdır (40).
  void begin(String listingId, {String? messageToHost}) {
    _method = null;
    state = CheckoutState(listingId: listingId, messageToHost: messageToHost);
  }

  void selectCard(String id) => state = state.copyWith(cardId: id);

  void setInstallments(int n) => state = state.copyWith(installments: n);

  bool get canRetry => _method != null;

  /// Geçersizse [CouponRejected] fırlatır.
  Future<void> applyCoupon(String code) async {
    final listingId = state.listingId!;
    final nights = ref.read(bookingDraftControllerProvider(listingId)).nights;
    final quote = await _repo.applyCoupon(
      listingId: listingId,
      nights: nights,
      code: code,
    );
    state = state.copyWith(
      couponCode: code.trim().toUpperCase(),
      couponQuote: quote,
    );
  }

  void removeCoupon() =>
      state = state.copyWith(couponCode: null, couponQuote: null);

  Future<ThreeDsChallenge> pay(PaymentMethod method) async {
    final listingId = state.listingId!;
    final draft = ref.read(bookingDraftControllerProvider(listingId));
    final challenge = await _repo.startPayment(
      PaymentRequest(
        listingId: listingId,
        dates: draft.dates!,
        guests: draft.guests,
        method: method,
        installments: state.installments,
        couponCode: state.couponCode,
        messageToHost: state.messageToHost,
      ),
    );
    _method = method;
    state = state.copyWith(challenge: challenge, declined: null);
    return challenge;
  }

  /// Aynı kartla yeniden dener.
  Future<ThreeDsChallenge> retry() => pay(_method!);

  Future<void> resendCode() async {
    final c = state.challenge!;
    final expiresAt = await _repo.resendPaymentCode(c.id);
    state = state.copyWith(challenge: c.copyWith(expiresAt: expiresAt));
  }

  /// Onaylanırsa rezervasyonu döner ve kart bilgisini bellekten siler;
  /// reddedilirse [PaymentDeclined] fırlatır.
  Future<Booking> confirm(String code) async {
    try {
      final booking = await _repo.confirmPayment(state.challenge!.id, code);
      _method = null;
      state = CheckoutState(listingId: state.listingId);
      return booking;
    } on PaymentDeclined catch (e) {
      state = state.copyWith(challenge: null, declined: e);
      rethrow;
    }
  }

  Future<void> cancelChallenge() async {
    final c = state.challenge;
    if (c == null) return;
    await _repo.cancelPayment(c.id);
    state = state.copyWith(challenge: null);
  }
}
