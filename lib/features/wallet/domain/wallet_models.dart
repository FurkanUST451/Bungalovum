import 'package:freezed_annotation/freezed_annotation.dart';

import '../../booking/domain/booking.dart';
import '../../booking/domain/payment.dart';

part 'wallet_models.freezed.dart';

enum CouponKind { percent, amount }

/// 77 · Hesaba eklenmiş kupon. İndirimi ödeme sırasında backend hesaplar.
@freezed
abstract class Coupon with _$Coupon {
  const Coupon._();

  const factory Coupon({
    required String code,
    required CouponKind kind,

    /// Yüzde (10) ya da tutar (₺500 → 500).
    required int value,

    /// Yüzdelik kuponlarda en fazla indirim.
    int? maxDiscount,
    required DateTime expiresAt,
    DateTime? usedAt,
  }) = _Coupon;

  bool isActive(DateTime now) => usedAt == null && now.isBefore(expiresAt);
}

enum PaymentKind {
  /// Kartan çekilen konaklama ödemesi.
  payment,

  /// Ev sahibi onayı bekleyen talep için tutulan tutar (çekilmedi).
  provision,

  /// İptal sonrası karta iade.
  refund,
}

/// 76 · Ödeme geçmişi satırı.
@freezed
abstract class PaymentRecord with _$PaymentRecord {
  const factory PaymentRecord({
    required String bookingId,
    required String listingId,
    required PaymentKind kind,
    required int amount,
    required DateTime at,
    required CardBrand cardBrand,
    String? cardLast4,
  }) = _PaymentRecord;
}

abstract final class PaymentHistory {
  /// Rezervasyonlardan ödeme ve iade hareketleri, en yeni önce.
  static List<PaymentRecord> fromBookings(Iterable<Booking> bookings) {
    final out = <PaymentRecord>[];
    for (final b in bookings) {
      PaymentRecord record(PaymentKind kind, int amount, DateTime at) =>
          PaymentRecord(
            bookingId: b.id,
            listingId: b.listingId,
            kind: kind,
            amount: amount,
            at: at,
            cardBrand: b.cardBrand,
            cardLast4: b.cardLast4,
          );
      if (b.status == BookingStatus.pending && b.requestedAt != null) {
        out.add(record(PaymentKind.provision, b.amountPaid, b.requestedAt!));
      }
      if (b.paidAt != null) {
        out.add(record(PaymentKind.payment, b.amountPaid, b.paidAt!));
      }
      final refund = b.refundAmount ?? 0;
      if (refund > 0 && b.cancelledAt != null) {
        out.add(record(PaymentKind.refund, refund, b.cancelledAt!));
      }
    }
    return out..sort((a, b) => b.at.compareTo(a.at));
  }
}
