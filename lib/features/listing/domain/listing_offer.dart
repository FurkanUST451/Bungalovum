import 'package:freezed_annotation/freezed_annotation.dart';

import '../../booking/domain/price_calculator.dart';
import 'listing.dart';

part 'listing_offer.freezed.dart';
part 'listing_offer.g.dart';

/// Belirli tarihler için fiyatlandırılmış ilan (arama sonucu, hafta sonu
/// fırsatı, harita pini).
@freezed
abstract class ListingOffer with _$ListingOffer {
  const factory ListingOffer({
    required Listing listing,
    required PriceBreakdown price,

    /// Seçili tarihlerde kalan gece sayısı azsa (ör. "Son 2 gece!").
    int? nightsLeft,
  }) = _ListingOffer;

  factory ListingOffer.fromJson(Map<String, dynamic> json) =>
      _$ListingOfferFromJson(json);
}
