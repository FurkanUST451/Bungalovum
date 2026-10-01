import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_calculator.freezed.dart';
part 'price_calculator.g.dart';

/// Konaklama fiyat kalemleri. Temizlik, hizmet bedeli ve indirim tutarları
/// backend'den gelir; uygulamada sabit oran yoktur.
@freezed
abstract class PriceBreakdown with _$PriceBreakdown {
  const factory PriceBreakdown({
    required int nightlyRate,
    required int nights,
    @Default(0) int cleaningFee,
    @Default(0) int serviceFee,
    @Default(0) int discount,
  }) = _PriceBreakdown;

  factory PriceBreakdown.fromJson(Map<String, dynamic> json) =>
      _$PriceBreakdownFromJson(json);
}

/// Fiyatın gösterildiği her ekran toplamı buradan alır; UI'da hesap yapılmaz.
abstract final class PriceCalculator {
  /// gecelik × gece.
  static int stay(PriceBreakdown p) => p.nightlyRate * p.nights;

  /// İndirim öncesi toplam (gecelik × gece + temizlik + hizmet bedeli).
  static int subtotal(PriceBreakdown p) =>
      stay(p) + p.cleaningFee + p.serviceFee;

  /// Ödenecek toplam.
  static int total(PriceBreakdown p) => subtotal(p) - p.discount;

  static bool hasDiscount(PriceBreakdown p) => p.discount > 0;
}
