import 'package:freezed_annotation/freezed_annotation.dart';

import '../../search/domain/search_query.dart';
import 'payment.dart';
import 'price_calculator.dart';

part 'booking.freezed.dart';

/// Rezervasyon durumu: anında onayda doğrudan `confirmed`, talepte
/// `pending → confirmed | declined`.
enum BookingStatus { pending, confirmed, declined, cancelled, completed }

@freezed
abstract class Booking with _$Booking {
  const factory Booking({
    required String id,

    /// Misafire gösterilen kod: "KZ-48K2Q".
    required String code,
    required String listingId,
    required StayDates dates,
    required GuestCount guests,

    /// Anında onayda ödenen, talepte provizyon olarak tutulan tutar.
    required int amountPaid,
    required BookingStatus status,

    /// Ev sahibi onaylı talep (40–43).
    @Default(false) bool isRequest,
    @Default(CardBrand.unknown) CardBrand cardBrand,
    String? cardLast4,
    DateTime? requestedAt,

    /// Ev sahibinin yanıt vermesi gereken son an; geçerse talep düşer.
    DateTime? respondBy,

    /// Misafirin verdiği genel puan (değerlendirdiyse).
    double? myRating,
    DateTime? cancelledAt,

    /// false: ev sahibi iptal etti.
    @Default(true) bool cancelledByGuest,

    /// İptalde karta iade edilen tutar.
    int? refundAmount,

    /// Rezervasyon anındaki fiyat kalemleri (makbuz).
    PriceBreakdown? price,
    DateTime? paidAt,
  }) = _Booking;
}

/// Rezervasyon kuralları (§1, §10).
abstract final class BookingPolicy {
  /// Ev sahibinin talebe yanıt süresi.
  static const requestResponseHours = 24;

  /// Ev sahibine tanışma mesajının en kısa uzunluğu.
  static const minIntroLength = 20;
}

/// Kimlik bildirimi (KBS) için misafirin uyruğu.
enum Nationality { turkish, foreign }

/// Kimlik bildirimi için kayıtlı misafir. KVKK: kimlik numarası uygulamaya
/// yalnızca maskeli döner ([idLast2]); tam numara sadece gönderilirken
/// bellekte bulunur.
@freezed
abstract class StayGuest with _$StayGuest {
  const factory StayGuest({
    required String id,
    required String fullName,
    required Nationality nationality,

    /// Kimlik / pasaport numarasının son 2 hanesi.
    required String idLast2,

    /// Rezervasyonu yapan kullanıcı.
    @Default(false) bool isYou,
  }) = _StayGuest;
}

/// Kaydedilecek misafir formu (yalnızca bellekte).
class StayGuestInput {
  const StayGuestInput({
    required this.fullName,
    required this.nationality,
    required this.idNumber,
    required this.birthDate,
  });

  final String fullName;
  final Nationality nationality;

  /// T.C. kimlik no ya da pasaport no.
  final String idNumber;
  final DateTime birthDate;

  @override
  String toString() => 'StayGuestInput($nationality)';
}

/// Rezervasyonun misafir listesi ve kaç kişinin bilgisi gerektiği.
@freezed
abstract class StayGuestList with _$StayGuestList {
  const StayGuestList._();

  const factory StayGuestList({
    required List<StayGuest> guests,

    /// Bilgisi girilmesi gereken toplam kişi (bebekler dahil değil).
    required int requiredCount,
    required DateTime checkIn,
  }) = _StayGuestList;

  int get missing => requiredCount - guests.length;

  bool get isComplete => missing <= 0;
}

abstract final class IdValidators {
  /// T.C. kimlik numarası algoritması (11 hane, ilk hane 0 değil, 10. ve 11.
  /// haneler kontrol hanesi).
  static bool isTckn(String s) {
    if (!RegExp(r'^[1-9]\d{10}$').hasMatch(s)) return false;
    final d = s.split('').map(int.parse).toList();
    final odd = d[0] + d[2] + d[4] + d[6] + d[8];
    final even = d[1] + d[3] + d[5] + d[7];
    if ((odd * 7 - even) % 10 != d[9]) return false;
    return d.take(10).fold(0, (a, b) => a + b) % 10 == d[10];
  }

  /// Pasaport: 6–9 harf/rakam.
  static bool isPassport(String s) =>
      RegExp(r'^[A-Za-z0-9]{6,9}$').hasMatch(s.trim());
}
