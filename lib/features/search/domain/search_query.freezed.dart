// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GuestCount {

 int get adults; int get children; int get infants; int get pets;
/// Create a copy of GuestCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuestCountCopyWith<GuestCount> get copyWith => _$GuestCountCopyWithImpl<GuestCount>(this as GuestCount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuestCount&&(identical(other.adults, adults) || other.adults == adults)&&(identical(other.children, children) || other.children == children)&&(identical(other.infants, infants) || other.infants == infants)&&(identical(other.pets, pets) || other.pets == pets));
}


@override
int get hashCode => Object.hash(runtimeType,adults,children,infants,pets);

@override
String toString() {
  return 'GuestCount(adults: $adults, children: $children, infants: $infants, pets: $pets)';
}


}

/// @nodoc
abstract mixin class $GuestCountCopyWith<$Res>  {
  factory $GuestCountCopyWith(GuestCount value, $Res Function(GuestCount) _then) = _$GuestCountCopyWithImpl;
@useResult
$Res call({
 int adults, int children, int infants, int pets
});




}
/// @nodoc
class _$GuestCountCopyWithImpl<$Res>
    implements $GuestCountCopyWith<$Res> {
  _$GuestCountCopyWithImpl(this._self, this._then);

  final GuestCount _self;
  final $Res Function(GuestCount) _then;

/// Create a copy of GuestCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? adults = null,Object? children = null,Object? infants = null,Object? pets = null,}) {
  return _then(GuestCount(
adults: null == adults ? _self.adults : adults // ignore: cast_nullable_to_non_nullable
as int,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as int,infants: null == infants ? _self.infants : infants // ignore: cast_nullable_to_non_nullable
as int,pets: null == pets ? _self.pets : pets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GuestCount].
extension GuestCountPatterns on GuestCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuestCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuestCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuestCount value)  $default,){
final _that = this;
switch (_that) {
case _GuestCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuestCount value)?  $default,){
final _that = this;
switch (_that) {
case _GuestCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int adults,  int children,  int infants,  int pets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuestCount() when $default != null:
return $default(_that.adults,_that.children,_that.infants,_that.pets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int adults,  int children,  int infants,  int pets)  $default,) {final _that = this;
switch (_that) {
case _GuestCount():
return $default(_that.adults,_that.children,_that.infants,_that.pets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int adults,  int children,  int infants,  int pets)?  $default,) {final _that = this;
switch (_that) {
case _GuestCount() when $default != null:
return $default(_that.adults,_that.children,_that.infants,_that.pets);case _:
  return null;

}
}

}

/// @nodoc


class _GuestCount extends GuestCount {
  const _GuestCount({this.adults = 2, this.children = 0, this.infants = 0, this.pets = 0}): super._();
  

@override@JsonKey() final  int adults;
@override@JsonKey() final  int children;
@override@JsonKey() final  int infants;
@override@JsonKey() final  int pets;

/// Create a copy of GuestCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuestCountCopyWith<_GuestCount> get copyWith => __$GuestCountCopyWithImpl<_GuestCount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuestCount&&(identical(other.adults, adults) || other.adults == adults)&&(identical(other.children, children) || other.children == children)&&(identical(other.infants, infants) || other.infants == infants)&&(identical(other.pets, pets) || other.pets == pets));
}


@override
int get hashCode => Object.hash(runtimeType,adults,children,infants,pets);

@override
String toString() {
  return 'GuestCount(adults: $adults, children: $children, infants: $infants, pets: $pets)';
}


}

