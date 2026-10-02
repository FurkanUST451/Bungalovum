// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserProfile {

 String get id; String get firstName; String get lastName;/// Ev sahiplerine görünen kısa ad ("Deniz"); boşsa ad kullanılır.
 String? get displayName; String get email;/// 10 haneli TR cep numarası.
 String? get phone; String? get address; EmergencyContact? get emergencyContact;/// Yerel dosya yolu ya da sunucu adresi.
 String? get avatarUrl; DateTime get memberSince;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.emergencyContact, emergencyContact) || other.emergencyContact == emergencyContact)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince));
}


@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,displayName,email,phone,address,emergencyContact,avatarUrl,memberSince);

@override
String toString() {
  return 'UserProfile(id: $id, firstName: $firstName, lastName: $lastName, displayName: $displayName, email: $email, phone: $phone, address: $address, emergencyContact: $emergencyContact, avatarUrl: $avatarUrl, memberSince: $memberSince)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String firstName, String lastName, String? displayName, String email, String? phone, String? address, EmergencyContact? emergencyContact, String? avatarUrl, DateTime memberSince
});


$EmergencyContactCopyWith<$Res>? get emergencyContact;

}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? displayName = freezed,Object? email = null,Object? phone = freezed,Object? address = freezed,Object? emergencyContact = freezed,Object? avatarUrl = freezed,Object? memberSince = null,}) {
  return _then(UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,emergencyContact: freezed == emergencyContact ? _self.emergencyContact : emergencyContact // ignore: cast_nullable_to_non_nullable
as EmergencyContact?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,memberSince: null == memberSince ? _self.memberSince : memberSince // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmergencyContactCopyWith<$Res>? get emergencyContact {
    if (_self.emergencyContact == null) {
    return null;
  }

  return $EmergencyContactCopyWith<$Res>(_self.emergencyContact!, (value) {
    return _then(_self.copyWith(emergencyContact: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String firstName,  String lastName,  String? displayName,  String email,  String? phone,  String? address,  EmergencyContact? emergencyContact,  String? avatarUrl,  DateTime memberSince)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.displayName,_that.email,_that.phone,_that.address,_that.emergencyContact,_that.avatarUrl,_that.memberSince);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String firstName,  String lastName,  String? displayName,  String email,  String? phone,  String? address,  EmergencyContact? emergencyContact,  String? avatarUrl,  DateTime memberSince)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.firstName,_that.lastName,_that.displayName,_that.email,_that.phone,_that.address,_that.emergencyContact,_that.avatarUrl,_that.memberSince);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String firstName,  String lastName,  String? displayName,  String email,  String? phone,  String? address,  EmergencyContact? emergencyContact,  String? avatarUrl,  DateTime memberSince)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.displayName,_that.email,_that.phone,_that.address,_that.emergencyContact,_that.avatarUrl,_that.memberSince);case _:
  return null;

}
}

}

/// @nodoc


class _UserProfile extends UserProfile {
  const _UserProfile({required this.id, required this.firstName, required this.lastName, this.displayName, required this.email, this.phone, this.address, this.emergencyContact, this.avatarUrl, required this.memberSince}): super._();
  

@override final  String id;
@override final  String firstName;
@override final  String lastName;
/// Ev sahiplerine görünen kısa ad ("Deniz"); boşsa ad kullanılır.
@override final  String? displayName;
@override final  String email;
/// 10 haneli TR cep numarası.
@override final  String? phone;
@override final  String? address;
@override final  EmergencyContact? emergencyContact;
/// Yerel dosya yolu ya da sunucu adresi.
@override final  String? avatarUrl;
@override final  DateTime memberSince;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.emergencyContact, emergencyContact) || other.emergencyContact == emergencyContact)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince));
}


@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,displayName,email,phone,address,emergencyContact,avatarUrl,memberSince);

@override
String toString() {
  return 'UserProfile(id: $id, firstName: $firstName, lastName: $lastName, displayName: $displayName, email: $email, phone: $phone, address: $address, emergencyContact: $emergencyContact, avatarUrl: $avatarUrl, memberSince: $memberSince)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String firstName, String lastName, String? displayName, String email, String? phone, String? address, EmergencyContact? emergencyContact, String? avatarUrl, DateTime memberSince
});


@override $EmergencyContactCopyWith<$Res>? get emergencyContact;

}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? displayName = freezed,Object? email = null,Object? phone = freezed,Object? address = freezed,Object? emergencyContact = freezed,Object? avatarUrl = freezed,Object? memberSince = null,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,emergencyContact: freezed == emergencyContact ? _self.emergencyContact : emergencyContact // ignore: cast_nullable_to_non_nullable
as EmergencyContact?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,memberSince: null == memberSince ? _self.memberSince : memberSince // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmergencyContactCopyWith<$Res>? get emergencyContact {
    if (_self.emergencyContact == null) {
    return null;
  }

  return $EmergencyContactCopyWith<$Res>(_self.emergencyContact!, (value) {
    return _then(_self.copyWith(emergencyContact: value));
  });
}
}

