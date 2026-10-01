import 'package:freezed_annotation/freezed_annotation.dart';

import '../../listing/domain/listing.dart';
import '../../listing/domain/listing_offer.dart';

part 'explore_feed.freezed.dart';
part 'explore_feed.g.dart';

enum WeatherCondition { sunny, partlyCloudy, cloudy, rainy, snowy }

@freezed
abstract class WeatherSummary with _$WeatherSummary {
  const factory WeatherSummary({
    required DateTime date,
    required int temperatureC,
    required WeatherCondition condition,

    /// Hafta sonu müsait bungalov sayısı.
    required int availableCount,
  }) = _WeatherSummary;

  factory WeatherSummary.fromJson(Map<String, dynamic> json) =>
      _$WeatherSummaryFromJson(json);
}

@freezed
abstract class ExploreFeed with _$ExploreFeed {
  const factory ExploreFeed({
    /// "Sapanca, Sakarya"
    required String locationLabel,

    /// Bölge adı, Türkçe bulunma ekiyle: "Sapanca'da". Ek, backend'de
    /// ünlü uyumuna göre üretilir.
    required String regionLocative,
    WeatherSummary? weather,
    @Default(<Listing>[]) List<Listing> popular,
    required DateTime weekendStart,
    required DateTime weekendEnd,
    @Default(<ListingOffer>[]) List<ListingOffer> weekendDeals,
  }) = _ExploreFeed;

  factory ExploreFeed.fromJson(Map<String, dynamic> json) =>
      _$ExploreFeedFromJson(json);
}
