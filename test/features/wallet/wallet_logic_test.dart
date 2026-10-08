import 'package:bungalovum/features/booking/domain/booking.dart';
import 'package:bungalovum/features/booking/domain/payment.dart';
import 'package:bungalovum/features/search/domain/search_query.dart';
import 'package:bungalovum/features/wallet/data/mock_wallet_repository.dart';
import 'package:bungalovum/features/wallet/domain/wallet_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

Booking _booking(
  String id,
  BookingStatus status, {
  DateTime? paidAt,
  DateTime? requestedAt,
  DateTime? cancelledAt,
  int? refund,
}) => Booking(
  id: id,
  code: id.toUpperCase(),
  listingId: 'gol-esintisi',
  dates: StayDates(
    checkIn: DateTime(2026, 11, 6),
    checkOut: DateTime(2026, 11, 8),
  ),
  guests: const GuestCount(),
  amountPaid: 10800,
  status: status,
  paidAt: paidAt,
  requestedAt: requestedAt,
  cancelledAt: cancelledAt,
  refundAmount: refund,
);

void main() {
  group('Ödeme geçmişi', () {
    test('ödeme, provizyon ve iade hareketleri en yeni önce sıralanır', () {
      final records = PaymentHistory.fromBookings([
        _booking('a', BookingStatus.confirmed, paidAt: DateTime(2026, 10, 1)),
        _booking(
          'b',
          BookingStatus.pending,
          requestedAt: DateTime(2026, 11, 2),
        ),
        _booking(
          'c',
          BookingStatus.cancelled,
          paidAt: DateTime(2026, 8, 20),
          cancelledAt: DateTime(2026, 9, 2),
          refund: 5000,
        ),
        // Reddedilen talebin tutarı hiç çekilmedi; hareket yok.
        _booking('d', BookingStatus.declined, requestedAt: DateTime(2026, 9)),
      ]);
      expect(
        [for (final r in records) (r.bookingId, r.kind)],
        [
          ('b', PaymentKind.provision),
          ('a', PaymentKind.payment),
          ('c', PaymentKind.refund),
          ('c', PaymentKind.payment),
        ],
      );
      expect(records[2].amount, 5000);
    });

    test('iadesiz iptal yalnızca ödemeyi gösterir', () {
      final records = PaymentHistory.fromBookings([
        _booking(
          'c',
          BookingStatus.cancelled,
          paidAt: DateTime(2026, 8, 20),
          cancelledAt: DateTime(2026, 9, 2),
          refund: 0,
        ),
      ]);
      expect(records.map((r) => r.kind), [PaymentKind.payment]);
    });
  });

  group('Kartlar', () {
    test('varsayılan kart silinince sıradaki varsayılan olur', () async {
      final repo = MockWalletRepository(latency: Duration.zero);
      final cards = await repo.removeCard('card-visa');
      expect(cards.single.id, 'card-mc');
      expect(cards.single.isDefault, isTrue);
    });

    test('ilk eklenen kart varsayılandır; numara saklanmaz', () async {
      final repo = MockWalletRepository(latency: Duration.zero, cards: []);
      final cards = await repo.addCard(
        const NewCardInput(
          holder: 'Deniz Yılmaz',
          number: '4111111111111111',
          expMonth: 4,
          expYear: 29,
          cvc: '123',
        ),
      );
      expect(cards.single.isDefault, isTrue);
      expect(cards.single.last4, '1111');
      expect(cards.single.brand, CardBrand.visa);
    });

    test('varsayılan değiştirilince tek varsayılan kalır', () async {
      final repo = MockWalletRepository(latency: Duration.zero);
      final cards = await repo.setDefaultCard('card-mc');
      expect(cards.where((c) => c.isDefault).map((c) => c.id), ['card-mc']);
    });
  });

  group('Kuponlar', () {
    test('geçerli kod eklenir, ikinci kez eklenemez', () async {
      final repo = MockWalletRepository(
        latency: Duration.zero,
        clock: fixedClock,
      );
      final coupons = await repo.redeemCoupon(' bungalovum10 ');
      expect(coupons.single.code, 'BUNGALOVUM10');
      expect(coupons.single.isActive(fixedClock()), isTrue);
      await expectLater(
        repo.redeemCoupon('BUNGALOVUM10'),
        throwsA(
          isA<CouponRejected>().having(
            (e) => e.error,
            'error',
            CouponError.alreadyAdded,
          ),
        ),
      );
    });

    test('süresi geçmiş ve bilinmeyen kodlar reddedilir', () async {
      final repo = MockWalletRepository(latency: Duration.zero);
      await expectLater(
        repo.redeemCoupon('YAZ2025'),
        throwsA(
          isA<CouponRejected>().having(
            (e) => e.error,
            'e',
            CouponError.expired,
          ),
        ),
      );
      await expectLater(
        repo.redeemCoupon('YOKBOYLE'),
        throwsA(
          isA<CouponRejected>().having(
            (e) => e.error,
            'e',
            CouponError.notFound,
          ),
        ),
      );
    });

    test('kullanılan ya da süresi dolan kupon aktif sayılmaz', () {
      final c = Coupon(
        code: 'X',
        kind: CouponKind.amount,
        value: 500,
        expiresAt: DateTime(2026, 12, 31),
      );
      expect(c.isActive(DateTime(2027)), isFalse);
      expect(
        c.copyWith(usedAt: DateTime(2026, 11)).isActive(fixedClock()),
        isFalse,
      );
    });
  });
}
