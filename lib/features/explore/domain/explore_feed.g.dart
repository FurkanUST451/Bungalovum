// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherSummary _$WeatherSummaryFromJson(Map<String, dynamic> json) =>
    _WeatherSummary(
      date: DateTime.parse(json['date'] as String),
      temperatureC: (json['temperatureC'] as num).toInt(),
      condition: $enumDecode(_$WeatherConditionEnumMap, json['condition']),
      availableCount: (json['availableCount'] as num).toInt(),
    );

Map<String, dynamic> _$WeatherSummaryToJson(_WeatherSummary instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'temperatureC': instance.temperatureC,
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'availableCount': instance.availableCount,
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.sunny: 'sunny',
  WeatherCondition.partlyCloudy: 'partlyCloudy',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.rainy: 'rainy',
  WeatherCondition.snowy: 'snowy',
};

_ExploreSection _$ExploreSectionFromJson(Map<String, dynamic> json) =>
    _ExploreSection(
      kind: $enumDecode(_$ExploreSectionKindEnumMap, json['kind']),
      regionLocative: json['regionLocative'] as String,
      location: json['location'] as String,
      listings:
          (json['listings'] as List<dynamic>?)
              ?.map((e) => Listing.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Listing>[],
    );

Map<String, dynamic> _$ExploreSectionToJson(_ExploreSection instance) =>
    <String, dynamic>{
      'kind': _$ExploreSectionKindEnumMap[instance.kind]!,
      'regionLocative': instance.regionLocative,
      'location': instance.location,
      'listings': instance.listings.map((e) => e.toJson()).toList(),
    };

const _$ExploreSectionKindEnumMap = {
  ExploreSectionKind.loved: 'loved',
  ExploreSectionKind.favorites: 'favorites',
};

_ExploreFeed _$ExploreFeedFromJson(Map<String, dynamic> json) => _ExploreFeed(
  locationLabel: json['locationLabel'] as String,
  weather: json['weather'] == null
      ? null
      : WeatherSummary.fromJson(json['weather'] as Map<String, dynamic>),
  sections:
      (json['sections'] as List<dynamic>?)
          ?.map((e) => ExploreSection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ExploreSection>[],
  weekendStart: DateTime.parse(json['weekendStart'] as String),
  weekendEnd: DateTime.parse(json['weekendEnd'] as String),
  weekendDeals:
      (json['weekendDeals'] as List<dynamic>?)
          ?.map((e) => ListingOffer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ListingOffer>[],
);

Map<String, dynamic> _$ExploreFeedToJson(_ExploreFeed instance) =>
    <String, dynamic>{
      'locationLabel': instance.locationLabel,
      'weather': instance.weather?.toJson(),
      'sections': instance.sections.map((e) => e.toJson()).toList(),
      'weekendStart': instance.weekendStart.toIso8601String(),
      'weekendEnd': instance.weekendEnd.toIso8601String(),
      'weekendDeals': instance.weekendDeals.map((e) => e.toJson()).toList(),
    };
