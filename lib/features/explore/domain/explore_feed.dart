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

/// Bölüm başlığının kalıbı: "Sapanca'da en sevilenler", "Samsun'da favori
/// mekanlar".
enum ExploreSectionKind { loved, favorites }

/// Keşfet'te bir bölgenin yatay ilan şeridi.
@freezed
abstract class ExploreSection with _$ExploreSection {
  const factory ExploreSection({
    required ExploreSectionKind kind,

    /// Bölge adı, Türkçe bulunma ekiyle: "Sapanca'da".
    required String regionLocative,

    /// "Tümünü gör"de aranacak konum: "Sapanca".
    required String location,
    @Default(<Listing>[]) List<Listing> listings,
  }) = _ExploreSection;

  factory ExploreSection.fromJson(Map<String, dynamic> json) =>
      _$ExploreSectionFromJson(json);
}

@freezed
abstract class ExploreFeed with _$ExploreFeed {
  const factory ExploreFeed({
    /// "Sapanca, Sakarya"
    required String locationLabel,
    WeatherSummary? weather,

    /// Bölge şeritleri; ilanı olmayan bölüm gösterilmez.
    @Default(<ExploreSection>[]) List<ExploreSection> sections,
    required DateTime weekendStart,
    required DateTime weekendEnd,
    @Default(<ListingOffer>[]) List<ListingOffer> weekendDeals,
  }) = _ExploreFeed;

  factory ExploreFeed.fromJson(Map<String, dynamic> json) =>
      _$ExploreFeedFromJson(json);
}