/// @nodoc
mixin _$EmergencyContact {

 String get name; String get phone;
/// Create a copy of EmergencyContact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmergencyContactCopyWith<EmergencyContact> get copyWith => _$EmergencyContactCopyWithImpl<EmergencyContact>(this as EmergencyContact, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmergencyContact&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,name,phone);

@override
String toString() {
  return 'EmergencyContact(name: $name, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $EmergencyContactCopyWith<$Res>  {
  factory $EmergencyContactCopyWith(EmergencyContact value, $Res Function(EmergencyContact) _then) = _$EmergencyContactCopyWithImpl;
@useResult
$Res call({
 String name, String phone
});




}
/// @nodoc
class _$EmergencyContactCopyWithImpl<$Res>
    implements $EmergencyContactCopyWith<$Res> {
  _$EmergencyContactCopyWithImpl(this._self, this._then);

  final EmergencyContact _self;
  final $Res Function(EmergencyContact) _then;

/// Create a copy of EmergencyContact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? phone = null,}) {
  return _then(EmergencyContact(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EmergencyContact].
extension EmergencyContactPatterns on EmergencyContact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmergencyContact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmergencyContact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmergencyContact value)  $default,){
final _that = this;
switch (_that) {
case _EmergencyContact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmergencyContact value)?  $default,){
final _that = this;
switch (_that) {
case _EmergencyContact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmergencyContact() when $default != null:
return $default(_that.name,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String phone)  $default,) {final _that = this;
switch (_that) {
case _EmergencyContact():
return $default(_that.name,_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String phone)?  $default,) {final _that = this;
switch (_that) {
case _EmergencyContact() when $default != null:
return $default(_that.name,_that.phone);case _:
  return null;

}
}

}

/// @nodoc


class _EmergencyContact implements EmergencyContact {
  const _EmergencyContact({required this.name, required this.phone});
  

@override final  String name;
@override final  String phone;

/// Create a copy of EmergencyContact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmergencyContactCopyWith<_EmergencyContact> get copyWith => __$EmergencyContactCopyWithImpl<_EmergencyContact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmergencyContact&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,name,phone);

@override
String toString() {
  return 'EmergencyContact(name: $name, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$EmergencyContactCopyWith<$Res> implements $EmergencyContactCopyWith<$Res> {
  factory _$EmergencyContactCopyWith(_EmergencyContact value, $Res Function(_EmergencyContact) _then) = __$EmergencyContactCopyWithImpl;
@override @useResult
$Res call({
 String name, String phone
});




}
/// @nodoc
class __$EmergencyContactCopyWithImpl<$Res>
    implements _$EmergencyContactCopyWith<$Res> {
  __$EmergencyContactCopyWithImpl(this._self, this._then);

  final _EmergencyContact _self;
  final $Res Function(_EmergencyContact) _then;

/// Create a copy of EmergencyContact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? phone = null,}) {
  return _then(_EmergencyContact(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$AccountStats {

 int get stays; int get reviews; int get saved;
/// Create a copy of AccountStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountStatsCopyWith<AccountStats> get copyWith => _$AccountStatsCopyWithImpl<AccountStats>(this as AccountStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountStats&&(identical(other.stays, stays) || other.stays == stays)&&(identical(other.reviews, reviews) || other.reviews == reviews)&&(identical(other.saved, saved) || other.saved == saved));
}


@override
int get hashCode => Object.hash(runtimeType,stays,reviews,saved);

@override
String toString() {
  return 'AccountStats(stays: $stays, reviews: $reviews, saved: $saved)';
}


}

/// @nodoc
abstract mixin class $AccountStatsCopyWith<$Res>  {
  factory $AccountStatsCopyWith(AccountStats value, $Res Function(AccountStats) _then) = _$AccountStatsCopyWithImpl;
@useResult
$Res call({
 int stays, int reviews, int saved
});




}
/// @nodoc
class _$AccountStatsCopyWithImpl<$Res>
    implements $AccountStatsCopyWith<$Res> {
  _$AccountStatsCopyWithImpl(this._self, this._then);

  final AccountStats _self;
  final $Res Function(AccountStats) _then;

/// Create a copy of AccountStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stays = null,Object? reviews = null,Object? saved = null,}) {
  return _then(AccountStats(
stays: null == stays ? _self.stays : stays // ignore: cast_nullable_to_non_nullable
as int,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as int,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountStats].
extension AccountStatsPatterns on AccountStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountStats value)  $default,){
final _that = this;
switch (_that) {
case _AccountStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountStats value)?  $default,){
final _that = this;
switch (_that) {
case _AccountStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int stays,  int reviews,  int saved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountStats() when $default != null:
return $default(_that.stays,_that.reviews,_that.saved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int stays,  int reviews,  int saved)  $default,) {final _that = this;
switch (_that) {
case _AccountStats():
return $default(_that.stays,_that.reviews,_that.saved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int stays,  int reviews,  int saved)?  $default,) {final _that = this;
switch (_that) {
case _AccountStats() when $default != null:
return $default(_that.stays,_that.reviews,_that.saved);case _:
  return null;

}
}

}

/// @nodoc


class _AccountStats implements AccountStats {
  const _AccountStats({required this.stays, required this.reviews, required this.saved});
  

@override final  int stays;
@override final  int reviews;
@override final  int saved;

/// Create a copy of AccountStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountStatsCopyWith<_AccountStats> get copyWith => __$AccountStatsCopyWithImpl<_AccountStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountStats&&(identical(other.stays, stays) || other.stays == stays)&&(identical(other.reviews, reviews) || other.reviews == reviews)&&(identical(other.saved, saved) || other.saved == saved));
}


@override
int get hashCode => Object.hash(runtimeType,stays,reviews,saved);

@override
String toString() {
  return 'AccountStats(stays: $stays, reviews: $reviews, saved: $saved)';
}


}

/// @nodoc
abstract mixin class _$AccountStatsCopyWith<$Res> implements $AccountStatsCopyWith<$Res> {
  factory _$AccountStatsCopyWith(_AccountStats value, $Res Function(_AccountStats) _then) = __$AccountStatsCopyWithImpl;
@override @useResult
$Res call({
 int stays, int reviews, int saved
});




}
/// @nodoc
class __$AccountStatsCopyWithImpl<$Res>
    implements _$AccountStatsCopyWith<$Res> {
  __$AccountStatsCopyWithImpl(this._self, this._then);

  final _AccountStats _self;
  final $Res Function(_AccountStats) _then;

/// Create a copy of AccountStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stays = null,Object? reviews = null,Object? saved = null,}) {
  return _then(_AccountStats(
stays: null == stays ? _self.stays : stays // ignore: cast_nullable_to_non_nullable
as int,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as int,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$Device {

 String get id;/// "Android", "iPhone 15"
 String get name; String get city; DateTime get lastActive; bool get current;
/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceCopyWith<Device> get copyWith => _$DeviceCopyWithImpl<Device>(this as Device, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Device&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.lastActive, lastActive) || other.lastActive == lastActive)&&(identical(other.current, current) || other.current == current));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,city,lastActive,current);

@override
String toString() {
  return 'Device(id: $id, name: $name, city: $city, lastActive: $lastActive, current: $current)';
}


}

/// @nodoc
abstract mixin class $DeviceCopyWith<$Res>  {
  factory $DeviceCopyWith(Device value, $Res Function(Device) _then) = _$DeviceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String city, DateTime lastActive, bool current
});




}
/// @nodoc
class _$DeviceCopyWithImpl<$Res>
    implements $DeviceCopyWith<$Res> {
  _$DeviceCopyWithImpl(this._self, this._then);

  final Device _self;
  final $Res Function(Device) _then;

/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? city = null,Object? lastActive = null,Object? current = null,}) {
  return _then(Device(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,lastActive: null == lastActive ? _self.lastActive : lastActive // ignore: cast_nullable_to_non_nullable
as DateTime,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Device].
extension DevicePatterns on Device {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Device value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Device() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Device value)  $default,){
final _that = this;
switch (_that) {
case _Device():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Device value)?  $default,){
final _that = this;
switch (_that) {
case _Device() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String city,  DateTime lastActive,  bool current)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Device() when $default != null:
return $default(_that.id,_that.name,_that.city,_that.lastActive,_that.current);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String city,  DateTime lastActive,  bool current)  $default,) {final _that = this;
switch (_that) {
case _Device():
return $default(_that.id,_that.name,_that.city,_that.lastActive,_that.current);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String city,  DateTime lastActive,  bool current)?  $default,) {final _that = this;
switch (_that) {
case _Device() when $default != null:
return $default(_that.id,_that.name,_that.city,_that.lastActive,_that.current);case _:
  return null;

}
}

}

/// @nodoc


class _Device implements Device {
  const _Device({required this.id, required this.name, required this.city, required this.lastActive, this.current = false});
  

@override final  String id;
/// "Android", "iPhone 15"
@override final  String name;
@override final  String city;
@override final  DateTime lastActive;
@override@JsonKey() final  bool current;

/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceCopyWith<_Device> get copyWith => __$DeviceCopyWithImpl<_Device>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Device&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.lastActive, lastActive) || other.lastActive == lastActive)&&(identical(other.current, current) || other.current == current));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,city,lastActive,current);

