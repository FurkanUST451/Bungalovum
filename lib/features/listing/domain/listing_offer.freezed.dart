// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing_offer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListingOffer {

 Listing get listing; PriceBreakdown get price;/// Seçili tarihlerde kalan gece sayısı azsa (ör. "Son 2 gece!").
 int? get nightsLeft;
/// Create a copy of ListingOffer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingOfferCopyWith<ListingOffer> get copyWith => _$ListingOfferCopyWithImpl<ListingOffer>(this as ListingOffer, _$identity);

  /// Serializes this ListingOffer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListingOffer&&(identical(other.listing, listing) || other.listing == listing)&&(identical(other.price, price) || other.price == price)&&(identical(other.nightsLeft, nightsLeft) || other.nightsLeft == nightsLeft));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,listing,price,nightsLeft);

@override
String toString() {
  return 'ListingOffer(listing: $listing, price: $price, nightsLeft: $nightsLeft)';
}


}

/// @nodoc
abstract mixin class $ListingOfferCopyWith<$Res>  {
  factory $ListingOfferCopyWith(ListingOffer value, $Res Function(ListingOffer) _then) = _$ListingOfferCopyWithImpl;
@useResult
$Res call({
 Listing listing, PriceBreakdown price, int? nightsLeft
});


$ListingCopyWith<$Res> get listing;$PriceBreakdownCopyWith<$Res> get price;

}
/// @nodoc
class _$ListingOfferCopyWithImpl<$Res>
    implements $ListingOfferCopyWith<$Res> {
  _$ListingOfferCopyWithImpl(this._self, this._then);

  final ListingOffer _self;
  final $Res Function(ListingOffer) _then;

/// Create a copy of ListingOffer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listing = null,Object? price = null,Object? nightsLeft = freezed,}) {
  return _then(ListingOffer(
listing: null == listing ? _self.listing : listing // ignore: cast_nullable_to_non_nullable
as Listing,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as PriceBreakdown,nightsLeft: freezed == nightsLeft ? _self.nightsLeft : nightsLeft // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of ListingOffer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListingCopyWith<$Res> get listing {
  
  return $ListingCopyWith<$Res>(_self.listing, (value) {
    return _then(_self.copyWith(listing: value));
  });
}/// Create a copy of ListingOffer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceBreakdownCopyWith<$Res> get price {
  
  return $PriceBreakdownCopyWith<$Res>(_self.price, (value) {
    return _then(_self.copyWith(price: value));
  });
}
}


/// Adds pattern-matching-related methods to [ListingOffer].
extension ListingOfferPatterns on ListingOffer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListingOffer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListingOffer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListingOffer value)  $default,){
final _that = this;
switch (_that) {
case _ListingOffer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListingOffer value)?  $default,){
final _that = this;
switch (_that) {
case _ListingOffer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Listing listing,  PriceBreakdown price,  int? nightsLeft)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListingOffer() when $default != null:
return $default(_that.listing,_that.price,_that.nightsLeft);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Listing listing,  PriceBreakdown price,  int? nightsLeft)  $default,) {final _that = this;
switch (_that) {
case _ListingOffer():
return $default(_that.listing,_that.price,_that.nightsLeft);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Listing listing,  PriceBreakdown price,  int? nightsLeft)?  $default,) {final _that = this;
switch (_that) {
case _ListingOffer() when $default != null:
return $default(_that.listing,_that.price,_that.nightsLeft);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListingOffer implements ListingOffer {
  const _ListingOffer({required this.listing, required this.price, this.nightsLeft});
  factory _ListingOffer.fromJson(Map<String, dynamic> json) => _$ListingOfferFromJson(json);

@override final  Listing listing;
@override final  PriceBreakdown price;
/// Seçili tarihlerde kalan gece sayısı azsa (ör. "Son 2 gece!").
@override final  int? nightsLeft;

/// Create a copy of ListingOffer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingOfferCopyWith<_ListingOffer> get copyWith => __$ListingOfferCopyWithImpl<_ListingOffer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListingOfferToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListingOffer&&(identical(other.listing, listing) || other.listing == listing)&&(identical(other.price, price) || other.price == price)&&(identical(other.nightsLeft, nightsLeft) || other.nightsLeft == nightsLeft));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,listing,price,nightsLeft);

@override
String toString() {
  return 'ListingOffer(listing: $listing, price: $price, nightsLeft: $nightsLeft)';
}


}

/// @nodoc
abstract mixin class _$ListingOfferCopyWith<$Res> implements $ListingOfferCopyWith<$Res> {
  factory _$ListingOfferCopyWith(_ListingOffer value, $Res Function(_ListingOffer) _then) = __$ListingOfferCopyWithImpl;
@override @useResult
$Res call({
 Listing listing, PriceBreakdown price, int? nightsLeft
});


@override $ListingCopyWith<$Res> get listing;@override $PriceBreakdownCopyWith<$Res> get price;

}
/// @nodoc
class __$ListingOfferCopyWithImpl<$Res>
    implements _$ListingOfferCopyWith<$Res> {
  __$ListingOfferCopyWithImpl(this._self, this._then);

  final _ListingOffer _self;
  final $Res Function(_ListingOffer) _then;

/// Create a copy of ListingOffer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listing = null,Object? price = null,Object? nightsLeft = freezed,}) {
  return _then(_ListingOffer(
listing: null == listing ? _self.listing : listing // ignore: cast_nullable_to_non_nullable
as Listing,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as PriceBreakdown,nightsLeft: freezed == nightsLeft ? _self.nightsLeft : nightsLeft // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of ListingOffer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListingCopyWith<$Res> get listing {
  
  return $ListingCopyWith<$Res>(_self.listing, (value) {
    return _then(_self.copyWith(listing: value));
  });
}/// Create a copy of ListingOffer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceBreakdownCopyWith<$Res> get price {
  
  return $PriceBreakdownCopyWith<$Res>(_self.price, (value) {
    return _then(_self.copyWith(price: value));
  });
}
}

// dart format on
