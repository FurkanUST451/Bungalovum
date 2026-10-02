// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutState {

 String? get listingId;/// Seçili kayıtlı kart; null ise varsayılan kart.
 String? get cardId; int get installments; ThreeDsChallenge? get challenge;/// Son reddin bilgisi (37 · Ödeme Başarısız).
 PaymentDeclined? get declined;/// Uygulanan kupon ve onunla hesaplanan fiyat kalemleri.
 String? get couponCode; PriceBreakdown? get couponQuote;/// Ev sahibi onaylı talepte tanışma mesajı (40); null = anında onay.
 String? get messageToHost;
/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutStateCopyWith<CheckoutState> get copyWith => _$CheckoutStateCopyWithImpl<CheckoutState>(this as CheckoutState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutState&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.installments, installments) || other.installments == installments)&&(identical(other.challenge, challenge) || other.challenge == challenge)&&(identical(other.declined, declined) || other.declined == declined)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.couponQuote, couponQuote) || other.couponQuote == couponQuote)&&(identical(other.messageToHost, messageToHost) || other.messageToHost == messageToHost));
}


@override
int get hashCode => Object.hash(runtimeType,listingId,cardId,installments,challenge,declined,couponCode,couponQuote,messageToHost);

@override
String toString() {
  return 'CheckoutState(listingId: $listingId, cardId: $cardId, installments: $installments, challenge: $challenge, declined: $declined, couponCode: $couponCode, couponQuote: $couponQuote, messageToHost: $messageToHost)';
}


}

/// @nodoc
abstract mixin class $CheckoutStateCopyWith<$Res>  {
  factory $CheckoutStateCopyWith(CheckoutState value, $Res Function(CheckoutState) _then) = _$CheckoutStateCopyWithImpl;
@useResult
$Res call({
 String? listingId, String? cardId, int installments, ThreeDsChallenge? challenge, PaymentDeclined? declined, String? couponCode, PriceBreakdown? couponQuote, String? messageToHost
});


$ThreeDsChallengeCopyWith<$Res>? get challenge;$PriceBreakdownCopyWith<$Res>? get couponQuote;

}
/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._self, this._then);

  final CheckoutState _self;
  final $Res Function(CheckoutState) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listingId = freezed,Object? cardId = freezed,Object? installments = null,Object? challenge = freezed,Object? declined = freezed,Object? couponCode = freezed,Object? couponQuote = freezed,Object? messageToHost = freezed,}) {
  return _then(CheckoutState(
listingId: freezed == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String?,cardId: freezed == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String?,installments: null == installments ? _self.installments : installments // ignore: cast_nullable_to_non_nullable
as int,challenge: freezed == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as ThreeDsChallenge?,declined: freezed == declined ? _self.declined : declined // ignore: cast_nullable_to_non_nullable
as PaymentDeclined?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,couponQuote: freezed == couponQuote ? _self.couponQuote : couponQuote // ignore: cast_nullable_to_non_nullable
as PriceBreakdown?,messageToHost: freezed == messageToHost ? _self.messageToHost : messageToHost // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThreeDsChallengeCopyWith<$Res>? get challenge {
    if (_self.challenge == null) {
    return null;
  }

  return $ThreeDsChallengeCopyWith<$Res>(_self.challenge!, (value) {
    return _then(_self.copyWith(challenge: value));
  });
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceBreakdownCopyWith<$Res>? get couponQuote {
    if (_self.couponQuote == null) {
    return null;
  }

  return $PriceBreakdownCopyWith<$Res>(_self.couponQuote!, (value) {
    return _then(_self.copyWith(couponQuote: value));
  });
}
}


/// Adds pattern-matching-related methods to [CheckoutState].
extension CheckoutStatePatterns on CheckoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutState value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutState value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? listingId,  String? cardId,  int installments,  ThreeDsChallenge? challenge,  PaymentDeclined? declined,  String? couponCode,  PriceBreakdown? couponQuote,  String? messageToHost)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
return $default(_that.listingId,_that.cardId,_that.installments,_that.challenge,_that.declined,_that.couponCode,_that.couponQuote,_that.messageToHost);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? listingId,  String? cardId,  int installments,  ThreeDsChallenge? challenge,  PaymentDeclined? declined,  String? couponCode,  PriceBreakdown? couponQuote,  String? messageToHost)  $default,) {final _that = this;
switch (_that) {
case _CheckoutState():
return $default(_that.listingId,_that.cardId,_that.installments,_that.challenge,_that.declined,_that.couponCode,_that.couponQuote,_that.messageToHost);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? listingId,  String? cardId,  int installments,  ThreeDsChallenge? challenge,  PaymentDeclined? declined,  String? couponCode,  PriceBreakdown? couponQuote,  String? messageToHost)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
return $default(_that.listingId,_that.cardId,_that.installments,_that.challenge,_that.declined,_that.couponCode,_that.couponQuote,_that.messageToHost);case _:
  return null;

}
}

}