/// @nodoc
abstract mixin class _$GuestCountCopyWith<$Res> implements $GuestCountCopyWith<$Res> {
  factory _$GuestCountCopyWith(_GuestCount value, $Res Function(_GuestCount) _then) = __$GuestCountCopyWithImpl;
@override @useResult
$Res call({
 int adults, int children, int infants, int pets
});




}
/// @nodoc
class __$GuestCountCopyWithImpl<$Res>
    implements _$GuestCountCopyWith<$Res> {
  __$GuestCountCopyWithImpl(this._self, this._then);

  final _GuestCount _self;
  final $Res Function(_GuestCount) _then;

/// Create a copy of GuestCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? adults = null,Object? children = null,Object? infants = null,Object? pets = null,}) {
  return _then(_GuestCount(
adults: null == adults ? _self.adults : adults // ignore: cast_nullable_to_non_nullable
as int,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as int,infants: null == infants ? _self.infants : infants // ignore: cast_nullable_to_non_nullable
as int,pets: null == pets ? _self.pets : pets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$StayDates {

 DateTime get checkIn; DateTime get checkOut;
/// Create a copy of StayDates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StayDatesCopyWith<StayDates> get copyWith => _$StayDatesCopyWithImpl<StayDates>(this as StayDates, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StayDates&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn)&&(identical(other.checkOut, checkOut) || other.checkOut == checkOut));
}


@override
int get hashCode => Object.hash(runtimeType,checkIn,checkOut);

@override
String toString() {
  return 'StayDates(checkIn: $checkIn, checkOut: $checkOut)';
}


}

/// @nodoc
abstract mixin class $StayDatesCopyWith<$Res>  {
  factory $StayDatesCopyWith(StayDates value, $Res Function(StayDates) _then) = _$StayDatesCopyWithImpl;
@useResult
$Res call({
 DateTime checkIn, DateTime checkOut
});




}
/// @nodoc
class _$StayDatesCopyWithImpl<$Res>
    implements $StayDatesCopyWith<$Res> {
  _$StayDatesCopyWithImpl(this._self, this._then);

  final StayDates _self;
  final $Res Function(StayDates) _then;

/// Create a copy of StayDates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? checkIn = null,Object? checkOut = null,}) {
  return _then(StayDates(
checkIn: null == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as DateTime,checkOut: null == checkOut ? _self.checkOut : checkOut // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [StayDates].
extension StayDatesPatterns on StayDates {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StayDates value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StayDates() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StayDates value)  $default,){
final _that = this;
switch (_that) {
case _StayDates():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StayDates value)?  $default,){
final _that = this;
switch (_that) {
case _StayDates() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime checkIn,  DateTime checkOut)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StayDates() when $default != null:
return $default(_that.checkIn,_that.checkOut);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime checkIn,  DateTime checkOut)  $default,) {final _that = this;
switch (_that) {
case _StayDates():
return $default(_that.checkIn,_that.checkOut);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime checkIn,  DateTime checkOut)?  $default,) {final _that = this;
switch (_that) {
case _StayDates() when $default != null:
return $default(_that.checkIn,_that.checkOut);case _:
  return null;

}
}

}

/// @nodoc


class _StayDates extends StayDates {
  const _StayDates({required this.checkIn, required this.checkOut}): super._();
  

@override final  DateTime checkIn;
@override final  DateTime checkOut;

/// Create a copy of StayDates
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StayDatesCopyWith<_StayDates> get copyWith => __$StayDatesCopyWithImpl<_StayDates>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StayDates&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn)&&(identical(other.checkOut, checkOut) || other.checkOut == checkOut));
}


@override
int get hashCode => Object.hash(runtimeType,checkIn,checkOut);

@override
String toString() {
  return 'StayDates(checkIn: $checkIn, checkOut: $checkOut)';
}


}

/// @nodoc
abstract mixin class _$StayDatesCopyWith<$Res> implements $StayDatesCopyWith<$Res> {
  factory _$StayDatesCopyWith(_StayDates value, $Res Function(_StayDates) _then) = __$StayDatesCopyWithImpl;
@override @useResult
$Res call({
 DateTime checkIn, DateTime checkOut
});




}
/// @nodoc
class __$StayDatesCopyWithImpl<$Res>
    implements _$StayDatesCopyWith<$Res> {
  __$StayDatesCopyWithImpl(this._self, this._then);

  final _StayDates _self;
  final $Res Function(_StayDates) _then;

/// Create a copy of StayDates
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? checkIn = null,Object? checkOut = null,}) {
  return _then(_StayDates(
checkIn: null == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as DateTime,checkOut: null == checkOut ? _self.checkOut : checkOut // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$SearchFilters {

/// Gecelik fiyat aralığı (TRY); null = sınır yok.
 int? get priceMin; int? get priceMax; Set<SearchFeature> get features;/// null = farketmez; 4 = 4 ve üzeri.
 int? get bedrooms; bool get instantBook; bool get freeCancellation; bool get petsAllowed; bool get accessible;
/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFiltersCopyWith<SearchFilters> get copyWith => _$SearchFiltersCopyWithImpl<SearchFilters>(this as SearchFilters, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFilters&&(identical(other.priceMin, priceMin) || other.priceMin == priceMin)&&(identical(other.priceMax, priceMax) || other.priceMax == priceMax)&&const DeepCollectionEquality().equals(other.features, features)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.instantBook, instantBook) || other.instantBook == instantBook)&&(identical(other.freeCancellation, freeCancellation) || other.freeCancellation == freeCancellation)&&(identical(other.petsAllowed, petsAllowed) || other.petsAllowed == petsAllowed)&&(identical(other.accessible, accessible) || other.accessible == accessible));
}


