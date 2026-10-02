// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TripAccess {

 DateTime get revealAt;/// "Kırkpınar, Sapanca" — açılmadan önce gösterilen yaklaşık konum.
 String get areaLabel;/// Açılmadan önce yaklaşık, sonra tam konum.
 double get latitude; double get longitude;/// "14:00", "11:00"
 String get checkInFrom; String get checkOutBy;/// Ev kuralları ve çıkış listesi her zaman görünür.
 List<GuideSection> get sections; List<String> get checkoutTasks; List<String>? get addressLines; String? get hostPhone; String? get lockboxCode; String? get lockboxHint; String? get wifiName; String? get wifiPassword;
/// Create a copy of TripAccess
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripAccessCopyWith<TripAccess> get copyWith => _$TripAccessCopyWithImpl<TripAccess>(this as TripAccess, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripAccess&&(identical(other.revealAt, revealAt) || other.revealAt == revealAt)&&(identical(other.areaLabel, areaLabel) || other.areaLabel == areaLabel)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.checkInFrom, checkInFrom) || other.checkInFrom == checkInFrom)&&(identical(other.checkOutBy, checkOutBy) || other.checkOutBy == checkOutBy)&&const DeepCollectionEquality().equals(other.sections, sections)&&const DeepCollectionEquality().equals(other.checkoutTasks, checkoutTasks)&&const DeepCollectionEquality().equals(other.addressLines, addressLines)&&(identical(other.hostPhone, hostPhone) || other.hostPhone == hostPhone)&&(identical(other.lockboxCode, lockboxCode) || other.lockboxCode == lockboxCode)&&(identical(other.lockboxHint, lockboxHint) || other.lockboxHint == lockboxHint)&&(identical(other.wifiName, wifiName) || other.wifiName == wifiName)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword));
}


@override
int get hashCode => Object.hash(runtimeType,revealAt,areaLabel,latitude,longitude,checkInFrom,checkOutBy,const DeepCollectionEquality().hash(sections),const DeepCollectionEquality().hash(checkoutTasks),const DeepCollectionEquality().hash(addressLines),hostPhone,lockboxCode,lockboxHint,wifiName,wifiPassword);

@override
String toString() {
  return 'TripAccess(revealAt: $revealAt, areaLabel: $areaLabel, latitude: $latitude, longitude: $longitude, checkInFrom: $checkInFrom, checkOutBy: $checkOutBy, sections: $sections, checkoutTasks: $checkoutTasks, addressLines: $addressLines, hostPhone: $hostPhone, lockboxCode: $lockboxCode, lockboxHint: $lockboxHint, wifiName: $wifiName, wifiPassword: $wifiPassword)';
}


}