@override
String toString() {
  return 'Device(id: $id, name: $name, city: $city, lastActive: $lastActive, current: $current)';
}


}

/// @nodoc
abstract mixin class _$DeviceCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$DeviceCopyWith(_Device value, $Res Function(_Device) _then) = __$DeviceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String city, DateTime lastActive, bool current
});




}
/// @nodoc
class __$DeviceCopyWithImpl<$Res>
    implements _$DeviceCopyWith<$Res> {
  __$DeviceCopyWithImpl(this._self, this._then);

  final _Device _self;
  final $Res Function(_Device) _then;

/// Create a copy of Device
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? city = null,Object? lastActive = null,Object? current = null,}) {
  return _then(_Device(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,lastActive: null == lastActive ? _self.lastActive : lastActive // ignore: cast_nullable_to_non_nullable
as DateTime,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SecuritySettings {

 bool get biometric; DateTime get passwordUpdatedAt; List<Device> get devices;
/// Create a copy of SecuritySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecuritySettingsCopyWith<SecuritySettings> get copyWith => _$SecuritySettingsCopyWithImpl<SecuritySettings>(this as SecuritySettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecuritySettings&&(identical(other.biometric, biometric) || other.biometric == biometric)&&(identical(other.passwordUpdatedAt, passwordUpdatedAt) || other.passwordUpdatedAt == passwordUpdatedAt)&&const DeepCollectionEquality().equals(other.devices, devices));
}


@override
int get hashCode => Object.hash(runtimeType,biometric,passwordUpdatedAt,const DeepCollectionEquality().hash(devices));

@override
String toString() {
  return 'SecuritySettings(biometric: $biometric, passwordUpdatedAt: $passwordUpdatedAt, devices: $devices)';
}


}

/// @nodoc
abstract mixin class $SecuritySettingsCopyWith<$Res>  {
  factory $SecuritySettingsCopyWith(SecuritySettings value, $Res Function(SecuritySettings) _then) = _$SecuritySettingsCopyWithImpl;
@useResult
$Res call({
 bool biometric, DateTime passwordUpdatedAt, List<Device> devices
});




}
/// @nodoc
class _$SecuritySettingsCopyWithImpl<$Res>
    implements $SecuritySettingsCopyWith<$Res> {
  _$SecuritySettingsCopyWithImpl(this._self, this._then);

  final SecuritySettings _self;
  final $Res Function(SecuritySettings) _then;

/// Create a copy of SecuritySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? biometric = null,Object? passwordUpdatedAt = null,Object? devices = null,}) {
  return _then(SecuritySettings(
biometric: null == biometric ? _self.biometric : biometric // ignore: cast_nullable_to_non_nullable
as bool,passwordUpdatedAt: null == passwordUpdatedAt ? _self.passwordUpdatedAt : passwordUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,devices: null == devices ? _self.devices : devices // ignore: cast_nullable_to_non_nullable
as List<Device>,
  ));
}

}


/// Adds pattern-matching-related methods to [SecuritySettings].
extension SecuritySettingsPatterns on SecuritySettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SecuritySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SecuritySettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SecuritySettings value)  $default,){
final _that = this;
switch (_that) {
case _SecuritySettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SecuritySettings value)?  $default,){
final _that = this;
switch (_that) {
case _SecuritySettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool biometric,  DateTime passwordUpdatedAt,  List<Device> devices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecuritySettings() when $default != null:
return $default(_that.biometric,_that.passwordUpdatedAt,_that.devices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool biometric,  DateTime passwordUpdatedAt,  List<Device> devices)  $default,) {final _that = this;
switch (_that) {
case _SecuritySettings():
return $default(_that.biometric,_that.passwordUpdatedAt,_that.devices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool biometric,  DateTime passwordUpdatedAt,  List<Device> devices)?  $default,) {final _that = this;
switch (_that) {
case _SecuritySettings() when $default != null:
return $default(_that.biometric,_that.passwordUpdatedAt,_that.devices);case _:
  return null;

}
}

}

/// @nodoc


class _SecuritySettings implements SecuritySettings {
  const _SecuritySettings({this.biometric = false, required this.passwordUpdatedAt,  List<Device> devices = const <Device>[]}): _devices = devices;
  

@override@JsonKey() final  bool biometric;
@override final  DateTime passwordUpdatedAt;
 final  List<Device> _devices;
@override@JsonKey() List<Device> get devices {
  if (_devices is EqualUnmodifiableListView) return _devices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_devices);
}


/// Create a copy of SecuritySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecuritySettingsCopyWith<_SecuritySettings> get copyWith => __$SecuritySettingsCopyWithImpl<_SecuritySettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecuritySettings&&(identical(other.biometric, biometric) || other.biometric == biometric)&&(identical(other.passwordUpdatedAt, passwordUpdatedAt) || other.passwordUpdatedAt == passwordUpdatedAt)&&const DeepCollectionEquality().equals(other._devices, _devices));
}