@override
int get hashCode => Object.hash(runtimeType,priceMin,priceMax,const DeepCollectionEquality().hash(features),bedrooms,instantBook,freeCancellation,petsAllowed,accessible);

@override
String toString() {
  return 'SearchFilters(priceMin: $priceMin, priceMax: $priceMax, features: $features, bedrooms: $bedrooms, instantBook: $instantBook, freeCancellation: $freeCancellation, petsAllowed: $petsAllowed, accessible: $accessible)';
}


}

/// @nodoc
abstract mixin class $SearchFiltersCopyWith<$Res>  {
  factory $SearchFiltersCopyWith(SearchFilters value, $Res Function(SearchFilters) _then) = _$SearchFiltersCopyWithImpl;
@useResult
$Res call({
 int? priceMin, int? priceMax, Set<SearchFeature> features, int? bedrooms, bool instantBook, bool freeCancellation, bool petsAllowed, bool accessible
});




}
/// @nodoc
class _$SearchFiltersCopyWithImpl<$Res>
    implements $SearchFiltersCopyWith<$Res> {
  _$SearchFiltersCopyWithImpl(this._self, this._then);

  final SearchFilters _self;
  final $Res Function(SearchFilters) _then;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? priceMin = freezed,Object? priceMax = freezed,Object? features = null,Object? bedrooms = freezed,Object? instantBook = null,Object? freeCancellation = null,Object? petsAllowed = null,Object? accessible = null,}) {
  return _then(SearchFilters(
priceMin: freezed == priceMin ? _self.priceMin : priceMin // ignore: cast_nullable_to_non_nullable
as int?,priceMax: freezed == priceMax ? _self.priceMax : priceMax // ignore: cast_nullable_to_non_nullable
as int?,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as Set<SearchFeature>,bedrooms: freezed == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int?,instantBook: null == instantBook ? _self.instantBook : instantBook // ignore: cast_nullable_to_non_nullable
as bool,freeCancellation: null == freeCancellation ? _self.freeCancellation : freeCancellation // ignore: cast_nullable_to_non_nullable
as bool,petsAllowed: null == petsAllowed ? _self.petsAllowed : petsAllowed // ignore: cast_nullable_to_non_nullable
as bool,accessible: null == accessible ? _self.accessible : accessible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchFilters].
extension SearchFiltersPatterns on SearchFilters {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchFilters value)  $default,){
final _that = this;
switch (_that) {
case _SearchFilters():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchFilters value)?  $default,){
final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? priceMin,  int? priceMax,  Set<SearchFeature> features,  int? bedrooms,  bool instantBook,  bool freeCancellation,  bool petsAllowed,  bool accessible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that.priceMin,_that.priceMax,_that.features,_that.bedrooms,_that.instantBook,_that.freeCancellation,_that.petsAllowed,_that.accessible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? priceMin,  int? priceMax,  Set<SearchFeature> features,  int? bedrooms,  bool instantBook,  bool freeCancellation,  bool petsAllowed,  bool accessible)  $default,) {final _that = this;
switch (_that) {
case _SearchFilters():
return $default(_that.priceMin,_that.priceMax,_that.features,_that.bedrooms,_that.instantBook,_that.freeCancellation,_that.petsAllowed,_that.accessible);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? priceMin,  int? priceMax,  Set<SearchFeature> features,  int? bedrooms,  bool instantBook,  bool freeCancellation,  bool petsAllowed,  bool accessible)?  $default,) {final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that.priceMin,_that.priceMax,_that.features,_that.bedrooms,_that.instantBook,_that.freeCancellation,_that.petsAllowed,_that.accessible);case _:
  return null;

}
}

}

/// @nodoc


