// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Booking {

 String get id;/// Misafire gösterilen kod: "KZ-48K2Q".
 String get code; String get listingId; StayDates get dates; GuestCount get guests;/// Anında onayda ödenen, talepte provizyon olarak tutulan tutar.
 int get amountPaid; BookingStatus get status;/// Ev sahibi onaylı talep (40–43).
 bool get isRequest; CardBrand get cardBrand; String? get cardLast4; DateTime? get requestedAt;/// Ev sahibinin yanıt vermesi gereken son an; geçerse talep düşer.
 DateTime? get respondBy;/// Misafirin verdiği genel puan (değerlendirdiyse).
 double? get myRating; DateTime? get cancelledAt;/// false: ev sahibi iptal etti.
 bool get cancelledByGuest;/// İptalde karta iade edilen tutar.
 int? get refundAmount;/// Rezervasyon anındaki fiyat kalemleri (makbuz).
 PriceBreakdown? get price; DateTime? get paidAt;
/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingCopyWith<Booking> get copyWith => _$BookingCopyWithImpl<Booking>(this as Booking, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.dates, dates) || other.dates == dates)&&(identical(other.guests, guests) || other.guests == guests)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.status, status) || other.status == status)&&(identical(other.isRequest, isRequest) || other.isRequest == isRequest)&&(identical(other.cardBrand, cardBrand) || other.cardBrand == cardBrand)&&(identical(other.cardLast4, cardLast4) || other.cardLast4 == cardLast4)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.respondBy, respondBy) || other.respondBy == respondBy)&&(identical(other.myRating, myRating) || other.myRating == myRating)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.cancelledByGuest, cancelledByGuest) || other.cancelledByGuest == cancelledByGuest)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&(identical(other.price, price) || other.price == price)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,listingId,dates,guests,amountPaid,status,isRequest,cardBrand,cardLast4,requestedAt,respondBy,myRating,cancelledAt,cancelledByGuest,refundAmount,price,paidAt);

@override
String toString() {
  return 'Booking(id: $id, code: $code, listingId: $listingId, dates: $dates, guests: $guests, amountPaid: $amountPaid, status: $status, isRequest: $isRequest, cardBrand: $cardBrand, cardLast4: $cardLast4, requestedAt: $requestedAt, respondBy: $respondBy, myRating: $myRating, cancelledAt: $cancelledAt, cancelledByGuest: $cancelledByGuest, refundAmount: $refundAmount, price: $price, paidAt: $paidAt)';
}


}

/// @nodoc
abstract mixin class $BookingCopyWith<$Res>  {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) _then) = _$BookingCopyWithImpl;
@useResult
$Res call({
 String id, String code, String listingId, StayDates dates, GuestCount guests, int amountPaid, BookingStatus status, bool isRequest, CardBrand cardBrand, String? cardLast4, DateTime? requestedAt, DateTime? respondBy, double? myRating, DateTime? cancelledAt, bool cancelledByGuest, int? refundAmount, PriceBreakdown? price, DateTime? paidAt
});