/// @nodoc
abstract mixin class $TripAccessCopyWith<$Res>  {
  factory $TripAccessCopyWith(TripAccess value, $Res Function(TripAccess) _then) = _$TripAccessCopyWithImpl;
@useResult
$Res call({
 DateTime revealAt, String areaLabel, double latitude, double longitude, String checkInFrom, String checkOutBy, List<GuideSection> sections, List<String> checkoutTasks, List<String>? addressLines, String? hostPhone, String? lockboxCode, String? lockboxHint, String? wifiName, String? wifiPassword
});




}
/// @nodoc
class _$TripAccessCopyWithImpl<$Res>
    implements $TripAccessCopyWith<$Res> {
  _$TripAccessCopyWithImpl(this._self, this._then);

  final TripAccess _self;
  final $Res Function(TripAccess) _then;

/// Create a copy of TripAccess
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? revealAt = null,Object? areaLabel = null,Object? latitude = null,Object? longitude = null,Object? checkInFrom = null,Object? checkOutBy = null,Object? sections = null,Object? checkoutTasks = null,Object? addressLines = freezed,Object? hostPhone = freezed,Object? lockboxCode = freezed,Object? lockboxHint = freezed,Object? wifiName = freezed,Object? wifiPassword = freezed,}) {
  return _then(TripAccess(
revealAt: null == revealAt ? _self.revealAt : revealAt // ignore: cast_nullable_to_non_nullable
as DateTime,areaLabel: null == areaLabel ? _self.areaLabel : areaLabel // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,checkInFrom: null == checkInFrom ? _self.checkInFrom : checkInFrom // ignore: cast_nullable_to_non_nullable
as String,checkOutBy: null == checkOutBy ? _self.checkOutBy : checkOutBy // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<GuideSection>,checkoutTasks: null == checkoutTasks ? _self.checkoutTasks : checkoutTasks // ignore: cast_nullable_to_non_nullable
as List<String>,addressLines: freezed == addressLines ? _self.addressLines : addressLines // ignore: cast_nullable_to_non_nullable
as List<String>?,hostPhone: freezed == hostPhone ? _self.hostPhone : hostPhone // ignore: cast_nullable_to_non_nullable
as String?,lockboxCode: freezed == lockboxCode ? _self.lockboxCode : lockboxCode // ignore: cast_nullable_to_non_nullable
as String?,lockboxHint: freezed == lockboxHint ? _self.lockboxHint : lockboxHint // ignore: cast_nullable_to_non_nullable
as String?,wifiName: freezed == wifiName ? _self.wifiName : wifiName // ignore: cast_nullable_to_non_nullable
as String?,wifiPassword: freezed == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripAccess].
extension TripAccessPatterns on TripAccess {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripAccess value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripAccess() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripAccess value)  $default,){
final _that = this;
switch (_that) {
case _TripAccess():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripAccess value)?  $default,){
final _that = this;
switch (_that) {
case _TripAccess() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime revealAt,  String areaLabel,  double latitude,  double longitude,  String checkInFrom,  String checkOutBy,  List<GuideSection> sections,  List<String> checkoutTasks,  List<String>? addressLines,  String? hostPhone,  String? lockboxCode,  String? lockboxHint,  String? wifiName,  String? wifiPassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripAccess() when $default != null:
return $default(_that.revealAt,_that.areaLabel,_that.latitude,_that.longitude,_that.checkInFrom,_that.checkOutBy,_that.sections,_that.checkoutTasks,_that.addressLines,_that.hostPhone,_that.lockboxCode,_that.lockboxHint,_that.wifiName,_that.wifiPassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime revealAt,  String areaLabel,  double latitude,  double longitude,  String checkInFrom,  String checkOutBy,  List<GuideSection> sections,  List<String> checkoutTasks,  List<String>? addressLines,  String? hostPhone,  String? lockboxCode,  String? lockboxHint,  String? wifiName,  String? wifiPassword)  $default,) {final _that = this;
switch (_that) {
case _TripAccess():
return $default(_that.revealAt,_that.areaLabel,_that.latitude,_that.longitude,_that.checkInFrom,_that.checkOutBy,_that.sections,_that.checkoutTasks,_that.addressLines,_that.hostPhone,_that.lockboxCode,_that.lockboxHint,_that.wifiName,_that.wifiPassword);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime revealAt,  String areaLabel,  double latitude,  double longitude,  String checkInFrom,  String checkOutBy,  List<GuideSection> sections,  List<String> checkoutTasks,  List<String>? addressLines,  String? hostPhone,  String? lockboxCode,  String? lockboxHint,  String? wifiName,  String? wifiPassword)?  $default,) {final _that = this;
switch (_that) {
case _TripAccess() when $default != null:
return $default(_that.revealAt,_that.areaLabel,_that.latitude,_that.longitude,_that.checkInFrom,_that.checkOutBy,_that.sections,_that.checkoutTasks,_that.addressLines,_that.hostPhone,_that.lockboxCode,_that.lockboxHint,_that.wifiName,_that.wifiPassword);case _:
  return null;

}
}

}

/// @nodoc


class _TripAccess extends TripAccess {
  const _TripAccess({required this.revealAt, required this.areaLabel, required this.latitude, required this.longitude, required this.checkInFrom, required this.checkOutBy,  List<GuideSection> sections = const <GuideSection>[],  List<String> checkoutTasks = const <String>[],  List<String>? addressLines, this.hostPhone, this.lockboxCode, this.lockboxHint, this.wifiName, this.wifiPassword}): _sections = sections,_checkoutTasks = checkoutTasks,_addressLines = addressLines,super._();
  

@override final  DateTime revealAt;
/// "Kırkpınar, Sapanca" — açılmadan önce gösterilen yaklaşık konum.
@override final  String areaLabel;
/// Açılmadan önce yaklaşık, sonra tam konum.
@override final  double latitude;
@override final  double longitude;
/// "14:00", "11:00"
@override final  String checkInFrom;
@override final  String checkOutBy;
/// Ev kuralları ve çıkış listesi her zaman görünür.
 final  List<GuideSection> _sections;
/// Ev kuralları ve çıkış listesi her zaman görünür.
@override@JsonKey() List<GuideSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

 final  List<String> _checkoutTasks;
@override@JsonKey() List<String> get checkoutTasks {
  if (_checkoutTasks is EqualUnmodifiableListView) return _checkoutTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checkoutTasks);
}

 final  List<String>? _addressLines;
@override List<String>? get addressLines {
  final value = _addressLines;
  if (value == null) return null;
  if (_addressLines is EqualUnmodifiableListView) return _addressLines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? hostPhone;
@override final  String? lockboxCode;
@override final  String? lockboxHint;
@override final  String? wifiName;
@override final  String? wifiPassword;

/// Create a copy of TripAccess
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripAccessCopyWith<_TripAccess> get copyWith => __$TripAccessCopyWithImpl<_TripAccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripAccess&&(identical(other.revealAt, revealAt) || other.revealAt == revealAt)&&(identical(other.areaLabel, areaLabel) || other.areaLabel == areaLabel)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.checkInFrom, checkInFrom) || other.checkInFrom == checkInFrom)&&(identical(other.checkOutBy, checkOutBy) || other.checkOutBy == checkOutBy)&&const DeepCollectionEquality().equals(other._sections, _sections)&&const DeepCollectionEquality().equals(other._checkoutTasks, _checkoutTasks)&&const DeepCollectionEquality().equals(other._addressLines, _addressLines)&&(identical(other.hostPhone, hostPhone) || other.hostPhone == hostPhone)&&(identical(other.lockboxCode, lockboxCode) || other.lockboxCode == lockboxCode)&&(identical(other.lockboxHint, lockboxHint) || other.lockboxHint == lockboxHint)&&(identical(other.wifiName, wifiName) || other.wifiName == wifiName)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword));
}