class _SearchFilters extends SearchFilters {
  const _SearchFilters({this.priceMin, this.priceMax,  Set<SearchFeature> features = const <SearchFeature>{}, this.bedrooms, this.instantBook = false, this.freeCancellation = false, this.petsAllowed = false, this.accessible = false}): _features = features,super._();
  

/// Gecelik fiyat aralığı (TRY); null = sınır yok.
@override final  int? priceMin;
@override final  int? priceMax;
 final  Set<SearchFeature> _features;
@override@JsonKey() Set<SearchFeature> get features {
  if (_features is EqualUnmodifiableSetView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_features);
}

/// null = farketmez; 4 = 4 ve üzeri.
@override final  int? bedrooms;
@override@JsonKey() final  bool instantBook;
@override@JsonKey() final  bool freeCancellation;
@override@JsonKey() final  bool petsAllowed;
@override@JsonKey() final  bool accessible;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchFiltersCopyWith<_SearchFilters> get copyWith => __$SearchFiltersCopyWithImpl<_SearchFilters>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchFilters&&(identical(other.priceMin, priceMin) || other.priceMin == priceMin)&&(identical(other.priceMax, priceMax) || other.priceMax == priceMax)&&const DeepCollectionEquality().equals(other._features, _features)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.instantBook, instantBook) || other.instantBook == instantBook)&&(identical(other.freeCancellation, freeCancellation) || other.freeCancellation == freeCancellation)&&(identical(other.petsAllowed, petsAllowed) || other.petsAllowed == petsAllowed)&&(identical(other.accessible, accessible) || other.accessible == accessible));
}


@override
int get hashCode => Object.hash(runtimeType,priceMin,priceMax,const DeepCollectionEquality().hash(_features),bedrooms,instantBook,freeCancellation,petsAllowed,accessible);

@override
String toString() {
  return 'SearchFilters(priceMin: $priceMin, priceMax: $priceMax, features: $features, bedrooms: $bedrooms, instantBook: $instantBook, freeCancellation: $freeCancellation, petsAllowed: $petsAllowed, accessible: $accessible)';
}


}

/// @nodoc
abstract mixin class _$SearchFiltersCopyWith<$Res> implements $SearchFiltersCopyWith<$Res> {
  factory _$SearchFiltersCopyWith(_SearchFilters value, $Res Function(_SearchFilters) _then) = __$SearchFiltersCopyWithImpl;
@override @useResult
$Res call({
 int? priceMin, int? priceMax, Set<SearchFeature> features, int? bedrooms, bool instantBook, bool freeCancellation, bool petsAllowed, bool accessible
});




}
/// @nodoc
class __$SearchFiltersCopyWithImpl<$Res>
    implements _$SearchFiltersCopyWith<$Res> {
  __$SearchFiltersCopyWithImpl(this._self, this._then);

  final _SearchFilters _self;
  final $Res Function(_SearchFilters) _then;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? priceMin = freezed,Object? priceMax = freezed,Object? features = null,Object? bedrooms = freezed,Object? instantBook = null,Object? freeCancellation = null,Object? petsAllowed = null,Object? accessible = null,}) {
  return _then(_SearchFilters(
priceMin: freezed == priceMin ? _self.priceMin : priceMin // ignore: cast_nullable_to_non_nullable
as int?,priceMax: freezed == priceMax ? _self.priceMax : priceMax // ignore: cast_nullable_to_non_nullable
as int?,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as Set<SearchFeature>,bedrooms: freezed == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int?,instantBook: null == instantBook ? _self.instantBook : instantBook // ignore: cast_nullable_to_non_nullable
as bool,freeCancellation: null == freeCancellation ? _self.freeCancellation : freeCancellation // ignore: cast_nullable_to_non_nullable
as bool,petsAllowed: null == petsAllowed ? _self.petsAllowed : petsAllowed // ignore: cast_nullable_to_non_nullable
as bool,accessible: null == accessible ? _self.accessible : accessible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SearchQuery {

 String get location; StayDates? get dates; GuestCount get guests; SearchFilters get filters; SearchSort get sort;
/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchQueryCopyWith<SearchQuery> get copyWith => _$SearchQueryCopyWithImpl<SearchQuery>(this as SearchQuery, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchQuery&&(identical(other.location, location) || other.location == location)&&(identical(other.dates, dates) || other.dates == dates)&&(identical(other.guests, guests) || other.guests == guests)&&(identical(other.filters, filters) || other.filters == filters)&&(identical(other.sort, sort) || other.sort == sort));
}


@override
int get hashCode => Object.hash(runtimeType,location,dates,guests,filters,sort);

@override
String toString() {
  return 'SearchQuery(location: $location, dates: $dates, guests: $guests, filters: $filters, sort: $sort)';
}


}

/// @nodoc
abstract mixin class $SearchQueryCopyWith<$Res>  {
  factory $SearchQueryCopyWith(SearchQuery value, $Res Function(SearchQuery) _then) = _$SearchQueryCopyWithImpl;
@useResult
$Res call({
 String location, StayDates? dates, GuestCount guests, SearchFilters filters, SearchSort sort
});


$StayDatesCopyWith<$Res>? get dates;$GuestCountCopyWith<$Res> get guests;$SearchFiltersCopyWith<$Res> get filters;

}
/// @nodoc
class _$SearchQueryCopyWithImpl<$Res>
    implements $SearchQueryCopyWith<$Res> {
  _$SearchQueryCopyWithImpl(this._self, this._then);

  final SearchQuery _self;
  final $Res Function(SearchQuery) _then;

/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? dates = freezed,Object? guests = null,Object? filters = null,Object? sort = null,}) {
  return _then(SearchQuery(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,dates: freezed == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as StayDates?,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as GuestCount,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as SearchFilters,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as SearchSort,
  ));
}
/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StayDatesCopyWith<$Res>? get dates {
    if (_self.dates == null) {
    return null;
  }

  return $StayDatesCopyWith<$Res>(_self.dates!, (value) {
    return _then(_self.copyWith(dates: value));
  });
}/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuestCountCopyWith<$Res> get guests {
  
  return $GuestCountCopyWith<$Res>(_self.guests, (value) {
    return _then(_self.copyWith(guests: value));
  });
}/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchFiltersCopyWith<$Res> get filters {
  
  return $SearchFiltersCopyWith<$Res>(_self.filters, (value) {
    return _then(_self.copyWith(filters: value));
  });
}
}


