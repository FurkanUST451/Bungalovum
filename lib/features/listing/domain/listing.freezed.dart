// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Listing {

 String get id; String get title;/// Semt / mevki: "Kırkpınar".
 String get district; PropertyType get propertyType; List<ListingSetting> get settings; List<Amenity> get amenities; int get maxGuests;/// Ortalama puan (0–5); değerlendirme yoksa null.
 double? get rating;/// Tüm ücretler dahil gecelik fiyat (TRY). Backend hesaplar.
 int get nightlyPrice;/// Ev sahibinin yazdığı kısa öne çıkan bilgi: "10 dk göle yürüme".
 String? get highlight; List<String> get photoUrls;/// Toplam fotoğraf sayısı (liste yanıtında tüm URL'ler gelmeyebilir).
 int get photoCount; ListingBadge? get badge;/// Bölge: "Sapanca". Aramada konum eşleşmesi buna göre yapılır.
 String get region; int get bedrooms;/// Anında onay (true) ya da ev sahibi onaylı talep (false).
 bool get instantBook;/// Girişten 24 saat öncesine kadar ücretsiz iptal.
 bool get freeCancellation; bool get petsAllowed;/// Basamaksız giriş, geniş kapılar.
 bool get accessible;/// Yaklaşık konum (tam adres yalnızca onaylı rezervasyonda paylaşılır).
 double get latitude; double get longitude;
/// Create a copy of Listing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingCopyWith<Listing> get copyWith => _$ListingCopyWithImpl<Listing>(this as Listing, _$identity);

  /// Serializes this Listing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Listing&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.district, district) || other.district == district)&&(identical(other.propertyType, propertyType) || other.propertyType == propertyType)&&const DeepCollectionEquality().equals(other.settings, settings)&&const DeepCollectionEquality().equals(other.amenities, amenities)&&(identical(other.maxGuests, maxGuests) || other.maxGuests == maxGuests)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.nightlyPrice, nightlyPrice) || other.nightlyPrice == nightlyPrice)&&(identical(other.highlight, highlight) || other.highlight == highlight)&&const DeepCollectionEquality().equals(other.photoUrls, photoUrls)&&(identical(other.photoCount, photoCount) || other.photoCount == photoCount)&&(identical(other.badge, badge) || other.badge == badge)&&(identical(other.region, region) || other.region == region)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.instantBook, instantBook) || other.instantBook == instantBook)&&(identical(other.freeCancellation, freeCancellation) || other.freeCancellation == freeCancellation)&&(identical(other.petsAllowed, petsAllowed) || other.petsAllowed == petsAllowed)&&(identical(other.accessible, accessible) || other.accessible == accessible)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,district,propertyType,const DeepCollectionEquality().hash(settings),const DeepCollectionEquality().hash(amenities),maxGuests,rating,nightlyPrice,highlight,const DeepCollectionEquality().hash(photoUrls),photoCount,badge,region,bedrooms,instantBook,freeCancellation,petsAllowed,accessible,latitude,longitude]);

