// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListingDetail {

 Listing get listing;/// "KZ-1042"
 String get listingNo;/// Turizm/kısa dönem kiralama izin belge numarası (yayın için zorunlu).
 String get permitNo; int get beds; int get bathrooms; int get reviewCount;/// "En iyi %5" — yalnızca Misafirlerin gözdesi ilanlarda.
 int? get topPercent; HostSummary get host; List<ListingHighlight> get highlights; PoolInfo? get pool; ListingDescription get description; RatingBreakdown get ratings; List<ReviewTopicCount> get reviewTopics; List<Review> get reviews; List<AmenityItem> get amenityItems;/// "Sapanca, Sakarya, Türkiye"
 String get locationLabel;/// "Kırkpınar, Sapanca" — yaklaşık konum etiketi.
 String get areaLabel; List<NearbyPlace> get nearby; HouseRules get rules;/// Girişten kaç saat öncesine kadar ücretsiz iptal.
 int get freeCancelHours; List<SafetyItem> get safety; List<PhotoRoom> get photoRooms; List<String> get nearbyListingIds;
/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingDetailCopyWith<ListingDetail> get copyWith => _$ListingDetailCopyWithImpl<ListingDetail>(this as ListingDetail, _$identity);

  /// Serializes this ListingDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListingDetail&&(identical(other.listing, listing) || other.listing == listing)&&(identical(other.listingNo, listingNo) || other.listingNo == listingNo)&&(identical(other.permitNo, permitNo) || other.permitNo == permitNo)&&(identical(other.beds, beds) || other.beds == beds)&&(identical(other.bathrooms, bathrooms) || other.bathrooms == bathrooms)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.topPercent, topPercent) || other.topPercent == topPercent)&&(identical(other.host, host) || other.host == host)&&const DeepCollectionEquality().equals(other.highlights, highlights)&&(identical(other.pool, pool) || other.pool == pool)&&(identical(other.description, description) || other.description == description)&&(identical(other.ratings, ratings) || other.ratings == ratings)&&const DeepCollectionEquality().equals(other.reviewTopics, reviewTopics)&&const DeepCollectionEquality().equals(other.reviews, reviews)&&const DeepCollectionEquality().equals(other.amenityItems, amenityItems)&&(identical(other.locationLabel, locationLabel) || other.locationLabel == locationLabel)&&(identical(other.areaLabel, areaLabel) || other.areaLabel == areaLabel)&&const DeepCollectionEquality().equals(other.nearby, nearby)&&(identical(other.rules, rules) || other.rules == rules)&&(identical(other.freeCancelHours, freeCancelHours) || other.freeCancelHours == freeCancelHours)&&const DeepCollectionEquality().equals(other.safety, safety)&&const DeepCollectionEquality().equals(other.photoRooms, photoRooms)&&const DeepCollectionEquality().equals(other.nearbyListingIds, nearbyListingIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,listing,listingNo,permitNo,beds,bathrooms,reviewCount,topPercent,host,const DeepCollectionEquality().hash(highlights),pool,description,ratings,const DeepCollectionEquality().hash(reviewTopics),const DeepCollectionEquality().hash(reviews),const DeepCollectionEquality().hash(amenityItems),locationLabel,areaLabel,const DeepCollectionEquality().hash(nearby),rules,freeCancelHours,const DeepCollectionEquality().hash(safety),const DeepCollectionEquality().hash(photoRooms),const DeepCollectionEquality().hash(nearbyListingIds)]);

@override
String toString() {
  return 'ListingDetail(listing: $listing, listingNo: $listingNo, permitNo: $permitNo, beds: $beds, bathrooms: $bathrooms, reviewCount: $reviewCount, topPercent: $topPercent, host: $host, highlights: $highlights, pool: $pool, description: $description, ratings: $ratings, reviewTopics: $reviewTopics, reviews: $reviews, amenityItems: $amenityItems, locationLabel: $locationLabel, areaLabel: $areaLabel, nearby: $nearby, rules: $rules, freeCancelHours: $freeCancelHours, safety: $safety, photoRooms: $photoRooms, nearbyListingIds: $nearbyListingIds)';
}


}