/// Adds pattern-matching-related methods to [SearchQuery].
extension SearchQueryPatterns on SearchQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchQuery value)  $default,){
final _that = this;
switch (_that) {
case _SearchQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchQuery value)?  $default,){
final _that = this;
switch (_that) {
case _SearchQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String location,  StayDates? dates,  GuestCount guests,  SearchFilters filters,  SearchSort sort)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchQuery() when $default != null:
return $default(_that.location,_that.dates,_that.guests,_that.filters,_that.sort);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String location,  StayDates? dates,  GuestCount guests,  SearchFilters filters,  SearchSort sort)  $default,) {final _that = this;
switch (_that) {
case _SearchQuery():
return $default(_that.location,_that.dates,_that.guests,_that.filters,_that.sort);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String location,  StayDates? dates,  GuestCount guests,  SearchFilters filters,  SearchSort sort)?  $default,) {final _that = this;
switch (_that) {
case _SearchQuery() when $default != null:
return $default(_that.location,_that.dates,_that.guests,_that.filters,_that.sort);case _:
  return null;

}
}

}

/// @nodoc


class _SearchQuery extends SearchQuery {
  const _SearchQuery({this.location = '', this.dates, this.guests = const GuestCount(), this.filters = const SearchFilters(), this.sort = SearchSort.recommended}): super._();
  

@override@JsonKey() final  String location;
@override final  StayDates? dates;
@override@JsonKey() final  GuestCount guests;
@override@JsonKey() final  SearchFilters filters;
@override@JsonKey() final  SearchSort sort;

/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchQueryCopyWith<_SearchQuery> get copyWith => __$SearchQueryCopyWithImpl<_SearchQuery>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchQuery&&(identical(other.location, location) || other.location == location)&&(identical(other.dates, dates) || other.dates == dates)&&(identical(other.guests, guests) || other.guests == guests)&&(identical(other.filters, filters) || other.filters == filters)&&(identical(other.sort, sort) || other.sort == sort));
}


@override
int get hashCode => Object.hash(runtimeType,location,dates,guests,filters,sort);

@override
String toString() {
  return 'SearchQuery(location: $location, dates: $dates, guests: $guests, filters: $filters, sort: $sort)';
}


}

/// @nodoc
abstract mixin class _$SearchQueryCopyWith<$Res> implements $SearchQueryCopyWith<$Res> {
  factory _$SearchQueryCopyWith(_SearchQuery value, $Res Function(_SearchQuery) _then) = __$SearchQueryCopyWithImpl;
@override @useResult
$Res call({
 String location, StayDates? dates, GuestCount guests, SearchFilters filters, SearchSort sort
});


@override $StayDatesCopyWith<$Res>? get dates;@override $GuestCountCopyWith<$Res> get guests;@override $SearchFiltersCopyWith<$Res> get filters;

}
/// @nodoc
class __$SearchQueryCopyWithImpl<$Res>
    implements _$SearchQueryCopyWith<$Res> {
  __$SearchQueryCopyWithImpl(this._self, this._then);

  final _SearchQuery _self;
  final $Res Function(_SearchQuery) _then;

/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? dates = freezed,Object? guests = null,Object? filters = null,Object? sort = null,}) {
  return _then(_SearchQuery(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,dates: freezed == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as StayDates?,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as GuestCount,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as SearchFilters,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as SearchSort,
  ));
}