@override
int get hashCode => Object.hash(runtimeType,biometric,passwordUpdatedAt,const DeepCollectionEquality().hash(_devices));

@override
String toString() {
  return 'SecuritySettings(biometric: $biometric, passwordUpdatedAt: $passwordUpdatedAt, devices: $devices)';
}


}

/// @nodoc
abstract mixin class _$SecuritySettingsCopyWith<$Res> implements $SecuritySettingsCopyWith<$Res> {
  factory _$SecuritySettingsCopyWith(_SecuritySettings value, $Res Function(_SecuritySettings) _then) = __$SecuritySettingsCopyWithImpl;
@override @useResult
$Res call({
 bool biometric, DateTime passwordUpdatedAt, List<Device> devices
});




}
/// @nodoc
class __$SecuritySettingsCopyWithImpl<$Res>
    implements _$SecuritySettingsCopyWith<$Res> {
  __$SecuritySettingsCopyWithImpl(this._self, this._then);

  final _SecuritySettings _self;
  final $Res Function(_SecuritySettings) _then;

/// Create a copy of SecuritySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? biometric = null,Object? passwordUpdatedAt = null,Object? devices = null,}) {
  return _then(_SecuritySettings(
biometric: null == biometric ? _self.biometric : biometric // ignore: cast_nullable_to_non_nullable
as bool,passwordUpdatedAt: null == passwordUpdatedAt ? _self.passwordUpdatedAt : passwordUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,devices: null == devices ? _self._devices : devices // ignore: cast_nullable_to_non_nullable
as List<Device>,
  ));
}


}

/// @nodoc
mixin _$NotificationPrefs {

 Map<NotifTopic, Set<NotifChannel>> get topics;
/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPrefsCopyWith<NotificationPrefs> get copyWith => _$NotificationPrefsCopyWithImpl<NotificationPrefs>(this as NotificationPrefs, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPrefs&&const DeepCollectionEquality().equals(other.topics, topics));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(topics));

@override
String toString() {
  return 'NotificationPrefs(topics: $topics)';
}


}

