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

_ExploreFeed _$ExploreFeedFromJson(Map<String, dynamic> json) => _ExploreFeed(
  locationLabel: json['locationLabel'] as String,
  regionLocative: json['regionLocative'] as String,
  weather: json['weather'] == null
      ? null
      : WeatherSummary.fromJson(json['weather'] as Map<String, dynamic>),
  popular:
      (json['popular'] as List<dynamic>?)
          ?.map((e) => Listing.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Listing>[],
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
      'regionLocative': instance.regionLocative,
      'weather': instance.weather?.toJson(),
      'popular': instance.popular.map((e) => e.toJson()).toList(),
      'weekendStart': instance.weekendStart.toIso8601String(),
      'weekendEnd': instance.weekendEnd.toIso8601String(),
      'weekendDeals': instance.weekendDeals.map((e) => e.toJson()).toList(),
    };