/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StayDatesCopyWith<$Res>? get dates {
    if (_self.dates == null) {
    return null;
  }

  return $StayDatesCopyWith<$Res>(_self.dates!, (value) {
    return _then(_self.copyWith(dates: value));
  });
}/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuestCountCopyWith<$Res> get guests {
  
  return $GuestCountCopyWith<$Res>(_self.guests, (value) {
    return _then(_self.copyWith(guests: value));
  });
}/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchFiltersCopyWith<$Res> get filters {
  
  return $SearchFiltersCopyWith<$Res>(_self.filters, (value) {
    return _then(_self.copyWith(filters: value));
  });
}
}

/// @nodoc
mixin _$RecentSearch {

 String get location; StayDates? get dates; GuestCount get guests;
/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentSearchCopyWith<RecentSearch> get copyWith => _$RecentSearchCopyWithImpl<RecentSearch>(this as RecentSearch, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentSearch&&(identical(other.location, location) || other.location == location)&&(identical(other.dates, dates) || other.dates == dates)&&(identical(other.guests, guests) || other.guests == guests));
}


@override
int get hashCode => Object.hash(runtimeType,location,dates,guests);

@override
String toString() {
  return 'RecentSearch(location: $location, dates: $dates, guests: $guests)';
}


}

/// @nodoc
abstract mixin class $RecentSearchCopyWith<$Res>  {
  factory $RecentSearchCopyWith(RecentSearch value, $Res Function(RecentSearch) _then) = _$RecentSearchCopyWithImpl;
@useResult
$Res call({
 String location, StayDates? dates, GuestCount guests
});


$StayDatesCopyWith<$Res>? get dates;$GuestCountCopyWith<$Res> get guests;

}
/// @nodoc
class _$RecentSearchCopyWithImpl<$Res>
    implements $RecentSearchCopyWith<$Res> {
  _$RecentSearchCopyWithImpl(this._self, this._then);

  final RecentSearch _self;
  final $Res Function(RecentSearch) _then;

/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? dates = freezed,Object? guests = null,}) {
  return _then(RecentSearch(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,dates: freezed == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as StayDates?,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as GuestCount,
  ));
}
/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StayDatesCopyWith<$Res>? get dates {
    if (_self.dates == null) {
    return null;
  }

  return $StayDatesCopyWith<$Res>(_self.dates!, (value) {
    return _then(_self.copyWith(dates: value));
  });
}/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuestCountCopyWith<$Res> get guests {
  
  return $GuestCountCopyWith<$Res>(_self.guests, (value) {
    return _then(_self.copyWith(guests: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecentSearch].
extension RecentSearchPatterns on RecentSearch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentSearch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentSearch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentSearch value)  $default,){
final _that = this;
switch (_that) {
case _RecentSearch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentSearch value)?  $default,){
final _that = this;
switch (_that) {
case _RecentSearch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String location,  StayDates? dates,  GuestCount guests)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentSearch() when $default != null:
return $default(_that.location,_that.dates,_that.guests);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String location,  StayDates? dates,  GuestCount guests)  $default,) {final _that = this;
switch (_that) {
case _RecentSearch():
return $default(_that.location,_that.dates,_that.guests);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String location,  StayDates? dates,  GuestCount guests)?  $default,) {final _that = this;
switch (_that) {
case _RecentSearch() when $default != null:
return $default(_that.location,_that.dates,_that.guests);case _:
  return null;

}
}

}

/// @nodoc


class _RecentSearch implements RecentSearch {
  const _RecentSearch({required this.location, this.dates, required this.guests});
  

@override final  String location;
@override final  StayDates? dates;
@override final  GuestCount guests;

/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentSearchCopyWith<_RecentSearch> get copyWith => __$RecentSearchCopyWithImpl<_RecentSearch>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentSearch&&(identical(other.location, location) || other.location == location)&&(identical(other.dates, dates) || other.dates == dates)&&(identical(other.guests, guests) || other.guests == guests));
}


@override
int get hashCode => Object.hash(runtimeType,location,dates,guests);

@override
String toString() {
  return 'RecentSearch(location: $location, dates: $dates, guests: $guests)';
}


}

