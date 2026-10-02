// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Coupon {

 String get code; CouponKind get kind;/// Yüzde (10) ya da tutar (₺500 → 500).
 int get value;/// Yüzdelik kuponlarda en fazla indirim.
 int? get maxDiscount; DateTime get expiresAt; DateTime? get usedAt;
/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CouponCopyWith<Coupon> get copyWith => _$CouponCopyWithImpl<Coupon>(this as Coupon, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Coupon&&(identical(other.code, code) || other.code == code)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.value, value) || other.value == value)&&(identical(other.maxDiscount, maxDiscount) || other.maxDiscount == maxDiscount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.usedAt, usedAt) || other.usedAt == usedAt));
}


@override
int get hashCode => Object.hash(runtimeType,code,kind,value,maxDiscount,expiresAt,usedAt);

@override
String toString() {
  return 'Coupon(code: $code, kind: $kind, value: $value, maxDiscount: $maxDiscount, expiresAt: $expiresAt, usedAt: $usedAt)';
}


}

/// @nodoc
abstract mixin class $CouponCopyWith<$Res>  {
  factory $CouponCopyWith(Coupon value, $Res Function(Coupon) _then) = _$CouponCopyWithImpl;
@useResult
$Res call({
 String code, CouponKind kind, int value, int? maxDiscount, DateTime expiresAt, DateTime? usedAt
});




}
/// @nodoc
class _$CouponCopyWithImpl<$Res>
    implements $CouponCopyWith<$Res> {
  _$CouponCopyWithImpl(this._self, this._then);

  final Coupon _self;
  final $Res Function(Coupon) _then;

/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? kind = null,Object? value = null,Object? maxDiscount = freezed,Object? expiresAt = null,Object? usedAt = freezed,}) {
  return _then(Coupon(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CouponKind,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,maxDiscount: freezed == maxDiscount ? _self.maxDiscount : maxDiscount // ignore: cast_nullable_to_non_nullable
as int?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,usedAt: freezed == usedAt ? _self.usedAt : usedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Coupon].
extension CouponPatterns on Coupon {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Coupon value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Coupon() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Coupon value)  $default,){
final _that = this;
switch (_that) {
case _Coupon():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Coupon value)?  $default,){
final _that = this;
switch (_that) {
case _Coupon() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  CouponKind kind,  int value,  int? maxDiscount,  DateTime expiresAt,  DateTime? usedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Coupon() when $default != null:
return $default(_that.code,_that.kind,_that.value,_that.maxDiscount,_that.expiresAt,_that.usedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  CouponKind kind,  int value,  int? maxDiscount,  DateTime expiresAt,  DateTime? usedAt)  $default,) {final _that = this;
switch (_that) {
case _Coupon():
return $default(_that.code,_that.kind,_that.value,_that.maxDiscount,_that.expiresAt,_that.usedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  CouponKind kind,  int value,  int? maxDiscount,  DateTime expiresAt,  DateTime? usedAt)?  $default,) {final _that = this;
switch (_that) {
case _Coupon() when $default != null:
return $default(_that.code,_that.kind,_that.value,_that.maxDiscount,_that.expiresAt,_that.usedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Coupon extends Coupon {
  const _Coupon({required this.code, required this.kind, required this.value, this.maxDiscount, required this.expiresAt, this.usedAt}): super._();
  

@override final  String code;
@override final  CouponKind kind;
/// Yüzde (10) ya da tutar (₺500 → 500).
@override final  int value;
/// Yüzdelik kuponlarda en fazla indirim.
@override final  int? maxDiscount;
@override final  DateTime expiresAt;
@override final  DateTime? usedAt;

/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CouponCopyWith<_Coupon> get copyWith => __$CouponCopyWithImpl<_Coupon>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Coupon&&(identical(other.code, code) || other.code == code)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.value, value) || other.value == value)&&(identical(other.maxDiscount, maxDiscount) || other.maxDiscount == maxDiscount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.usedAt, usedAt) || other.usedAt == usedAt));
}


@override
int get hashCode => Object.hash(runtimeType,code,kind,value,maxDiscount,expiresAt,usedAt);

@override
String toString() {
  return 'Coupon(code: $code, kind: $kind, value: $value, maxDiscount: $maxDiscount, expiresAt: $expiresAt, usedAt: $usedAt)';
}


}

/// @nodoc
abstract mixin class _$CouponCopyWith<$Res> implements $CouponCopyWith<$Res> {
  factory _$CouponCopyWith(_Coupon value, $Res Function(_Coupon) _then) = __$CouponCopyWithImpl;
@override @useResult
$Res call({
 String code, CouponKind kind, int value, int? maxDiscount, DateTime expiresAt, DateTime? usedAt
});




}
/// @nodoc
class __$CouponCopyWithImpl<$Res>
    implements _$CouponCopyWith<$Res> {
  __$CouponCopyWithImpl(this._self, this._then);

  final _Coupon _self;
  final $Res Function(_Coupon) _then;

/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? kind = null,Object? value = null,Object? maxDiscount = freezed,Object? expiresAt = null,Object? usedAt = freezed,}) {
  return _then(_Coupon(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CouponKind,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,maxDiscount: freezed == maxDiscount ? _self.maxDiscount : maxDiscount // ignore: cast_nullable_to_non_nullable
as int?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,usedAt: freezed == usedAt ? _self.usedAt : usedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$PaymentRecord {

 String get bookingId; String get listingId; PaymentKind get kind; int get amount; DateTime get at; CardBrand get cardBrand; String? get cardLast4;
/// Create a copy of PaymentRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentRecordCopyWith<PaymentRecord> get copyWith => _$PaymentRecordCopyWithImpl<PaymentRecord>(this as PaymentRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentRecord&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.at, at) || other.at == at)&&(identical(other.cardBrand, cardBrand) || other.cardBrand == cardBrand)&&(identical(other.cardLast4, cardLast4) || other.cardLast4 == cardLast4));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId,listingId,kind,amount,at,cardBrand,cardLast4);

@override
String toString() {
  return 'PaymentRecord(bookingId: $bookingId, listingId: $listingId, kind: $kind, amount: $amount, at: $at, cardBrand: $cardBrand, cardLast4: $cardLast4)';
}


}

/// @nodoc
abstract mixin class $PaymentRecordCopyWith<$Res>  {
  factory $PaymentRecordCopyWith(PaymentRecord value, $Res Function(PaymentRecord) _then) = _$PaymentRecordCopyWithImpl;
@useResult
$Res call({
 String bookingId, String listingId, PaymentKind kind, int amount, DateTime at, CardBrand cardBrand, String? cardLast4
});




}
/// @nodoc
class _$PaymentRecordCopyWithImpl<$Res>
    implements $PaymentRecordCopyWith<$Res> {
  _$PaymentRecordCopyWithImpl(this._self, this._then);

  final PaymentRecord _self;
  final $Res Function(PaymentRecord) _then;

/// Create a copy of PaymentRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookingId = null,Object? listingId = null,Object? kind = null,Object? amount = null,Object? at = null,Object? cardBrand = null,Object? cardLast4 = freezed,}) {
  return _then(PaymentRecord(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PaymentKind,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,cardBrand: null == cardBrand ? _self.cardBrand : cardBrand // ignore: cast_nullable_to_non_nullable
as CardBrand,cardLast4: freezed == cardLast4 ? _self.cardLast4 : cardLast4 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentRecord].
extension PaymentRecordPatterns on PaymentRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentRecord value)  $default,){
final _that = this;
switch (_that) {
case _PaymentRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentRecord value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bookingId,  String listingId,  PaymentKind kind,  int amount,  DateTime at,  CardBrand cardBrand,  String? cardLast4)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentRecord() when $default != null:
return $default(_that.bookingId,_that.listingId,_that.kind,_that.amount,_that.at,_that.cardBrand,_that.cardLast4);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bookingId,  String listingId,  PaymentKind kind,  int amount,  DateTime at,  CardBrand cardBrand,  String? cardLast4)  $default,) {final _that = this;
switch (_that) {
case _PaymentRecord():
return $default(_that.bookingId,_that.listingId,_that.kind,_that.amount,_that.at,_that.cardBrand,_that.cardLast4);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bookingId,  String listingId,  PaymentKind kind,  int amount,  DateTime at,  CardBrand cardBrand,  String? cardLast4)?  $default,) {final _that = this;
switch (_that) {
case _PaymentRecord() when $default != null:
return $default(_that.bookingId,_that.listingId,_that.kind,_that.amount,_that.at,_that.cardBrand,_that.cardLast4);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentRecord implements PaymentRecord {
  const _PaymentRecord({required this.bookingId, required this.listingId, required this.kind, required this.amount, required this.at, required this.cardBrand, this.cardLast4});
  

@override final  String bookingId;
@override final  String listingId;
@override final  PaymentKind kind;
@override final  int amount;
@override final  DateTime at;
@override final  CardBrand cardBrand;
@override final  String? cardLast4;

/// Create a copy of PaymentRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentRecordCopyWith<_PaymentRecord> get copyWith => __$PaymentRecordCopyWithImpl<_PaymentRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentRecord&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.at, at) || other.at == at)&&(identical(other.cardBrand, cardBrand) || other.cardBrand == cardBrand)&&(identical(other.cardLast4, cardLast4) || other.cardLast4 == cardLast4));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId,listingId,kind,amount,at,cardBrand,cardLast4);

@override
String toString() {
  return 'PaymentRecord(bookingId: $bookingId, listingId: $listingId, kind: $kind, amount: $amount, at: $at, cardBrand: $cardBrand, cardLast4: $cardLast4)';
}


}

/// @nodoc
abstract mixin class _$PaymentRecordCopyWith<$Res> implements $PaymentRecordCopyWith<$Res> {
  factory _$PaymentRecordCopyWith(_PaymentRecord value, $Res Function(_PaymentRecord) _then) = __$PaymentRecordCopyWithImpl;
@override @useResult
$Res call({
 String bookingId, String listingId, PaymentKind kind, int amount, DateTime at, CardBrand cardBrand, String? cardLast4
});




}
/// @nodoc
class __$PaymentRecordCopyWithImpl<$Res>
    implements _$PaymentRecordCopyWith<$Res> {
  __$PaymentRecordCopyWithImpl(this._self, this._then);

  final _PaymentRecord _self;
  final $Res Function(_PaymentRecord) _then;

/// Create a copy of PaymentRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = null,Object? listingId = null,Object? kind = null,Object? amount = null,Object? at = null,Object? cardBrand = null,Object? cardLast4 = freezed,}) {
  return _then(_PaymentRecord(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PaymentKind,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,cardBrand: null == cardBrand ? _self.cardBrand : cardBrand // ignore: cast_nullable_to_non_nullable
as CardBrand,cardLast4: freezed == cardLast4 ? _self.cardLast4 : cardLast4 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