/// @nodoc
abstract mixin class $NotificationPrefsCopyWith<$Res>  {
  factory $NotificationPrefsCopyWith(NotificationPrefs value, $Res Function(NotificationPrefs) _then) = _$NotificationPrefsCopyWithImpl;
@useResult
$Res call({
 Map<NotifTopic, Set<NotifChannel>> topics
});




}
/// @nodoc
class _$NotificationPrefsCopyWithImpl<$Res>
    implements $NotificationPrefsCopyWith<$Res> {
  _$NotificationPrefsCopyWithImpl(this._self, this._then);

  final NotificationPrefs _self;
  final $Res Function(NotificationPrefs) _then;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topics = null,}) {
  return _then(NotificationPrefs(
topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as Map<NotifTopic, Set<NotifChannel>>,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPrefs].
extension NotificationPrefsPatterns on NotificationPrefs {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPrefs value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPrefs value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPrefs():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPrefs value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<NotifTopic, Set<NotifChannel>> topics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
return $default(_that.topics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<NotifTopic, Set<NotifChannel>> topics)  $default,) {final _that = this;
switch (_that) {
case _NotificationPrefs():
return $default(_that.topics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<NotifTopic, Set<NotifChannel>> topics)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
return $default(_that.topics);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationPrefs extends NotificationPrefs {
  const _NotificationPrefs({ Map<NotifTopic, Set<NotifChannel>> topics = const <NotifTopic, Set<NotifChannel>>{}}): _topics = topics,super._();
  

 final  Map<NotifTopic, Set<NotifChannel>> _topics;
@override@JsonKey() Map<NotifTopic, Set<NotifChannel>> get topics {
  if (_topics is EqualUnmodifiableMapView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_topics);
}


/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPrefsCopyWith<_NotificationPrefs> get copyWith => __$NotificationPrefsCopyWithImpl<_NotificationPrefs>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPrefs&&const DeepCollectionEquality().equals(other._topics, _topics));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_topics));

@override
String toString() {
  return 'NotificationPrefs(topics: $topics)';
}


}

/// @nodoc
abstract mixin class _$NotificationPrefsCopyWith<$Res> implements $NotificationPrefsCopyWith<$Res> {
  factory _$NotificationPrefsCopyWith(_NotificationPrefs value, $Res Function(_NotificationPrefs) _then) = __$NotificationPrefsCopyWithImpl;
@override @useResult
$Res call({
 Map<NotifTopic, Set<NotifChannel>> topics
});




}
/// @nodoc
class __$NotificationPrefsCopyWithImpl<$Res>
    implements _$NotificationPrefsCopyWith<$Res> {
  __$NotificationPrefsCopyWithImpl(this._self, this._then);

  final _NotificationPrefs _self;
  final $Res Function(_NotificationPrefs) _then;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topics = null,}) {
  return _then(_NotificationPrefs(
topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as Map<NotifTopic, Set<NotifChannel>>,
  ));
}


}

/// @nodoc
mixin _$PrivacySettings {

 bool get showProfileToHosts; bool get showNameInReviews; bool get locationAccess; bool get personalizedRecs;
/// Create a copy of PrivacySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrivacySettingsCopyWith<PrivacySettings> get copyWith => _$PrivacySettingsCopyWithImpl<PrivacySettings>(this as PrivacySettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrivacySettings&&(identical(other.showProfileToHosts, showProfileToHosts) || other.showProfileToHosts == showProfileToHosts)&&(identical(other.showNameInReviews, showNameInReviews) || other.showNameInReviews == showNameInReviews)&&(identical(other.locationAccess, locationAccess) || other.locationAccess == locationAccess)&&(identical(other.personalizedRecs, personalizedRecs) || other.personalizedRecs == personalizedRecs));
}


@override
int get hashCode => Object.hash(runtimeType,showProfileToHosts,showNameInReviews,locationAccess,personalizedRecs);

@override
String toString() {
  return 'PrivacySettings(showProfileToHosts: $showProfileToHosts, showNameInReviews: $showNameInReviews, locationAccess: $locationAccess, personalizedRecs: $personalizedRecs)';
}


}

/// @nodoc
abstract mixin class $PrivacySettingsCopyWith<$Res>  {
  factory $PrivacySettingsCopyWith(PrivacySettings value, $Res Function(PrivacySettings) _then) = _$PrivacySettingsCopyWithImpl;
@useResult
$Res call({
 bool showProfileToHosts, bool showNameInReviews, bool locationAccess, bool personalizedRecs
});




}
/// @nodoc
class _$PrivacySettingsCopyWithImpl<$Res>
    implements $PrivacySettingsCopyWith<$Res> {
  _$PrivacySettingsCopyWithImpl(this._self, this._then);

  final PrivacySettings _self;
  final $Res Function(PrivacySettings) _then;

/// Create a copy of PrivacySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showProfileToHosts = null,Object? showNameInReviews = null,Object? locationAccess = null,Object? personalizedRecs = null,}) {
  return _then(PrivacySettings(
showProfileToHosts: null == showProfileToHosts ? _self.showProfileToHosts : showProfileToHosts // ignore: cast_nullable_to_non_nullable
as bool,showNameInReviews: null == showNameInReviews ? _self.showNameInReviews : showNameInReviews // ignore: cast_nullable_to_non_nullable
as bool,locationAccess: null == locationAccess ? _self.locationAccess : locationAccess // ignore: cast_nullable_to_non_nullable
as bool,personalizedRecs: null == personalizedRecs ? _self.personalizedRecs : personalizedRecs // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PrivacySettings].
extension PrivacySettingsPatterns on PrivacySettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrivacySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrivacySettings value)  $default,){
final _that = this;
switch (_that) {
case _PrivacySettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrivacySettings value)?  $default,){
final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool showProfileToHosts,  bool showNameInReviews,  bool locationAccess,  bool personalizedRecs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
return $default(_that.showProfileToHosts,_that.showNameInReviews,_that.locationAccess,_that.personalizedRecs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool showProfileToHosts,  bool showNameInReviews,  bool locationAccess,  bool personalizedRecs)  $default,) {final _that = this;
switch (_that) {
case _PrivacySettings():
return $default(_that.showProfileToHosts,_that.showNameInReviews,_that.locationAccess,_that.personalizedRecs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool showProfileToHosts,  bool showNameInReviews,  bool locationAccess,  bool personalizedRecs)?  $default,) {final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
return $default(_that.showProfileToHosts,_that.showNameInReviews,_that.locationAccess,_that.personalizedRecs);case _:
  return null;

}
}

}