/// @nodoc
abstract mixin class _$RecentSearchCopyWith<$Res> implements $RecentSearchCopyWith<$Res> {
  factory _$RecentSearchCopyWith(_RecentSearch value, $Res Function(_RecentSearch) _then) = __$RecentSearchCopyWithImpl;
@override @useResult
$Res call({
 String location, StayDates? dates, GuestCount guests
});


@override $StayDatesCopyWith<$Res>? get dates;@override $GuestCountCopyWith<$Res> get guests;

}
/// @nodoc
class __$RecentSearchCopyWithImpl<$Res>
    implements _$RecentSearchCopyWith<$Res> {
  __$RecentSearchCopyWithImpl(this._self, this._then);

  final _RecentSearch _self;
  final $Res Function(_RecentSearch) _then;

/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? dates = freezed,Object? guests = null,}) {
  return _then(_RecentSearch(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,dates: freezed == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as StayDates?,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as GuestCount,
  ));
}

/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StayDatesCopyWith<$Res>? get dates {
    if (_self.dates == null) {
    return null;
  }

  return $StayDatesCopyWith<$Res>(_self.dates!, (value) {
    return _then(_self.copyWith(dates: value));
  });
}/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuestCountCopyWith<$Res> get guests {
  
  return $GuestCountCopyWith<$Res>(_self.guests, (value) {
    return _then(_self.copyWith(guests: value));
  });
}
}

/// @nodoc
mixin _$RelaxSuggestion {

 RelaxKind get kind; int get extraCount;
/// Create a copy of RelaxSuggestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelaxSuggestionCopyWith<RelaxSuggestion> get copyWith => _$RelaxSuggestionCopyWithImpl<RelaxSuggestion>(this as RelaxSuggestion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelaxSuggestion&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.extraCount, extraCount) || other.extraCount == extraCount));
}


@override
int get hashCode => Object.hash(runtimeType,kind,extraCount);

@override
String toString() {
  return 'RelaxSuggestion(kind: $kind, extraCount: $extraCount)';
}


}

/// @nodoc
abstract mixin class $RelaxSuggestionCopyWith<$Res>  {
  factory $RelaxSuggestionCopyWith(RelaxSuggestion value, $Res Function(RelaxSuggestion) _then) = _$RelaxSuggestionCopyWithImpl;
@useResult
$Res call({
 RelaxKind kind, int extraCount
});




}
/// @nodoc
class _$RelaxSuggestionCopyWithImpl<$Res>
    implements $RelaxSuggestionCopyWith<$Res> {
  _$RelaxSuggestionCopyWithImpl(this._self, this._then);

  final RelaxSuggestion _self;
  final $Res Function(RelaxSuggestion) _then;

/// Create a copy of RelaxSuggestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? extraCount = null,}) {
  return _then(RelaxSuggestion(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RelaxKind,extraCount: null == extraCount ? _self.extraCount : extraCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RelaxSuggestion].
extension RelaxSuggestionPatterns on RelaxSuggestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RelaxSuggestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RelaxSuggestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RelaxSuggestion value)  $default,){
final _that = this;
switch (_that) {
case _RelaxSuggestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RelaxSuggestion value)?  $default,){
final _that = this;
switch (_that) {
case _RelaxSuggestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RelaxKind kind,  int extraCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RelaxSuggestion() when $default != null:
return $default(_that.kind,_that.extraCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RelaxKind kind,  int extraCount)  $default,) {final _that = this;
switch (_that) {
case _RelaxSuggestion():
return $default(_that.kind,_that.extraCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RelaxKind kind,  int extraCount)?  $default,) {final _that = this;
switch (_that) {
case _RelaxSuggestion() when $default != null:
return $default(_that.kind,_that.extraCount);case _:
  return null;

}
}

}

/// @nodoc


class _RelaxSuggestion implements RelaxSuggestion {
  const _RelaxSuggestion({required this.kind, required this.extraCount});
  

@override final  RelaxKind kind;
@override final  int extraCount;

/// Create a copy of RelaxSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RelaxSuggestionCopyWith<_RelaxSuggestion> get copyWith => __$RelaxSuggestionCopyWithImpl<_RelaxSuggestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RelaxSuggestion&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.extraCount, extraCount) || other.extraCount == extraCount));
}


@override
int get hashCode => Object.hash(runtimeType,kind,extraCount);

@override
String toString() {
  return 'RelaxSuggestion(kind: $kind, extraCount: $extraCount)';
}


}

