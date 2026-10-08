import 'package:bungalovum/core/utils/clock.dart';
import 'package:bungalovum/core/utils/formatters.dart';
import 'package:bungalovum/features/booking/data/booking_repository.dart';
import 'package:bungalovum/features/booking/data/mock_booking_repository.dart';
import 'package:bungalovum/features/booking/domain/booking.dart';
import 'package:bungalovum/features/booking/domain/payment.dart';
import 'package:bungalovum/features/booking/domain/price_calculator.dart';
import 'package:bungalovum/features/booking/presentation/controllers/checkout_controller.dart';
import 'package:bungalovum/features/search/domain/search_query.dart';
import 'package:bungalovum/features/search/presentation/controllers/search_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/test_app.dart';

void main() {
  setUpAll(() => initializeDateFormatting(kzLocale));

  group('IdValidators.isTckn', () {
    test('geçerli numarayı kabul eder', () {
      expect(IdValidators.isTckn('10000000146'), isTrue);
    });
    test('kontrol hanesi yanlışsa reddeder', () {
      expect(IdValidators.isTckn('10000000147'), isFalse);
    });
    test('0 ile başlayan ya da 11 hane olmayanı reddeder', () {
      expect(IdValidators.isTckn('01234567890'), isFalse);
      expect(IdValidators.isTckn('1000000014'), isFalse);
    });
  });

  group('CardValidators', () {
    test('Luhn', () {
      expect(CardValidators.isCardNumber('4242 4242 4242 4242'), isTrue);
      expect(CardValidators.isCardNumber('4242 4242 4242 4241'), isFalse);
    });
    test('marka', () {
      expect(CardValidators.brandOf('4242'), CardBrand.visa);
      expect(CardValidators.brandOf('5555'), CardBrand.mastercard);
      expect(CardValidators.brandOf('9792'), CardBrand.troy);
      expect(CardValidators.brandOf('3714'), CardBrand.amex);
    });
    test('son kullanma', () {
      final today = DateTime(2026, 11, 3);
      expect(CardValidators.isExpiryValid('11 / 26', today), isTrue);
      expect(CardValidators.isExpiryValid('10 / 26', today), isFalse);
      expect(CardValidators.isExpiryValid('13 / 27', today), isFalse);
    });
    test('CVC uzunluğu markaya göre', () {
      expect(CardValidators.isCvc('123', CardBrand.visa), isTrue);
      expect(CardValidators.isCvc('123', CardBrand.amex), isFalse);
    });
  });

  group('Türkçe ekler', () {
    test('saat yönelme eki', () {
      String at(int h, [int m = 0]) =>
          KzFormat.dayMonthTimeDative(DateTime(2026, 11, 5, h, m));
      expect(at(14), '5 Kas 14:00’e');
      expect(at(16), '5 Kas 16:00’ya');
      expect(at(12), '5 Kas 12:00’ye');
      expect(at(10), '5 Kas 10:00’a');
      expect(at(9, 30), '5 Kas 09:30’a');
    });
    test('saat ayrılma eki', () {
      String from(int h) =>
          KzFormat.dayMonthTimeAblative(DateTime(2026, 11, 5, h));
      expect(from(14), '5 Kas 14:00’ten');
      expect(from(16), '5 Kas 16:00’dan');
      expect(from(11), '5 Kas 11:00’den');
    });
    test('ay bulunma eki', () {
      String on(int month) =>
          KzFormat.dayMonthLocative(DateTime(2026, month, 6));
      expect(on(11), '6 Kasım’da');
      expect(on(3), '6 Mart’ta');
      expect(on(9), '6 Eylül’de');
      expect(on(12), '6 Aralık’ta');
    });
  });

  group('Ödeme akışı', () {
    late ProviderContainer c;
    const visa = SavedCardMethod(
      PaymentCard(
        id: 'card-visa',
        brand: CardBrand.visa,
        last4: '4242',
        expMonth: 12,
        expYear: 28,
      ),
    );

    setUp(() {
      c = ProviderContainer(
        overrides: [
          bookingRepositoryProvider.overrideWithValue(
            MockBookingRepository(latency: Duration.zero, clock: fixedClock),
          ),
          clockProvider.overrideWithValue(fixedClock),
        ],
      );
      c
          .read(searchQueryControllerProvider.notifier)
          .apply(
            SearchQuery(
              location: 'Sapanca',
              dates: StayDates(
                checkIn: DateTime(2026, 11, 6),
                checkOut: DateTime(2026, 11, 8),
              ),
            ),
          );
      c.read(checkoutControllerProvider.notifier).begin('gol-esintisi');
    });
    tearDown(() => c.dispose());

    test('doğru şifre rezervasyonu onaylar ve akışı temizler', () async {
      final checkout = c.read(checkoutControllerProvider.notifier);
      final challenge = await checkout.pay(visa);
      expect(challenge.cardLast4, '4242');
      final booking = await checkout.confirm('123456');
      expect(booking.status, BookingStatus.confirmed);
      expect(booking.dates.nights, 2);
      expect(c.read(checkoutControllerProvider).challenge, isNull);
      expect(checkout.canRetry, isFalse);
    });

    test(
      'kupon: geçerli kod indirimi uygular, ödeme tutarına yansır',
      () async {
        final checkout = c.read(checkoutControllerProvider.notifier);
        await checkout.applyCoupon(' bungalovum10 ');
        final s = c.read(checkoutControllerProvider);
        expect(s.couponCode, MockBookingRepository.sampleCoupon);
        expect(s.couponQuote!.discountKind, DiscountKind.coupon);
        final quote = await c.read(checkoutQuoteProvider.future);
        final challenge = await checkout.pay(visa);
        expect(challenge.amount, PriceCalculator.total(quote));

        checkout.removeCoupon();
        expect(c.read(checkoutControllerProvider).couponQuote, isNull);
      },
    );

    test('kupon: geçersiz ve süresi dolmuş kod reddedilir', () async {
      final checkout = c.read(checkoutControllerProvider.notifier);
      await expectLater(
        checkout.applyCoupon('YOKBOYLE'),
        throwsA(
          isA<CouponRejected>().having(
            (e) => e.error,
            'error',
            CouponError.notFound,
          ),
        ),
      );
      await expectLater(
        checkout.applyCoupon(MockBookingRepository.expiredCoupon),
        throwsA(
          isA<CouponRejected>().having(
            (e) => e.error,
            'error',
            CouponError.expired,
          ),
        ),
      );
      expect(c.read(checkoutControllerProvider).couponCode, isNull);
    });

    test('talep: mesajla başlarsa onay bekleyen rezervasyon oluşur', () async {
      final checkout = c.read(checkoutControllerProvider.notifier)
        ..begin('gol-esintisi', messageToHost: 'Merhaba, eşimle geliyoruz.');
      expect(c.read(checkoutControllerProvider).isRequest, isTrue);
      await checkout.pay(visa);
      final booking = await checkout.confirm('123456');
      expect(booking.status, BookingStatus.pending);
      expect(booking.isRequest, isTrue);
      expect(booking.cardLast4, '4242');
      expect(
        booking.respondBy!.difference(booking.requestedAt!).inHours,
        BookingPolicy.requestResponseHours,
      );
    });

    test('ret: tutma süresi döner, aynı kartla yeniden denenebilir', () async {
      final checkout = c.read(checkoutControllerProvider.notifier);
      await checkout.pay(visa);
      await expectLater(
        checkout.confirm(MockBookingRepository.declineCode),
        throwsA(isA<PaymentDeclined>()),
      );
      final state = c.read(checkoutControllerProvider);
      expect(state.declined?.holdUntil.isAfter(fixedClock()), isTrue);
      expect(checkout.canRetry, isTrue);
      final retry = await checkout.retry();
      expect(retry.cardLast4, '4242');
    });
  });
}