/// @nodoc


class _PrivacySettings implements PrivacySettings {
  const _PrivacySettings({this.showProfileToHosts = true, this.showNameInReviews = true, this.locationAccess = false, this.personalizedRecs = true});
  

@override@JsonKey() final  bool showProfileToHosts;
@override@JsonKey() final  bool showNameInReviews;
@override@JsonKey() final  bool locationAccess;
@override@JsonKey() final  bool personalizedRecs;

/// Create a copy of PrivacySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrivacySettingsCopyWith<_PrivacySettings> get copyWith => __$PrivacySettingsCopyWithImpl<_PrivacySettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrivacySettings&&(identical(other.showProfileToHosts, showProfileToHosts) || other.showProfileToHosts == showProfileToHosts)&&(identical(other.showNameInReviews, showNameInReviews) || other.showNameInReviews == showNameInReviews)&&(identical(other.locationAccess, locationAccess) || other.locationAccess == locationAccess)&&(identical(other.personalizedRecs, personalizedRecs) || other.personalizedRecs == personalizedRecs));
}


@override
int get hashCode => Object.hash(runtimeType,showProfileToHosts,showNameInReviews,locationAccess,personalizedRecs);

@override
String toString() {
  return 'PrivacySettings(showProfileToHosts: $showProfileToHosts, showNameInReviews: $showNameInReviews, locationAccess: $locationAccess, personalizedRecs: $personalizedRecs)';
}


}