/// @nodoc


class _CheckoutState extends CheckoutState {
  const _CheckoutState({this.listingId, this.cardId, this.installments = 1, this.challenge, this.declined, this.couponCode, this.couponQuote, this.messageToHost}): super._();
  

@override final  String? listingId;
/// Seçili kayıtlı kart; null ise varsayılan kart.
@override final  String? cardId;
@override@JsonKey() final  int installments;
@override final  ThreeDsChallenge? challenge;
/// Son reddin bilgisi (37 · Ödeme Başarısız).
@override final  PaymentDeclined? declined;
/// Uygulanan kupon ve onunla hesaplanan fiyat kalemleri.
@override final  String? couponCode;
@override final  PriceBreakdown? couponQuote;
/// Ev sahibi onaylı talepte tanışma mesajı (40); null = anında onay.
@override final  String? messageToHost;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutStateCopyWith<_CheckoutState> get copyWith => __$CheckoutStateCopyWithImpl<_CheckoutState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutState&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.installments, installments) || other.installments == installments)&&(identical(other.challenge, challenge) || other.challenge == challenge)&&(identical(other.declined, declined) || other.declined == declined)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.couponQuote, couponQuote) || other.couponQuote == couponQuote)&&(identical(other.messageToHost, messageToHost) || other.messageToHost == messageToHost));
}


@override
int get hashCode => Object.hash(runtimeType,listingId,cardId,installments,challenge,declined,couponCode,couponQuote,messageToHost);

@override
String toString() {
  return 'CheckoutState(listingId: $listingId, cardId: $cardId, installments: $installments, challenge: $challenge, declined: $declined, couponCode: $couponCode, couponQuote: $couponQuote, messageToHost: $messageToHost)';
}


}

/// @nodoc
abstract mixin class _$CheckoutStateCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory _$CheckoutStateCopyWith(_CheckoutState value, $Res Function(_CheckoutState) _then) = __$CheckoutStateCopyWithImpl;
@override @useResult
$Res call({
 String? listingId, String? cardId, int installments, ThreeDsChallenge? challenge, PaymentDeclined? declined, String? couponCode, PriceBreakdown? couponQuote, String? messageToHost
});


@override $ThreeDsChallengeCopyWith<$Res>? get challenge;@override $PriceBreakdownCopyWith<$Res>? get couponQuote;

}
/// @nodoc
class __$CheckoutStateCopyWithImpl<$Res>
    implements _$CheckoutStateCopyWith<$Res> {
  __$CheckoutStateCopyWithImpl(this._self, this._then);

  final _CheckoutState _self;
  final $Res Function(_CheckoutState) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listingId = freezed,Object? cardId = freezed,Object? installments = null,Object? challenge = freezed,Object? declined = freezed,Object? couponCode = freezed,Object? couponQuote = freezed,Object? messageToHost = freezed,}) {
  return _then(_CheckoutState(
listingId: freezed == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String?,cardId: freezed == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String?,installments: null == installments ? _self.installments : installments // ignore: cast_nullable_to_non_nullable
as int,challenge: freezed == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as ThreeDsChallenge?,declined: freezed == declined ? _self.declined : declined // ignore: cast_nullable_to_non_nullable
as PaymentDeclined?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,couponQuote: freezed == couponQuote ? _self.couponQuote : couponQuote // ignore: cast_nullable_to_non_nullable
as PriceBreakdown?,messageToHost: freezed == messageToHost ? _self.messageToHost : messageToHost // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThreeDsChallengeCopyWith<$Res>? get challenge {
    if (_self.challenge == null) {
    return null;
  }

  return $ThreeDsChallengeCopyWith<$Res>(_self.challenge!, (value) {
    return _then(_self.copyWith(challenge: value));
  });
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceBreakdownCopyWith<$Res>? get couponQuote {
    if (_self.couponQuote == null) {
    return null;
  }

  return $PriceBreakdownCopyWith<$Res>(_self.couponQuote!, (value) {
    return _then(_self.copyWith(couponQuote: value));
  });
}
}

// dart format on