@override
String toString() {
  return 'Listing(id: $id, title: $title, district: $district, propertyType: $propertyType, settings: $settings, amenities: $amenities, maxGuests: $maxGuests, rating: $rating, nightlyPrice: $nightlyPrice, highlight: $highlight, photoUrls: $photoUrls, photoCount: $photoCount, badge: $badge, region: $region, bedrooms: $bedrooms, instantBook: $instantBook, freeCancellation: $freeCancellation, petsAllowed: $petsAllowed, accessible: $accessible, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $ListingCopyWith<$Res>  {
  factory $ListingCopyWith(Listing value, $Res Function(Listing) _then) = _$ListingCopyWithImpl;
@useResult
$Res call({
 String id, String title, String district, PropertyType propertyType, List<ListingSetting> settings, List<Amenity> amenities, int maxGuests, double? rating, int nightlyPrice, String? highlight, List<String> photoUrls, int photoCount, ListingBadge? badge, String region, int bedrooms, bool instantBook, bool freeCancellation, bool petsAllowed, bool accessible, double latitude, double longitude
});




}
/// @nodoc
class _$ListingCopyWithImpl<$Res>
    implements $ListingCopyWith<$Res> {
  _$ListingCopyWithImpl(this._self, this._then);

  final Listing _self;
  final $Res Function(Listing) _then;

/// Create a copy of Listing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? district = null,Object? propertyType = null,Object? settings = null,Object? amenities = null,Object? maxGuests = null,Object? rating = freezed,Object? nightlyPrice = null,Object? highlight = freezed,Object? photoUrls = null,Object? photoCount = null,Object? badge = freezed,Object? region = null,Object? bedrooms = null,Object? instantBook = null,Object? freeCancellation = null,Object? petsAllowed = null,Object? accessible = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(Listing(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,propertyType: null == propertyType ? _self.propertyType : propertyType // ignore: cast_nullable_to_non_nullable
as PropertyType,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as List<ListingSetting>,amenities: null == amenities ? _self.amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<Amenity>,maxGuests: null == maxGuests ? _self.maxGuests : maxGuests // ignore: cast_nullable_to_non_nullable
as int,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,nightlyPrice: null == nightlyPrice ? _self.nightlyPrice : nightlyPrice // ignore: cast_nullable_to_non_nullable
as int,highlight: freezed == highlight ? _self.highlight : highlight // ignore: cast_nullable_to_non_nullable
as String?,photoUrls: null == photoUrls ? _self.photoUrls : photoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,photoCount: null == photoCount ? _self.photoCount : photoCount // ignore: cast_nullable_to_non_nullable
as int,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as ListingBadge?,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,bedrooms: null == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int,instantBook: null == instantBook ? _self.instantBook : instantBook // ignore: cast_nullable_to_non_nullable
as bool,freeCancellation: null == freeCancellation ? _self.freeCancellation : freeCancellation // ignore: cast_nullable_to_non_nullable
as bool,petsAllowed: null == petsAllowed ? _self.petsAllowed : petsAllowed // ignore: cast_nullable_to_non_nullable
as bool,accessible: null == accessible ? _self.accessible : accessible // ignore: cast_nullable_to_non_nullable
as bool,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Listing].
extension ListingPatterns on Listing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Listing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Listing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Listing value)  $default,){
final _that = this;
switch (_that) {
case _Listing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Listing value)?  $default,){
final _that = this;
switch (_that) {
case _Listing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String district,  PropertyType propertyType,  List<ListingSetting> settings,  List<Amenity> amenities,  int maxGuests,  double? rating,  int nightlyPrice,  String? highlight,  List<String> photoUrls,  int photoCount,  ListingBadge? badge,  String region,  int bedrooms,  bool instantBook,  bool freeCancellation,  bool petsAllowed,  bool accessible,  double latitude,  double longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Listing() when $default != null:
return $default(_that.id,_that.title,_that.district,_that.propertyType,_that.settings,_that.amenities,_that.maxGuests,_that.rating,_that.nightlyPrice,_that.highlight,_that.photoUrls,_that.photoCount,_that.badge,_that.region,_that.bedrooms,_that.instantBook,_that.freeCancellation,_that.petsAllowed,_that.accessible,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String district,  PropertyType propertyType,  List<ListingSetting> settings,  List<Amenity> amenities,  int maxGuests,  double? rating,  int nightlyPrice,  String? highlight,  List<String> photoUrls,  int photoCount,  ListingBadge? badge,  String region,  int bedrooms,  bool instantBook,  bool freeCancellation,  bool petsAllowed,  bool accessible,  double latitude,  double longitude)  $default,) {final _that = this;
switch (_that) {
case _Listing():
return $default(_that.id,_that.title,_that.district,_that.propertyType,_that.settings,_that.amenities,_that.maxGuests,_that.rating,_that.nightlyPrice,_that.highlight,_that.photoUrls,_that.photoCount,_that.badge,_that.region,_that.bedrooms,_that.instantBook,_that.freeCancellation,_that.petsAllowed,_that.accessible,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String district,  PropertyType propertyType,  List<ListingSetting> settings,  List<Amenity> amenities,  int maxGuests,  double? rating,  int nightlyPrice,  String? highlight,  List<String> photoUrls,  int photoCount,  ListingBadge? badge,  String region,  int bedrooms,  bool instantBook,  bool freeCancellation,  bool petsAllowed,  bool accessible,  double latitude,  double longitude)?  $default,) {final _that = this;
switch (_that) {
case _Listing() when $default != null:
return $default(_that.id,_that.title,_that.district,_that.propertyType,_that.settings,_that.amenities,_that.maxGuests,_that.rating,_that.nightlyPrice,_that.highlight,_that.photoUrls,_that.photoCount,_that.badge,_that.region,_that.bedrooms,_that.instantBook,_that.freeCancellation,_that.petsAllowed,_that.accessible,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Listing implements Listing {
  const _Listing({required this.id, required this.title, required this.district, required this.propertyType,  List<ListingSetting> settings = const <ListingSetting>[],  List<Amenity> amenities = const <Amenity>[], required this.maxGuests, this.rating, required this.nightlyPrice, this.highlight,  List<String> photoUrls = const <String>[], required this.photoCount, this.badge, this.region = '', this.bedrooms = 1, this.instantBook = true, this.freeCancellation = false, this.petsAllowed = false, this.accessible = false, this.latitude = 0, this.longitude = 0}): _settings = settings,_amenities = amenities,_photoUrls = photoUrls;
  factory _Listing.fromJson(Map<String, dynamic> json) => _$ListingFromJson(json);

@override final  String id;
@override final  String title;
/// Semt / mevki: "Kırkpınar".
@override final  String district;
@override final  PropertyType propertyType;
 final  List<ListingSetting> _settings;
@override@JsonKey() List<ListingSetting> get settings {
  if (_settings is EqualUnmodifiableListView) return _settings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_settings);
}

 final  List<Amenity> _amenities;
@override@JsonKey() List<Amenity> get amenities {
  if (_amenities is EqualUnmodifiableListView) return _amenities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_amenities);
}

@override final  int maxGuests;
/// Ortalama puan (0–5); değerlendirme yoksa null.
@override final  double? rating;
/// Tüm ücretler dahil gecelik fiyat (TRY). Backend hesaplar.
@override final  int nightlyPrice;
/// Ev sahibinin yazdığı kısa öne çıkan bilgi: "10 dk göle yürüme".
@override final  String? highlight;
 final  List<String> _photoUrls;
@override@JsonKey() List<String> get photoUrls {
  if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photoUrls);
}

/// Toplam fotoğraf sayısı (liste yanıtında tüm URL'ler gelmeyebilir).
@override final  int photoCount;
@override final  ListingBadge? badge;
/// Bölge: "Sapanca". Aramada konum eşleşmesi buna göre yapılır.
@override@JsonKey() final  String region;
@override@JsonKey() final  int bedrooms;
/// Anında onay (true) ya da ev sahibi onaylı talep (false).
@override@JsonKey() final  bool instantBook;
/// Girişten 24 saat öncesine kadar ücretsiz iptal.
@override@JsonKey() final  bool freeCancellation;
@override@JsonKey() final  bool petsAllowed;
/// Basamaksız giriş, geniş kapılar.
@override@JsonKey() final  bool accessible;
/// Yaklaşık konum (tam adres yalnızca onaylı rezervasyonda paylaşılır).
@override@JsonKey() final  double latitude;
@override@JsonKey() final  double longitude;

/// Create a copy of Listing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingCopyWith<_Listing> get copyWith => __$ListingCopyWithImpl<_Listing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Listing&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.district, district) || other.district == district)&&(identical(other.propertyType, propertyType) || other.propertyType == propertyType)&&const DeepCollectionEquality().equals(other._settings, _settings)&&const DeepCollectionEquality().equals(other._amenities, _amenities)&&(identical(other.maxGuests, maxGuests) || other.maxGuests == maxGuests)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.nightlyPrice, nightlyPrice) || other.nightlyPrice == nightlyPrice)&&(identical(other.highlight, highlight) || other.highlight == highlight)&&const DeepCollectionEquality().equals(other._photoUrls, _photoUrls)&&(identical(other.photoCount, photoCount) || other.photoCount == photoCount)&&(identical(other.badge, badge) || other.badge == badge)&&(identical(other.region, region) || other.region == region)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.instantBook, instantBook) || other.instantBook == instantBook)&&(identical(other.freeCancellation, freeCancellation) || other.freeCancellation == freeCancellation)&&(identical(other.petsAllowed, petsAllowed) || other.petsAllowed == petsAllowed)&&(identical(other.accessible, accessible) || other.accessible == accessible)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,district,propertyType,const DeepCollectionEquality().hash(_settings),const DeepCollectionEquality().hash(_amenities),maxGuests,rating,nightlyPrice,highlight,const DeepCollectionEquality().hash(_photoUrls),photoCount,badge,region,bedrooms,instantBook,freeCancellation,petsAllowed,accessible,latitude,longitude]);

@override
String toString() {
  return 'Listing(id: $id, title: $title, district: $district, propertyType: $propertyType, settings: $settings, amenities: $amenities, maxGuests: $maxGuests, rating: $rating, nightlyPrice: $nightlyPrice, highlight: $highlight, photoUrls: $photoUrls, photoCount: $photoCount, badge: $badge, region: $region, bedrooms: $bedrooms, instantBook: $instantBook, freeCancellation: $freeCancellation, petsAllowed: $petsAllowed, accessible: $accessible, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$ListingCopyWith<$Res> implements $ListingCopyWith<$Res> {
  factory _$ListingCopyWith(_Listing value, $Res Function(_Listing) _then) = __$ListingCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String district, PropertyType propertyType, List<ListingSetting> settings, List<Amenity> amenities, int maxGuests, double? rating, int nightlyPrice, String? highlight, List<String> photoUrls, int photoCount, ListingBadge? badge, String region, int bedrooms, bool instantBook, bool freeCancellation, bool petsAllowed, bool accessible, double latitude, double longitude
});




}
/// @nodoc
class __$ListingCopyWithImpl<$Res>
    implements _$ListingCopyWith<$Res> {
  __$ListingCopyWithImpl(this._self, this._then);

  final _Listing _self;
  final $Res Function(_Listing) _then;

/// Create a copy of Listing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? district = null,Object? propertyType = null,Object? settings = null,Object? amenities = null,Object? maxGuests = null,Object? rating = freezed,Object? nightlyPrice = null,Object? highlight = freezed,Object? photoUrls = null,Object? photoCount = null,Object? badge = freezed,Object? region = null,Object? bedrooms = null,Object? instantBook = null,Object? freeCancellation = null,Object? petsAllowed = null,Object? accessible = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_Listing(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,propertyType: null == propertyType ? _self.propertyType : propertyType // ignore: cast_nullable_to_non_nullable
as PropertyType,settings: null == settings ? _self._settings : settings // ignore: cast_nullable_to_non_nullable
as List<ListingSetting>,amenities: null == amenities ? _self._amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<Amenity>,maxGuests: null == maxGuests ? _self.maxGuests : maxGuests // ignore: cast_nullable_to_non_nullable
as int,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,nightlyPrice: null == nightlyPrice ? _self.nightlyPrice : nightlyPrice // ignore: cast_nullable_to_non_nullable
as int,highlight: freezed == highlight ? _self.highlight : highlight // ignore: cast_nullable_to_non_nullable
as String?,photoUrls: null == photoUrls ? _self._photoUrls : photoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,photoCount: null == photoCount ? _self.photoCount : photoCount // ignore: cast_nullable_to_non_nullable
as int,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as ListingBadge?,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,bedrooms: null == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int,instantBook: null == instantBook ? _self.instantBook : instantBook // ignore: cast_nullable_to_non_nullable
as bool,freeCancellation: null == freeCancellation ? _self.freeCancellation : freeCancellation // ignore: cast_nullable_to_non_nullable
as bool,petsAllowed: null == petsAllowed ? _self.petsAllowed : petsAllowed // ignore: cast_nullable_to_non_nullable
as bool,accessible: null == accessible ? _self.accessible : accessible // ignore: cast_nullable_to_non_nullable
as bool,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
