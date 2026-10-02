import '../../booking/domain/booking.dart';

enum TripsTab { upcoming, past, cancelled }

/// Rezervasyonların Seyahatler sekmelerine dağılımı. Gruplama kuralları
/// burada; ekran yalnızca sonucu çizer.
class TripsOverview {
  TripsOverview._({
    required this.pending,
    required this.upcoming,
    required this.past,
    required this.cancelled,
  });

  factory TripsOverview.from(List<Booking> all, DateTime now) {
    final pending = <Booking>[];
    final upcoming = <Booking>[];
    final past = <Booking>[];
    final cancelled = <Booking>[];
    for (final b in all) {
      switch (b.status) {
        case BookingStatus.pending:
          pending.add(b);
        case BookingStatus.confirmed when b.dates.checkOut.isAfter(now):
          upcoming.add(b);
        case BookingStatus.confirmed || BookingStatus.completed:
          past.add(b);
        case BookingStatus.cancelled || BookingStatus.declined:
          cancelled.add(b);
      }
    }
    int byCheckIn(Booking a, Booking b) =>
        a.dates.checkIn.compareTo(b.dates.checkIn);
    return TripsOverview._(
      pending: pending..sort(byCheckIn),
      upcoming: upcoming..sort(byCheckIn),
      // En yeni konaklama üstte.
      past: past..sort((a, b) => byCheckIn(b, a)),
      cancelled: cancelled
        ..sort(
          (a, b) => (b.cancelledAt ?? b.dates.checkIn).compareTo(
            a.cancelledAt ?? a.dates.checkIn,
          ),
        ),
    );
  }

  /// Ev sahibi onayı bekleyen talepler.
  final List<Booking> pending;

  /// Onaylı, henüz bitmemiş konaklamalar (en yakın önce).
  final List<Booking> upcoming;
  final List<Booking> past;

  /// İptal edilen ve reddedilen.
  final List<Booking> cancelled;

  /// Yaklaşan sekmesinin büyük kartı: önce bekleyen talep, yoksa en yakın
  /// konaklama.
  Booking? get featured => pending.firstOrNull ?? upcoming.firstOrNull;

  /// Büyük kartın altındaki "Onaylanmış" listesi.
  List<Booking> get otherUpcoming =>
      upcoming.where((b) => b != featured).toList();

  /// Yaklaşan sekmesinde gösterilen önceki konaklamalar (en fazla 2).
  static const recentPastLimit = 2;

  List<Booking> get recentPast => past.take(recentPastLimit).toList();

  bool get hasAny =>
      pending.isNotEmpty ||
      upcoming.isNotEmpty ||
      past.isNotEmpty ||
      cancelled.isNotEmpty;
}
