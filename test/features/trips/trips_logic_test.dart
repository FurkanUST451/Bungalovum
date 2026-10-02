import 'package:bungapp/features/booking/data/mock_booking_repository.dart';
import 'package:bungapp/features/booking/domain/booking.dart';
import 'package:bungapp/features/search/domain/search_query.dart';
import 'package:bungapp/features/trips/domain/trip_models.dart';
import 'package:bungapp/features/trips/domain/trips_overview.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

Booking _b(
  String id,
  BookingStatus status,
  DateTime checkIn, {
  DateTime? cancelledAt,
}) => Booking(
  id: id,
  code: id,
  listingId: 'gol-esintisi',
  dates: StayDates(
    checkIn: checkIn,
    checkOut: checkIn.add(const Duration(days: 2)),
  ),
  guests: const GuestCount(),
  amountPaid: 1000,
  status: status,
  cancelledAt: cancelledAt,
);

void main() {
  group('TripsOverview', () {
    final now = DateTime(2026, 11, 3);
    final o = TripsOverview.from([
      _b('up2', BookingStatus.confirmed, DateTime(2026, 12, 1)),
      _b('up1', BookingStatus.confirmed, DateTime(2026, 11, 6)),
      _b('pend', BookingStatus.pending, DateTime(2026, 11, 20)),
      _b('old', BookingStatus.completed, DateTime(2026, 8, 1)),
      _b('new', BookingStatus.completed, DateTime(2026, 9, 1)),
      // Onaylı ama bitmiş → geçmiş.
      _b('done', BookingStatus.confirmed, DateTime(2026, 10, 1)),
      _b('c', BookingStatus.cancelled, DateTime(2026, 9, 12)),
      _b('d', BookingStatus.declined, DateTime(2026, 10, 12)),
    ], now);

    test('gruplar ve sıralama', () {
      expect(o.pending.map((b) => b.id), ['pend']);
      expect(o.upcoming.map((b) => b.id), ['up1', 'up2']);
      expect(o.past.map((b) => b.id), ['done', 'new', 'old']);
      expect(o.cancelled.map((b) => b.id).toSet(), {'c', 'd'});
    });

    test('büyük kart: önce bekleyen talep, sonra en yakın konaklama', () {
      expect(o.featured?.id, 'pend');
      expect(o.otherUpcoming.map((b) => b.id), ['up1', 'up2']);
      final noPending = TripsOverview.from(o.upcoming, now);
      expect(noPending.featured?.id, 'up1');
      expect(noPending.otherUpcoming.map((b) => b.id), ['up2']);
    });

    test('boş liste', () {
      final empty = TripsOverview.from(const [], now);
      expect(empty.hasAny, isFalse);
      expect(empty.featured, isNull);
    });
  });

  group('Mock seyahat işlemleri', () {
    late MockBookingRepository repo;
    setUp(
      () => repo = MockBookingRepository(
        latency: Duration.zero,
        clock: fixedClock,
      ),
    );

    test('adres ve şifreler girişten 1 gün önce açılır (§10)', () async {
      final locked = await repo.tripAccess(
        MockBookingRepository.sampleBookingId,
      );
      expect(locked.revealed, isFalse);
      expect(locked.lockboxCode, isNull);
      expect(locked.wifiPassword, isNull);
      expect(locked.hostPhone, isNull);
      // Ev kuralları ve çıkış listesi kilitli değil.
      expect(locked.sections, isNotEmpty);
      expect(locked.checkoutTasks, isNotEmpty);

      final open = await repo.tripAccess(
        MockBookingRepository.sampleRevealedId,
      );
      expect(open.revealed, isTrue);
      expect(open.lockboxCode, isNotNull);
    });

    test('ücretsiz iptal süresinde tam iade', () async {
      final q = await repo.cancellationQuote(
        MockBookingRepository.sampleBookingId,
      );
      expect(q.fullRefund, isTrue);
      expect(q.refund, q.paid);
      final b = await repo.cancelBooking(
        MockBookingRepository.sampleBookingId,
        CancelReason.plansChanged,
      );
      expect(b.status, BookingStatus.cancelled);
      expect(b.refundAmount, q.paid);
    });

    test('süre geçtiyse kesinti yapılır', () async {
      // Girişi bugün olan örnekte ücretsiz iptal dün 14:00'te bitti.
      final q = await repo.cancellationQuote(
        MockBookingRepository.sampleRevealedId,
      );
      expect(q.fullRefund, isFalse);
      expect(q.refund, lessThan(q.paid));
    });

    test('talep geri çekilince iptal edilir, iade yok', () async {
      final b = await repo.withdrawRequest(
        MockBookingRepository.sampleRequestId,
      );
      expect(b.status, BookingStatus.cancelled);
      expect(b.refundAmount, 0);
    });

    test('değerlendirme puanı rezervasyona yazılır', () async {
      final b = await repo.submitReview(
        'kz-p2',
        const ReviewInput(
          overall: 4,
          categories: {},
          likes: {},
          text: 'Harika bir konaklamaydı, tekrar geleceğiz.',
        ),
      );
      expect(b.myRating, 4);
    });
  });
}