@override
int get hashCode => Object.hash(runtimeType,revealAt,areaLabel,latitude,longitude,checkInFrom,checkOutBy,const DeepCollectionEquality().hash(_sections),const DeepCollectionEquality().hash(_checkoutTasks),const DeepCollectionEquality().hash(_addressLines),hostPhone,lockboxCode,lockboxHint,wifiName,wifiPassword);

@override
String toString() {
  return 'TripAccess(revealAt: $revealAt, areaLabel: $areaLabel, latitude: $latitude, longitude: $longitude, checkInFrom: $checkInFrom, checkOutBy: $checkOutBy, sections: $sections, checkoutTasks: $checkoutTasks, addressLines: $addressLines, hostPhone: $hostPhone, lockboxCode: $lockboxCode, lockboxHint: $lockboxHint, wifiName: $wifiName, wifiPassword: $wifiPassword)';
}


}

/// @nodoc
abstract mixin class _$TripAccessCopyWith<$Res> implements $TripAccessCopyWith<$Res> {
  factory _$TripAccessCopyWith(_TripAccess value, $Res Function(_TripAccess) _then) = __$TripAccessCopyWithImpl;
@override @useResult
$Res call({
 DateTime revealAt, String areaLabel, double latitude, double longitude, String checkInFrom, String checkOutBy, List<GuideSection> sections, List<String> checkoutTasks, List<String>? addressLines, String? hostPhone, String? lockboxCode, String? lockboxHint, String? wifiName, String? wifiPassword
});




}
/// @nodoc
class __$TripAccessCopyWithImpl<$Res>
    implements _$TripAccessCopyWith<$Res> {
  __$TripAccessCopyWithImpl(this._self, this._then);

  final _TripAccess _self;
  final $Res Function(_TripAccess) _then;

/// Create a copy of TripAccess
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? revealAt = null,Object? areaLabel = null,Object? latitude = null,Object? longitude = null,Object? checkInFrom = null,Object? checkOutBy = null,Object? sections = null,Object? checkoutTasks = null,Object? addressLines = freezed,Object? hostPhone = freezed,Object? lockboxCode = freezed,Object? lockboxHint = freezed,Object? wifiName = freezed,Object? wifiPassword = freezed,}) {
  return _then(_TripAccess(
revealAt: null == revealAt ? _self.revealAt : revealAt // ignore: cast_nullable_to_non_nullable
as DateTime,areaLabel: null == areaLabel ? _self.areaLabel : areaLabel // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,checkInFrom: null == checkInFrom ? _self.checkInFrom : checkInFrom // ignore: cast_nullable_to_non_nullable
as String,checkOutBy: null == checkOutBy ? _self.checkOutBy : checkOutBy // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<GuideSection>,checkoutTasks: null == checkoutTasks ? _self._checkoutTasks : checkoutTasks // ignore: cast_nullable_to_non_nullable
as List<String>,addressLines: freezed == addressLines ? _self._addressLines : addressLines // ignore: cast_nullable_to_non_nullable
as List<String>?,hostPhone: freezed == hostPhone ? _self.hostPhone : hostPhone // ignore: cast_nullable_to_non_nullable
as String?,lockboxCode: freezed == lockboxCode ? _self.lockboxCode : lockboxCode // ignore: cast_nullable_to_non_nullable
as String?,lockboxHint: freezed == lockboxHint ? _self.lockboxHint : lockboxHint // ignore: cast_nullable_to_non_nullable
as String?,wifiName: freezed == wifiName ? _self.wifiName : wifiName // ignore: cast_nullable_to_non_nullable
as String?,wifiPassword: freezed == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$BillingInfo {

 BillingType get type; String get fullName;/// Bireyselde isteğe bağlı. KVKK: yalnızca maskeli döner.
 String? get tcknLast2; String get address; String get email; String get companyName; String get taxOffice; String get taxNumber;
/// Create a copy of BillingInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillingInfoCopyWith<BillingInfo> get copyWith => _$BillingInfoCopyWithImpl<BillingInfo>(this as BillingInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillingInfo&&(identical(other.type, type) || other.type == type)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.tcknLast2, tcknLast2) || other.tcknLast2 == tcknLast2)&&(identical(other.address, address) || other.address == address)&&(identical(other.email, email) || other.email == email)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.taxOffice, taxOffice) || other.taxOffice == taxOffice)&&(identical(other.taxNumber, taxNumber) || other.taxNumber == taxNumber));
}


@override
int get hashCode => Object.hash(runtimeType,type,fullName,tcknLast2,address,email,companyName,taxOffice,taxNumber);

@override
String toString() {
  return 'BillingInfo(type: $type, fullName: $fullName, tcknLast2: $tcknLast2, address: $address, email: $email, companyName: $companyName, taxOffice: $taxOffice, taxNumber: $taxNumber)';
}


}

/// @nodoc
abstract mixin class $BillingInfoCopyWith<$Res>  {
  factory $BillingInfoCopyWith(BillingInfo value, $Res Function(BillingInfo) _then) = _$BillingInfoCopyWithImpl;
@useResult
$Res call({
 BillingType type, String fullName, String? tcknLast2, String address, String email, String companyName, String taxOffice, String taxNumber
});




}
/// @nodoc
class _$BillingInfoCopyWithImpl<$Res>
    implements $BillingInfoCopyWith<$Res> {
  _$BillingInfoCopyWithImpl(this._self, this._then);

  final BillingInfo _self;
  final $Res Function(BillingInfo) _then;

/// Create a copy of BillingInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? fullName = null,Object? tcknLast2 = freezed,Object? address = null,Object? email = null,Object? companyName = null,Object? taxOffice = null,Object? taxNumber = null,}) {
  return _then(BillingInfo(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BillingType,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,tcknLast2: freezed == tcknLast2 ? _self.tcknLast2 : tcknLast2 // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,taxOffice: null == taxOffice ? _self.taxOffice : taxOffice // ignore: cast_nullable_to_non_nullable
as String,taxNumber: null == taxNumber ? _self.taxNumber : taxNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BillingInfo].
extension BillingInfoPatterns on BillingInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillingInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillingInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillingInfo value)  $default,){
final _that = this;
switch (_that) {
case _BillingInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillingInfo value)?  $default,){
final _that = this;
switch (_that) {
case _BillingInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BillingType type,  String fullName,  String? tcknLast2,  String address,  String email,  String companyName,  String taxOffice,  String taxNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillingInfo() when $default != null:
return $default(_that.type,_that.fullName,_that.tcknLast2,_that.address,_that.email,_that.companyName,_that.taxOffice,_that.taxNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BillingType type,  String fullName,  String? tcknLast2,  String address,  String email,  String companyName,  String taxOffice,  String taxNumber)  $default,) {final _that = this;
switch (_that) {
case _BillingInfo():
return $default(_that.type,_that.fullName,_that.tcknLast2,_that.address,_that.email,_that.companyName,_that.taxOffice,_that.taxNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BillingType type,  String fullName,  String? tcknLast2,  String address,  String email,  String companyName,  String taxOffice,  String taxNumber)?  $default,) {final _that = this;
switch (_that) {
case _BillingInfo() when $default != null:
return $default(_that.type,_that.fullName,_that.tcknLast2,_that.address,_that.email,_that.companyName,_that.taxOffice,_that.taxNumber);case _:
  return null;

}
}

}

/// @nodoc


class _BillingInfo implements BillingInfo {
  const _BillingInfo({this.type = BillingType.individual, this.fullName = '', this.tcknLast2, this.address = '', this.email = '', this.companyName = '', this.taxOffice = '', this.taxNumber = ''});
  

@override@JsonKey() final  BillingType type;
@override@JsonKey() final  String fullName;
/// Bireyselde isteğe bağlı. KVKK: yalnızca maskeli döner.
@override final  String? tcknLast2;
@override@JsonKey() final  String address;
@override@JsonKey() final  String email;
@override@JsonKey() final  String companyName;
@override@JsonKey() final  String taxOffice;
@override@JsonKey() final  String taxNumber;

/// Create a copy of BillingInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillingInfoCopyWith<_BillingInfo> get copyWith => __$BillingInfoCopyWithImpl<_BillingInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillingInfo&&(identical(other.type, type) || other.type == type)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.tcknLast2, tcknLast2) || other.tcknLast2 == tcknLast2)&&(identical(other.address, address) || other.address == address)&&(identical(other.email, email) || other.email == email)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.taxOffice, taxOffice) || other.taxOffice == taxOffice)&&(identical(other.taxNumber, taxNumber) || other.taxNumber == taxNumber));
}


@override
int get hashCode => Object.hash(runtimeType,type,fullName,tcknLast2,address,email,companyName,taxOffice,taxNumber);

@override
String toString() {
  return 'BillingInfo(type: $type, fullName: $fullName, tcknLast2: $tcknLast2, address: $address, email: $email, companyName: $companyName, taxOffice: $taxOffice, taxNumber: $taxNumber)';
}


}

/// @nodoc
abstract mixin class _$BillingInfoCopyWith<$Res> implements $BillingInfoCopyWith<$Res> {
  factory _$BillingInfoCopyWith(_BillingInfo value, $Res Function(_BillingInfo) _then) = __$BillingInfoCopyWithImpl;
@override @useResult
$Res call({
 BillingType type, String fullName, String? tcknLast2, String address, String email, String companyName, String taxOffice, String taxNumber
});




}
/// @nodoc
class __$BillingInfoCopyWithImpl<$Res>
    implements _$BillingInfoCopyWith<$Res> {
  __$BillingInfoCopyWithImpl(this._self, this._then);

  final _BillingInfo _self;
  final $Res Function(_BillingInfo) _then;

/// Create a copy of BillingInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? fullName = null,Object? tcknLast2 = freezed,Object? address = null,Object? email = null,Object? companyName = null,Object? taxOffice = null,Object? taxNumber = null,}) {
  return _then(_BillingInfo(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BillingType,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,tcknLast2: freezed == tcknLast2 ? _self.tcknLast2 : tcknLast2 // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,taxOffice: null == taxOffice ? _self.taxOffice : taxOffice // ignore: cast_nullable_to_non_nullable
as String,taxNumber: null == taxNumber ? _self.taxNumber : taxNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$CancellationQuote {

 int get paid; int get deduction; int get refund;/// Ücretsiz iptalin son anı.
 DateTime get freeUntil;
/// Create a copy of CancellationQuote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CancellationQuoteCopyWith<CancellationQuote> get copyWith => _$CancellationQuoteCopyWithImpl<CancellationQuote>(this as CancellationQuote, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancellationQuote&&(identical(other.paid, paid) || other.paid == paid)&&(identical(other.deduction, deduction) || other.deduction == deduction)&&(identical(other.refund, refund) || other.refund == refund)&&(identical(other.freeUntil, freeUntil) || other.freeUntil == freeUntil));
}


@override
int get hashCode => Object.hash(runtimeType,paid,deduction,refund,freeUntil);

@override
String toString() {
  return 'CancellationQuote(paid: $paid, deduction: $deduction, refund: $refund, freeUntil: $freeUntil)';
}


}

/// @nodoc
abstract mixin class $CancellationQuoteCopyWith<$Res>  {
  factory $CancellationQuoteCopyWith(CancellationQuote value, $Res Function(CancellationQuote) _then) = _$CancellationQuoteCopyWithImpl;
@useResult
$Res call({
 int paid, int deduction, int refund, DateTime freeUntil
});




}
/// @nodoc
class _$CancellationQuoteCopyWithImpl<$Res>
    implements $CancellationQuoteCopyWith<$Res> {
  _$CancellationQuoteCopyWithImpl(this._self, this._then);

  final CancellationQuote _self;
  final $Res Function(CancellationQuote) _then;

/// Create a copy of CancellationQuote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paid = null,Object? deduction = null,Object? refund = null,Object? freeUntil = null,}) {
  return _then(CancellationQuote(
paid: null == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as int,deduction: null == deduction ? _self.deduction : deduction // ignore: cast_nullable_to_non_nullable
as int,refund: null == refund ? _self.refund : refund // ignore: cast_nullable_to_non_nullable
as int,freeUntil: null == freeUntil ? _self.freeUntil : freeUntil // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CancellationQuote].
extension CancellationQuotePatterns on CancellationQuote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CancellationQuote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CancellationQuote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CancellationQuote value)  $default,){
final _that = this;
switch (_that) {
case _CancellationQuote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CancellationQuote value)?  $default,){
final _that = this;
switch (_that) {
case _CancellationQuote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int paid,  int deduction,  int refund,  DateTime freeUntil)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CancellationQuote() when $default != null:
return $default(_that.paid,_that.deduction,_that.refund,_that.freeUntil);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int paid,  int deduction,  int refund,  DateTime freeUntil)  $default,) {final _that = this;
switch (_that) {
case _CancellationQuote():
return $default(_that.paid,_that.deduction,_that.refund,_that.freeUntil);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int paid,  int deduction,  int refund,  DateTime freeUntil)?  $default,) {final _that = this;
switch (_that) {
case _CancellationQuote() when $default != null:
return $default(_that.paid,_that.deduction,_that.refund,_that.freeUntil);case _:
  return null;

}
}

}

/// @nodoc


class _CancellationQuote extends CancellationQuote {
  const _CancellationQuote({required this.paid, required this.deduction, required this.refund, required this.freeUntil}): super._();
  

@override final  int paid;
@override final  int deduction;
@override final  int refund;
/// Ücretsiz iptalin son anı.
@override final  DateTime freeUntil;

/// Create a copy of CancellationQuote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancellationQuoteCopyWith<_CancellationQuote> get copyWith => __$CancellationQuoteCopyWithImpl<_CancellationQuote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancellationQuote&&(identical(other.paid, paid) || other.paid == paid)&&(identical(other.deduction, deduction) || other.deduction == deduction)&&(identical(other.refund, refund) || other.refund == refund)&&(identical(other.freeUntil, freeUntil) || other.freeUntil == freeUntil));
}


@override
int get hashCode => Object.hash(runtimeType,paid,deduction,refund,freeUntil);

@override
String toString() {
  return 'CancellationQuote(paid: $paid, deduction: $deduction, refund: $refund, freeUntil: $freeUntil)';
}


}

/// @nodoc
abstract mixin class _$CancellationQuoteCopyWith<$Res> implements $CancellationQuoteCopyWith<$Res> {
  factory _$CancellationQuoteCopyWith(_CancellationQuote value, $Res Function(_CancellationQuote) _then) = __$CancellationQuoteCopyWithImpl;
@override @useResult
$Res call({
 int paid, int deduction, int refund, DateTime freeUntil
});




}
/// @nodoc
class __$CancellationQuoteCopyWithImpl<$Res>
    implements _$CancellationQuoteCopyWith<$Res> {
  __$CancellationQuoteCopyWithImpl(this._self, this._then);

  final _CancellationQuote _self;
  final $Res Function(_CancellationQuote) _then;

/// Create a copy of CancellationQuote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paid = null,Object? deduction = null,Object? refund = null,Object? freeUntil = null,}) {
  return _then(_CancellationQuote(
paid: null == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as int,deduction: null == deduction ? _self.deduction : deduction // ignore: cast_nullable_to_non_nullable
as int,refund: null == refund ? _self.refund : refund // ignore: cast_nullable_to_non_nullable
as int,freeUntil: null == freeUntil ? _self.freeUntil : freeUntil // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
