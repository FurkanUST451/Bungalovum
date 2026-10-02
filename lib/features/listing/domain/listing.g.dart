// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Listing _$ListingFromJson(Map<String, dynamic> json) => _Listing(
  id: json['id'] as String,
  title: json['title'] as String,
  district: json['district'] as String,
  propertyType: $enumDecode(_$PropertyTypeEnumMap, json['propertyType']),
  settings:
      (json['settings'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ListingSettingEnumMap, e))
          .toList() ??
      const <ListingSetting>[],
  amenities:
      (json['amenities'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$AmenityEnumMap, e))
          .toList() ??
      const <Amenity>[],
  maxGuests: (json['maxGuests'] as num).toInt(),
  rating: (json['rating'] as num?)?.toDouble(),
  nightlyPrice: (json['nightlyPrice'] as num).toInt(),
  highlight: json['highlight'] as String?,
  photoUrls:
      (json['photoUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  photoCount: (json['photoCount'] as num).toInt(),
  badge: $enumDecodeNullable(_$ListingBadgeEnumMap, json['badge']),
  region: json['region'] as String? ?? '',
  bedrooms: (json['bedrooms'] as num?)?.toInt() ?? 1,
  instantBook: json['instantBook'] as bool? ?? true,
  freeCancellation: json['freeCancellation'] as bool? ?? false,
  petsAllowed: json['petsAllowed'] as bool? ?? false,
  accessible: json['accessible'] as bool? ?? false,
  latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
  longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$ListingToJson(_Listing instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'district': instance.district,
  'propertyType': _$PropertyTypeEnumMap[instance.propertyType]!,
  'settings': instance.settings
      .map((e) => _$ListingSettingEnumMap[e]!)
      .toList(),
  'amenities': instance.amenities.map((e) => _$AmenityEnumMap[e]!).toList(),
  'maxGuests': instance.maxGuests,
  'rating': instance.rating,
  'nightlyPrice': instance.nightlyPrice,
  'highlight': instance.highlight,
  'photoUrls': instance.photoUrls,
  'photoCount': instance.photoCount,
  'badge': _$ListingBadgeEnumMap[instance.badge],
  'region': instance.region,
  'bedrooms': instance.bedrooms,
  'instantBook': instance.instantBook,
  'freeCancellation': instance.freeCancellation,
  'petsAllowed': instance.petsAllowed,
  'accessible': instance.accessible,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};

const _$PropertyTypeEnumMap = {
  PropertyType.bungalow: 'bungalow',
  PropertyType.aFrame: 'aFrame',
  PropertyType.treeHouse: 'treeHouse',
  PropertyType.stoneHouse: 'stoneHouse',
  PropertyType.glampingTent: 'glampingTent',
  PropertyType.tinyHouse: 'tinyHouse',
  PropertyType.cabin: 'cabin',
};

const _$ListingSettingEnumMap = {
  ListingSetting.lakeside: 'lakeside',
  ListingSetting.lakeView: 'lakeView',
  ListingSetting.forest: 'forest',
  ListingSetting.mountainView: 'mountainView',
  ListingSetting.nearSea: 'nearSea',
};

const _$AmenityEnumMap = {
  Amenity.pool: 'pool',
  Amenity.heatedPool: 'heatedPool',
  Amenity.jacuzzi: 'jacuzzi',
  Amenity.fireplace: 'fireplace',
  Amenity.airConditioning: 'airConditioning',
  Amenity.wifi: 'wifi',
  Amenity.parking: 'parking',
};

const _$ListingBadgeEnumMap = {
  ListingBadge.guestFavorite: 'guestFavorite',
  ListingBadge.rareFind: 'rareFind',
};