/// @nodoc
abstract mixin class $ListingDetailCopyWith<$Res>  {
  factory $ListingDetailCopyWith(ListingDetail value, $Res Function(ListingDetail) _then) = _$ListingDetailCopyWithImpl;
@useResult
$Res call({
 Listing listing, String listingNo, String permitNo, int beds, int bathrooms, int reviewCount, int? topPercent, HostSummary host, List<ListingHighlight> highlights, PoolInfo? pool, ListingDescription description, RatingBreakdown ratings, List<ReviewTopicCount> reviewTopics, List<Review> reviews, List<AmenityItem> amenityItems, String locationLabel, String areaLabel, List<NearbyPlace> nearby, HouseRules rules, int freeCancelHours, List<SafetyItem> safety, List<PhotoRoom> photoRooms, List<String> nearbyListingIds
});


$ListingCopyWith<$Res> get listing;$HostSummaryCopyWith<$Res> get host;$PoolInfoCopyWith<$Res>? get pool;$ListingDescriptionCopyWith<$Res> get description;$RatingBreakdownCopyWith<$Res> get ratings;$HouseRulesCopyWith<$Res> get rules;

}
/// @nodoc
class _$ListingDetailCopyWithImpl<$Res>
    implements $ListingDetailCopyWith<$Res> {
  _$ListingDetailCopyWithImpl(this._self, this._then);

  final ListingDetail _self;
  final $Res Function(ListingDetail) _then;

/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listing = null,Object? listingNo = null,Object? permitNo = null,Object? beds = null,Object? bathrooms = null,Object? reviewCount = null,Object? topPercent = freezed,Object? host = null,Object? highlights = null,Object? pool = freezed,Object? description = null,Object? ratings = null,Object? reviewTopics = null,Object? reviews = null,Object? amenityItems = null,Object? locationLabel = null,Object? areaLabel = null,Object? nearby = null,Object? rules = null,Object? freeCancelHours = null,Object? safety = null,Object? photoRooms = null,Object? nearbyListingIds = null,}) {
  return _then(ListingDetail(
listing: null == listing ? _self.listing : listing // ignore: cast_nullable_to_non_nullable
as Listing,listingNo: null == listingNo ? _self.listingNo : listingNo // ignore: cast_nullable_to_non_nullable
as String,permitNo: null == permitNo ? _self.permitNo : permitNo // ignore: cast_nullable_to_non_nullable
as String,beds: null == beds ? _self.beds : beds // ignore: cast_nullable_to_non_nullable
as int,bathrooms: null == bathrooms ? _self.bathrooms : bathrooms // ignore: cast_nullable_to_non_nullable
as int,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,topPercent: freezed == topPercent ? _self.topPercent : topPercent // ignore: cast_nullable_to_non_nullable
as int?,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as HostSummary,highlights: null == highlights ? _self.highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<ListingHighlight>,pool: freezed == pool ? _self.pool : pool // ignore: cast_nullable_to_non_nullable
as PoolInfo?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as ListingDescription,ratings: null == ratings ? _self.ratings : ratings // ignore: cast_nullable_to_non_nullable
as RatingBreakdown,reviewTopics: null == reviewTopics ? _self.reviewTopics : reviewTopics // ignore: cast_nullable_to_non_nullable
as List<ReviewTopicCount>,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,amenityItems: null == amenityItems ? _self.amenityItems : amenityItems // ignore: cast_nullable_to_non_nullable
as List<AmenityItem>,locationLabel: null == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String,areaLabel: null == areaLabel ? _self.areaLabel : areaLabel // ignore: cast_nullable_to_non_nullable
as String,nearby: null == nearby ? _self.nearby : nearby // ignore: cast_nullable_to_non_nullable
as List<NearbyPlace>,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as HouseRules,freeCancelHours: null == freeCancelHours ? _self.freeCancelHours : freeCancelHours // ignore: cast_nullable_to_non_nullable
as int,safety: null == safety ? _self.safety : safety // ignore: cast_nullable_to_non_nullable
as List<SafetyItem>,photoRooms: null == photoRooms ? _self.photoRooms : photoRooms // ignore: cast_nullable_to_non_nullable
as List<PhotoRoom>,nearbyListingIds: null == nearbyListingIds ? _self.nearbyListingIds : nearbyListingIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListingCopyWith<$Res> get listing {
  
  return $ListingCopyWith<$Res>(_self.listing, (value) {
    return _then(_self.copyWith(listing: value));
  });
}/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HostSummaryCopyWith<$Res> get host {
  
  return $HostSummaryCopyWith<$Res>(_self.host, (value) {
    return _then(_self.copyWith(host: value));
  });
}/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PoolInfoCopyWith<$Res>? get pool {
    if (_self.pool == null) {
    return null;
  }

  return $PoolInfoCopyWith<$Res>(_self.pool!, (value) {
    return _then(_self.copyWith(pool: value));
  });
}/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListingDescriptionCopyWith<$Res> get description {
  
  return $ListingDescriptionCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RatingBreakdownCopyWith<$Res> get ratings {
  
  return $RatingBreakdownCopyWith<$Res>(_self.ratings, (value) {
    return _then(_self.copyWith(ratings: value));
  });
}/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HouseRulesCopyWith<$Res> get rules {
  
  return $HouseRulesCopyWith<$Res>(_self.rules, (value) {
    return _then(_self.copyWith(rules: value));
  });
}
}


/// Adds pattern-matching-related methods to [ListingDetail].
extension ListingDetailPatterns on ListingDetail {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListingDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListingDetail() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListingDetail value)  $default,){
final _that = this;
switch (_that) {
case _ListingDetail():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListingDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ListingDetail() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Listing listing,  String listingNo,  String permitNo,  int beds,  int bathrooms,  int reviewCount,  int? topPercent,  HostSummary host,  List<ListingHighlight> highlights,  PoolInfo? pool,  ListingDescription description,  RatingBreakdown ratings,  List<ReviewTopicCount> reviewTopics,  List<Review> reviews,  List<AmenityItem> amenityItems,  String locationLabel,  String areaLabel,  List<NearbyPlace> nearby,  HouseRules rules,  int freeCancelHours,  List<SafetyItem> safety,  List<PhotoRoom> photoRooms,  List<String> nearbyListingIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListingDetail() when $default != null:
return $default(_that.listing,_that.listingNo,_that.permitNo,_that.beds,_that.bathrooms,_that.reviewCount,_that.topPercent,_that.host,_that.highlights,_that.pool,_that.description,_that.ratings,_that.reviewTopics,_that.reviews,_that.amenityItems,_that.locationLabel,_that.areaLabel,_that.nearby,_that.rules,_that.freeCancelHours,_that.safety,_that.photoRooms,_that.nearbyListingIds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Listing listing,  String listingNo,  String permitNo,  int beds,  int bathrooms,  int reviewCount,  int? topPercent,  HostSummary host,  List<ListingHighlight> highlights,  PoolInfo? pool,  ListingDescription description,  RatingBreakdown ratings,  List<ReviewTopicCount> reviewTopics,  List<Review> reviews,  List<AmenityItem> amenityItems,  String locationLabel,  String areaLabel,  List<NearbyPlace> nearby,  HouseRules rules,  int freeCancelHours,  List<SafetyItem> safety,  List<PhotoRoom> photoRooms,  List<String> nearbyListingIds)  $default,) {final _that = this;
switch (_that) {
case _ListingDetail():
return $default(_that.listing,_that.listingNo,_that.permitNo,_that.beds,_that.bathrooms,_that.reviewCount,_that.topPercent,_that.host,_that.highlights,_that.pool,_that.description,_that.ratings,_that.reviewTopics,_that.reviews,_that.amenityItems,_that.locationLabel,_that.areaLabel,_that.nearby,_that.rules,_that.freeCancelHours,_that.safety,_that.photoRooms,_that.nearbyListingIds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Listing listing,  String listingNo,  String permitNo,  int beds,  int bathrooms,  int reviewCount,  int? topPercent,  HostSummary host,  List<ListingHighlight> highlights,  PoolInfo? pool,  ListingDescription description,  RatingBreakdown ratings,  List<ReviewTopicCount> reviewTopics,  List<Review> reviews,  List<AmenityItem> amenityItems,  String locationLabel,  String areaLabel,  List<NearbyPlace> nearby,  HouseRules rules,  int freeCancelHours,  List<SafetyItem> safety,  List<PhotoRoom> photoRooms,  List<String> nearbyListingIds)?  $default,) {final _that = this;
switch (_that) {
case _ListingDetail() when $default != null:
return $default(_that.listing,_that.listingNo,_that.permitNo,_that.beds,_that.bathrooms,_that.reviewCount,_that.topPercent,_that.host,_that.highlights,_that.pool,_that.description,_that.ratings,_that.reviewTopics,_that.reviews,_that.amenityItems,_that.locationLabel,_that.areaLabel,_that.nearby,_that.rules,_that.freeCancelHours,_that.safety,_that.photoRooms,_that.nearbyListingIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListingDetail implements ListingDetail {
  const _ListingDetail({required this.listing, required this.listingNo, required this.permitNo, required this.beds, required this.bathrooms, required this.reviewCount, this.topPercent, required this.host,  List<ListingHighlight> highlights = const <ListingHighlight>[], this.pool, required this.description, required this.ratings,  List<ReviewTopicCount> reviewTopics = const <ReviewTopicCount>[],  List<Review> reviews = const <Review>[],  List<AmenityItem> amenityItems = const <AmenityItem>[], required this.locationLabel, required this.areaLabel,  List<NearbyPlace> nearby = const <NearbyPlace>[], required this.rules, required this.freeCancelHours,  List<SafetyItem> safety = const <SafetyItem>[],  List<PhotoRoom> photoRooms = const <PhotoRoom>[],  List<String> nearbyListingIds = const <String>[]}): _highlights = highlights,_reviewTopics = reviewTopics,_reviews = reviews,_amenityItems = amenityItems,_nearby = nearby,_safety = safety,_photoRooms = photoRooms,_nearbyListingIds = nearbyListingIds;
  factory _ListingDetail.fromJson(Map<String, dynamic> json) => _$ListingDetailFromJson(json);

@override final  Listing listing;
/// "KZ-1042"
@override final  String listingNo;
/// Turizm/kısa dönem kiralama izin belge numarası (yayın için zorunlu).
@override final  String permitNo;
@override final  int beds;
@override final  int bathrooms;
@override final  int reviewCount;
/// "En iyi %5" — yalnızca Misafirlerin gözdesi ilanlarda.
@override final  int? topPercent;
@override final  HostSummary host;
 final  List<ListingHighlight> _highlights;
@override@JsonKey() List<ListingHighlight> get highlights {
  if (_highlights is EqualUnmodifiableListView) return _highlights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_highlights);
}

@override final  PoolInfo? pool;
@override final  ListingDescription description;
@override final  RatingBreakdown ratings;
 final  List<ReviewTopicCount> _reviewTopics;
@override@JsonKey() List<ReviewTopicCount> get reviewTopics {
  if (_reviewTopics is EqualUnmodifiableListView) return _reviewTopics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviewTopics);
}

 final  List<Review> _reviews;
@override@JsonKey() List<Review> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

 final  List<AmenityItem> _amenityItems;
@override@JsonKey() List<AmenityItem> get amenityItems {
  if (_amenityItems is EqualUnmodifiableListView) return _amenityItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_amenityItems);
}

/// "Sapanca, Sakarya, Türkiye"
@override final  String locationLabel;
/// "Kırkpınar, Sapanca" — yaklaşık konum etiketi.
@override final  String areaLabel;
 final  List<NearbyPlace> _nearby;
@override@JsonKey() List<NearbyPlace> get nearby {
  if (_nearby is EqualUnmodifiableListView) return _nearby;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nearby);
}

@override final  HouseRules rules;
/// Girişten kaç saat öncesine kadar ücretsiz iptal.
@override final  int freeCancelHours;
 final  List<SafetyItem> _safety;
@override@JsonKey() List<SafetyItem> get safety {
  if (_safety is EqualUnmodifiableListView) return _safety;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_safety);
}

 final  List<PhotoRoom> _photoRooms;
@override@JsonKey() List<PhotoRoom> get photoRooms {
  if (_photoRooms is EqualUnmodifiableListView) return _photoRooms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photoRooms);
}

 final  List<String> _nearbyListingIds;
@override@JsonKey() List<String> get nearbyListingIds {
  if (_nearbyListingIds is EqualUnmodifiableListView) return _nearbyListingIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nearbyListingIds);
}


/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingDetailCopyWith<_ListingDetail> get copyWith => __$ListingDetailCopyWithImpl<_ListingDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListingDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListingDetail&&(identical(other.listing, listing) || other.listing == listing)&&(identical(other.listingNo, listingNo) || other.listingNo == listingNo)&&(identical(other.permitNo, permitNo) || other.permitNo == permitNo)&&(identical(other.beds, beds) || other.beds == beds)&&(identical(other.bathrooms, bathrooms) || other.bathrooms == bathrooms)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.topPercent, topPercent) || other.topPercent == topPercent)&&(identical(other.host, host) || other.host == host)&&const DeepCollectionEquality().equals(other._highlights, _highlights)&&(identical(other.pool, pool) || other.pool == pool)&&(identical(other.description, description) || other.description == description)&&(identical(other.ratings, ratings) || other.ratings == ratings)&&const DeepCollectionEquality().equals(other._reviewTopics, _reviewTopics)&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&const DeepCollectionEquality().equals(other._amenityItems, _amenityItems)&&(identical(other.locationLabel, locationLabel) || other.locationLabel == locationLabel)&&(identical(other.areaLabel, areaLabel) || other.areaLabel == areaLabel)&&const DeepCollectionEquality().equals(other._nearby, _nearby)&&(identical(other.rules, rules) || other.rules == rules)&&(identical(other.freeCancelHours, freeCancelHours) || other.freeCancelHours == freeCancelHours)&&const DeepCollectionEquality().equals(other._safety, _safety)&&const DeepCollectionEquality().equals(other._photoRooms, _photoRooms)&&const DeepCollectionEquality().equals(other._nearbyListingIds, _nearbyListingIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,listing,listingNo,permitNo,beds,bathrooms,reviewCount,topPercent,host,const DeepCollectionEquality().hash(_highlights),pool,description,ratings,const DeepCollectionEquality().hash(_reviewTopics),const DeepCollectionEquality().hash(_reviews),const DeepCollectionEquality().hash(_amenityItems),locationLabel,areaLabel,const DeepCollectionEquality().hash(_nearby),rules,freeCancelHours,const DeepCollectionEquality().hash(_safety),const DeepCollectionEquality().hash(_photoRooms),const DeepCollectionEquality().hash(_nearbyListingIds)]);

@override
String toString() {
  return 'ListingDetail(listing: $listing, listingNo: $listingNo, permitNo: $permitNo, beds: $beds, bathrooms: $bathrooms, reviewCount: $reviewCount, topPercent: $topPercent, host: $host, highlights: $highlights, pool: $pool, description: $description, ratings: $ratings, reviewTopics: $reviewTopics, reviews: $reviews, amenityItems: $amenityItems, locationLabel: $locationLabel, areaLabel: $areaLabel, nearby: $nearby, rules: $rules, freeCancelHours: $freeCancelHours, safety: $safety, photoRooms: $photoRooms, nearbyListingIds: $nearbyListingIds)';
}


}

