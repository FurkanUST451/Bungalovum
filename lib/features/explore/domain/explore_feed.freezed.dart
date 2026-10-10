// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherSummary {

 DateTime get date; int get temperatureC; WeatherCondition get condition;/// Hafta sonu müsait bungalov sayısı.
 int get availableCount;
/// Create a copy of WeatherSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherSummaryCopyWith<WeatherSummary> get copyWith => _$WeatherSummaryCopyWithImpl<WeatherSummary>(this as WeatherSummary, _$identity);

  /// Serializes this WeatherSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherSummary&&(identical(other.date, date) || other.date == date)&&(identical(other.temperatureC, temperatureC) || other.temperatureC == temperatureC)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.availableCount, availableCount) || other.availableCount == availableCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,temperatureC,condition,availableCount);

@override
String toString() {
  return 'WeatherSummary(date: $date, temperatureC: $temperatureC, condition: $condition, availableCount: $availableCount)';
}


}

/// @nodoc
abstract mixin class $WeatherSummaryCopyWith<$Res>  {
  factory $WeatherSummaryCopyWith(WeatherSummary value, $Res Function(WeatherSummary) _then) = _$WeatherSummaryCopyWithImpl;
@useResult
$Res call({
 DateTime date, int temperatureC, WeatherCondition condition, int availableCount
});




}
/// @nodoc
class _$WeatherSummaryCopyWithImpl<$Res>
    implements $WeatherSummaryCopyWith<$Res> {
  _$WeatherSummaryCopyWithImpl(this._self, this._then);

  final WeatherSummary _self;
  final $Res Function(WeatherSummary) _then;

/// Create a copy of WeatherSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? temperatureC = null,Object? condition = null,Object? availableCount = null,}) {
  return _then(WeatherSummary(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,temperatureC: null == temperatureC ? _self.temperatureC : temperatureC // ignore: cast_nullable_to_non_nullable
as int,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as WeatherCondition,availableCount: null == availableCount ? _self.availableCount : availableCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherSummary].
extension WeatherSummaryPatterns on WeatherSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherSummary value)  $default,){
final _that = this;
switch (_that) {
case _WeatherSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherSummary value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int temperatureC,  WeatherCondition condition,  int availableCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherSummary() when $default != null:
return $default(_that.date,_that.temperatureC,_that.condition,_that.availableCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int temperatureC,  WeatherCondition condition,  int availableCount)  $default,) {final _that = this;
switch (_that) {
case _WeatherSummary():
return $default(_that.date,_that.temperatureC,_that.condition,_that.availableCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int temperatureC,  WeatherCondition condition,  int availableCount)?  $default,) {final _that = this;
switch (_that) {
case _WeatherSummary() when $default != null:
return $default(_that.date,_that.temperatureC,_that.condition,_that.availableCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherSummary implements WeatherSummary {
  const _WeatherSummary({required this.date, required this.temperatureC, required this.condition, required this.availableCount});
  factory _WeatherSummary.fromJson(Map<String, dynamic> json) => _$WeatherSummaryFromJson(json);

@override final  DateTime date;
@override final  int temperatureC;
@override final  WeatherCondition condition;
/// Hafta sonu müsait bungalov sayısı.
@override final  int availableCount;

/// Create a copy of WeatherSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherSummaryCopyWith<_WeatherSummary> get copyWith => __$WeatherSummaryCopyWithImpl<_WeatherSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherSummary&&(identical(other.date, date) || other.date == date)&&(identical(other.temperatureC, temperatureC) || other.temperatureC == temperatureC)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.availableCount, availableCount) || other.availableCount == availableCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,temperatureC,condition,availableCount);

@override
String toString() {
  return 'WeatherSummary(date: $date, temperatureC: $temperatureC, condition: $condition, availableCount: $availableCount)';
}


}

/// @nodoc
abstract mixin class _$WeatherSummaryCopyWith<$Res> implements $WeatherSummaryCopyWith<$Res> {
  factory _$WeatherSummaryCopyWith(_WeatherSummary value, $Res Function(_WeatherSummary) _then) = __$WeatherSummaryCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int temperatureC, WeatherCondition condition, int availableCount
});




}
/// @nodoc
class __$WeatherSummaryCopyWithImpl<$Res>
    implements _$WeatherSummaryCopyWith<$Res> {
  __$WeatherSummaryCopyWithImpl(this._self, this._then);

  final _WeatherSummary _self;
  final $Res Function(_WeatherSummary) _then;

/// Create a copy of WeatherSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? temperatureC = null,Object? condition = null,Object? availableCount = null,}) {
  return _then(_WeatherSummary(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,temperatureC: null == temperatureC ? _self.temperatureC : temperatureC // ignore: cast_nullable_to_non_nullable
as int,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as WeatherCondition,availableCount: null == availableCount ? _self.availableCount : availableCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ExploreSection {

 ExploreSectionKind get kind;/// Bölge adı, Türkçe bulunma ekiyle: "Sapanca'da".
 String get regionLocative;/// "Tümünü gör"de aranacak konum: "Sapanca".
 String get location; List<Listing> get listings;
/// Create a copy of ExploreSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreSectionCopyWith<ExploreSection> get copyWith => _$ExploreSectionCopyWithImpl<ExploreSection>(this as ExploreSection, _$identity);

  /// Serializes this ExploreSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreSection&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.regionLocative, regionLocative) || other.regionLocative == regionLocative)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.listings, listings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,regionLocative,location,const DeepCollectionEquality().hash(listings));

@override
String toString() {
  return 'ExploreSection(kind: $kind, regionLocative: $regionLocative, location: $location, listings: $listings)';
}


}

/// @nodoc
abstract mixin class $ExploreSectionCopyWith<$Res>  {
  factory $ExploreSectionCopyWith(ExploreSection value, $Res Function(ExploreSection) _then) = _$ExploreSectionCopyWithImpl;
@useResult
$Res call({
 ExploreSectionKind kind, String regionLocative, String location, List<Listing> listings
});




}
/// @nodoc
class _$ExploreSectionCopyWithImpl<$Res>
    implements $ExploreSectionCopyWith<$Res> {
  _$ExploreSectionCopyWithImpl(this._self, this._then);

  final ExploreSection _self;
  final $Res Function(ExploreSection) _then;

/// Create a copy of ExploreSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? regionLocative = null,Object? location = null,Object? listings = null,}) {
  return _then(ExploreSection(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ExploreSectionKind,regionLocative: null == regionLocative ? _self.regionLocative : regionLocative // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,listings: null == listings ? _self.listings : listings // ignore: cast_nullable_to_non_nullable
as List<Listing>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExploreSection].
extension ExploreSectionPatterns on ExploreSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreSection value)  $default,){
final _that = this;
switch (_that) {
case _ExploreSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreSection value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExploreSectionKind kind,  String regionLocative,  String location,  List<Listing> listings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreSection() when $default != null:
return $default(_that.kind,_that.regionLocative,_that.location,_that.listings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExploreSectionKind kind,  String regionLocative,  String location,  List<Listing> listings)  $default,) {final _that = this;
switch (_that) {
case _ExploreSection():
return $default(_that.kind,_that.regionLocative,_that.location,_that.listings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExploreSectionKind kind,  String regionLocative,  String location,  List<Listing> listings)?  $default,) {final _that = this;
switch (_that) {
case _ExploreSection() when $default != null:
return $default(_that.kind,_that.regionLocative,_that.location,_that.listings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExploreSection implements ExploreSection {
  const _ExploreSection({required this.kind, required this.regionLocative, required this.location,  List<Listing> listings = const <Listing>[]}): _listings = listings;
  factory _ExploreSection.fromJson(Map<String, dynamic> json) => _$ExploreSectionFromJson(json);

@override final  ExploreSectionKind kind;
/// Bölge adı, Türkçe bulunma ekiyle: "Sapanca'da".
@override final  String regionLocative;
/// "Tümünü gör"de aranacak konum: "Sapanca".
@override final  String location;
 final  List<Listing> _listings;
@override@JsonKey() List<Listing> get listings {
  if (_listings is EqualUnmodifiableListView) return _listings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listings);
}


/// Create a copy of ExploreSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreSectionCopyWith<_ExploreSection> get copyWith => __$ExploreSectionCopyWithImpl<_ExploreSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExploreSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreSection&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.regionLocative, regionLocative) || other.regionLocative == regionLocative)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._listings, _listings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,regionLocative,location,const DeepCollectionEquality().hash(_listings));

@override
String toString() {
  return 'ExploreSection(kind: $kind, regionLocative: $regionLocative, location: $location, listings: $listings)';
}


}

/// @nodoc
abstract mixin class _$ExploreSectionCopyWith<$Res> implements $ExploreSectionCopyWith<$Res> {
  factory _$ExploreSectionCopyWith(_ExploreSection value, $Res Function(_ExploreSection) _then) = __$ExploreSectionCopyWithImpl;
@override @useResult
$Res call({
 ExploreSectionKind kind, String regionLocative, String location, List<Listing> listings
});




}
/// @nodoc
class __$ExploreSectionCopyWithImpl<$Res>
    implements _$ExploreSectionCopyWith<$Res> {
  __$ExploreSectionCopyWithImpl(this._self, this._then);

  final _ExploreSection _self;
  final $Res Function(_ExploreSection) _then;

/// Create a copy of ExploreSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? regionLocative = null,Object? location = null,Object? listings = null,}) {
  return _then(_ExploreSection(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ExploreSectionKind,regionLocative: null == regionLocative ? _self.regionLocative : regionLocative // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,listings: null == listings ? _self._listings : listings // ignore: cast_nullable_to_non_nullable
as List<Listing>,
  ));
}


}


/// @nodoc
mixin _$ExploreFeed {

/// "Sapanca, Sakarya"
 String get locationLabel; WeatherSummary? get weather;/// Bölge şeritleri; ilanı olmayan bölüm gösterilmez.
 List<ExploreSection> get sections; DateTime get weekendStart; DateTime get weekendEnd; List<ListingOffer> get weekendDeals;
/// Create a copy of ExploreFeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreFeedCopyWith<ExploreFeed> get copyWith => _$ExploreFeedCopyWithImpl<ExploreFeed>(this as ExploreFeed, _$identity);

  /// Serializes this ExploreFeed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreFeed&&(identical(other.locationLabel, locationLabel) || other.locationLabel == locationLabel)&&(identical(other.weather, weather) || other.weather == weather)&&const DeepCollectionEquality().equals(other.sections, sections)&&(identical(other.weekendStart, weekendStart) || other.weekendStart == weekendStart)&&(identical(other.weekendEnd, weekendEnd) || other.weekendEnd == weekendEnd)&&const DeepCollectionEquality().equals(other.weekendDeals, weekendDeals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locationLabel,weather,const DeepCollectionEquality().hash(sections),weekendStart,weekendEnd,const DeepCollectionEquality().hash(weekendDeals));

@override
String toString() {
  return 'ExploreFeed(locationLabel: $locationLabel, weather: $weather, sections: $sections, weekendStart: $weekendStart, weekendEnd: $weekendEnd, weekendDeals: $weekendDeals)';
}


}

/// @nodoc
abstract mixin class $ExploreFeedCopyWith<$Res>  {
  factory $ExploreFeedCopyWith(ExploreFeed value, $Res Function(ExploreFeed) _then) = _$ExploreFeedCopyWithImpl;
@useResult
$Res call({
 String locationLabel, WeatherSummary? weather, List<ExploreSection> sections, DateTime weekendStart, DateTime weekendEnd, List<ListingOffer> weekendDeals
});


$WeatherSummaryCopyWith<$Res>? get weather;

}
/// @nodoc
class _$ExploreFeedCopyWithImpl<$Res>
    implements $ExploreFeedCopyWith<$Res> {
  _$ExploreFeedCopyWithImpl(this._self, this._then);

  final ExploreFeed _self;
  final $Res Function(ExploreFeed) _then;

/// Create a copy of ExploreFeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locationLabel = null,Object? weather = freezed,Object? sections = null,Object? weekendStart = null,Object? weekendEnd = null,Object? weekendDeals = null,}) {
  return _then(ExploreFeed(
locationLabel: null == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String,weather: freezed == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as WeatherSummary?,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<ExploreSection>,weekendStart: null == weekendStart ? _self.weekendStart : weekendStart // ignore: cast_nullable_to_non_nullable
as DateTime,weekendEnd: null == weekendEnd ? _self.weekendEnd : weekendEnd // ignore: cast_nullable_to_non_nullable
as DateTime,weekendDeals: null == weekendDeals ? _self.weekendDeals : weekendDeals // ignore: cast_nullable_to_non_nullable
as List<ListingOffer>,
  ));
}
/// Create a copy of ExploreFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherSummaryCopyWith<$Res>? get weather {
    if (_self.weather == null) {
    return null;
  }

  return $WeatherSummaryCopyWith<$Res>(_self.weather!, (value) {
    return _then(_self.copyWith(weather: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExploreFeed].
extension ExploreFeedPatterns on ExploreFeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreFeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreFeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreFeed value)  $default,){
final _that = this;
switch (_that) {
case _ExploreFeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreFeed value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreFeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String locationLabel,  WeatherSummary? weather,  List<ExploreSection> sections,  DateTime weekendStart,  DateTime weekendEnd,  List<ListingOffer> weekendDeals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreFeed() when $default != null:
return $default(_that.locationLabel,_that.weather,_that.sections,_that.weekendStart,_that.weekendEnd,_that.weekendDeals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String locationLabel,  WeatherSummary? weather,  List<ExploreSection> sections,  DateTime weekendStart,  DateTime weekendEnd,  List<ListingOffer> weekendDeals)  $default,) {final _that = this;
switch (_that) {
case _ExploreFeed():
return $default(_that.locationLabel,_that.weather,_that.sections,_that.weekendStart,_that.weekendEnd,_that.weekendDeals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String locationLabel,  WeatherSummary? weather,  List<ExploreSection> sections,  DateTime weekendStart,  DateTime weekendEnd,  List<ListingOffer> weekendDeals)?  $default,) {final _that = this;
switch (_that) {
case _ExploreFeed() when $default != null:
return $default(_that.locationLabel,_that.weather,_that.sections,_that.weekendStart,_that.weekendEnd,_that.weekendDeals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExploreFeed implements ExploreFeed {
  const _ExploreFeed({required this.locationLabel, this.weather,  List<ExploreSection> sections = const <ExploreSection>[], required this.weekendStart, required this.weekendEnd,  List<ListingOffer> weekendDeals = const <ListingOffer>[]}): _sections = sections,_weekendDeals = weekendDeals;
  factory _ExploreFeed.fromJson(Map<String, dynamic> json) => _$ExploreFeedFromJson(json);

/// "Sapanca, Sakarya"
@override final  String locationLabel;
@override final  WeatherSummary? weather;
/// Bölge şeritleri; ilanı olmayan bölüm gösterilmez.
 final  List<ExploreSection> _sections;
/// Bölge şeritleri; ilanı olmayan bölüm gösterilmez.
@override@JsonKey() List<ExploreSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

@override final  DateTime weekendStart;
@override final  DateTime weekendEnd;
 final  List<ListingOffer> _weekendDeals;
@override@JsonKey() List<ListingOffer> get weekendDeals {
  if (_weekendDeals is EqualUnmodifiableListView) return _weekendDeals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weekendDeals);
}


/// Create a copy of ExploreFeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreFeedCopyWith<_ExploreFeed> get copyWith => __$ExploreFeedCopyWithImpl<_ExploreFeed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExploreFeedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreFeed&&(identical(other.locationLabel, locationLabel) || other.locationLabel == locationLabel)&&(identical(other.weather, weather) || other.weather == weather)&&const DeepCollectionEquality().equals(other._sections, _sections)&&(identical(other.weekendStart, weekendStart) || other.weekendStart == weekendStart)&&(identical(other.weekendEnd, weekendEnd) || other.weekendEnd == weekendEnd)&&const DeepCollectionEquality().equals(other._weekendDeals, _weekendDeals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locationLabel,weather,const DeepCollectionEquality().hash(_sections),weekendStart,weekendEnd,const DeepCollectionEquality().hash(_weekendDeals));

@override
String toString() {
  return 'ExploreFeed(locationLabel: $locationLabel, weather: $weather, sections: $sections, weekendStart: $weekendStart, weekendEnd: $weekendEnd, weekendDeals: $weekendDeals)';
}


}

/// @nodoc
abstract mixin class _$ExploreFeedCopyWith<$Res> implements $ExploreFeedCopyWith<$Res> {
  factory _$ExploreFeedCopyWith(_ExploreFeed value, $Res Function(_ExploreFeed) _then) = __$ExploreFeedCopyWithImpl;
@override @useResult
$Res call({
 String locationLabel, WeatherSummary? weather, List<ExploreSection> sections, DateTime weekendStart, DateTime weekendEnd, List<ListingOffer> weekendDeals
});


@override $WeatherSummaryCopyWith<$Res>? get weather;

}
/// @nodoc
class __$ExploreFeedCopyWithImpl<$Res>
    implements _$ExploreFeedCopyWith<$Res> {
  __$ExploreFeedCopyWithImpl(this._self, this._then);

  final _ExploreFeed _self;
  final $Res Function(_ExploreFeed) _then;

/// Create a copy of ExploreFeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locationLabel = null,Object? weather = freezed,Object? sections = null,Object? weekendStart = null,Object? weekendEnd = null,Object? weekendDeals = null,}) {
  return _then(_ExploreFeed(
locationLabel: null == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String,weather: freezed == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as WeatherSummary?,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<ExploreSection>,weekendStart: null == weekendStart ? _self.weekendStart : weekendStart // ignore: cast_nullable_to_non_nullable
as DateTime,weekendEnd: null == weekendEnd ? _self.weekendEnd : weekendEnd // ignore: cast_nullable_to_non_nullable
as DateTime,weekendDeals: null == weekendDeals ? _self._weekendDeals : weekendDeals // ignore: cast_nullable_to_non_nullable
as List<ListingOffer>,
  ));
}

/// Create a copy of ExploreFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherSummaryCopyWith<$Res>? get weather {
    if (_self.weather == null) {
    return null;
  }

  return $WeatherSummaryCopyWith<$Res>(_self.weather!, (value) {
    return _then(_self.copyWith(weather: value));
  });
}
}

// dart format on