$StayDatesCopyWith<$Res> get dates;$GuestCountCopyWith<$Res> get guests;$PriceBreakdownCopyWith<$Res>? get price;

}
/// @nodoc
class _$BookingCopyWithImpl<$Res>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._self, this._then);

  final Booking _self;
  final $Res Function(Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? listingId = null,Object? dates = null,Object? guests = null,Object? amountPaid = null,Object? status = null,Object? isRequest = null,Object? cardBrand = null,Object? cardLast4 = freezed,Object? requestedAt = freezed,Object? respondBy = freezed,Object? myRating = freezed,Object? cancelledAt = freezed,Object? cancelledByGuest = null,Object? refundAmount = freezed,Object? price = freezed,Object? paidAt = freezed,}) {
  return _then(Booking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,dates: null == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as StayDates,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as GuestCount,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,isRequest: null == isRequest ? _self.isRequest : isRequest // ignore: cast_nullable_to_non_nullable
as bool,cardBrand: null == cardBrand ? _self.cardBrand : cardBrand // ignore: cast_nullable_to_non_nullable
as CardBrand,cardLast4: freezed == cardLast4 ? _self.cardLast4 : cardLast4 // ignore: cast_nullable_to_non_nullable
as String?,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,respondBy: freezed == respondBy ? _self.respondBy : respondBy // ignore: cast_nullable_to_non_nullable
as DateTime?,myRating: freezed == myRating ? _self.myRating : myRating // ignore: cast_nullable_to_non_nullable
as double?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledByGuest: null == cancelledByGuest ? _self.cancelledByGuest : cancelledByGuest // ignore: cast_nullable_to_non_nullable
as bool,refundAmount: freezed == refundAmount ? _self.refundAmount : refundAmount // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as PriceBreakdown?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StayDatesCopyWith<$Res> get dates {
  
  return $StayDatesCopyWith<$Res>(_self.dates, (value) {
    return _then(_self.copyWith(dates: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuestCountCopyWith<$Res> get guests {
  
  return $GuestCountCopyWith<$Res>(_self.guests, (value) {
    return _then(_self.copyWith(guests: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceBreakdownCopyWith<$Res>? get price {
    if (_self.price == null) {
    return null;
  }

  return $PriceBreakdownCopyWith<$Res>(_self.price!, (value) {
    return _then(_self.copyWith(price: value));
  });
}
}


/// Adds pattern-matching-related methods to [Booking].
extension BookingPatterns on Booking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Booking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Booking value)  $default,){
final _that = this;
switch (_that) {
case _Booking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Booking value)?  $default,){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String listingId,  StayDates dates,  GuestCount guests,  int amountPaid,  BookingStatus status,  bool isRequest,  CardBrand cardBrand,  String? cardLast4,  DateTime? requestedAt,  DateTime? respondBy,  double? myRating,  DateTime? cancelledAt,  bool cancelledByGuest,  int? refundAmount,  PriceBreakdown? price,  DateTime? paidAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.code,_that.listingId,_that.dates,_that.guests,_that.amountPaid,_that.status,_that.isRequest,_that.cardBrand,_that.cardLast4,_that.requestedAt,_that.respondBy,_that.myRating,_that.cancelledAt,_that.cancelledByGuest,_that.refundAmount,_that.price,_that.paidAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String listingId,  StayDates dates,  GuestCount guests,  int amountPaid,  BookingStatus status,  bool isRequest,  CardBrand cardBrand,  String? cardLast4,  DateTime? requestedAt,  DateTime? respondBy,  double? myRating,  DateTime? cancelledAt,  bool cancelledByGuest,  int? refundAmount,  PriceBreakdown? price,  DateTime? paidAt)  $default,) {final _that = this;
switch (_that) {
case _Booking():
return $default(_that.id,_that.code,_that.listingId,_that.dates,_that.guests,_that.amountPaid,_that.status,_that.isRequest,_that.cardBrand,_that.cardLast4,_that.requestedAt,_that.respondBy,_that.myRating,_that.cancelledAt,_that.cancelledByGuest,_that.refundAmount,_that.price,_that.paidAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String listingId,  StayDates dates,  GuestCount guests,  int amountPaid,  BookingStatus status,  bool isRequest,  CardBrand cardBrand,  String? cardLast4,  DateTime? requestedAt,  DateTime? respondBy,  double? myRating,  DateTime? cancelledAt,  bool cancelledByGuest,  int? refundAmount,  PriceBreakdown? price,  DateTime? paidAt)?  $default,) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.code,_that.listingId,_that.dates,_that.guests,_that.amountPaid,_that.status,_that.isRequest,_that.cardBrand,_that.cardLast4,_that.requestedAt,_that.respondBy,_that.myRating,_that.cancelledAt,_that.cancelledByGuest,_that.refundAmount,_that.price,_that.paidAt);case _:
  return null;

}
}

}

/// @nodoc


class _Booking implements Booking {
  const _Booking({required this.id, required this.code, required this.listingId, required this.dates, required this.guests, required this.amountPaid, required this.status, this.isRequest = false, this.cardBrand = CardBrand.unknown, this.cardLast4, this.requestedAt, this.respondBy, this.myRating, this.cancelledAt, this.cancelledByGuest = true, this.refundAmount, this.price, this.paidAt});
  

@override final  String id;
/// Misafire gösterilen kod: "KZ-48K2Q".
@override final  String code;
@override final  String listingId;
@override final  StayDates dates;
@override final  GuestCount guests;
/// Anında onayda ödenen, talepte provizyon olarak tutulan tutar.
@override final  int amountPaid;
@override final  BookingStatus status;
/// Ev sahibi onaylı talep (40–43).
@override@JsonKey() final  bool isRequest;
@override@JsonKey() final  CardBrand cardBrand;
@override final  String? cardLast4;
@override final  DateTime? requestedAt;
/// Ev sahibinin yanıt vermesi gereken son an; geçerse talep düşer.
@override final  DateTime? respondBy;
/// Misafirin verdiği genel puan (değerlendirdiyse).
@override final  double? myRating;
@override final  DateTime? cancelledAt;
/// false: ev sahibi iptal etti.
@override@JsonKey() final  bool cancelledByGuest;
/// İptalde karta iade edilen tutar.
@override final  int? refundAmount;
/// Rezervasyon anındaki fiyat kalemleri (makbuz).
@override final  PriceBreakdown? price;
@override final  DateTime? paidAt;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingCopyWith<_Booking> get copyWith => __$BookingCopyWithImpl<_Booking>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.dates, dates) || other.dates == dates)&&(identical(other.guests, guests) || other.guests == guests)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.status, status) || other.status == status)&&(identical(other.isRequest, isRequest) || other.isRequest == isRequest)&&(identical(other.cardBrand, cardBrand) || other.cardBrand == cardBrand)&&(identical(other.cardLast4, cardLast4) || other.cardLast4 == cardLast4)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.respondBy, respondBy) || other.respondBy == respondBy)&&(identical(other.myRating, myRating) || other.myRating == myRating)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.cancelledByGuest, cancelledByGuest) || other.cancelledByGuest == cancelledByGuest)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&(identical(other.price, price) || other.price == price)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,listingId,dates,guests,amountPaid,status,isRequest,cardBrand,cardLast4,requestedAt,respondBy,myRating,cancelledAt,cancelledByGuest,refundAmount,price,paidAt);