/// @nodoc
abstract mixin class _$ListingDetailCopyWith<$Res> implements $ListingDetailCopyWith<$Res> {
  factory _$ListingDetailCopyWith(_ListingDetail value, $Res Function(_ListingDetail) _then) = __$ListingDetailCopyWithImpl;
@override @useResult
$Res call({
 Listing listing, String listingNo, String permitNo, int beds, int bathrooms, int reviewCount, int? topPercent, HostSummary host, List<ListingHighlight> highlights, PoolInfo? pool, ListingDescription description, RatingBreakdown ratings, List<ReviewTopicCount> reviewTopics, List<Review> reviews, List<AmenityItem> amenityItems, String locationLabel, String areaLabel, List<NearbyPlace> nearby, HouseRules rules, int freeCancelHours, List<SafetyItem> safety, List<PhotoRoom> photoRooms, List<String> nearbyListingIds
});


@override $ListingCopyWith<$Res> get listing;@override $HostSummaryCopyWith<$Res> get host;@override $PoolInfoCopyWith<$Res>? get pool;@override $ListingDescriptionCopyWith<$Res> get description;@override $RatingBreakdownCopyWith<$Res> get ratings;@override $HouseRulesCopyWith<$Res> get rules;

}
/// @nodoc
class __$ListingDetailCopyWithImpl<$Res>
    implements _$ListingDetailCopyWith<$Res> {
  __$ListingDetailCopyWithImpl(this._self, this._then);

  final _ListingDetail _self;
  final $Res Function(_ListingDetail) _then;

/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listing = null,Object? listingNo = null,Object? permitNo = null,Object? beds = null,Object? bathrooms = null,Object? reviewCount = null,Object? topPercent = freezed,Object? host = null,Object? highlights = null,Object? pool = freezed,Object? description = null,Object? ratings = null,Object? reviewTopics = null,Object? reviews = null,Object? amenityItems = null,Object? locationLabel = null,Object? areaLabel = null,Object? nearby = null,Object? rules = null,Object? freeCancelHours = null,Object? safety = null,Object? photoRooms = null,Object? nearbyListingIds = null,}) {
  return _then(_ListingDetail(
listing: null == listing ? _self.listing : listing // ignore: cast_nullable_to_non_nullable
as Listing,listingNo: null == listingNo ? _self.listingNo : listingNo // ignore: cast_nullable_to_non_nullable
as String,permitNo: null == permitNo ? _self.permitNo : permitNo // ignore: cast_nullable_to_non_nullable
as String,beds: null == beds ? _self.beds : beds // ignore: cast_nullable_to_non_nullable
as int,bathrooms: null == bathrooms ? _self.bathrooms : bathrooms // ignore: cast_nullable_to_non_nullable
as int,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,topPercent: freezed == topPercent ? _self.topPercent : topPercent // ignore: cast_nullable_to_non_nullable
as int?,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as HostSummary,highlights: null == highlights ? _self._highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<ListingHighlight>,pool: freezed == pool ? _self.pool : pool // ignore: cast_nullable_to_non_nullable
as PoolInfo?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as ListingDescription,ratings: null == ratings ? _self.ratings : ratings // ignore: cast_nullable_to_non_nullable
as RatingBreakdown,reviewTopics: null == reviewTopics ? _self._reviewTopics : reviewTopics // ignore: cast_nullable_to_non_nullable
as List<ReviewTopicCount>,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,amenityItems: null == amenityItems ? _self._amenityItems : amenityItems // ignore: cast_nullable_to_non_nullable
as List<AmenityItem>,locationLabel: null == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String,areaLabel: null == areaLabel ? _self.areaLabel : areaLabel // ignore: cast_nullable_to_non_nullable
as String,nearby: null == nearby ? _self._nearby : nearby // ignore: cast_nullable_to_non_nullable
as List<NearbyPlace>,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as HouseRules,freeCancelHours: null == freeCancelHours ? _self.freeCancelHours : freeCancelHours // ignore: cast_nullable_to_non_nullable
as int,safety: null == safety ? _self._safety : safety // ignore: cast_nullable_to_non_nullable
as List<SafetyItem>,photoRooms: null == photoRooms ? _self._photoRooms : photoRooms // ignore: cast_nullable_to_non_nullable
as List<PhotoRoom>,nearbyListingIds: null == nearbyListingIds ? _self._nearbyListingIds : nearbyListingIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListingCopyWith<$Res> get listing {
  
  return $ListingCopyWith<$Res>(_self.listing, (value) {
    return _then(_self.copyWith(listing: value));
  });
}/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HostSummaryCopyWith<$Res> get host {
  
  return $HostSummaryCopyWith<$Res>(_self.host, (value) {
    return _then(_self.copyWith(host: value));
  });
}/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PoolInfoCopyWith<$Res>? get pool {
    if (_self.pool == null) {
    return null;
  }

  return $PoolInfoCopyWith<$Res>(_self.pool!, (value) {
    return _then(_self.copyWith(pool: value));
  });
}/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListingDescriptionCopyWith<$Res> get description {
  
  return $ListingDescriptionCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RatingBreakdownCopyWith<$Res> get ratings {
  
  return $RatingBreakdownCopyWith<$Res>(_self.ratings, (value) {
    return _then(_self.copyWith(ratings: value));
  });
}/// Create a copy of ListingDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HouseRulesCopyWith<$Res> get rules {
  
  return $HouseRulesCopyWith<$Res>(_self.rules, (value) {
    return _then(_self.copyWith(rules: value));
  });
}
}


/// @nodoc
mixin _$HostSummary {

 String get id; String get name; HostLevel get level; int get yearsHosting; String? get avatarUrl; int get reviewCount; double get rating;/// Yüzde (0–100).
 int get responseRate;/// Dakika cinsinden ortalama yanıt süresi.
 int get responseMinutes; List<String> get languages; bool get identityVerified; String get about; List<String> get listingIds;
/// Create a copy of HostSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HostSummaryCopyWith<HostSummary> get copyWith => _$HostSummaryCopyWithImpl<HostSummary>(this as HostSummary, _$identity);

  /// Serializes this HostSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HostSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.level, level) || other.level == level)&&(identical(other.yearsHosting, yearsHosting) || other.yearsHosting == yearsHosting)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.responseRate, responseRate) || other.responseRate == responseRate)&&(identical(other.responseMinutes, responseMinutes) || other.responseMinutes == responseMinutes)&&const DeepCollectionEquality().equals(other.languages, languages)&&(identical(other.identityVerified, identityVerified) || other.identityVerified == identityVerified)&&(identical(other.about, about) || other.about == about)&&const DeepCollectionEquality().equals(other.listingIds, listingIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,level,yearsHosting,avatarUrl,reviewCount,rating,responseRate,responseMinutes,const DeepCollectionEquality().hash(languages),identityVerified,about,const DeepCollectionEquality().hash(listingIds));

@override
String toString() {
  return 'HostSummary(id: $id, name: $name, level: $level, yearsHosting: $yearsHosting, avatarUrl: $avatarUrl, reviewCount: $reviewCount, rating: $rating, responseRate: $responseRate, responseMinutes: $responseMinutes, languages: $languages, identityVerified: $identityVerified, about: $about, listingIds: $listingIds)';
}


}

/// @nodoc
abstract mixin class $HostSummaryCopyWith<$Res>  {
  factory $HostSummaryCopyWith(HostSummary value, $Res Function(HostSummary) _then) = _$HostSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String name, HostLevel level, int yearsHosting, String? avatarUrl, int reviewCount, double rating, int responseRate, int responseMinutes, List<String> languages, bool identityVerified, String about, List<String> listingIds
});




}
/// @nodoc
class _$HostSummaryCopyWithImpl<$Res>
    implements $HostSummaryCopyWith<$Res> {
  _$HostSummaryCopyWithImpl(this._self, this._then);

  final HostSummary _self;
  final $Res Function(HostSummary) _then;

/// Create a copy of HostSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? level = null,Object? yearsHosting = null,Object? avatarUrl = freezed,Object? reviewCount = null,Object? rating = null,Object? responseRate = null,Object? responseMinutes = null,Object? languages = null,Object? identityVerified = null,Object? about = null,Object? listingIds = null,}) {
  return _then(HostSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as HostLevel,yearsHosting: null == yearsHosting ? _self.yearsHosting : yearsHosting // ignore: cast_nullable_to_non_nullable
as int,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,responseRate: null == responseRate ? _self.responseRate : responseRate // ignore: cast_nullable_to_non_nullable
as int,responseMinutes: null == responseMinutes ? _self.responseMinutes : responseMinutes // ignore: cast_nullable_to_non_nullable
as int,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,identityVerified: null == identityVerified ? _self.identityVerified : identityVerified // ignore: cast_nullable_to_non_nullable
as bool,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,listingIds: null == listingIds ? _self.listingIds : listingIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [HostSummary].
extension HostSummaryPatterns on HostSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HostSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HostSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HostSummary value)  $default,){
final _that = this;
switch (_that) {
case _HostSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HostSummary value)?  $default,){
final _that = this;
switch (_that) {
case _HostSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  HostLevel level,  int yearsHosting,  String? avatarUrl,  int reviewCount,  double rating,  int responseRate,  int responseMinutes,  List<String> languages,  bool identityVerified,  String about,  List<String> listingIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HostSummary() when $default != null:
return $default(_that.id,_that.name,_that.level,_that.yearsHosting,_that.avatarUrl,_that.reviewCount,_that.rating,_that.responseRate,_that.responseMinutes,_that.languages,_that.identityVerified,_that.about,_that.listingIds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  HostLevel level,  int yearsHosting,  String? avatarUrl,  int reviewCount,  double rating,  int responseRate,  int responseMinutes,  List<String> languages,  bool identityVerified,  String about,  List<String> listingIds)  $default,) {final _that = this;
switch (_that) {
case _HostSummary():
return $default(_that.id,_that.name,_that.level,_that.yearsHosting,_that.avatarUrl,_that.reviewCount,_that.rating,_that.responseRate,_that.responseMinutes,_that.languages,_that.identityVerified,_that.about,_that.listingIds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  HostLevel level,  int yearsHosting,  String? avatarUrl,  int reviewCount,  double rating,  int responseRate,  int responseMinutes,  List<String> languages,  bool identityVerified,  String about,  List<String> listingIds)?  $default,) {final _that = this;
switch (_that) {
case _HostSummary() when $default != null:
return $default(_that.id,_that.name,_that.level,_that.yearsHosting,_that.avatarUrl,_that.reviewCount,_that.rating,_that.responseRate,_that.responseMinutes,_that.languages,_that.identityVerified,_that.about,_that.listingIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HostSummary implements HostSummary {
  const _HostSummary({required this.id, required this.name, this.level = HostLevel.standard, required this.yearsHosting, this.avatarUrl, required this.reviewCount, required this.rating, required this.responseRate, required this.responseMinutes,  List<String> languages = const <String>[], this.identityVerified = false, this.about = '',  List<String> listingIds = const <String>[]}): _languages = languages,_listingIds = listingIds;
  factory _HostSummary.fromJson(Map<String, dynamic> json) => _$HostSummaryFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  HostLevel level;
@override final  int yearsHosting;
@override final  String? avatarUrl;
@override final  int reviewCount;
@override final  double rating;
/// Yüzde (0–100).
@override final  int responseRate;
/// Dakika cinsinden ortalama yanıt süresi.
@override final  int responseMinutes;
 final  List<String> _languages;
@override@JsonKey() List<String> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

@override@JsonKey() final  bool identityVerified;
@override@JsonKey() final  String about;
 final  List<String> _listingIds;
@override@JsonKey() List<String> get listingIds {
  if (_listingIds is EqualUnmodifiableListView) return _listingIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listingIds);
}


/// Create a copy of HostSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HostSummaryCopyWith<_HostSummary> get copyWith => __$HostSummaryCopyWithImpl<_HostSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HostSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HostSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.level, level) || other.level == level)&&(identical(other.yearsHosting, yearsHosting) || other.yearsHosting == yearsHosting)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.responseRate, responseRate) || other.responseRate == responseRate)&&(identical(other.responseMinutes, responseMinutes) || other.responseMinutes == responseMinutes)&&const DeepCollectionEquality().equals(other._languages, _languages)&&(identical(other.identityVerified, identityVerified) || other.identityVerified == identityVerified)&&(identical(other.about, about) || other.about == about)&&const DeepCollectionEquality().equals(other._listingIds, _listingIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,level,yearsHosting,avatarUrl,reviewCount,rating,responseRate,responseMinutes,const DeepCollectionEquality().hash(_languages),identityVerified,about,const DeepCollectionEquality().hash(_listingIds));

@override
String toString() {
  return 'HostSummary(id: $id, name: $name, level: $level, yearsHosting: $yearsHosting, avatarUrl: $avatarUrl, reviewCount: $reviewCount, rating: $rating, responseRate: $responseRate, responseMinutes: $responseMinutes, languages: $languages, identityVerified: $identityVerified, about: $about, listingIds: $listingIds)';
}


}

/// @nodoc
abstract mixin class _$HostSummaryCopyWith<$Res> implements $HostSummaryCopyWith<$Res> {
  factory _$HostSummaryCopyWith(_HostSummary value, $Res Function(_HostSummary) _then) = __$HostSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, HostLevel level, int yearsHosting, String? avatarUrl, int reviewCount, double rating, int responseRate, int responseMinutes, List<String> languages, bool identityVerified, String about, List<String> listingIds
});




}
/// @nodoc
class __$HostSummaryCopyWithImpl<$Res>
    implements _$HostSummaryCopyWith<$Res> {
  __$HostSummaryCopyWithImpl(this._self, this._then);

  final _HostSummary _self;
  final $Res Function(_HostSummary) _then;

/// Create a copy of HostSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? level = null,Object? yearsHosting = null,Object? avatarUrl = freezed,Object? reviewCount = null,Object? rating = null,Object? responseRate = null,Object? responseMinutes = null,Object? languages = null,Object? identityVerified = null,Object? about = null,Object? listingIds = null,}) {
  return _then(_HostSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as HostLevel,yearsHosting: null == yearsHosting ? _self.yearsHosting : yearsHosting // ignore: cast_nullable_to_non_nullable
as int,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,responseRate: null == responseRate ? _self.responseRate : responseRate // ignore: cast_nullable_to_non_nullable
as int,responseMinutes: null == responseMinutes ? _self.responseMinutes : responseMinutes // ignore: cast_nullable_to_non_nullable
as int,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,identityVerified: null == identityVerified ? _self.identityVerified : identityVerified // ignore: cast_nullable_to_non_nullable
as bool,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,listingIds: null == listingIds ? _self._listingIds : listingIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ListingHighlight {

 HighlightKind get kind; String get title; String get body;
/// Create a copy of ListingHighlight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingHighlightCopyWith<ListingHighlight> get copyWith => _$ListingHighlightCopyWithImpl<ListingHighlight>(this as ListingHighlight, _$identity);

  /// Serializes this ListingHighlight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListingHighlight&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,title,body);

@override
String toString() {
  return 'ListingHighlight(kind: $kind, title: $title, body: $body)';
}


}

/// @nodoc
abstract mixin class $ListingHighlightCopyWith<$Res>  {
  factory $ListingHighlightCopyWith(ListingHighlight value, $Res Function(ListingHighlight) _then) = _$ListingHighlightCopyWithImpl;
@useResult
$Res call({
 HighlightKind kind, String title, String body
});




}
/// @nodoc
class _$ListingHighlightCopyWithImpl<$Res>
    implements $ListingHighlightCopyWith<$Res> {
  _$ListingHighlightCopyWithImpl(this._self, this._then);

  final ListingHighlight _self;
  final $Res Function(ListingHighlight) _then;

/// Create a copy of ListingHighlight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? title = null,Object? body = null,}) {
  return _then(ListingHighlight(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as HighlightKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ListingHighlight].
extension ListingHighlightPatterns on ListingHighlight {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListingHighlight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListingHighlight() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListingHighlight value)  $default,){
final _that = this;
switch (_that) {
case _ListingHighlight():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListingHighlight value)?  $default,){
final _that = this;
switch (_that) {
case _ListingHighlight() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HighlightKind kind,  String title,  String body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListingHighlight() when $default != null:
return $default(_that.kind,_that.title,_that.body);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HighlightKind kind,  String title,  String body)  $default,) {final _that = this;
switch (_that) {
case _ListingHighlight():
return $default(_that.kind,_that.title,_that.body);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HighlightKind kind,  String title,  String body)?  $default,) {final _that = this;
switch (_that) {
case _ListingHighlight() when $default != null:
return $default(_that.kind,_that.title,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListingHighlight implements ListingHighlight {
  const _ListingHighlight({required this.kind, required this.title, required this.body});
  factory _ListingHighlight.fromJson(Map<String, dynamic> json) => _$ListingHighlightFromJson(json);

@override final  HighlightKind kind;
@override final  String title;
@override final  String body;

/// Create a copy of ListingHighlight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingHighlightCopyWith<_ListingHighlight> get copyWith => __$ListingHighlightCopyWithImpl<_ListingHighlight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListingHighlightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListingHighlight&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,title,body);

@override
String toString() {
  return 'ListingHighlight(kind: $kind, title: $title, body: $body)';
}


}

/// @nodoc
abstract mixin class _$ListingHighlightCopyWith<$Res> implements $ListingHighlightCopyWith<$Res> {
  factory _$ListingHighlightCopyWith(_ListingHighlight value, $Res Function(_ListingHighlight) _then) = __$ListingHighlightCopyWithImpl;
@override @useResult
$Res call({
 HighlightKind kind, String title, String body
});




}
/// @nodoc
class __$ListingHighlightCopyWithImpl<$Res>
    implements _$ListingHighlightCopyWith<$Res> {
  __$ListingHighlightCopyWithImpl(this._self, this._then);

  final _ListingHighlight _self;
  final $Res Function(_ListingHighlight) _then;

/// Create a copy of ListingHighlight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? title = null,Object? body = null,}) {
  return _then(_ListingHighlight(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as HighlightKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PoolInfo {

/// Sana özel (paylaşımsız) ya da ortak.
 bool get private; bool get heated; int? get temperatureC; double get widthM; double get lengthM; double get depthMinM; double get depthMaxM;/// Açık olduğu aylar (1–12).
 int get seasonStartMonth; int get seasonEndMonth; String get note;
/// Create a copy of PoolInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PoolInfoCopyWith<PoolInfo> get copyWith => _$PoolInfoCopyWithImpl<PoolInfo>(this as PoolInfo, _$identity);

  /// Serializes this PoolInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PoolInfo&&(identical(other.private, private) || other.private == private)&&(identical(other.heated, heated) || other.heated == heated)&&(identical(other.temperatureC, temperatureC) || other.temperatureC == temperatureC)&&(identical(other.widthM, widthM) || other.widthM == widthM)&&(identical(other.lengthM, lengthM) || other.lengthM == lengthM)&&(identical(other.depthMinM, depthMinM) || other.depthMinM == depthMinM)&&(identical(other.depthMaxM, depthMaxM) || other.depthMaxM == depthMaxM)&&(identical(other.seasonStartMonth, seasonStartMonth) || other.seasonStartMonth == seasonStartMonth)&&(identical(other.seasonEndMonth, seasonEndMonth) || other.seasonEndMonth == seasonEndMonth)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,private,heated,temperatureC,widthM,lengthM,depthMinM,depthMaxM,seasonStartMonth,seasonEndMonth,note);

@override
String toString() {
  return 'PoolInfo(private: $private, heated: $heated, temperatureC: $temperatureC, widthM: $widthM, lengthM: $lengthM, depthMinM: $depthMinM, depthMaxM: $depthMaxM, seasonStartMonth: $seasonStartMonth, seasonEndMonth: $seasonEndMonth, note: $note)';
}


}

/// @nodoc
abstract mixin class $PoolInfoCopyWith<$Res>  {
  factory $PoolInfoCopyWith(PoolInfo value, $Res Function(PoolInfo) _then) = _$PoolInfoCopyWithImpl;
@useResult
$Res call({
 bool private, bool heated, int? temperatureC, double widthM, double lengthM, double depthMinM, double depthMaxM, int seasonStartMonth, int seasonEndMonth, String note
});




}
/// @nodoc
class _$PoolInfoCopyWithImpl<$Res>
    implements $PoolInfoCopyWith<$Res> {
  _$PoolInfoCopyWithImpl(this._self, this._then);

  final PoolInfo _self;
  final $Res Function(PoolInfo) _then;

/// Create a copy of PoolInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? private = null,Object? heated = null,Object? temperatureC = freezed,Object? widthM = null,Object? lengthM = null,Object? depthMinM = null,Object? depthMaxM = null,Object? seasonStartMonth = null,Object? seasonEndMonth = null,Object? note = null,}) {
  return _then(PoolInfo(
private: null == private ? _self.private : private // ignore: cast_nullable_to_non_nullable
as bool,heated: null == heated ? _self.heated : heated // ignore: cast_nullable_to_non_nullable
as bool,temperatureC: freezed == temperatureC ? _self.temperatureC : temperatureC // ignore: cast_nullable_to_non_nullable
as int?,widthM: null == widthM ? _self.widthM : widthM // ignore: cast_nullable_to_non_nullable
as double,lengthM: null == lengthM ? _self.lengthM : lengthM // ignore: cast_nullable_to_non_nullable
as double,depthMinM: null == depthMinM ? _self.depthMinM : depthMinM // ignore: cast_nullable_to_non_nullable
as double,depthMaxM: null == depthMaxM ? _self.depthMaxM : depthMaxM // ignore: cast_nullable_to_non_nullable
as double,seasonStartMonth: null == seasonStartMonth ? _self.seasonStartMonth : seasonStartMonth // ignore: cast_nullable_to_non_nullable
as int,seasonEndMonth: null == seasonEndMonth ? _self.seasonEndMonth : seasonEndMonth // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PoolInfo].
extension PoolInfoPatterns on PoolInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PoolInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PoolInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PoolInfo value)  $default,){
final _that = this;
switch (_that) {
case _PoolInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PoolInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PoolInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool private,  bool heated,  int? temperatureC,  double widthM,  double lengthM,  double depthMinM,  double depthMaxM,  int seasonStartMonth,  int seasonEndMonth,  String note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PoolInfo() when $default != null:
return $default(_that.private,_that.heated,_that.temperatureC,_that.widthM,_that.lengthM,_that.depthMinM,_that.depthMaxM,_that.seasonStartMonth,_that.seasonEndMonth,_that.note);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool private,  bool heated,  int? temperatureC,  double widthM,  double lengthM,  double depthMinM,  double depthMaxM,  int seasonStartMonth,  int seasonEndMonth,  String note)  $default,) {final _that = this;
switch (_that) {
case _PoolInfo():
return $default(_that.private,_that.heated,_that.temperatureC,_that.widthM,_that.lengthM,_that.depthMinM,_that.depthMaxM,_that.seasonStartMonth,_that.seasonEndMonth,_that.note);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool private,  bool heated,  int? temperatureC,  double widthM,  double lengthM,  double depthMinM,  double depthMaxM,  int seasonStartMonth,  int seasonEndMonth,  String note)?  $default,) {final _that = this;
switch (_that) {
case _PoolInfo() when $default != null:
return $default(_that.private,_that.heated,_that.temperatureC,_that.widthM,_that.lengthM,_that.depthMinM,_that.depthMaxM,_that.seasonStartMonth,_that.seasonEndMonth,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PoolInfo implements PoolInfo {
  const _PoolInfo({this.private = true, this.heated = false, this.temperatureC, required this.widthM, required this.lengthM, required this.depthMinM, required this.depthMaxM, required this.seasonStartMonth, required this.seasonEndMonth, this.note = ''});
  factory _PoolInfo.fromJson(Map<String, dynamic> json) => _$PoolInfoFromJson(json);

/// Sana özel (paylaşımsız) ya da ortak.
@override@JsonKey() final  bool private;
@override@JsonKey() final  bool heated;
@override final  int? temperatureC;
@override final  double widthM;
@override final  double lengthM;
@override final  double depthMinM;
@override final  double depthMaxM;
/// Açık olduğu aylar (1–12).
@override final  int seasonStartMonth;
@override final  int seasonEndMonth;
@override@JsonKey() final  String note;

/// Create a copy of PoolInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PoolInfoCopyWith<_PoolInfo> get copyWith => __$PoolInfoCopyWithImpl<_PoolInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PoolInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PoolInfo&&(identical(other.private, private) || other.private == private)&&(identical(other.heated, heated) || other.heated == heated)&&(identical(other.temperatureC, temperatureC) || other.temperatureC == temperatureC)&&(identical(other.widthM, widthM) || other.widthM == widthM)&&(identical(other.lengthM, lengthM) || other.lengthM == lengthM)&&(identical(other.depthMinM, depthMinM) || other.depthMinM == depthMinM)&&(identical(other.depthMaxM, depthMaxM) || other.depthMaxM == depthMaxM)&&(identical(other.seasonStartMonth, seasonStartMonth) || other.seasonStartMonth == seasonStartMonth)&&(identical(other.seasonEndMonth, seasonEndMonth) || other.seasonEndMonth == seasonEndMonth)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,private,heated,temperatureC,widthM,lengthM,depthMinM,depthMaxM,seasonStartMonth,seasonEndMonth,note);

@override
String toString() {
  return 'PoolInfo(private: $private, heated: $heated, temperatureC: $temperatureC, widthM: $widthM, lengthM: $lengthM, depthMinM: $depthMinM, depthMaxM: $depthMaxM, seasonStartMonth: $seasonStartMonth, seasonEndMonth: $seasonEndMonth, note: $note)';
}


}

/// @nodoc
abstract mixin class _$PoolInfoCopyWith<$Res> implements $PoolInfoCopyWith<$Res> {
  factory _$PoolInfoCopyWith(_PoolInfo value, $Res Function(_PoolInfo) _then) = __$PoolInfoCopyWithImpl;
@override @useResult
$Res call({
 bool private, bool heated, int? temperatureC, double widthM, double lengthM, double depthMinM, double depthMaxM, int seasonStartMonth, int seasonEndMonth, String note
});




}
/// @nodoc
class __$PoolInfoCopyWithImpl<$Res>
    implements _$PoolInfoCopyWith<$Res> {
  __$PoolInfoCopyWithImpl(this._self, this._then);

  final _PoolInfo _self;
  final $Res Function(_PoolInfo) _then;

/// Create a copy of PoolInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? private = null,Object? heated = null,Object? temperatureC = freezed,Object? widthM = null,Object? lengthM = null,Object? depthMinM = null,Object? depthMaxM = null,Object? seasonStartMonth = null,Object? seasonEndMonth = null,Object? note = null,}) {
  return _then(_PoolInfo(
private: null == private ? _self.private : private // ignore: cast_nullable_to_non_nullable
as bool,heated: null == heated ? _self.heated : heated // ignore: cast_nullable_to_non_nullable
as bool,temperatureC: freezed == temperatureC ? _self.temperatureC : temperatureC // ignore: cast_nullable_to_non_nullable
as int?,widthM: null == widthM ? _self.widthM : widthM // ignore: cast_nullable_to_non_nullable
as double,lengthM: null == lengthM ? _self.lengthM : lengthM // ignore: cast_nullable_to_non_nullable
as double,depthMinM: null == depthMinM ? _self.depthMinM : depthMinM // ignore: cast_nullable_to_non_nullable
as double,depthMaxM: null == depthMaxM ? _self.depthMaxM : depthMaxM // ignore: cast_nullable_to_non_nullable
as double,seasonStartMonth: null == seasonStartMonth ? _self.seasonStartMonth : seasonStartMonth // ignore: cast_nullable_to_non_nullable
as int,seasonEndMonth: null == seasonEndMonth ? _self.seasonEndMonth : seasonEndMonth // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ListingDescription {

 String get summary; String get space; String get guestAccess; String get otherNotes;
/// Create a copy of ListingDescription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingDescriptionCopyWith<ListingDescription> get copyWith => _$ListingDescriptionCopyWithImpl<ListingDescription>(this as ListingDescription, _$identity);

  /// Serializes this ListingDescription to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListingDescription&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.space, space) || other.space == space)&&(identical(other.guestAccess, guestAccess) || other.guestAccess == guestAccess)&&(identical(other.otherNotes, otherNotes) || other.otherNotes == otherNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,space,guestAccess,otherNotes);

@override
String toString() {
  return 'ListingDescription(summary: $summary, space: $space, guestAccess: $guestAccess, otherNotes: $otherNotes)';
}


}

/// @nodoc
abstract mixin class $ListingDescriptionCopyWith<$Res>  {
  factory $ListingDescriptionCopyWith(ListingDescription value, $Res Function(ListingDescription) _then) = _$ListingDescriptionCopyWithImpl;
@useResult
$Res call({
 String summary, String space, String guestAccess, String otherNotes
});




}
/// @nodoc
class _$ListingDescriptionCopyWithImpl<$Res>
    implements $ListingDescriptionCopyWith<$Res> {
  _$ListingDescriptionCopyWithImpl(this._self, this._then);

  final ListingDescription _self;
  final $Res Function(ListingDescription) _then;

/// Create a copy of ListingDescription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? space = null,Object? guestAccess = null,Object? otherNotes = null,}) {
  return _then(ListingDescription(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,space: null == space ? _self.space : space // ignore: cast_nullable_to_non_nullable
as String,guestAccess: null == guestAccess ? _self.guestAccess : guestAccess // ignore: cast_nullable_to_non_nullable
as String,otherNotes: null == otherNotes ? _self.otherNotes : otherNotes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ListingDescription].
extension ListingDescriptionPatterns on ListingDescription {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListingDescription value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListingDescription() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListingDescription value)  $default,){
final _that = this;
switch (_that) {
case _ListingDescription():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListingDescription value)?  $default,){
final _that = this;
switch (_that) {
case _ListingDescription() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String summary,  String space,  String guestAccess,  String otherNotes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListingDescription() when $default != null:
return $default(_that.summary,_that.space,_that.guestAccess,_that.otherNotes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String summary,  String space,  String guestAccess,  String otherNotes)  $default,) {final _that = this;
switch (_that) {
case _ListingDescription():
return $default(_that.summary,_that.space,_that.guestAccess,_that.otherNotes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String summary,  String space,  String guestAccess,  String otherNotes)?  $default,) {final _that = this;
switch (_that) {
case _ListingDescription() when $default != null:
return $default(_that.summary,_that.space,_that.guestAccess,_that.otherNotes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListingDescription implements ListingDescription {
  const _ListingDescription({required this.summary, required this.space, required this.guestAccess, required this.otherNotes});
  factory _ListingDescription.fromJson(Map<String, dynamic> json) => _$ListingDescriptionFromJson(json);

@override final  String summary;
@override final  String space;
@override final  String guestAccess;
@override final  String otherNotes;

/// Create a copy of ListingDescription
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingDescriptionCopyWith<_ListingDescription> get copyWith => __$ListingDescriptionCopyWithImpl<_ListingDescription>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListingDescriptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListingDescription&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.space, space) || other.space == space)&&(identical(other.guestAccess, guestAccess) || other.guestAccess == guestAccess)&&(identical(other.otherNotes, otherNotes) || other.otherNotes == otherNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,space,guestAccess,otherNotes);

@override
String toString() {
  return 'ListingDescription(summary: $summary, space: $space, guestAccess: $guestAccess, otherNotes: $otherNotes)';
}


}

/// @nodoc
abstract mixin class _$ListingDescriptionCopyWith<$Res> implements $ListingDescriptionCopyWith<$Res> {
  factory _$ListingDescriptionCopyWith(_ListingDescription value, $Res Function(_ListingDescription) _then) = __$ListingDescriptionCopyWithImpl;
@override @useResult
$Res call({
 String summary, String space, String guestAccess, String otherNotes
});




}
/// @nodoc
class __$ListingDescriptionCopyWithImpl<$Res>
    implements _$ListingDescriptionCopyWith<$Res> {
  __$ListingDescriptionCopyWithImpl(this._self, this._then);

  final _ListingDescription _self;
  final $Res Function(_ListingDescription) _then;

/// Create a copy of ListingDescription
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? space = null,Object? guestAccess = null,Object? otherNotes = null,}) {
  return _then(_ListingDescription(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,space: null == space ? _self.space : space // ignore: cast_nullable_to_non_nullable
as String,guestAccess: null == guestAccess ? _self.guestAccess : guestAccess // ignore: cast_nullable_to_non_nullable
as String,otherNotes: null == otherNotes ? _self.otherNotes : otherNotes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RatingBreakdown {

 double get cleanliness; double get accuracy; double get communication; double get location;
/// Create a copy of RatingBreakdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatingBreakdownCopyWith<RatingBreakdown> get copyWith => _$RatingBreakdownCopyWithImpl<RatingBreakdown>(this as RatingBreakdown, _$identity);

  /// Serializes this RatingBreakdown to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingBreakdown&&(identical(other.cleanliness, cleanliness) || other.cleanliness == cleanliness)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.communication, communication) || other.communication == communication)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cleanliness,accuracy,communication,location);

@override
String toString() {
  return 'RatingBreakdown(cleanliness: $cleanliness, accuracy: $accuracy, communication: $communication, location: $location)';
}


}

/// @nodoc
abstract mixin class $RatingBreakdownCopyWith<$Res>  {
  factory $RatingBreakdownCopyWith(RatingBreakdown value, $Res Function(RatingBreakdown) _then) = _$RatingBreakdownCopyWithImpl;
@useResult
$Res call({
 double cleanliness, double accuracy, double communication, double location
});




}
/// @nodoc
class _$RatingBreakdownCopyWithImpl<$Res>
    implements $RatingBreakdownCopyWith<$Res> {
  _$RatingBreakdownCopyWithImpl(this._self, this._then);

  final RatingBreakdown _self;
  final $Res Function(RatingBreakdown) _then;

/// Create a copy of RatingBreakdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cleanliness = null,Object? accuracy = null,Object? communication = null,Object? location = null,}) {
  return _then(RatingBreakdown(
cleanliness: null == cleanliness ? _self.cleanliness : cleanliness // ignore: cast_nullable_to_non_nullable
as double,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,communication: null == communication ? _self.communication : communication // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RatingBreakdown].
extension RatingBreakdownPatterns on RatingBreakdown {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RatingBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RatingBreakdown() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RatingBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _RatingBreakdown():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RatingBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _RatingBreakdown() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double cleanliness,  double accuracy,  double communication,  double location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RatingBreakdown() when $default != null:
return $default(_that.cleanliness,_that.accuracy,_that.communication,_that.location);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double cleanliness,  double accuracy,  double communication,  double location)  $default,) {final _that = this;
switch (_that) {
case _RatingBreakdown():
return $default(_that.cleanliness,_that.accuracy,_that.communication,_that.location);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double cleanliness,  double accuracy,  double communication,  double location)?  $default,) {final _that = this;
switch (_that) {
case _RatingBreakdown() when $default != null:
return $default(_that.cleanliness,_that.accuracy,_that.communication,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RatingBreakdown implements RatingBreakdown {
  const _RatingBreakdown({required this.cleanliness, required this.accuracy, required this.communication, required this.location});
  factory _RatingBreakdown.fromJson(Map<String, dynamic> json) => _$RatingBreakdownFromJson(json);

@override final  double cleanliness;
@override final  double accuracy;
@override final  double communication;
@override final  double location;

/// Create a copy of RatingBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatingBreakdownCopyWith<_RatingBreakdown> get copyWith => __$RatingBreakdownCopyWithImpl<_RatingBreakdown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RatingBreakdownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RatingBreakdown&&(identical(other.cleanliness, cleanliness) || other.cleanliness == cleanliness)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.communication, communication) || other.communication == communication)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cleanliness,accuracy,communication,location);

@override
String toString() {
  return 'RatingBreakdown(cleanliness: $cleanliness, accuracy: $accuracy, communication: $communication, location: $location)';
}


}

/// @nodoc
abstract mixin class _$RatingBreakdownCopyWith<$Res> implements $RatingBreakdownCopyWith<$Res> {
  factory _$RatingBreakdownCopyWith(_RatingBreakdown value, $Res Function(_RatingBreakdown) _then) = __$RatingBreakdownCopyWithImpl;
@override @useResult
$Res call({
 double cleanliness, double accuracy, double communication, double location
});




}
/// @nodoc
class __$RatingBreakdownCopyWithImpl<$Res>
    implements _$RatingBreakdownCopyWith<$Res> {
  __$RatingBreakdownCopyWithImpl(this._self, this._then);

  final _RatingBreakdown _self;
  final $Res Function(_RatingBreakdown) _then;

/// Create a copy of RatingBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cleanliness = null,Object? accuracy = null,Object? communication = null,Object? location = null,}) {
  return _then(_RatingBreakdown(
cleanliness: null == cleanliness ? _self.cleanliness : cleanliness // ignore: cast_nullable_to_non_nullable
as double,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,communication: null == communication ? _self.communication : communication // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ReviewTopicCount {

 ReviewTopic get topic; int get count;
/// Create a copy of ReviewTopicCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewTopicCountCopyWith<ReviewTopicCount> get copyWith => _$ReviewTopicCountCopyWithImpl<ReviewTopicCount>(this as ReviewTopicCount, _$identity);

  /// Serializes this ReviewTopicCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewTopicCount&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topic,count);

@override
String toString() {
  return 'ReviewTopicCount(topic: $topic, count: $count)';
}


}

/// @nodoc
abstract mixin class $ReviewTopicCountCopyWith<$Res>  {
  factory $ReviewTopicCountCopyWith(ReviewTopicCount value, $Res Function(ReviewTopicCount) _then) = _$ReviewTopicCountCopyWithImpl;
@useResult
$Res call({
 ReviewTopic topic, int count
});




}
/// @nodoc
class _$ReviewTopicCountCopyWithImpl<$Res>
    implements $ReviewTopicCountCopyWith<$Res> {
  _$ReviewTopicCountCopyWithImpl(this._self, this._then);

  final ReviewTopicCount _self;
  final $Res Function(ReviewTopicCount) _then;

/// Create a copy of ReviewTopicCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topic = null,Object? count = null,}) {
  return _then(ReviewTopicCount(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as ReviewTopic,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewTopicCount].
extension ReviewTopicCountPatterns on ReviewTopicCount {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewTopicCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewTopicCount() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewTopicCount value)  $default,){
final _that = this;
switch (_that) {
case _ReviewTopicCount():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewTopicCount value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewTopicCount() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReviewTopic topic,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewTopicCount() when $default != null:
return $default(_that.topic,_that.count);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReviewTopic topic,  int count)  $default,) {final _that = this;
switch (_that) {
case _ReviewTopicCount():
return $default(_that.topic,_that.count);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReviewTopic topic,  int count)?  $default,) {final _that = this;
switch (_that) {
case _ReviewTopicCount() when $default != null:
return $default(_that.topic,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewTopicCount implements ReviewTopicCount {
  const _ReviewTopicCount({required this.topic, required this.count});
  factory _ReviewTopicCount.fromJson(Map<String, dynamic> json) => _$ReviewTopicCountFromJson(json);

@override final  ReviewTopic topic;
@override final  int count;

/// Create a copy of ReviewTopicCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewTopicCountCopyWith<_ReviewTopicCount> get copyWith => __$ReviewTopicCountCopyWithImpl<_ReviewTopicCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewTopicCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewTopicCount&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topic,count);

@override
String toString() {
  return 'ReviewTopicCount(topic: $topic, count: $count)';
}


}

/// @nodoc
abstract mixin class _$ReviewTopicCountCopyWith<$Res> implements $ReviewTopicCountCopyWith<$Res> {
  factory _$ReviewTopicCountCopyWith(_ReviewTopicCount value, $Res Function(_ReviewTopicCount) _then) = __$ReviewTopicCountCopyWithImpl;
@override @useResult
$Res call({
 ReviewTopic topic, int count
});




}
/// @nodoc
class __$ReviewTopicCountCopyWithImpl<$Res>
    implements _$ReviewTopicCountCopyWith<$Res> {
  __$ReviewTopicCountCopyWithImpl(this._self, this._then);

  final _ReviewTopicCount _self;
  final $Res Function(_ReviewTopicCount) _then;

/// Create a copy of ReviewTopicCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topic = null,Object? count = null,}) {
  return _then(_ReviewTopicCount(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as ReviewTopic,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Review {

 String get id; String get author; String get city; int get rating; DateTime get date; String get text; List<ReviewTopic> get topics;
/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewCopyWith<Review> get copyWith => _$ReviewCopyWithImpl<Review>(this as Review, _$identity);

  /// Serializes this Review to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Review&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.city, city) || other.city == city)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.date, date) || other.date == date)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.topics, topics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,author,city,rating,date,text,const DeepCollectionEquality().hash(topics));

@override
String toString() {
  return 'Review(id: $id, author: $author, city: $city, rating: $rating, date: $date, text: $text, topics: $topics)';
}


}

/// @nodoc
abstract mixin class $ReviewCopyWith<$Res>  {
  factory $ReviewCopyWith(Review value, $Res Function(Review) _then) = _$ReviewCopyWithImpl;
@useResult
$Res call({
 String id, String author, String city, int rating, DateTime date, String text, List<ReviewTopic> topics
});




}
/// @nodoc
class _$ReviewCopyWithImpl<$Res>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._self, this._then);

  final Review _self;
  final $Res Function(Review) _then;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? city = null,Object? rating = null,Object? date = null,Object? text = null,Object? topics = null,}) {
  return _then(Review(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<ReviewTopic>,
  ));
}

}


/// Adds pattern-matching-related methods to [Review].
extension ReviewPatterns on Review {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Review value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Review() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Review value)  $default,){
final _that = this;
switch (_that) {
case _Review():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Review value)?  $default,){
final _that = this;
switch (_that) {
case _Review() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String author,  String city,  int rating,  DateTime date,  String text,  List<ReviewTopic> topics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Review() when $default != null:
return $default(_that.id,_that.author,_that.city,_that.rating,_that.date,_that.text,_that.topics);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String author,  String city,  int rating,  DateTime date,  String text,  List<ReviewTopic> topics)  $default,) {final _that = this;
switch (_that) {
case _Review():
return $default(_that.id,_that.author,_that.city,_that.rating,_that.date,_that.text,_that.topics);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String author,  String city,  int rating,  DateTime date,  String text,  List<ReviewTopic> topics)?  $default,) {final _that = this;
switch (_that) {
case _Review() when $default != null:
return $default(_that.id,_that.author,_that.city,_that.rating,_that.date,_that.text,_that.topics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Review implements Review {
  const _Review({required this.id, required this.author, required this.city, required this.rating, required this.date, required this.text,  List<ReviewTopic> topics = const <ReviewTopic>[]}): _topics = topics;
  factory _Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

@override final  String id;
@override final  String author;
@override final  String city;
@override final  int rating;
@override final  DateTime date;
@override final  String text;
 final  List<ReviewTopic> _topics;
@override@JsonKey() List<ReviewTopic> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}


/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewCopyWith<_Review> get copyWith => __$ReviewCopyWithImpl<_Review>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Review&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.city, city) || other.city == city)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.date, date) || other.date == date)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._topics, _topics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,author,city,rating,date,text,const DeepCollectionEquality().hash(_topics));

@override
String toString() {
  return 'Review(id: $id, author: $author, city: $city, rating: $rating, date: $date, text: $text, topics: $topics)';
}


}

/// @nodoc
abstract mixin class _$ReviewCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$ReviewCopyWith(_Review value, $Res Function(_Review) _then) = __$ReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String author, String city, int rating, DateTime date, String text, List<ReviewTopic> topics
});




}
/// @nodoc
class __$ReviewCopyWithImpl<$Res>
    implements _$ReviewCopyWith<$Res> {
  __$ReviewCopyWithImpl(this._self, this._then);

  final _Review _self;
  final $Res Function(_Review) _then;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? city = null,Object? rating = null,Object? date = null,Object? text = null,Object? topics = null,}) {
  return _then(_Review(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<ReviewTopic>,
  ));
}


}


/// @nodoc
mixin _$AmenityItem {

 AmenityKind get kind; AmenityGroup get group;/// Ek açıklama: "Isıtmalı · 28°C", "100 Mbps".
 String? get note;
/// Create a copy of AmenityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AmenityItemCopyWith<AmenityItem> get copyWith => _$AmenityItemCopyWithImpl<AmenityItem>(this as AmenityItem, _$identity);

  /// Serializes this AmenityItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AmenityItem&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.group, group) || other.group == group)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,group,note);

@override
String toString() {
  return 'AmenityItem(kind: $kind, group: $group, note: $note)';
}


}

/// @nodoc
abstract mixin class $AmenityItemCopyWith<$Res>  {
  factory $AmenityItemCopyWith(AmenityItem value, $Res Function(AmenityItem) _then) = _$AmenityItemCopyWithImpl;
@useResult
$Res call({
 AmenityKind kind, AmenityGroup group, String? note
});




}
/// @nodoc
class _$AmenityItemCopyWithImpl<$Res>
    implements $AmenityItemCopyWith<$Res> {
  _$AmenityItemCopyWithImpl(this._self, this._then);

  final AmenityItem _self;
  final $Res Function(AmenityItem) _then;

/// Create a copy of AmenityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? group = null,Object? note = freezed,}) {
  return _then(AmenityItem(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AmenityKind,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as AmenityGroup,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AmenityItem].
extension AmenityItemPatterns on AmenityItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AmenityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AmenityItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AmenityItem value)  $default,){
final _that = this;
switch (_that) {
case _AmenityItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AmenityItem value)?  $default,){
final _that = this;
switch (_that) {
case _AmenityItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AmenityKind kind,  AmenityGroup group,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AmenityItem() when $default != null:
return $default(_that.kind,_that.group,_that.note);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AmenityKind kind,  AmenityGroup group,  String? note)  $default,) {final _that = this;
switch (_that) {
case _AmenityItem():
return $default(_that.kind,_that.group,_that.note);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AmenityKind kind,  AmenityGroup group,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _AmenityItem() when $default != null:
return $default(_that.kind,_that.group,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AmenityItem implements AmenityItem {
  const _AmenityItem({required this.kind, required this.group, this.note});
  factory _AmenityItem.fromJson(Map<String, dynamic> json) => _$AmenityItemFromJson(json);

@override final  AmenityKind kind;
@override final  AmenityGroup group;
/// Ek açıklama: "Isıtmalı · 28°C", "100 Mbps".
@override final  String? note;

/// Create a copy of AmenityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AmenityItemCopyWith<_AmenityItem> get copyWith => __$AmenityItemCopyWithImpl<_AmenityItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AmenityItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AmenityItem&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.group, group) || other.group == group)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,group,note);

@override
String toString() {
  return 'AmenityItem(kind: $kind, group: $group, note: $note)';
}


}

/// @nodoc
abstract mixin class _$AmenityItemCopyWith<$Res> implements $AmenityItemCopyWith<$Res> {
  factory _$AmenityItemCopyWith(_AmenityItem value, $Res Function(_AmenityItem) _then) = __$AmenityItemCopyWithImpl;
@override @useResult
$Res call({
 AmenityKind kind, AmenityGroup group, String? note
});




}
/// @nodoc
class __$AmenityItemCopyWithImpl<$Res>
    implements _$AmenityItemCopyWith<$Res> {
  __$AmenityItemCopyWithImpl(this._self, this._then);

  final _AmenityItem _self;
  final $Res Function(_AmenityItem) _then;

/// Create a copy of AmenityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? group = null,Object? note = freezed,}) {
  return _then(_AmenityItem(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AmenityKind,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as AmenityGroup,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NearbyPlace {

 NearbyKind get kind; String get name; int get distanceMeters; int get minutes;/// true: yürüme, false: araçla.
 bool get walking;
/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbyPlaceCopyWith<NearbyPlace> get copyWith => _$NearbyPlaceCopyWithImpl<NearbyPlace>(this as NearbyPlace, _$identity);

  /// Serializes this NearbyPlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbyPlace&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.name, name) || other.name == name)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.walking, walking) || other.walking == walking));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,name,distanceMeters,minutes,walking);

@override
String toString() {
  return 'NearbyPlace(kind: $kind, name: $name, distanceMeters: $distanceMeters, minutes: $minutes, walking: $walking)';
}


}

/// @nodoc
abstract mixin class $NearbyPlaceCopyWith<$Res>  {
  factory $NearbyPlaceCopyWith(NearbyPlace value, $Res Function(NearbyPlace) _then) = _$NearbyPlaceCopyWithImpl;
@useResult
$Res call({
 NearbyKind kind, String name, int distanceMeters, int minutes, bool walking
});




}
/// @nodoc
class _$NearbyPlaceCopyWithImpl<$Res>
    implements $NearbyPlaceCopyWith<$Res> {
  _$NearbyPlaceCopyWithImpl(this._self, this._then);

  final NearbyPlace _self;
  final $Res Function(NearbyPlace) _then;

/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? name = null,Object? distanceMeters = null,Object? minutes = null,Object? walking = null,}) {
  return _then(NearbyPlace(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as NearbyKind,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,walking: null == walking ? _self.walking : walking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NearbyPlace].
extension NearbyPlacePatterns on NearbyPlace {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NearbyPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NearbyPlace value)  $default,){
final _that = this;
switch (_that) {
case _NearbyPlace():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NearbyPlace value)?  $default,){
final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NearbyKind kind,  String name,  int distanceMeters,  int minutes,  bool walking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
return $default(_that.kind,_that.name,_that.distanceMeters,_that.minutes,_that.walking);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NearbyKind kind,  String name,  int distanceMeters,  int minutes,  bool walking)  $default,) {final _that = this;
switch (_that) {
case _NearbyPlace():
return $default(_that.kind,_that.name,_that.distanceMeters,_that.minutes,_that.walking);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NearbyKind kind,  String name,  int distanceMeters,  int minutes,  bool walking)?  $default,) {final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
return $default(_that.kind,_that.name,_that.distanceMeters,_that.minutes,_that.walking);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NearbyPlace implements NearbyPlace {
  const _NearbyPlace({required this.kind, required this.name, required this.distanceMeters, required this.minutes, this.walking = false});
  factory _NearbyPlace.fromJson(Map<String, dynamic> json) => _$NearbyPlaceFromJson(json);

@override final  NearbyKind kind;
@override final  String name;
@override final  int distanceMeters;
@override final  int minutes;
/// true: yürüme, false: araçla.
@override@JsonKey() final  bool walking;

/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbyPlaceCopyWith<_NearbyPlace> get copyWith => __$NearbyPlaceCopyWithImpl<_NearbyPlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NearbyPlaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbyPlace&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.name, name) || other.name == name)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.walking, walking) || other.walking == walking));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,name,distanceMeters,minutes,walking);

@override
String toString() {
  return 'NearbyPlace(kind: $kind, name: $name, distanceMeters: $distanceMeters, minutes: $minutes, walking: $walking)';
}


}

/// @nodoc
abstract mixin class _$NearbyPlaceCopyWith<$Res> implements $NearbyPlaceCopyWith<$Res> {
  factory _$NearbyPlaceCopyWith(_NearbyPlace value, $Res Function(_NearbyPlace) _then) = __$NearbyPlaceCopyWithImpl;
@override @useResult
$Res call({
 NearbyKind kind, String name, int distanceMeters, int minutes, bool walking
});




}
/// @nodoc
class __$NearbyPlaceCopyWithImpl<$Res>
    implements _$NearbyPlaceCopyWith<$Res> {
  __$NearbyPlaceCopyWithImpl(this._self, this._then);

  final _NearbyPlace _self;
  final $Res Function(_NearbyPlace) _then;

/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? name = null,Object? distanceMeters = null,Object? minutes = null,Object? walking = null,}) {
  return _then(_NearbyPlace(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as NearbyKind,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,walking: null == walking ? _self.walking : walking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$HouseRules {

/// "14:00" biçiminde yerel saat.
 String get checkInFrom; String get checkInTo; String get checkOutBy; SelfCheckIn get selfCheckIn; String get quietFrom; String get quietTo; bool get smokingAllowed;
/// Create a copy of HouseRules
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HouseRulesCopyWith<HouseRules> get copyWith => _$HouseRulesCopyWithImpl<HouseRules>(this as HouseRules, _$identity);

  /// Serializes this HouseRules to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HouseRules&&(identical(other.checkInFrom, checkInFrom) || other.checkInFrom == checkInFrom)&&(identical(other.checkInTo, checkInTo) || other.checkInTo == checkInTo)&&(identical(other.checkOutBy, checkOutBy) || other.checkOutBy == checkOutBy)&&(identical(other.selfCheckIn, selfCheckIn) || other.selfCheckIn == selfCheckIn)&&(identical(other.quietFrom, quietFrom) || other.quietFrom == quietFrom)&&(identical(other.quietTo, quietTo) || other.quietTo == quietTo)&&(identical(other.smokingAllowed, smokingAllowed) || other.smokingAllowed == smokingAllowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,checkInFrom,checkInTo,checkOutBy,selfCheckIn,quietFrom,quietTo,smokingAllowed);

@override
String toString() {
  return 'HouseRules(checkInFrom: $checkInFrom, checkInTo: $checkInTo, checkOutBy: $checkOutBy, selfCheckIn: $selfCheckIn, quietFrom: $quietFrom, quietTo: $quietTo, smokingAllowed: $smokingAllowed)';
}


}

/// @nodoc
abstract mixin class $HouseRulesCopyWith<$Res>  {
  factory $HouseRulesCopyWith(HouseRules value, $Res Function(HouseRules) _then) = _$HouseRulesCopyWithImpl;
@useResult
$Res call({
 String checkInFrom, String checkInTo, String checkOutBy, SelfCheckIn selfCheckIn, String quietFrom, String quietTo, bool smokingAllowed
});




}
/// @nodoc
class _$HouseRulesCopyWithImpl<$Res>
    implements $HouseRulesCopyWith<$Res> {
  _$HouseRulesCopyWithImpl(this._self, this._then);

  final HouseRules _self;
  final $Res Function(HouseRules) _then;

/// Create a copy of HouseRules
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? checkInFrom = null,Object? checkInTo = null,Object? checkOutBy = null,Object? selfCheckIn = null,Object? quietFrom = null,Object? quietTo = null,Object? smokingAllowed = null,}) {
  return _then(HouseRules(
checkInFrom: null == checkInFrom ? _self.checkInFrom : checkInFrom // ignore: cast_nullable_to_non_nullable
as String,checkInTo: null == checkInTo ? _self.checkInTo : checkInTo // ignore: cast_nullable_to_non_nullable
as String,checkOutBy: null == checkOutBy ? _self.checkOutBy : checkOutBy // ignore: cast_nullable_to_non_nullable
as String,selfCheckIn: null == selfCheckIn ? _self.selfCheckIn : selfCheckIn // ignore: cast_nullable_to_non_nullable
as SelfCheckIn,quietFrom: null == quietFrom ? _self.quietFrom : quietFrom // ignore: cast_nullable_to_non_nullable
as String,quietTo: null == quietTo ? _self.quietTo : quietTo // ignore: cast_nullable_to_non_nullable
as String,smokingAllowed: null == smokingAllowed ? _self.smokingAllowed : smokingAllowed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HouseRules].
extension HouseRulesPatterns on HouseRules {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HouseRules value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HouseRules() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HouseRules value)  $default,){
final _that = this;
switch (_that) {
case _HouseRules():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HouseRules value)?  $default,){
final _that = this;
switch (_that) {
case _HouseRules() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String checkInFrom,  String checkInTo,  String checkOutBy,  SelfCheckIn selfCheckIn,  String quietFrom,  String quietTo,  bool smokingAllowed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HouseRules() when $default != null:
return $default(_that.checkInFrom,_that.checkInTo,_that.checkOutBy,_that.selfCheckIn,_that.quietFrom,_that.quietTo,_that.smokingAllowed);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String checkInFrom,  String checkInTo,  String checkOutBy,  SelfCheckIn selfCheckIn,  String quietFrom,  String quietTo,  bool smokingAllowed)  $default,) {final _that = this;
switch (_that) {
case _HouseRules():
return $default(_that.checkInFrom,_that.checkInTo,_that.checkOutBy,_that.selfCheckIn,_that.quietFrom,_that.quietTo,_that.smokingAllowed);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String checkInFrom,  String checkInTo,  String checkOutBy,  SelfCheckIn selfCheckIn,  String quietFrom,  String quietTo,  bool smokingAllowed)?  $default,) {final _that = this;
switch (_that) {
case _HouseRules() when $default != null:
return $default(_that.checkInFrom,_that.checkInTo,_that.checkOutBy,_that.selfCheckIn,_that.quietFrom,_that.quietTo,_that.smokingAllowed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HouseRules implements HouseRules {
  const _HouseRules({required this.checkInFrom, required this.checkInTo, required this.checkOutBy, this.selfCheckIn = SelfCheckIn.none, required this.quietFrom, required this.quietTo, this.smokingAllowed = false});
  factory _HouseRules.fromJson(Map<String, dynamic> json) => _$HouseRulesFromJson(json);

/// "14:00" biçiminde yerel saat.
@override final  String checkInFrom;
@override final  String checkInTo;
@override final  String checkOutBy;
@override@JsonKey() final  SelfCheckIn selfCheckIn;
@override final  String quietFrom;
@override final  String quietTo;
@override@JsonKey() final  bool smokingAllowed;

/// Create a copy of HouseRules
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HouseRulesCopyWith<_HouseRules> get copyWith => __$HouseRulesCopyWithImpl<_HouseRules>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HouseRulesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HouseRules&&(identical(other.checkInFrom, checkInFrom) || other.checkInFrom == checkInFrom)&&(identical(other.checkInTo, checkInTo) || other.checkInTo == checkInTo)&&(identical(other.checkOutBy, checkOutBy) || other.checkOutBy == checkOutBy)&&(identical(other.selfCheckIn, selfCheckIn) || other.selfCheckIn == selfCheckIn)&&(identical(other.quietFrom, quietFrom) || other.quietFrom == quietFrom)&&(identical(other.quietTo, quietTo) || other.quietTo == quietTo)&&(identical(other.smokingAllowed, smokingAllowed) || other.smokingAllowed == smokingAllowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,checkInFrom,checkInTo,checkOutBy,selfCheckIn,quietFrom,quietTo,smokingAllowed);

@override
String toString() {
  return 'HouseRules(checkInFrom: $checkInFrom, checkInTo: $checkInTo, checkOutBy: $checkOutBy, selfCheckIn: $selfCheckIn, quietFrom: $quietFrom, quietTo: $quietTo, smokingAllowed: $smokingAllowed)';
}


}

/// @nodoc
abstract mixin class _$HouseRulesCopyWith<$Res> implements $HouseRulesCopyWith<$Res> {
  factory _$HouseRulesCopyWith(_HouseRules value, $Res Function(_HouseRules) _then) = __$HouseRulesCopyWithImpl;
@override @useResult
$Res call({
 String checkInFrom, String checkInTo, String checkOutBy, SelfCheckIn selfCheckIn, String quietFrom, String quietTo, bool smokingAllowed
});




}
/// @nodoc
class __$HouseRulesCopyWithImpl<$Res>
    implements _$HouseRulesCopyWith<$Res> {
  __$HouseRulesCopyWithImpl(this._self, this._then);

  final _HouseRules _self;
  final $Res Function(_HouseRules) _then;

/// Create a copy of HouseRules
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? checkInFrom = null,Object? checkInTo = null,Object? checkOutBy = null,Object? selfCheckIn = null,Object? quietFrom = null,Object? quietTo = null,Object? smokingAllowed = null,}) {
  return _then(_HouseRules(
checkInFrom: null == checkInFrom ? _self.checkInFrom : checkInFrom // ignore: cast_nullable_to_non_nullable
as String,checkInTo: null == checkInTo ? _self.checkInTo : checkInTo // ignore: cast_nullable_to_non_nullable
as String,checkOutBy: null == checkOutBy ? _self.checkOutBy : checkOutBy // ignore: cast_nullable_to_non_nullable
as String,selfCheckIn: null == selfCheckIn ? _self.selfCheckIn : selfCheckIn // ignore: cast_nullable_to_non_nullable
as SelfCheckIn,quietFrom: null == quietFrom ? _self.quietFrom : quietFrom // ignore: cast_nullable_to_non_nullable
as String,quietTo: null == quietTo ? _self.quietTo : quietTo // ignore: cast_nullable_to_non_nullable
as String,smokingAllowed: null == smokingAllowed ? _self.smokingAllowed : smokingAllowed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SafetyItem {

 SafetyKind get kind;/// Dış kamera için konum açıklaması (zorunlu, §10).
 String? get note;
/// Create a copy of SafetyItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SafetyItemCopyWith<SafetyItem> get copyWith => _$SafetyItemCopyWithImpl<SafetyItem>(this as SafetyItem, _$identity);

  /// Serializes this SafetyItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SafetyItem&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,note);

@override
String toString() {
  return 'SafetyItem(kind: $kind, note: $note)';
}


}

/// @nodoc
abstract mixin class $SafetyItemCopyWith<$Res>  {
  factory $SafetyItemCopyWith(SafetyItem value, $Res Function(SafetyItem) _then) = _$SafetyItemCopyWithImpl;
@useResult
$Res call({
 SafetyKind kind, String? note
});




}
/// @nodoc
class _$SafetyItemCopyWithImpl<$Res>
    implements $SafetyItemCopyWith<$Res> {
  _$SafetyItemCopyWithImpl(this._self, this._then);

  final SafetyItem _self;
  final $Res Function(SafetyItem) _then;

/// Create a copy of SafetyItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? note = freezed,}) {
  return _then(SafetyItem(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SafetyKind,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SafetyItem].
extension SafetyItemPatterns on SafetyItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SafetyItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SafetyItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SafetyItem value)  $default,){
final _that = this;
switch (_that) {
case _SafetyItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SafetyItem value)?  $default,){
final _that = this;
switch (_that) {
case _SafetyItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SafetyKind kind,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SafetyItem() when $default != null:
return $default(_that.kind,_that.note);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SafetyKind kind,  String? note)  $default,) {final _that = this;
switch (_that) {
case _SafetyItem():
return $default(_that.kind,_that.note);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SafetyKind kind,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _SafetyItem() when $default != null:
return $default(_that.kind,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SafetyItem implements SafetyItem {
  const _SafetyItem({required this.kind, this.note});
  factory _SafetyItem.fromJson(Map<String, dynamic> json) => _$SafetyItemFromJson(json);

@override final  SafetyKind kind;
/// Dış kamera için konum açıklaması (zorunlu, §10).
@override final  String? note;

/// Create a copy of SafetyItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SafetyItemCopyWith<_SafetyItem> get copyWith => __$SafetyItemCopyWithImpl<_SafetyItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SafetyItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SafetyItem&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,note);

@override
String toString() {
  return 'SafetyItem(kind: $kind, note: $note)';
}


}

/// @nodoc
abstract mixin class _$SafetyItemCopyWith<$Res> implements $SafetyItemCopyWith<$Res> {
  factory _$SafetyItemCopyWith(_SafetyItem value, $Res Function(_SafetyItem) _then) = __$SafetyItemCopyWithImpl;
@override @useResult
$Res call({
 SafetyKind kind, String? note
});




}
/// @nodoc
class __$SafetyItemCopyWithImpl<$Res>
    implements _$SafetyItemCopyWith<$Res> {
  __$SafetyItemCopyWithImpl(this._self, this._then);

  final _SafetyItem _self;
  final $Res Function(_SafetyItem) _then;

/// Create a copy of SafetyItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? note = freezed,}) {
  return _then(_SafetyItem(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SafetyKind,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ListingPhoto {

 String? get url; String get caption;
/// Create a copy of ListingPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingPhotoCopyWith<ListingPhoto> get copyWith => _$ListingPhotoCopyWithImpl<ListingPhoto>(this as ListingPhoto, _$identity);

  /// Serializes this ListingPhoto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListingPhoto&&(identical(other.url, url) || other.url == url)&&(identical(other.caption, caption) || other.caption == caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,caption);

@override
String toString() {
  return 'ListingPhoto(url: $url, caption: $caption)';
}


}

/// @nodoc
abstract mixin class $ListingPhotoCopyWith<$Res>  {
  factory $ListingPhotoCopyWith(ListingPhoto value, $Res Function(ListingPhoto) _then) = _$ListingPhotoCopyWithImpl;
@useResult
$Res call({
 String? url, String caption
});




}
/// @nodoc
class _$ListingPhotoCopyWithImpl<$Res>
    implements $ListingPhotoCopyWith<$Res> {
  _$ListingPhotoCopyWithImpl(this._self, this._then);

  final ListingPhoto _self;
  final $Res Function(ListingPhoto) _then;

/// Create a copy of ListingPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? caption = null,}) {
  return _then(ListingPhoto(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ListingPhoto].
extension ListingPhotoPatterns on ListingPhoto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListingPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListingPhoto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListingPhoto value)  $default,){
final _that = this;
switch (_that) {
case _ListingPhoto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListingPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _ListingPhoto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? url,  String caption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListingPhoto() when $default != null:
return $default(_that.url,_that.caption);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? url,  String caption)  $default,) {final _that = this;
switch (_that) {
case _ListingPhoto():
return $default(_that.url,_that.caption);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? url,  String caption)?  $default,) {final _that = this;
switch (_that) {
case _ListingPhoto() when $default != null:
return $default(_that.url,_that.caption);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListingPhoto implements ListingPhoto {
  const _ListingPhoto({this.url, this.caption = ''});
  factory _ListingPhoto.fromJson(Map<String, dynamic> json) => _$ListingPhotoFromJson(json);

@override final  String? url;
@override@JsonKey() final  String caption;

/// Create a copy of ListingPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingPhotoCopyWith<_ListingPhoto> get copyWith => __$ListingPhotoCopyWithImpl<_ListingPhoto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListingPhotoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListingPhoto&&(identical(other.url, url) || other.url == url)&&(identical(other.caption, caption) || other.caption == caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,caption);

@override
String toString() {
  return 'ListingPhoto(url: $url, caption: $caption)';
}


}

/// @nodoc
abstract mixin class _$ListingPhotoCopyWith<$Res> implements $ListingPhotoCopyWith<$Res> {
  factory _$ListingPhotoCopyWith(_ListingPhoto value, $Res Function(_ListingPhoto) _then) = __$ListingPhotoCopyWithImpl;
@override @useResult
$Res call({
 String? url, String caption
});




}
/// @nodoc
class __$ListingPhotoCopyWithImpl<$Res>
    implements _$ListingPhotoCopyWith<$Res> {
  __$ListingPhotoCopyWithImpl(this._self, this._then);

  final _ListingPhoto _self;
  final $Res Function(_ListingPhoto) _then;

/// Create a copy of ListingPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? caption = null,}) {
  return _then(_ListingPhoto(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PhotoRoom {

 RoomKind get kind; List<ListingPhoto> get photos;
/// Create a copy of PhotoRoom
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoRoomCopyWith<PhotoRoom> get copyWith => _$PhotoRoomCopyWithImpl<PhotoRoom>(this as PhotoRoom, _$identity);

  /// Serializes this PhotoRoom to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoRoom&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other.photos, photos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,const DeepCollectionEquality().hash(photos));

@override
String toString() {
  return 'PhotoRoom(kind: $kind, photos: $photos)';
}


}

/// @nodoc
abstract mixin class $PhotoRoomCopyWith<$Res>  {
  factory $PhotoRoomCopyWith(PhotoRoom value, $Res Function(PhotoRoom) _then) = _$PhotoRoomCopyWithImpl;
@useResult
$Res call({
 RoomKind kind, List<ListingPhoto> photos
});




}
/// @nodoc
class _$PhotoRoomCopyWithImpl<$Res>
    implements $PhotoRoomCopyWith<$Res> {
  _$PhotoRoomCopyWithImpl(this._self, this._then);

  final PhotoRoom _self;
  final $Res Function(PhotoRoom) _then;

/// Create a copy of PhotoRoom
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? photos = null,}) {
  return _then(PhotoRoom(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RoomKind,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<ListingPhoto>,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoRoom].
extension PhotoRoomPatterns on PhotoRoom {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoRoom value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoRoom() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoRoom value)  $default,){
final _that = this;
switch (_that) {
case _PhotoRoom():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoRoom value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoRoom() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RoomKind kind,  List<ListingPhoto> photos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoRoom() when $default != null:
return $default(_that.kind,_that.photos);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RoomKind kind,  List<ListingPhoto> photos)  $default,) {final _that = this;
switch (_that) {
case _PhotoRoom():
return $default(_that.kind,_that.photos);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RoomKind kind,  List<ListingPhoto> photos)?  $default,) {final _that = this;
switch (_that) {
case _PhotoRoom() when $default != null:
return $default(_that.kind,_that.photos);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhotoRoom implements PhotoRoom {
  const _PhotoRoom({required this.kind, required  List<ListingPhoto> photos}): _photos = photos;
  factory _PhotoRoom.fromJson(Map<String, dynamic> json) => _$PhotoRoomFromJson(json);

@override final  RoomKind kind;
 final  List<ListingPhoto> _photos;
@override List<ListingPhoto> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}


/// Create a copy of PhotoRoom
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoRoomCopyWith<_PhotoRoom> get copyWith => __$PhotoRoomCopyWithImpl<_PhotoRoom>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhotoRoomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoRoom&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other._photos, _photos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,const DeepCollectionEquality().hash(_photos));

@override
String toString() {
  return 'PhotoRoom(kind: $kind, photos: $photos)';
}


}

/// @nodoc
abstract mixin class _$PhotoRoomCopyWith<$Res> implements $PhotoRoomCopyWith<$Res> {
  factory _$PhotoRoomCopyWith(_PhotoRoom value, $Res Function(_PhotoRoom) _then) = __$PhotoRoomCopyWithImpl;
@override @useResult
$Res call({
 RoomKind kind, List<ListingPhoto> photos
});




}
/// @nodoc
class __$PhotoRoomCopyWithImpl<$Res>
    implements _$PhotoRoomCopyWith<$Res> {
  __$PhotoRoomCopyWithImpl(this._self, this._then);

  final _PhotoRoom _self;
  final $Res Function(_PhotoRoom) _then;

/// Create a copy of PhotoRoom
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? photos = null,}) {
  return _then(_PhotoRoom(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RoomKind,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<ListingPhoto>,
  ));
}


}

// dart format on