/// @nodoc
abstract mixin class _$PrivacySettingsCopyWith<$Res> implements $PrivacySettingsCopyWith<$Res> {
  factory _$PrivacySettingsCopyWith(_PrivacySettings value, $Res Function(_PrivacySettings) _then) = __$PrivacySettingsCopyWithImpl;
@override @useResult
$Res call({
 bool showProfileToHosts, bool showNameInReviews, bool locationAccess, bool personalizedRecs
});




}
/// @nodoc
class __$PrivacySettingsCopyWithImpl<$Res>
    implements _$PrivacySettingsCopyWith<$Res> {
  __$PrivacySettingsCopyWithImpl(this._self, this._then);

  final _PrivacySettings _self;
  final $Res Function(_PrivacySettings) _then;

/// Create a copy of PrivacySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showProfileToHosts = null,Object? showNameInReviews = null,Object? locationAccess = null,Object? personalizedRecs = null,}) {
  return _then(_PrivacySettings(
showProfileToHosts: null == showProfileToHosts ? _self.showProfileToHosts : showProfileToHosts // ignore: cast_nullable_to_non_nullable
as bool,showNameInReviews: null == showNameInReviews ? _self.showNameInReviews : showNameInReviews // ignore: cast_nullable_to_non_nullable
as bool,locationAccess: null == locationAccess ? _self.locationAccess : locationAccess // ignore: cast_nullable_to_non_nullable
as bool,personalizedRecs: null == personalizedRecs ? _self.personalizedRecs : personalizedRecs // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$CloseAccountImpact {

/// "Göl Esintisi · 6–8 Kas" — varsa hesap kapatılamaz.
 String? get upcomingBooking; int get lists; int get savedListings;
/// Create a copy of CloseAccountImpact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CloseAccountImpactCopyWith<CloseAccountImpact> get copyWith => _$CloseAccountImpactCopyWithImpl<CloseAccountImpact>(this as CloseAccountImpact, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CloseAccountImpact&&(identical(other.upcomingBooking, upcomingBooking) || other.upcomingBooking == upcomingBooking)&&(identical(other.lists, lists) || other.lists == lists)&&(identical(other.savedListings, savedListings) || other.savedListings == savedListings));
}


@override
int get hashCode => Object.hash(runtimeType,upcomingBooking,lists,savedListings);

@override
String toString() {
  return 'CloseAccountImpact(upcomingBooking: $upcomingBooking, lists: $lists, savedListings: $savedListings)';
}


}

/// @nodoc
abstract mixin class $CloseAccountImpactCopyWith<$Res>  {
  factory $CloseAccountImpactCopyWith(CloseAccountImpact value, $Res Function(CloseAccountImpact) _then) = _$CloseAccountImpactCopyWithImpl;
@useResult
$Res call({
 String? upcomingBooking, int lists, int savedListings
});




}
/// @nodoc
class _$CloseAccountImpactCopyWithImpl<$Res>
    implements $CloseAccountImpactCopyWith<$Res> {
  _$CloseAccountImpactCopyWithImpl(this._self, this._then);

  final CloseAccountImpact _self;
  final $Res Function(CloseAccountImpact) _then;

/// Create a copy of CloseAccountImpact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? upcomingBooking = freezed,Object? lists = null,Object? savedListings = null,}) {
  return _then(CloseAccountImpact(
upcomingBooking: freezed == upcomingBooking ? _self.upcomingBooking : upcomingBooking // ignore: cast_nullable_to_non_nullable
as String?,lists: null == lists ? _self.lists : lists // ignore: cast_nullable_to_non_nullable
as int,savedListings: null == savedListings ? _self.savedListings : savedListings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CloseAccountImpact].
extension CloseAccountImpactPatterns on CloseAccountImpact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CloseAccountImpact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CloseAccountImpact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CloseAccountImpact value)  $default,){
final _that = this;
switch (_that) {
case _CloseAccountImpact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CloseAccountImpact value)?  $default,){
final _that = this;
switch (_that) {
case _CloseAccountImpact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? upcomingBooking,  int lists,  int savedListings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CloseAccountImpact() when $default != null:
return $default(_that.upcomingBooking,_that.lists,_that.savedListings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? upcomingBooking,  int lists,  int savedListings)  $default,) {final _that = this;
switch (_that) {
case _CloseAccountImpact():
return $default(_that.upcomingBooking,_that.lists,_that.savedListings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? upcomingBooking,  int lists,  int savedListings)?  $default,) {final _that = this;
switch (_that) {
case _CloseAccountImpact() when $default != null:
return $default(_that.upcomingBooking,_that.lists,_that.savedListings);case _:
  return null;

}
}

}

/// @nodoc


class _CloseAccountImpact implements CloseAccountImpact {
  const _CloseAccountImpact({this.upcomingBooking, required this.lists, required this.savedListings});
  

/// "Göl Esintisi · 6–8 Kas" — varsa hesap kapatılamaz.
@override final  String? upcomingBooking;
@override final  int lists;
@override final  int savedListings;

/// Create a copy of CloseAccountImpact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CloseAccountImpactCopyWith<_CloseAccountImpact> get copyWith => __$CloseAccountImpactCopyWithImpl<_CloseAccountImpact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CloseAccountImpact&&(identical(other.upcomingBooking, upcomingBooking) || other.upcomingBooking == upcomingBooking)&&(identical(other.lists, lists) || other.lists == lists)&&(identical(other.savedListings, savedListings) || other.savedListings == savedListings));
}


@override
int get hashCode => Object.hash(runtimeType,upcomingBooking,lists,savedListings);

@override
String toString() {
  return 'CloseAccountImpact(upcomingBooking: $upcomingBooking, lists: $lists, savedListings: $savedListings)';
}


}

/// @nodoc
abstract mixin class _$CloseAccountImpactCopyWith<$Res> implements $CloseAccountImpactCopyWith<$Res> {
  factory _$CloseAccountImpactCopyWith(_CloseAccountImpact value, $Res Function(_CloseAccountImpact) _then) = __$CloseAccountImpactCopyWithImpl;
@override @useResult
$Res call({
 String? upcomingBooking, int lists, int savedListings
});




}
/// @nodoc
class __$CloseAccountImpactCopyWithImpl<$Res>
    implements _$CloseAccountImpactCopyWith<$Res> {
  __$CloseAccountImpactCopyWithImpl(this._self, this._then);

  final _CloseAccountImpact _self;
  final $Res Function(_CloseAccountImpact) _then;

/// Create a copy of CloseAccountImpact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? upcomingBooking = freezed,Object? lists = null,Object? savedListings = null,}) {
  return _then(_CloseAccountImpact(
upcomingBooking: freezed == upcomingBooking ? _self.upcomingBooking : upcomingBooking // ignore: cast_nullable_to_non_nullable
as String?,lists: null == lists ? _self.lists : lists // ignore: cast_nullable_to_non_nullable
as int,savedListings: null == savedListings ? _self.savedListings : savedListings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$LegalDocument {

 LegalDoc get doc; DateTime get updatedAt;/// Paragraflar; başlıklar "## " ile başlar.
 List<String> get paragraphs;
/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalDocumentCopyWith<LegalDocument> get copyWith => _$LegalDocumentCopyWithImpl<LegalDocument>(this as LegalDocument, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalDocument&&(identical(other.doc, doc) || other.doc == doc)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.paragraphs, paragraphs));
}


@override
int get hashCode => Object.hash(runtimeType,doc,updatedAt,const DeepCollectionEquality().hash(paragraphs));

@override
String toString() {
  return 'LegalDocument(doc: $doc, updatedAt: $updatedAt, paragraphs: $paragraphs)';
}


}

/// @nodoc
abstract mixin class $LegalDocumentCopyWith<$Res>  {
  factory $LegalDocumentCopyWith(LegalDocument value, $Res Function(LegalDocument) _then) = _$LegalDocumentCopyWithImpl;
@useResult
$Res call({
 LegalDoc doc, DateTime updatedAt, List<String> paragraphs
});




}
/// @nodoc
class _$LegalDocumentCopyWithImpl<$Res>
    implements $LegalDocumentCopyWith<$Res> {
  _$LegalDocumentCopyWithImpl(this._self, this._then);

  final LegalDocument _self;
  final $Res Function(LegalDocument) _then;

/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? doc = null,Object? updatedAt = null,Object? paragraphs = null,}) {
  return _then(LegalDocument(
doc: null == doc ? _self.doc : doc // ignore: cast_nullable_to_non_nullable
as LegalDoc,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,paragraphs: null == paragraphs ? _self.paragraphs : paragraphs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [LegalDocument].
extension LegalDocumentPatterns on LegalDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LegalDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LegalDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LegalDocument value)  $default,){
final _that = this;
switch (_that) {
case _LegalDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LegalDocument value)?  $default,){
final _that = this;
switch (_that) {
case _LegalDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LegalDoc doc,  DateTime updatedAt,  List<String> paragraphs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LegalDocument() when $default != null:
return $default(_that.doc,_that.updatedAt,_that.paragraphs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LegalDoc doc,  DateTime updatedAt,  List<String> paragraphs)  $default,) {final _that = this;
switch (_that) {
case _LegalDocument():
return $default(_that.doc,_that.updatedAt,_that.paragraphs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LegalDoc doc,  DateTime updatedAt,  List<String> paragraphs)?  $default,) {final _that = this;
switch (_that) {
case _LegalDocument() when $default != null:
return $default(_that.doc,_that.updatedAt,_that.paragraphs);case _:
  return null;

}
}

}

/// @nodoc


class _LegalDocument implements LegalDocument {
  const _LegalDocument({required this.doc, required this.updatedAt, required  List<String> paragraphs}): _paragraphs = paragraphs;
  

@override final  LegalDoc doc;
@override final  DateTime updatedAt;
/// Paragraflar; başlıklar "## " ile başlar.
 final  List<String> _paragraphs;
/// Paragraflar; başlıklar "## " ile başlar.
@override List<String> get paragraphs {
  if (_paragraphs is EqualUnmodifiableListView) return _paragraphs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paragraphs);
}


/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalDocumentCopyWith<_LegalDocument> get copyWith => __$LegalDocumentCopyWithImpl<_LegalDocument>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalDocument&&(identical(other.doc, doc) || other.doc == doc)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._paragraphs, _paragraphs));
}