@override
String toString() {
  return 'Booking(id: $id, code: $code, listingId: $listingId, dates: $dates, guests: $guests, amountPaid: $amountPaid, status: $status, isRequest: $isRequest, cardBrand: $cardBrand, cardLast4: $cardLast4, requestedAt: $requestedAt, respondBy: $respondBy, myRating: $myRating, cancelledAt: $cancelledAt, cancelledByGuest: $cancelledByGuest, refundAmount: $refundAmount, price: $price, paidAt: $paidAt)';
}


}

/// @nodoc
abstract mixin class _$BookingCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$BookingCopyWith(_Booking value, $Res Function(_Booking) _then) = __$BookingCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String listingId, StayDates dates, GuestCount guests, int amountPaid, BookingStatus status, bool isRequest, CardBrand cardBrand, String? cardLast4, DateTime? requestedAt, DateTime? respondBy, double? myRating, DateTime? cancelledAt, bool cancelledByGuest, int? refundAmount, PriceBreakdown? price, DateTime? paidAt
});


@override $StayDatesCopyWith<$Res> get dates;@override $GuestCountCopyWith<$Res> get guests;@override $PriceBreakdownCopyWith<$Res>? get price;

}
/// @nodoc
class __$BookingCopyWithImpl<$Res>
    implements _$BookingCopyWith<$Res> {
  __$BookingCopyWithImpl(this._self, this._then);

  final _Booking _self;
  final $Res Function(_Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? listingId = null,Object? dates = null,Object? guests = null,Object? amountPaid = null,Object? status = null,Object? isRequest = null,Object? cardBrand = null,Object? cardLast4 = freezed,Object? requestedAt = freezed,Object? respondBy = freezed,Object? myRating = freezed,Object? cancelledAt = freezed,Object? cancelledByGuest = null,Object? refundAmount = freezed,Object? price = freezed,Object? paidAt = freezed,}) {
  return _then(_Booking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,dates: null == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as StayDates,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as GuestCount,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,isRequest: null == isRequest ? _self.isRequest : isRequest // ignore: cast_nullable_to_non_nullable
as bool,cardBrand: null == cardBrand ? _self.cardBrand : cardBrand // ignore: cast_nullable_to_non_nullable
as CardBrand,cardLast4: freezed == cardLast4 ? _self.cardLast4 : cardLast4 // ignore: cast_nullable_to_non_nullable
as String?,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,respondBy: freezed == respondBy ? _self.respondBy : respondBy // ignore: cast_nullable_to_non_nullable
as DateTime?,myRating: freezed == myRating ? _self.myRating : myRating // ignore: cast_nullable_to_non_nullable
as double?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledByGuest: null == cancelledByGuest ? _self.cancelledByGuest : cancelledByGuest // ignore: cast_nullable_to_non_nullable
as bool,refundAmount: freezed == refundAmount ? _self.refundAmount : refundAmount // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as PriceBreakdown?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StayDatesCopyWith<$Res> get dates {
  
  return $StayDatesCopyWith<$Res>(_self.dates, (value) {
    return _then(_self.copyWith(dates: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuestCountCopyWith<$Res> get guests {
  
  return $GuestCountCopyWith<$Res>(_self.guests, (value) {
    return _then(_self.copyWith(guests: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceBreakdownCopyWith<$Res>? get price {
    if (_self.price == null) {
    return null;
  }

  return $PriceBreakdownCopyWith<$Res>(_self.price!, (value) {
    return _then(_self.copyWith(price: value));
  });
}
}

/// @nodoc
mixin _$StayGuest {

 String get id; String get fullName; Nationality get nationality;/// Kimlik / pasaport numarasının son 2 hanesi.
 String get idLast2;/// Rezervasyonu yapan kullanıcı.
 bool get isYou;
/// Create a copy of StayGuest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StayGuestCopyWith<StayGuest> get copyWith => _$StayGuestCopyWithImpl<StayGuest>(this as StayGuest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StayGuest&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.idLast2, idLast2) || other.idLast2 == idLast2)&&(identical(other.isYou, isYou) || other.isYou == isYou));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,nationality,idLast2,isYou);

@override
String toString() {
  return 'StayGuest(id: $id, fullName: $fullName, nationality: $nationality, idLast2: $idLast2, isYou: $isYou)';
}


}

/// @nodoc
abstract mixin class $StayGuestCopyWith<$Res>  {
  factory $StayGuestCopyWith(StayGuest value, $Res Function(StayGuest) _then) = _$StayGuestCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, Nationality nationality, String idLast2, bool isYou
});




}
/// @nodoc
class _$StayGuestCopyWithImpl<$Res>
    implements $StayGuestCopyWith<$Res> {
  _$StayGuestCopyWithImpl(this._self, this._then);

  final StayGuest _self;
  final $Res Function(StayGuest) _then;

/// Create a copy of StayGuest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? nationality = null,Object? idLast2 = null,Object? isYou = null,}) {
  return _then(StayGuest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as Nationality,idLast2: null == idLast2 ? _self.idLast2 : idLast2 // ignore: cast_nullable_to_non_nullable
as String,isYou: null == isYou ? _self.isYou : isYou // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StayGuest].
extension StayGuestPatterns on StayGuest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StayGuest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StayGuest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StayGuest value)  $default,){
final _that = this;
switch (_that) {
case _StayGuest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StayGuest value)?  $default,){
final _that = this;
switch (_that) {
case _StayGuest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  Nationality nationality,  String idLast2,  bool isYou)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StayGuest() when $default != null:
return $default(_that.id,_that.fullName,_that.nationality,_that.idLast2,_that.isYou);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  Nationality nationality,  String idLast2,  bool isYou)  $default,) {final _that = this;
switch (_that) {
case _StayGuest():
return $default(_that.id,_that.fullName,_that.nationality,_that.idLast2,_that.isYou);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  Nationality nationality,  String idLast2,  bool isYou)?  $default,) {final _that = this;
switch (_that) {
case _StayGuest() when $default != null:
return $default(_that.id,_that.fullName,_that.nationality,_that.idLast2,_that.isYou);case _:
  return null;

}
}

}

/// @nodoc


class _StayGuest implements StayGuest {
  const _StayGuest({required this.id, required this.fullName, required this.nationality, required this.idLast2, this.isYou = false});
  

@override final  String id;
@override final  String fullName;
@override final  Nationality nationality;
/// Kimlik / pasaport numarasının son 2 hanesi.
@override final  String idLast2;
/// Rezervasyonu yapan kullanıcı.
@override@JsonKey() final  bool isYou;

/// Create a copy of StayGuest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StayGuestCopyWith<_StayGuest> get copyWith => __$StayGuestCopyWithImpl<_StayGuest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StayGuest&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.idLast2, idLast2) || other.idLast2 == idLast2)&&(identical(other.isYou, isYou) || other.isYou == isYou));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,nationality,idLast2,isYou);

@override
String toString() {
  return 'StayGuest(id: $id, fullName: $fullName, nationality: $nationality, idLast2: $idLast2, isYou: $isYou)';
}


}

/// @nodoc
abstract mixin class _$StayGuestCopyWith<$Res> implements $StayGuestCopyWith<$Res> {
  factory _$StayGuestCopyWith(_StayGuest value, $Res Function(_StayGuest) _then) = __$StayGuestCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, Nationality nationality, String idLast2, bool isYou
});




}
/// @nodoc
class __$StayGuestCopyWithImpl<$Res>
    implements _$StayGuestCopyWith<$Res> {
  __$StayGuestCopyWithImpl(this._self, this._then);

  final _StayGuest _self;
  final $Res Function(_StayGuest) _then;

/// Create a copy of StayGuest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? nationality = null,Object? idLast2 = null,Object? isYou = null,}) {
  return _then(_StayGuest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as Nationality,idLast2: null == idLast2 ? _self.idLast2 : idLast2 // ignore: cast_nullable_to_non_nullable
as String,isYou: null == isYou ? _self.isYou : isYou // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$StayGuestList {

 List<StayGuest> get guests;/// Bilgisi girilmesi gereken toplam kişi (bebekler dahil değil).
 int get requiredCount; DateTime get checkIn;
/// Create a copy of StayGuestList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StayGuestListCopyWith<StayGuestList> get copyWith => _$StayGuestListCopyWithImpl<StayGuestList>(this as StayGuestList, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StayGuestList&&const DeepCollectionEquality().equals(other.guests, guests)&&(identical(other.requiredCount, requiredCount) || other.requiredCount == requiredCount)&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(guests),requiredCount,checkIn);

@override
String toString() {
  return 'StayGuestList(guests: $guests, requiredCount: $requiredCount, checkIn: $checkIn)';
}


}

/// @nodoc
abstract mixin class $StayGuestListCopyWith<$Res>  {
  factory $StayGuestListCopyWith(StayGuestList value, $Res Function(StayGuestList) _then) = _$StayGuestListCopyWithImpl;
@useResult
$Res call({
 List<StayGuest> guests, int requiredCount, DateTime checkIn
});




}
/// @nodoc
class _$StayGuestListCopyWithImpl<$Res>
    implements $StayGuestListCopyWith<$Res> {
  _$StayGuestListCopyWithImpl(this._self, this._then);

  final StayGuestList _self;
  final $Res Function(StayGuestList) _then;

/// Create a copy of StayGuestList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? guests = null,Object? requiredCount = null,Object? checkIn = null,}) {
  return _then(StayGuestList(
guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as List<StayGuest>,requiredCount: null == requiredCount ? _self.requiredCount : requiredCount // ignore: cast_nullable_to_non_nullable
as int,checkIn: null == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [StayGuestList].
extension StayGuestListPatterns on StayGuestList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StayGuestList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StayGuestList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StayGuestList value)  $default,){
final _that = this;
switch (_that) {
case _StayGuestList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StayGuestList value)?  $default,){
final _that = this;
switch (_that) {
case _StayGuestList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StayGuest> guests,  int requiredCount,  DateTime checkIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StayGuestList() when $default != null:
return $default(_that.guests,_that.requiredCount,_that.checkIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StayGuest> guests,  int requiredCount,  DateTime checkIn)  $default,) {final _that = this;
switch (_that) {
case _StayGuestList():
return $default(_that.guests,_that.requiredCount,_that.checkIn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StayGuest> guests,  int requiredCount,  DateTime checkIn)?  $default,) {final _that = this;
switch (_that) {
case _StayGuestList() when $default != null:
return $default(_that.guests,_that.requiredCount,_that.checkIn);case _:
  return null;

}
}

}

/// @nodoc


class _StayGuestList extends StayGuestList {
  const _StayGuestList({required  List<StayGuest> guests, required this.requiredCount, required this.checkIn}): _guests = guests,super._();
  

 final  List<StayGuest> _guests;
@override List<StayGuest> get guests {
  if (_guests is EqualUnmodifiableListView) return _guests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_guests);
}

/// Bilgisi girilmesi gereken toplam kişi (bebekler dahil değil).
@override final  int requiredCount;
@override final  DateTime checkIn;

/// Create a copy of StayGuestList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StayGuestListCopyWith<_StayGuestList> get copyWith => __$StayGuestListCopyWithImpl<_StayGuestList>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StayGuestList&&const DeepCollectionEquality().equals(other._guests, _guests)&&(identical(other.requiredCount, requiredCount) || other.requiredCount == requiredCount)&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_guests),requiredCount,checkIn);

@override
String toString() {
  return 'StayGuestList(guests: $guests, requiredCount: $requiredCount, checkIn: $checkIn)';
}


}

/// @nodoc
abstract mixin class _$StayGuestListCopyWith<$Res> implements $StayGuestListCopyWith<$Res> {
  factory _$StayGuestListCopyWith(_StayGuestList value, $Res Function(_StayGuestList) _then) = __$StayGuestListCopyWithImpl;
@override @useResult
$Res call({
 List<StayGuest> guests, int requiredCount, DateTime checkIn
});




}
/// @nodoc
class __$StayGuestListCopyWithImpl<$Res>
    implements _$StayGuestListCopyWith<$Res> {
  __$StayGuestListCopyWithImpl(this._self, this._then);

  final _StayGuestList _self;
  final $Res Function(_StayGuestList) _then;

/// Create a copy of StayGuestList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? guests = null,Object? requiredCount = null,Object? checkIn = null,}) {
  return _then(_StayGuestList(
guests: null == guests ? _self._guests : guests // ignore: cast_nullable_to_non_nullable
as List<StayGuest>,requiredCount: null == requiredCount ? _self.requiredCount : requiredCount // ignore: cast_nullable_to_non_nullable
as int,checkIn: null == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
