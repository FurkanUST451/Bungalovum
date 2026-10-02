// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentCard {

 String get id; CardBrand get brand; String get last4; int get expMonth;/// İki haneli yıl: 28.
 int get expYear; bool get isDefault;
/// Create a copy of PaymentCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCardCopyWith<PaymentCard> get copyWith => _$PaymentCardCopyWithImpl<PaymentCard>(this as PaymentCard, _$identity);

  /// Serializes this PaymentCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentCard&&(identical(other.id, id) || other.id == id)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.last4, last4) || other.last4 == last4)&&(identical(other.expMonth, expMonth) || other.expMonth == expMonth)&&(identical(other.expYear, expYear) || other.expYear == expYear)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,brand,last4,expMonth,expYear,isDefault);

@override
String toString() {
  return 'PaymentCard(id: $id, brand: $brand, last4: $last4, expMonth: $expMonth, expYear: $expYear, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $PaymentCardCopyWith<$Res>  {
  factory $PaymentCardCopyWith(PaymentCard value, $Res Function(PaymentCard) _then) = _$PaymentCardCopyWithImpl;
@useResult
$Res call({
 String id, CardBrand brand, String last4, int expMonth, int expYear, bool isDefault
});




}
/// @nodoc
class _$PaymentCardCopyWithImpl<$Res>
    implements $PaymentCardCopyWith<$Res> {
  _$PaymentCardCopyWithImpl(this._self, this._then);

  final PaymentCard _self;
  final $Res Function(PaymentCard) _then;

/// Create a copy of PaymentCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? brand = null,Object? last4 = null,Object? expMonth = null,Object? expYear = null,Object? isDefault = null,}) {
  return _then(PaymentCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as CardBrand,last4: null == last4 ? _self.last4 : last4 // ignore: cast_nullable_to_non_nullable
as String,expMonth: null == expMonth ? _self.expMonth : expMonth // ignore: cast_nullable_to_non_nullable
as int,expYear: null == expYear ? _self.expYear : expYear // ignore: cast_nullable_to_non_nullable
as int,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentCard].
extension PaymentCardPatterns on PaymentCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentCard value)  $default,){
final _that = this;
switch (_that) {
case _PaymentCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentCard value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  CardBrand brand,  String last4,  int expMonth,  int expYear,  bool isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentCard() when $default != null:
return $default(_that.id,_that.brand,_that.last4,_that.expMonth,_that.expYear,_that.isDefault);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  CardBrand brand,  String last4,  int expMonth,  int expYear,  bool isDefault)  $default,) {final _that = this;
switch (_that) {
case _PaymentCard():
return $default(_that.id,_that.brand,_that.last4,_that.expMonth,_that.expYear,_that.isDefault);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  CardBrand brand,  String last4,  int expMonth,  int expYear,  bool isDefault)?  $default,) {final _that = this;
switch (_that) {
case _PaymentCard() when $default != null:
return $default(_that.id,_that.brand,_that.last4,_that.expMonth,_that.expYear,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentCard implements PaymentCard {
  const _PaymentCard({required this.id, required this.brand, required this.last4, required this.expMonth, required this.expYear, this.isDefault = false});
  factory _PaymentCard.fromJson(Map<String, dynamic> json) => _$PaymentCardFromJson(json);

@override final  String id;
@override final  CardBrand brand;
@override final  String last4;
@override final  int expMonth;
/// İki haneli yıl: 28.
@override final  int expYear;
@override@JsonKey() final  bool isDefault;

/// Create a copy of PaymentCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCardCopyWith<_PaymentCard> get copyWith => __$PaymentCardCopyWithImpl<_PaymentCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentCardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentCard&&(identical(other.id, id) || other.id == id)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.last4, last4) || other.last4 == last4)&&(identical(other.expMonth, expMonth) || other.expMonth == expMonth)&&(identical(other.expYear, expYear) || other.expYear == expYear)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,brand,last4,expMonth,expYear,isDefault);

@override
String toString() {
  return 'PaymentCard(id: $id, brand: $brand, last4: $last4, expMonth: $expMonth, expYear: $expYear, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$PaymentCardCopyWith<$Res> implements $PaymentCardCopyWith<$Res> {
  factory _$PaymentCardCopyWith(_PaymentCard value, $Res Function(_PaymentCard) _then) = __$PaymentCardCopyWithImpl;
@override @useResult
$Res call({
 String id, CardBrand brand, String last4, int expMonth, int expYear, bool isDefault
});




}
/// @nodoc
class __$PaymentCardCopyWithImpl<$Res>
    implements _$PaymentCardCopyWith<$Res> {
  __$PaymentCardCopyWithImpl(this._self, this._then);

  final _PaymentCard _self;
  final $Res Function(_PaymentCard) _then;

/// Create a copy of PaymentCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? brand = null,Object? last4 = null,Object? expMonth = null,Object? expYear = null,Object? isDefault = null,}) {
  return _then(_PaymentCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as CardBrand,last4: null == last4 ? _self.last4 : last4 // ignore: cast_nullable_to_non_nullable
as String,expMonth: null == expMonth ? _self.expMonth : expMonth // ignore: cast_nullable_to_non_nullable
as int,expYear: null == expYear ? _self.expYear : expYear // ignore: cast_nullable_to_non_nullable
as int,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ThreeDsChallenge {

 String get id;/// "Kozalak Seyahat"
 String get merchant; int get amount; String get cardLast4; DateTime get expiresAt;/// Tarihlerin misafir için tutulduğu son an.
 DateTime get holdUntil; int get codeLength;
/// Create a copy of ThreeDsChallenge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThreeDsChallengeCopyWith<ThreeDsChallenge> get copyWith => _$ThreeDsChallengeCopyWithImpl<ThreeDsChallenge>(this as ThreeDsChallenge, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThreeDsChallenge&&(identical(other.id, id) || other.id == id)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.cardLast4, cardLast4) || other.cardLast4 == cardLast4)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.holdUntil, holdUntil) || other.holdUntil == holdUntil)&&(identical(other.codeLength, codeLength) || other.codeLength == codeLength));
}


@override
int get hashCode => Object.hash(runtimeType,id,merchant,amount,cardLast4,expiresAt,holdUntil,codeLength);

@override
String toString() {
  return 'ThreeDsChallenge(id: $id, merchant: $merchant, amount: $amount, cardLast4: $cardLast4, expiresAt: $expiresAt, holdUntil: $holdUntil, codeLength: $codeLength)';
}


}

/// @nodoc
abstract mixin class $ThreeDsChallengeCopyWith<$Res>  {
  factory $ThreeDsChallengeCopyWith(ThreeDsChallenge value, $Res Function(ThreeDsChallenge) _then) = _$ThreeDsChallengeCopyWithImpl;
@useResult
$Res call({
 String id, String merchant, int amount, String cardLast4, DateTime expiresAt, DateTime holdUntil, int codeLength
});




}
/// @nodoc
class _$ThreeDsChallengeCopyWithImpl<$Res>
    implements $ThreeDsChallengeCopyWith<$Res> {
  _$ThreeDsChallengeCopyWithImpl(this._self, this._then);

  final ThreeDsChallenge _self;
  final $Res Function(ThreeDsChallenge) _then;

/// Create a copy of ThreeDsChallenge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? merchant = null,Object? amount = null,Object? cardLast4 = null,Object? expiresAt = null,Object? holdUntil = null,Object? codeLength = null,}) {
  return _then(ThreeDsChallenge(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,merchant: null == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,cardLast4: null == cardLast4 ? _self.cardLast4 : cardLast4 // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,holdUntil: null == holdUntil ? _self.holdUntil : holdUntil // ignore: cast_nullable_to_non_nullable
as DateTime,codeLength: null == codeLength ? _self.codeLength : codeLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ThreeDsChallenge].
extension ThreeDsChallengePatterns on ThreeDsChallenge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThreeDsChallenge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThreeDsChallenge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThreeDsChallenge value)  $default,){
final _that = this;
switch (_that) {
case _ThreeDsChallenge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThreeDsChallenge value)?  $default,){
final _that = this;
switch (_that) {
case _ThreeDsChallenge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String merchant,  int amount,  String cardLast4,  DateTime expiresAt,  DateTime holdUntil,  int codeLength)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThreeDsChallenge() when $default != null:
return $default(_that.id,_that.merchant,_that.amount,_that.cardLast4,_that.expiresAt,_that.holdUntil,_that.codeLength);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String merchant,  int amount,  String cardLast4,  DateTime expiresAt,  DateTime holdUntil,  int codeLength)  $default,) {final _that = this;
switch (_that) {
case _ThreeDsChallenge():
return $default(_that.id,_that.merchant,_that.amount,_that.cardLast4,_that.expiresAt,_that.holdUntil,_that.codeLength);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String merchant,  int amount,  String cardLast4,  DateTime expiresAt,  DateTime holdUntil,  int codeLength)?  $default,) {final _that = this;
switch (_that) {
case _ThreeDsChallenge() when $default != null:
return $default(_that.id,_that.merchant,_that.amount,_that.cardLast4,_that.expiresAt,_that.holdUntil,_that.codeLength);case _:
  return null;

}
}

}

/// @nodoc


class _ThreeDsChallenge implements ThreeDsChallenge {
  const _ThreeDsChallenge({required this.id, required this.merchant, required this.amount, required this.cardLast4, required this.expiresAt, required this.holdUntil, this.codeLength = 6});
  

@override final  String id;
/// "Kozalak Seyahat"
@override final  String merchant;
@override final  int amount;
@override final  String cardLast4;
@override final  DateTime expiresAt;
/// Tarihlerin misafir için tutulduğu son an.
@override final  DateTime holdUntil;
@override@JsonKey() final  int codeLength;

/// Create a copy of ThreeDsChallenge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThreeDsChallengeCopyWith<_ThreeDsChallenge> get copyWith => __$ThreeDsChallengeCopyWithImpl<_ThreeDsChallenge>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThreeDsChallenge&&(identical(other.id, id) || other.id == id)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.cardLast4, cardLast4) || other.cardLast4 == cardLast4)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.holdUntil, holdUntil) || other.holdUntil == holdUntil)&&(identical(other.codeLength, codeLength) || other.codeLength == codeLength));
}


@override
int get hashCode => Object.hash(runtimeType,id,merchant,amount,cardLast4,expiresAt,holdUntil,codeLength);

@override
String toString() {
  return 'ThreeDsChallenge(id: $id, merchant: $merchant, amount: $amount, cardLast4: $cardLast4, expiresAt: $expiresAt, holdUntil: $holdUntil, codeLength: $codeLength)';
}


}

/// @nodoc
abstract mixin class _$ThreeDsChallengeCopyWith<$Res> implements $ThreeDsChallengeCopyWith<$Res> {
  factory _$ThreeDsChallengeCopyWith(_ThreeDsChallenge value, $Res Function(_ThreeDsChallenge) _then) = __$ThreeDsChallengeCopyWithImpl;
@override @useResult
$Res call({
 String id, String merchant, int amount, String cardLast4, DateTime expiresAt, DateTime holdUntil, int codeLength
});




}
/// @nodoc
class __$ThreeDsChallengeCopyWithImpl<$Res>
    implements _$ThreeDsChallengeCopyWith<$Res> {
  __$ThreeDsChallengeCopyWithImpl(this._self, this._then);

  final _ThreeDsChallenge _self;
  final $Res Function(_ThreeDsChallenge) _then;

/// Create a copy of ThreeDsChallenge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? merchant = null,Object? amount = null,Object? cardLast4 = null,Object? expiresAt = null,Object? holdUntil = null,Object? codeLength = null,}) {
  return _then(_ThreeDsChallenge(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,merchant: null == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,cardLast4: null == cardLast4 ? _self.cardLast4 : cardLast4 // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,holdUntil: null == holdUntil ? _self.holdUntil : holdUntil // ignore: cast_nullable_to_non_nullable
as DateTime,codeLength: null == codeLength ? _self.codeLength : codeLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
