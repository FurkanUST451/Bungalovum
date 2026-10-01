// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListingDetail _$ListingDetailFromJson(Map<String, dynamic> json) =>
    _ListingDetail(
      listing: Listing.fromJson(json['listing'] as Map<String, dynamic>),
      listingNo: json['listingNo'] as String,
      permitNo: json['permitNo'] as String,
      beds: (json['beds'] as num).toInt(),
      bathrooms: (json['bathrooms'] as num).toInt(),
      reviewCount: (json['reviewCount'] as num).toInt(),
      topPercent: (json['topPercent'] as num?)?.toInt(),
      host: HostSummary.fromJson(json['host'] as Map<String, dynamic>),
      highlights:
          (json['highlights'] as List<dynamic>?)
              ?.map((e) => ListingHighlight.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ListingHighlight>[],
      pool: json['pool'] == null
          ? null
          : PoolInfo.fromJson(json['pool'] as Map<String, dynamic>),
      description: ListingDescription.fromJson(
        json['description'] as Map<String, dynamic>,
      ),
      ratings: RatingBreakdown.fromJson(
        json['ratings'] as Map<String, dynamic>,
      ),
      reviewTopics:
          (json['reviewTopics'] as List<dynamic>?)
              ?.map((e) => ReviewTopicCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ReviewTopicCount>[],
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Review>[],
      amenityItems:
          (json['amenityItems'] as List<dynamic>?)
              ?.map((e) => AmenityItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AmenityItem>[],
      locationLabel: json['locationLabel'] as String,
      areaLabel: json['areaLabel'] as String,
      nearby:
          (json['nearby'] as List<dynamic>?)
              ?.map((e) => NearbyPlace.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <NearbyPlace>[],
      rules: HouseRules.fromJson(json['rules'] as Map<String, dynamic>),
      freeCancelHours: (json['freeCancelHours'] as num).toInt(),
      safety:
          (json['safety'] as List<dynamic>?)
              ?.map((e) => SafetyItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SafetyItem>[],
      photoRooms:
          (json['photoRooms'] as List<dynamic>?)
              ?.map((e) => PhotoRoom.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PhotoRoom>[],
      nearbyListingIds:
          (json['nearbyListingIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$ListingDetailToJson(_ListingDetail instance) =>
    <String, dynamic>{
      'listing': instance.listing.toJson(),
      'listingNo': instance.listingNo,
      'permitNo': instance.permitNo,
      'beds': instance.beds,
      'bathrooms': instance.bathrooms,
      'reviewCount': instance.reviewCount,
      'topPercent': instance.topPercent,
      'host': instance.host.toJson(),
      'highlights': instance.highlights.map((e) => e.toJson()).toList(),
      'pool': instance.pool?.toJson(),
      'description': instance.description.toJson(),
      'ratings': instance.ratings.toJson(),
      'reviewTopics': instance.reviewTopics.map((e) => e.toJson()).toList(),
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
      'amenityItems': instance.amenityItems.map((e) => e.toJson()).toList(),
      'locationLabel': instance.locationLabel,
      'areaLabel': instance.areaLabel,
      'nearby': instance.nearby.map((e) => e.toJson()).toList(),
      'rules': instance.rules.toJson(),
      'freeCancelHours': instance.freeCancelHours,
      'safety': instance.safety.map((e) => e.toJson()).toList(),
      'photoRooms': instance.photoRooms.map((e) => e.toJson()).toList(),
      'nearbyListingIds': instance.nearbyListingIds,
    };

_HostSummary _$HostSummaryFromJson(Map<String, dynamic> json) => _HostSummary(
  id: json['id'] as String,
  name: json['name'] as String,
  level:
      $enumDecodeNullable(_$HostLevelEnumMap, json['level']) ??
      HostLevel.standard,
  yearsHosting: (json['yearsHosting'] as num).toInt(),
  avatarUrl: json['avatarUrl'] as String?,
  reviewCount: (json['reviewCount'] as num).toInt(),
  rating: (json['rating'] as num).toDouble(),
  responseRate: (json['responseRate'] as num).toInt(),
  responseMinutes: (json['responseMinutes'] as num).toInt(),
  languages:
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  identityVerified: json['identityVerified'] as bool? ?? false,
  about: json['about'] as String? ?? '',
  listingIds:
      (json['listingIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
);

Map<String, dynamic> _$HostSummaryToJson(_HostSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'level': _$HostLevelEnumMap[instance.level]!,
      'yearsHosting': instance.yearsHosting,
      'avatarUrl': instance.avatarUrl,
      'reviewCount': instance.reviewCount,
      'rating': instance.rating,
      'responseRate': instance.responseRate,
      'responseMinutes': instance.responseMinutes,
      'languages': instance.languages,
      'identityVerified': instance.identityVerified,
      'about': instance.about,
      'listingIds': instance.listingIds,
    };

const _$HostLevelEnumMap = {
  HostLevel.standard: 'standard',
  HostLevel.superhost: 'superhost',
};

_ListingHighlight _$ListingHighlightFromJson(Map<String, dynamic> json) =>
    _ListingHighlight(
      kind: $enumDecode(_$HighlightKindEnumMap, json['kind']),
      title: json['title'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$ListingHighlightToJson(_ListingHighlight instance) =>
    <String, dynamic>{
      'kind': _$HighlightKindEnumMap[instance.kind]!,
      'title': instance.title,
      'body': instance.body,
    };

const _$HighlightKindEnumMap = {
  HighlightKind.topRated: 'topRated',
  HighlightKind.rarePool: 'rarePool',
  HighlightKind.greatCheckIn: 'greatCheckIn',
  HighlightKind.lakeView: 'lakeView',
  HighlightKind.selfCheckIn: 'selfCheckIn',
};

_PoolInfo _$PoolInfoFromJson(Map<String, dynamic> json) => _PoolInfo(
  private: json['private'] as bool? ?? true,
  heated: json['heated'] as bool? ?? false,
  temperatureC: (json['temperatureC'] as num?)?.toInt(),
  widthM: (json['widthM'] as num).toDouble(),
  lengthM: (json['lengthM'] as num).toDouble(),
  depthMinM: (json['depthMinM'] as num).toDouble(),
  depthMaxM: (json['depthMaxM'] as num).toDouble(),
  seasonStartMonth: (json['seasonStartMonth'] as num).toInt(),
  seasonEndMonth: (json['seasonEndMonth'] as num).toInt(),
  note: json['note'] as String? ?? '',
);

Map<String, dynamic> _$PoolInfoToJson(_PoolInfo instance) => <String, dynamic>{
  'private': instance.private,
  'heated': instance.heated,
  'temperatureC': instance.temperatureC,
  'widthM': instance.widthM,
  'lengthM': instance.lengthM,
  'depthMinM': instance.depthMinM,
  'depthMaxM': instance.depthMaxM,
  'seasonStartMonth': instance.seasonStartMonth,
  'seasonEndMonth': instance.seasonEndMonth,
  'note': instance.note,
};

_ListingDescription _$ListingDescriptionFromJson(Map<String, dynamic> json) =>
    _ListingDescription(
      summary: json['summary'] as String,
      space: json['space'] as String,
      guestAccess: json['guestAccess'] as String,
      otherNotes: json['otherNotes'] as String,
    );

Map<String, dynamic> _$ListingDescriptionToJson(_ListingDescription instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'space': instance.space,
      'guestAccess': instance.guestAccess,
      'otherNotes': instance.otherNotes,
    };

_RatingBreakdown _$RatingBreakdownFromJson(Map<String, dynamic> json) =>
    _RatingBreakdown(
      cleanliness: (json['cleanliness'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      communication: (json['communication'] as num).toDouble(),
      location: (json['location'] as num).toDouble(),
    );

Map<String, dynamic> _$RatingBreakdownToJson(_RatingBreakdown instance) =>
    <String, dynamic>{
      'cleanliness': instance.cleanliness,
      'accuracy': instance.accuracy,
      'communication': instance.communication,
      'location': instance.location,
    };

_ReviewTopicCount _$ReviewTopicCountFromJson(Map<String, dynamic> json) =>
    _ReviewTopicCount(
      topic: $enumDecode(_$ReviewTopicEnumMap, json['topic']),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$ReviewTopicCountToJson(_ReviewTopicCount instance) =>
    <String, dynamic>{
      'topic': _$ReviewTopicEnumMap[instance.topic]!,
      'count': instance.count,
    };

const _$ReviewTopicEnumMap = {
  ReviewTopic.pool: 'pool',
  ReviewTopic.cleanliness: 'cleanliness',
  ReviewTopic.host: 'host',
};

_Review _$ReviewFromJson(Map<String, dynamic> json) => _Review(
  id: json['id'] as String,
  author: json['author'] as String,
  city: json['city'] as String,
  rating: (json['rating'] as num).toInt(),
  date: DateTime.parse(json['date'] as String),
  text: json['text'] as String,
  topics:
      (json['topics'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ReviewTopicEnumMap, e))
          .toList() ??
      const <ReviewTopic>[],
);

Map<String, dynamic> _$ReviewToJson(_Review instance) => <String, dynamic>{
  'id': instance.id,
  'author': instance.author,
  'city': instance.city,
  'rating': instance.rating,
  'date': instance.date.toIso8601String(),
  'text': instance.text,
  'topics': instance.topics.map((e) => _$ReviewTopicEnumMap[e]!).toList(),
};

_AmenityItem _$AmenityItemFromJson(Map<String, dynamic> json) => _AmenityItem(
  kind: $enumDecode(_$AmenityKindEnumMap, json['kind']),
  group: $enumDecode(_$AmenityGroupEnumMap, json['group']),
  note: json['note'] as String?,
);

Map<String, dynamic> _$AmenityItemToJson(_AmenityItem instance) =>
    <String, dynamic>{
      'kind': _$AmenityKindEnumMap[instance.kind]!,
      'group': _$AmenityGroupEnumMap[instance.group]!,
      'note': instance.note,
    };

const _$AmenityKindEnumMap = {
  AmenityKind.privatePool: 'privatePool',
  AmenityKind.jacuzzi: 'jacuzzi',
  AmenityKind.barbecue: 'barbecue',
  AmenityKind.parking: 'parking',
  AmenityKind.kitchen: 'kitchen',
  AmenityKind.wifi: 'wifi',
  AmenityKind.airConditioning: 'airConditioning',
  AmenityKind.orthopedicBed: 'orthopedicBed',
  AmenityKind.fireplace: 'fireplace',
  AmenityKind.pets: 'pets',
  AmenityKind.stepFreeEntry: 'stepFreeEntry',
};

const _$AmenityGroupEnumMap = {
  AmenityGroup.outdoor: 'outdoor',
  AmenityGroup.indoor: 'indoor',
  AmenityGroup.notIncluded: 'notIncluded',
};

_NearbyPlace _$NearbyPlaceFromJson(Map<String, dynamic> json) => _NearbyPlace(
  kind: $enumDecode(_$NearbyKindEnumMap, json['kind']),
  name: json['name'] as String,
  distanceMeters: (json['distanceMeters'] as num).toInt(),
  minutes: (json['minutes'] as num).toInt(),
  walking: json['walking'] as bool? ?? false,
);

Map<String, dynamic> _$NearbyPlaceToJson(_NearbyPlace instance) =>
    <String, dynamic>{
      'kind': _$NearbyKindEnumMap[instance.kind]!,
      'name': instance.name,
      'distanceMeters': instance.distanceMeters,
      'minutes': instance.minutes,
      'walking': instance.walking,
    };

const _$NearbyKindEnumMap = {
  NearbyKind.lake: 'lake',
  NearbyKind.market: 'market',
  NearbyKind.mountain: 'mountain',
  NearbyKind.forest: 'forest',
};

_HouseRules _$HouseRulesFromJson(Map<String, dynamic> json) => _HouseRules(
  checkInFrom: json['checkInFrom'] as String,
  checkInTo: json['checkInTo'] as String,
  checkOutBy: json['checkOutBy'] as String,
  selfCheckIn:
      $enumDecodeNullable(_$SelfCheckInEnumMap, json['selfCheckIn']) ??
      SelfCheckIn.none,
  quietFrom: json['quietFrom'] as String,
  quietTo: json['quietTo'] as String,
  smokingAllowed: json['smokingAllowed'] as bool? ?? false,
);

Map<String, dynamic> _$HouseRulesToJson(_HouseRules instance) =>
    <String, dynamic>{
      'checkInFrom': instance.checkInFrom,
      'checkInTo': instance.checkInTo,
      'checkOutBy': instance.checkOutBy,
      'selfCheckIn': _$SelfCheckInEnumMap[instance.selfCheckIn]!,
      'quietFrom': instance.quietFrom,
      'quietTo': instance.quietTo,
      'smokingAllowed': instance.smokingAllowed,
    };

const _$SelfCheckInEnumMap = {
  SelfCheckIn.none: 'none',
  SelfCheckIn.keybox: 'keybox',
  SelfCheckIn.smartLock: 'smartLock',
};

_SafetyItem _$SafetyItemFromJson(Map<String, dynamic> json) => _SafetyItem(
  kind: $enumDecode(_$SafetyKindEnumMap, json['kind']),
  note: json['note'] as String?,
);

Map<String, dynamic> _$SafetyItemToJson(_SafetyItem instance) =>
    <String, dynamic>{
      'kind': _$SafetyKindEnumMap[instance.kind]!,
      'note': instance.note,
    };

const _$SafetyKindEnumMap = {
  SafetyKind.coAlarm: 'coAlarm',
  SafetyKind.smokeDetector: 'smokeDetector',
  SafetyKind.firstAidKit: 'firstAidKit',
  SafetyKind.fireExtinguisher: 'fireExtinguisher',
  SafetyKind.outdoorCamera: 'outdoorCamera',
};

_ListingPhoto _$ListingPhotoFromJson(Map<String, dynamic> json) =>
    _ListingPhoto(
      url: json['url'] as String?,
      caption: json['caption'] as String? ?? '',
    );

Map<String, dynamic> _$ListingPhotoToJson(_ListingPhoto instance) =>
    <String, dynamic>{'url': instance.url, 'caption': instance.caption};

_PhotoRoom _$PhotoRoomFromJson(Map<String, dynamic> json) => _PhotoRoom(
  kind: $enumDecode(_$RoomKindEnumMap, json['kind']),
  photos: (json['photos'] as List<dynamic>)
      .map((e) => ListingPhoto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PhotoRoomToJson(_PhotoRoom instance) =>
    <String, dynamic>{
      'kind': _$RoomKindEnumMap[instance.kind]!,
      'photos': instance.photos.map((e) => e.toJson()).toList(),
    };

const _$RoomKindEnumMap = {
  RoomKind.living: 'living',
  RoomKind.bedroom: 'bedroom',
  RoomKind.bathroom: 'bathroom',
  RoomKind.outdoor: 'outdoor',
  RoomKind.pool: 'pool',
};