@override
int get hashCode => Object.hash(runtimeType,doc,updatedAt,const DeepCollectionEquality().hash(_paragraphs));

@override
String toString() {
  return 'LegalDocument(doc: $doc, updatedAt: $updatedAt, paragraphs: $paragraphs)';
}


}

/// @nodoc
abstract mixin class _$LegalDocumentCopyWith<$Res> implements $LegalDocumentCopyWith<$Res> {
  factory _$LegalDocumentCopyWith(_LegalDocument value, $Res Function(_LegalDocument) _then) = __$LegalDocumentCopyWithImpl;
@override @useResult
$Res call({
 LegalDoc doc, DateTime updatedAt, List<String> paragraphs
});




}
/// @nodoc
class __$LegalDocumentCopyWithImpl<$Res>
    implements _$LegalDocumentCopyWith<$Res> {
  __$LegalDocumentCopyWithImpl(this._self, this._then);

  final _LegalDocument _self;
  final $Res Function(_LegalDocument) _then;

/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? doc = null,Object? updatedAt = null,Object? paragraphs = null,}) {
  return _then(_LegalDocument(
doc: null == doc ? _self.doc : doc // ignore: cast_nullable_to_non_nullable
as LegalDoc,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,paragraphs: null == paragraphs ? _self._paragraphs : paragraphs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$FaqItem {

 String get id; String get question; String get answer;
/// Create a copy of FaqItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaqItemCopyWith<FaqItem> get copyWith => _$FaqItemCopyWithImpl<FaqItem>(this as FaqItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaqItem&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}


@override
int get hashCode => Object.hash(runtimeType,id,question,answer);

@override
String toString() {
  return 'FaqItem(id: $id, question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $FaqItemCopyWith<$Res>  {
  factory $FaqItemCopyWith(FaqItem value, $Res Function(FaqItem) _then) = _$FaqItemCopyWithImpl;
@useResult
$Res call({
 String id, String question, String answer
});




}
/// @nodoc
class _$FaqItemCopyWithImpl<$Res>
    implements $FaqItemCopyWith<$Res> {
  _$FaqItemCopyWithImpl(this._self, this._then);

  final FaqItem _self;
  final $Res Function(FaqItem) _then;

/// Create a copy of FaqItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? question = null,Object? answer = null,}) {
  return _then(FaqItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FaqItem].
extension FaqItemPatterns on FaqItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FaqItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FaqItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FaqItem value)  $default,){
final _that = this;
switch (_that) {
case _FaqItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FaqItem value)?  $default,){
final _that = this;
switch (_that) {
case _FaqItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String question,  String answer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FaqItem() when $default != null:
return $default(_that.id,_that.question,_that.answer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String question,  String answer)  $default,) {final _that = this;
switch (_that) {
case _FaqItem():
return $default(_that.id,_that.question,_that.answer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String question,  String answer)?  $default,) {final _that = this;
switch (_that) {
case _FaqItem() when $default != null:
return $default(_that.id,_that.question,_that.answer);case _:
  return null;

}
}

}

/// @nodoc


class _FaqItem implements FaqItem {
  const _FaqItem({required this.id, required this.question, required this.answer});
  

@override final  String id;
@override final  String question;
@override final  String answer;

/// Create a copy of FaqItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaqItemCopyWith<_FaqItem> get copyWith => __$FaqItemCopyWithImpl<_FaqItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaqItem&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}


@override
int get hashCode => Object.hash(runtimeType,id,question,answer);

@override
String toString() {
  return 'FaqItem(id: $id, question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$FaqItemCopyWith<$Res> implements $FaqItemCopyWith<$Res> {
  factory _$FaqItemCopyWith(_FaqItem value, $Res Function(_FaqItem) _then) = __$FaqItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String question, String answer
});




}
/// @nodoc
class __$FaqItemCopyWithImpl<$Res>
    implements _$FaqItemCopyWith<$Res> {
  __$FaqItemCopyWithImpl(this._self, this._then);

  final _FaqItem _self;
  final $Res Function(_FaqItem) _then;

/// Create a copy of FaqItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? question = null,Object? answer = null,}) {
  return _then(_FaqItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
