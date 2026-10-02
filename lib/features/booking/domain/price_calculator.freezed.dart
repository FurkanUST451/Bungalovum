// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_calculator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PriceBreakdown {

 int get nightlyRate; int get nights; int get cleaningFee; int get serviceFee; int get discount; DiscountKind get discountKind;
/// Create a copy of PriceBreakdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceBreakdownCopyWith<PriceBreakdown> get copyWith => _$PriceBreakdownCopyWithImpl<PriceBreakdown>(this as PriceBreakdown, _$identity);

  /// Serializes this PriceBreakdown to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceBreakdown&&(identical(other.nightlyRate, nightlyRate) || other.nightlyRate == nightlyRate)&&(identical(other.nights, nights) || other.nights == nights)&&(identical(other.cleaningFee, cleaningFee) || other.cleaningFee == cleaningFee)&&(identical(other.serviceFee, serviceFee) || other.serviceFee == serviceFee)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.discountKind, discountKind) || other.discountKind == discountKind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nightlyRate,nights,cleaningFee,serviceFee,discount,discountKind);

@override
String toString() {
  return 'PriceBreakdown(nightlyRate: $nightlyRate, nights: $nights, cleaningFee: $cleaningFee, serviceFee: $serviceFee, discount: $discount, discountKind: $discountKind)';
}


}

/// @nodoc
abstract mixin class $PriceBreakdownCopyWith<$Res>  {
  factory $PriceBreakdownCopyWith(PriceBreakdown value, $Res Function(PriceBreakdown) _then) = _$PriceBreakdownCopyWithImpl;
@useResult
$Res call({
 int nightlyRate, int nights, int cleaningFee, int serviceFee, int discount, DiscountKind discountKind
});




}
/// @nodoc
class _$PriceBreakdownCopyWithImpl<$Res>
    implements $PriceBreakdownCopyWith<$Res> {
  _$PriceBreakdownCopyWithImpl(this._self, this._then);

  final PriceBreakdown _self;
  final $Res Function(PriceBreakdown) _then;

/// Create a copy of PriceBreakdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nightlyRate = null,Object? nights = null,Object? cleaningFee = null,Object? serviceFee = null,Object? discount = null,Object? discountKind = null,}) {
  return _then(PriceBreakdown(
nightlyRate: null == nightlyRate ? _self.nightlyRate : nightlyRate // ignore: cast_nullable_to_non_nullable
as int,nights: null == nights ? _self.nights : nights // ignore: cast_nullable_to_non_nullable
as int,cleaningFee: null == cleaningFee ? _self.cleaningFee : cleaningFee // ignore: cast_nullable_to_non_nullable
as int,serviceFee: null == serviceFee ? _self.serviceFee : serviceFee // ignore: cast_nullable_to_non_nullable
as int,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int,discountKind: null == discountKind ? _self.discountKind : discountKind // ignore: cast_nullable_to_non_nullable
as DiscountKind,
  ));
}

}


/// Adds pattern-matching-related methods to [PriceBreakdown].
extension PriceBreakdownPatterns on PriceBreakdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriceBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriceBreakdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriceBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _PriceBreakdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriceBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _PriceBreakdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int nightlyRate,  int nights,  int cleaningFee,  int serviceFee,  int discount,  DiscountKind discountKind)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriceBreakdown() when $default != null:
return $default(_that.nightlyRate,_that.nights,_that.cleaningFee,_that.serviceFee,_that.discount,_that.discountKind);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int nightlyRate,  int nights,  int cleaningFee,  int serviceFee,  int discount,  DiscountKind discountKind)  $default,) {final _that = this;
switch (_that) {
case _PriceBreakdown():
return $default(_that.nightlyRate,_that.nights,_that.cleaningFee,_that.serviceFee,_that.discount,_that.discountKind);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int nightlyRate,  int nights,  int cleaningFee,  int serviceFee,  int discount,  DiscountKind discountKind)?  $default,) {final _that = this;
switch (_that) {
case _PriceBreakdown() when $default != null:
return $default(_that.nightlyRate,_that.nights,_that.cleaningFee,_that.serviceFee,_that.discount,_that.discountKind);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PriceBreakdown implements PriceBreakdown {
  const _PriceBreakdown({required this.nightlyRate, required this.nights, this.cleaningFee = 0, this.serviceFee = 0, this.discount = 0, this.discountKind = DiscountKind.special});
  factory _PriceBreakdown.fromJson(Map<String, dynamic> json) => _$PriceBreakdownFromJson(json);

@override final  int nightlyRate;
@override final  int nights;
@override@JsonKey() final  int cleaningFee;
@override@JsonKey() final  int serviceFee;
@override@JsonKey() final  int discount;
@override@JsonKey() final  DiscountKind discountKind;

/// Create a copy of PriceBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriceBreakdownCopyWith<_PriceBreakdown> get copyWith => __$PriceBreakdownCopyWithImpl<_PriceBreakdown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PriceBreakdownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriceBreakdown&&(identical(other.nightlyRate, nightlyRate) || other.nightlyRate == nightlyRate)&&(identical(other.nights, nights) || other.nights == nights)&&(identical(other.cleaningFee, cleaningFee) || other.cleaningFee == cleaningFee)&&(identical(other.serviceFee, serviceFee) || other.serviceFee == serviceFee)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.discountKind, discountKind) || other.discountKind == discountKind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nightlyRate,nights,cleaningFee,serviceFee,discount,discountKind);

@override
String toString() {
  return 'PriceBreakdown(nightlyRate: $nightlyRate, nights: $nights, cleaningFee: $cleaningFee, serviceFee: $serviceFee, discount: $discount, discountKind: $discountKind)';
}


}

/// @nodoc
abstract mixin class _$PriceBreakdownCopyWith<$Res> implements $PriceBreakdownCopyWith<$Res> {
  factory _$PriceBreakdownCopyWith(_PriceBreakdown value, $Res Function(_PriceBreakdown) _then) = __$PriceBreakdownCopyWithImpl;
@override @useResult
$Res call({
 int nightlyRate, int nights, int cleaningFee, int serviceFee, int discount, DiscountKind discountKind
});




}
/// @nodoc
class __$PriceBreakdownCopyWithImpl<$Res>
    implements _$PriceBreakdownCopyWith<$Res> {
  __$PriceBreakdownCopyWithImpl(this._self, this._then);

  final _PriceBreakdown _self;
  final $Res Function(_PriceBreakdown) _then;

/// Create a copy of PriceBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nightlyRate = null,Object? nights = null,Object? cleaningFee = null,Object? serviceFee = null,Object? discount = null,Object? discountKind = null,}) {
  return _then(_PriceBreakdown(
nightlyRate: null == nightlyRate ? _self.nightlyRate : nightlyRate // ignore: cast_nullable_to_non_nullable
as int,nights: null == nights ? _self.nights : nights // ignore: cast_nullable_to_non_nullable
as int,cleaningFee: null == cleaningFee ? _self.cleaningFee : cleaningFee // ignore: cast_nullable_to_non_nullable
as int,serviceFee: null == serviceFee ? _self.serviceFee : serviceFee // ignore: cast_nullable_to_non_nullable
as int,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int,discountKind: null == discountKind ? _self.discountKind : discountKind // ignore: cast_nullable_to_non_nullable
as DiscountKind,
  ));
}


}

// dart format on