/// @nodoc
abstract mixin class _$RelaxSuggestionCopyWith<$Res> implements $RelaxSuggestionCopyWith<$Res> {
  factory _$RelaxSuggestionCopyWith(_RelaxSuggestion value, $Res Function(_RelaxSuggestion) _then) = __$RelaxSuggestionCopyWithImpl;
@override @useResult
$Res call({
 RelaxKind kind, int extraCount
});




}
/// @nodoc
class __$RelaxSuggestionCopyWithImpl<$Res>
    implements _$RelaxSuggestionCopyWith<$Res> {
  __$RelaxSuggestionCopyWithImpl(this._self, this._then);

  final _RelaxSuggestion _self;
  final $Res Function(_RelaxSuggestion) _then;

/// Create a copy of RelaxSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? extraCount = null,}) {
  return _then(_RelaxSuggestion(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RelaxKind,extraCount: null == extraCount ? _self.extraCount : extraCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$CalendarDay {

 DateTime get date; bool get available;/// Gecelik fiyat (TRY); dolu günlerde null.
 int? get price;/// Ortalamadan uygun fiyatlı gün (yeşil nokta).
 bool get isDeal;
/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarDayCopyWith<CalendarDay> get copyWith => _$CalendarDayCopyWithImpl<CalendarDay>(this as CalendarDay, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarDay&&(identical(other.date, date) || other.date == date)&&(identical(other.available, available) || other.available == available)&&(identical(other.price, price) || other.price == price)&&(identical(other.isDeal, isDeal) || other.isDeal == isDeal));
}


@override
int get hashCode => Object.hash(runtimeType,date,available,price,isDeal);

@override
String toString() {
  return 'CalendarDay(date: $date, available: $available, price: $price, isDeal: $isDeal)';
}


}

/// @nodoc
abstract mixin class $CalendarDayCopyWith<$Res>  {
  factory $CalendarDayCopyWith(CalendarDay value, $Res Function(CalendarDay) _then) = _$CalendarDayCopyWithImpl;
@useResult
$Res call({
 DateTime date, bool available, int? price, bool isDeal
});




}
/// @nodoc
class _$CalendarDayCopyWithImpl<$Res>
    implements $CalendarDayCopyWith<$Res> {
  _$CalendarDayCopyWithImpl(this._self, this._then);

  final CalendarDay _self;
  final $Res Function(CalendarDay) _then;

/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? available = null,Object? price = freezed,Object? isDeal = null,}) {
  return _then(CalendarDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,isDeal: null == isDeal ? _self.isDeal : isDeal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarDay].
extension CalendarDayPatterns on CalendarDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarDay value)  $default,){
final _that = this;
switch (_that) {
case _CalendarDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarDay value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  bool available,  int? price,  bool isDeal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarDay() when $default != null:
return $default(_that.date,_that.available,_that.price,_that.isDeal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  bool available,  int? price,  bool isDeal)  $default,) {final _that = this;
switch (_that) {
case _CalendarDay():
return $default(_that.date,_that.available,_that.price,_that.isDeal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  bool available,  int? price,  bool isDeal)?  $default,) {final _that = this;
switch (_that) {
case _CalendarDay() when $default != null:
return $default(_that.date,_that.available,_that.price,_that.isDeal);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarDay implements CalendarDay {
  const _CalendarDay({required this.date, required this.available, this.price, this.isDeal = false});
  

@override final  DateTime date;
@override final  bool available;
/// Gecelik fiyat (TRY); dolu günlerde null.
@override final  int? price;
/// Ortalamadan uygun fiyatlı gün (yeşil nokta).
@override@JsonKey() final  bool isDeal;

/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarDayCopyWith<_CalendarDay> get copyWith => __$CalendarDayCopyWithImpl<_CalendarDay>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarDay&&(identical(other.date, date) || other.date == date)&&(identical(other.available, available) || other.available == available)&&(identical(other.price, price) || other.price == price)&&(identical(other.isDeal, isDeal) || other.isDeal == isDeal));
}


@override
int get hashCode => Object.hash(runtimeType,date,available,price,isDeal);

@override
String toString() {
  return 'CalendarDay(date: $date, available: $available, price: $price, isDeal: $isDeal)';
}


}

/// @nodoc
abstract mixin class _$CalendarDayCopyWith<$Res> implements $CalendarDayCopyWith<$Res> {
  factory _$CalendarDayCopyWith(_CalendarDay value, $Res Function(_CalendarDay) _then) = __$CalendarDayCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, bool available, int? price, bool isDeal
});




}
/// @nodoc
class __$CalendarDayCopyWithImpl<$Res>
    implements _$CalendarDayCopyWith<$Res> {
  __$CalendarDayCopyWithImpl(this._self, this._then);

  final _CalendarDay _self;
  final $Res Function(_CalendarDay) _then;

/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? available = null,Object? price = freezed,Object? isDeal = null,}) {
  return _then(_CalendarDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,isDeal: null == isDeal ? _self.isDeal : isDeal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
