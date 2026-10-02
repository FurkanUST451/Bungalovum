// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BedCount {

 BedType get type; int get count;
/// Create a copy of BedCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BedCountCopyWith<BedCount> get copyWith => _$BedCountCopyWithImpl<BedCount>(this as BedCount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BedCount&&(identical(other.type, type) || other.type == type)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,type,count);

@override
String toString() {
  return 'BedCount(type: $type, count: $count)';
}


}

/// @nodoc
abstract mixin class $BedCountCopyWith<$Res>  {
  factory $BedCountCopyWith(BedCount value, $Res Function(BedCount) _then) = _$BedCountCopyWithImpl;
@useResult
$Res call({
 BedType type, int count
});




}
/// @nodoc
class _$BedCountCopyWithImpl<$Res>
    implements $BedCountCopyWith<$Res> {
  _$BedCountCopyWithImpl(this._self, this._then);

  final BedCount _self;
  final $Res Function(BedCount) _then;

/// Create a copy of BedCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? count = null,}) {
  return _then(BedCount(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BedType,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BedCount].
extension BedCountPatterns on BedCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BedCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BedCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BedCount value)  $default,){
final _that = this;
switch (_that) {
case _BedCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BedCount value)?  $default,){
final _that = this;
switch (_that) {
case _BedCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BedType type,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BedCount() when $default != null:
return $default(_that.type,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BedType type,  int count)  $default,) {final _that = this;
switch (_that) {
case _BedCount():
return $default(_that.type,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BedType type,  int count)?  $default,) {final _that = this;
switch (_that) {
case _BedCount() when $default != null:
return $default(_that.type,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _BedCount implements BedCount {
  const _BedCount({required this.type, required this.count});
  

@override final  BedType type;
@override final  int count;

/// Create a copy of BedCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BedCountCopyWith<_BedCount> get copyWith => __$BedCountCopyWithImpl<_BedCount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BedCount&&(identical(other.type, type) || other.type == type)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,type,count);

@override
String toString() {
  return 'BedCount(type: $type, count: $count)';
}


}

/// @nodoc
abstract mixin class _$BedCountCopyWith<$Res> implements $BedCountCopyWith<$Res> {
  factory _$BedCountCopyWith(_BedCount value, $Res Function(_BedCount) _then) = __$BedCountCopyWithImpl;
@override @useResult
$Res call({
 BedType type, int count
});




}
/// @nodoc
class __$BedCountCopyWithImpl<$Res>
    implements _$BedCountCopyWith<$Res> {
  __$BedCountCopyWithImpl(this._self, this._then);

  final _BedCount _self;
  final $Res Function(_BedCount) _then;

/// Create a copy of BedCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? count = null,}) {
  return _then(_BedCount(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BedType,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$HostDocument {

 String get id; DocStatus get status;
/// Create a copy of HostDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HostDocumentCopyWith<HostDocument> get copyWith => _$HostDocumentCopyWithImpl<HostDocument>(this as HostDocument, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HostDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,status);

@override
String toString() {
  return 'HostDocument(id: $id, status: $status)';
}


}

/// @nodoc
abstract mixin class $HostDocumentCopyWith<$Res>  {
  factory $HostDocumentCopyWith(HostDocument value, $Res Function(HostDocument) _then) = _$HostDocumentCopyWithImpl;
@useResult
$Res call({
 String id, DocStatus status
});




}
/// @nodoc
class _$HostDocumentCopyWithImpl<$Res>
    implements $HostDocumentCopyWith<$Res> {
  _$HostDocumentCopyWithImpl(this._self, this._then);

  final HostDocument _self;
  final $Res Function(HostDocument) _then;

/// Create a copy of HostDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,}) {
  return _then(HostDocument(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [HostDocument].
extension HostDocumentPatterns on HostDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HostDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HostDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HostDocument value)  $default,){
final _that = this;
switch (_that) {
case _HostDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HostDocument value)?  $default,){
final _that = this;
switch (_that) {
case _HostDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DocStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HostDocument() when $default != null:
return $default(_that.id,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DocStatus status)  $default,) {final _that = this;
switch (_that) {
case _HostDocument():
return $default(_that.id,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DocStatus status)?  $default,) {final _that = this;
switch (_that) {
case _HostDocument() when $default != null:
return $default(_that.id,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _HostDocument implements HostDocument {
  const _HostDocument({required this.id, this.status = DocStatus.uploaded});
  

@override final  String id;
@override@JsonKey() final  DocStatus status;

/// Create a copy of HostDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HostDocumentCopyWith<_HostDocument> get copyWith => __$HostDocumentCopyWithImpl<_HostDocument>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HostDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,status);

@override
String toString() {
  return 'HostDocument(id: $id, status: $status)';
}


}

/// @nodoc
abstract mixin class _$HostDocumentCopyWith<$Res> implements $HostDocumentCopyWith<$Res> {
  factory _$HostDocumentCopyWith(_HostDocument value, $Res Function(_HostDocument) _then) = __$HostDocumentCopyWithImpl;
@override @useResult
$Res call({
 String id, DocStatus status
});




}
/// @nodoc
class __$HostDocumentCopyWithImpl<$Res>
    implements _$HostDocumentCopyWith<$Res> {
  __$HostDocumentCopyWithImpl(this._self, this._then);

  final _HostDocument _self;
  final $Res Function(_HostDocument) _then;

/// Create a copy of HostDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,}) {
  return _then(_HostDocument(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocStatus,
  ));
}


}

/// @nodoc
mixin _$DraftPhoto {

 String get id; RoomKind get room; String get url;
/// Create a copy of DraftPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftPhotoCopyWith<DraftPhoto> get copyWith => _$DraftPhotoCopyWithImpl<DraftPhoto>(this as DraftPhoto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.room, room) || other.room == room)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,id,room,url);

@override
String toString() {
  return 'DraftPhoto(id: $id, room: $room, url: $url)';
}


}

/// @nodoc
abstract mixin class $DraftPhotoCopyWith<$Res>  {
  factory $DraftPhotoCopyWith(DraftPhoto value, $Res Function(DraftPhoto) _then) = _$DraftPhotoCopyWithImpl;
@useResult
$Res call({
 String id, RoomKind room, String url
});




}
/// @nodoc
class _$DraftPhotoCopyWithImpl<$Res>
    implements $DraftPhotoCopyWith<$Res> {
  _$DraftPhotoCopyWithImpl(this._self, this._then);

  final DraftPhoto _self;
  final $Res Function(DraftPhoto) _then;

/// Create a copy of DraftPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? room = null,Object? url = null,}) {
  return _then(DraftPhoto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,room: null == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as RoomKind,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftPhoto].
extension DraftPhotoPatterns on DraftPhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftPhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftPhoto value)  $default,){
final _that = this;
switch (_that) {
case _DraftPhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _DraftPhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  RoomKind room,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftPhoto() when $default != null:
return $default(_that.id,_that.room,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  RoomKind room,  String url)  $default,) {final _that = this;
switch (_that) {
case _DraftPhoto():
return $default(_that.id,_that.room,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  RoomKind room,  String url)?  $default,) {final _that = this;
switch (_that) {
case _DraftPhoto() when $default != null:
return $default(_that.id,_that.room,_that.url);case _:
  return null;

}
}

}

/// @nodoc


class _DraftPhoto implements DraftPhoto {
  const _DraftPhoto({required this.id, required this.room, required this.url});
  

@override final  String id;
@override final  RoomKind room;
@override final  String url;

/// Create a copy of DraftPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftPhotoCopyWith<_DraftPhoto> get copyWith => __$DraftPhotoCopyWithImpl<_DraftPhoto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.room, room) || other.room == room)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,id,room,url);

@override
String toString() {
  return 'DraftPhoto(id: $id, room: $room, url: $url)';
}


}

/// @nodoc
abstract mixin class _$DraftPhotoCopyWith<$Res> implements $DraftPhotoCopyWith<$Res> {
  factory _$DraftPhotoCopyWith(_DraftPhoto value, $Res Function(_DraftPhoto) _then) = __$DraftPhotoCopyWithImpl;
@override @useResult
$Res call({
 String id, RoomKind room, String url
});




}
/// @nodoc
class __$DraftPhotoCopyWithImpl<$Res>
    implements _$DraftPhotoCopyWith<$Res> {
  __$DraftPhotoCopyWithImpl(this._self, this._then);

  final _DraftPhoto _self;
  final $Res Function(_DraftPhoto) _then;

/// Create a copy of DraftPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? room = null,Object? url = null,}) {
  return _then(_DraftPhoto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,room: null == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as RoomKind,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ListingDraft {

 String get id; ListingStatus get status;/// Kaydet ve çık sonrası devam edilecek adım.
 WizardStep get resumeStep; DateTime? get submittedAt;/// Yayındaki ilanda yeniden incelemeye giren bölümler.
 Set<WizardStep> get sectionsInReview; PropertyType? get propertyType; Set<ListingSetting> get settings; String get address; String get city; String get district; double? get latitude; double? get longitude; int get maxGuests; int get bedrooms; int get beds; int get bathrooms; List<BedCount> get bedTypes; int? get indoorM2; int? get gardenM2;/// Bungalovun tamamı misafire mi ait (false: bahçe ortak).
 bool get wholePlace; bool get hasPool; bool get poolPrivate; bool get poolHeated; int? get poolTempC; double? get poolWidthM; double? get poolLengthM; double? get poolDepthMinM; double? get poolDepthMaxM; int? get poolSeasonStart; int? get poolSeasonEnd; Set<AmenityKind> get amenities; List<DraftPhoto> get photos; String? get coverPhotoId; String get title; Set<HighlightTag> get highlights; String get space; String get guestAccess; String get otherNotes; Set<SafetyKind> get safety; String get outdoorCameraNote; bool get poolNoLifeguardAck; bool get poolDepthMarked; String get checkInFrom; String get checkOutBy; bool get petsAllowed; bool get smokingAllowed; bool get eventsAllowed; bool get quietHours; String get quietFrom; String get quietTo; int? get nightlyPrice; int? get weekendPrice; int get cleaningFee; int get weeklyDiscountPercent; int get minNights; bool get instantBook; CancellationPolicy get cancellation; SelfCheckIn get checkInMethod; String get lockboxCode; String get lockboxHint; String get wifiName; String get wifiPassword; String get poolInstructions; String get houseInstructions; List<String> get checkoutTasks; PermitType? get permitType; String get permitNo; Map<HostDocKind, HostDocument> get documents; bool get multiUnitParcel; bool get onBehalfOfOwner; bool get kbsDeclaration; bool get permitHolderDeclaration; bool get updateDeclaration; TaxType get taxType;/// TCKN (şahıs) ya da vergi no (şirket). Ekranda maskeli gösterilir.
 String get taxId; String get taxOffice; Set<IdentityStep> get identityDone;/// Kimlik doğrulamasından gelen ad soyad; IBAN sahibi bununla eşleşmeli.
 String? get verifiedName; String get accountHolder; String get iban; String get billingAddress; String get emergencyPhone; bool get reachableDuringStay; bool get accuracyConsent; bool get agreementConsent; bool get ministryConsent;
/// Create a copy of ListingDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingDraftCopyWith<ListingDraft> get copyWith => _$ListingDraftCopyWithImpl<ListingDraft>(this as ListingDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListingDraft&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.resumeStep, resumeStep) || other.resumeStep == resumeStep)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&const DeepCollectionEquality().equals(other.sectionsInReview, sectionsInReview)&&(identical(other.propertyType, propertyType) || other.propertyType == propertyType)&&const DeepCollectionEquality().equals(other.settings, settings)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.district, district) || other.district == district)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.maxGuests, maxGuests) || other.maxGuests == maxGuests)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.beds, beds) || other.beds == beds)&&(identical(other.bathrooms, bathrooms) || other.bathrooms == bathrooms)&&const DeepCollectionEquality().equals(other.bedTypes, bedTypes)&&(identical(other.indoorM2, indoorM2) || other.indoorM2 == indoorM2)&&(identical(other.gardenM2, gardenM2) || other.gardenM2 == gardenM2)&&(identical(other.wholePlace, wholePlace) || other.wholePlace == wholePlace)&&(identical(other.hasPool, hasPool) || other.hasPool == hasPool)&&(identical(other.poolPrivate, poolPrivate) || other.poolPrivate == poolPrivate)&&(identical(other.poolHeated, poolHeated) || other.poolHeated == poolHeated)&&(identical(other.poolTempC, poolTempC) || other.poolTempC == poolTempC)&&(identical(other.poolWidthM, poolWidthM) || other.poolWidthM == poolWidthM)&&(identical(other.poolLengthM, poolLengthM) || other.poolLengthM == poolLengthM)&&(identical(other.poolDepthMinM, poolDepthMinM) || other.poolDepthMinM == poolDepthMinM)&&(identical(other.poolDepthMaxM, poolDepthMaxM) || other.poolDepthMaxM == poolDepthMaxM)&&(identical(other.poolSeasonStart, poolSeasonStart) || other.poolSeasonStart == poolSeasonStart)&&(identical(other.poolSeasonEnd, poolSeasonEnd) || other.poolSeasonEnd == poolSeasonEnd)&&const DeepCollectionEquality().equals(other.amenities, amenities)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.coverPhotoId, coverPhotoId) || other.coverPhotoId == coverPhotoId)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.highlights, highlights)&&(identical(other.space, space) || other.space == space)&&(identical(other.guestAccess, guestAccess) || other.guestAccess == guestAccess)&&(identical(other.otherNotes, otherNotes) || other.otherNotes == otherNotes)&&const DeepCollectionEquality().equals(other.safety, safety)&&(identical(other.outdoorCameraNote, outdoorCameraNote) || other.outdoorCameraNote == outdoorCameraNote)&&(identical(other.poolNoLifeguardAck, poolNoLifeguardAck) || other.poolNoLifeguardAck == poolNoLifeguardAck)&&(identical(other.poolDepthMarked, poolDepthMarked) || other.poolDepthMarked == poolDepthMarked)&&(identical(other.checkInFrom, checkInFrom) || other.checkInFrom == checkInFrom)&&(identical(other.checkOutBy, checkOutBy) || other.checkOutBy == checkOutBy)&&(identical(other.petsAllowed, petsAllowed) || other.petsAllowed == petsAllowed)&&(identical(other.smokingAllowed, smokingAllowed) || other.smokingAllowed == smokingAllowed)&&(identical(other.eventsAllowed, eventsAllowed) || other.eventsAllowed == eventsAllowed)&&(identical(other.quietHours, quietHours) || other.quietHours == quietHours)&&(identical(other.quietFrom, quietFrom) || other.quietFrom == quietFrom)&&(identical(other.quietTo, quietTo) || other.quietTo == quietTo)&&(identical(other.nightlyPrice, nightlyPrice) || other.nightlyPrice == nightlyPrice)&&(identical(other.weekendPrice, weekendPrice) || other.weekendPrice == weekendPrice)&&(identical(other.cleaningFee, cleaningFee) || other.cleaningFee == cleaningFee)&&(identical(other.weeklyDiscountPercent, weeklyDiscountPercent) || other.weeklyDiscountPercent == weeklyDiscountPercent)&&(identical(other.minNights, minNights) || other.minNights == minNights)&&(identical(other.instantBook, instantBook) || other.instantBook == instantBook)&&(identical(other.cancellation, cancellation) || other.cancellation == cancellation)&&(identical(other.checkInMethod, checkInMethod) || other.checkInMethod == checkInMethod)&&(identical(other.lockboxCode, lockboxCode) || other.lockboxCode == lockboxCode)&&(identical(other.lockboxHint, lockboxHint) || other.lockboxHint == lockboxHint)&&(identical(other.wifiName, wifiName) || other.wifiName == wifiName)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword)&&(identical(other.poolInstructions, poolInstructions) || other.poolInstructions == poolInstructions)&&(identical(other.houseInstructions, houseInstructions) || other.houseInstructions == houseInstructions)&&const DeepCollectionEquality().equals(other.checkoutTasks, checkoutTasks)&&(identical(other.permitType, permitType) || other.permitType == permitType)&&(identical(other.permitNo, permitNo) || other.permitNo == permitNo)&&const DeepCollectionEquality().equals(other.documents, documents)&&(identical(other.multiUnitParcel, multiUnitParcel) || other.multiUnitParcel == multiUnitParcel)&&(identical(other.onBehalfOfOwner, onBehalfOfOwner) || other.onBehalfOfOwner == onBehalfOfOwner)&&(identical(other.kbsDeclaration, kbsDeclaration) || other.kbsDeclaration == kbsDeclaration)&&(identical(other.permitHolderDeclaration, permitHolderDeclaration) || other.permitHolderDeclaration == permitHolderDeclaration)&&(identical(other.updateDeclaration, updateDeclaration) || other.updateDeclaration == updateDeclaration)&&(identical(other.taxType, taxType) || other.taxType == taxType)&&(identical(other.taxId, taxId) || other.taxId == taxId)&&(identical(other.taxOffice, taxOffice) || other.taxOffice == taxOffice)&&const DeepCollectionEquality().equals(other.identityDone, identityDone)&&(identical(other.verifiedName, verifiedName) || other.verifiedName == verifiedName)&&(identical(other.accountHolder, accountHolder) || other.accountHolder == accountHolder)&&(identical(other.iban, iban) || other.iban == iban)&&(identical(other.billingAddress, billingAddress) || other.billingAddress == billingAddress)&&(identical(other.emergencyPhone, emergencyPhone) || other.emergencyPhone == emergencyPhone)&&(identical(other.reachableDuringStay, reachableDuringStay) || other.reachableDuringStay == reachableDuringStay)&&(identical(other.accuracyConsent, accuracyConsent) || other.accuracyConsent == accuracyConsent)&&(identical(other.agreementConsent, agreementConsent) || other.agreementConsent == agreementConsent)&&(identical(other.ministryConsent, ministryConsent) || other.ministryConsent == ministryConsent));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,status,resumeStep,submittedAt,const DeepCollectionEquality().hash(sectionsInReview),propertyType,const DeepCollectionEquality().hash(settings),address,city,district,latitude,longitude,maxGuests,bedrooms,beds,bathrooms,const DeepCollectionEquality().hash(bedTypes),indoorM2,gardenM2,wholePlace,hasPool,poolPrivate,poolHeated,poolTempC,poolWidthM,poolLengthM,poolDepthMinM,poolDepthMaxM,poolSeasonStart,poolSeasonEnd,const DeepCollectionEquality().hash(amenities),const DeepCollectionEquality().hash(photos),coverPhotoId,title,const DeepCollectionEquality().hash(highlights),space,guestAccess,otherNotes,const DeepCollectionEquality().hash(safety),outdoorCameraNote,poolNoLifeguardAck,poolDepthMarked,checkInFrom,checkOutBy,petsAllowed,smokingAllowed,eventsAllowed,quietHours,quietFrom,quietTo,nightlyPrice,weekendPrice,cleaningFee,weeklyDiscountPercent,minNights,instantBook,cancellation,checkInMethod,lockboxCode,lockboxHint,wifiName,wifiPassword,poolInstructions,houseInstructions,const DeepCollectionEquality().hash(checkoutTasks),permitType,permitNo,const DeepCollectionEquality().hash(documents),multiUnitParcel,onBehalfOfOwner,kbsDeclaration,permitHolderDeclaration,updateDeclaration,taxType,taxId,taxOffice,const DeepCollectionEquality().hash(identityDone),verifiedName,accountHolder,iban,billingAddress,emergencyPhone,reachableDuringStay,accuracyConsent,agreementConsent,ministryConsent]);

@override
String toString() {
  return 'ListingDraft(id: $id, status: $status, resumeStep: $resumeStep, submittedAt: $submittedAt, sectionsInReview: $sectionsInReview, propertyType: $propertyType, settings: $settings, address: $address, city: $city, district: $district, latitude: $latitude, longitude: $longitude, maxGuests: $maxGuests, bedrooms: $bedrooms, beds: $beds, bathrooms: $bathrooms, bedTypes: $bedTypes, indoorM2: $indoorM2, gardenM2: $gardenM2, wholePlace: $wholePlace, hasPool: $hasPool, poolPrivate: $poolPrivate, poolHeated: $poolHeated, poolTempC: $poolTempC, poolWidthM: $poolWidthM, poolLengthM: $poolLengthM, poolDepthMinM: $poolDepthMinM, poolDepthMaxM: $poolDepthMaxM, poolSeasonStart: $poolSeasonStart, poolSeasonEnd: $poolSeasonEnd, amenities: $amenities, photos: $photos, coverPhotoId: $coverPhotoId, title: $title, highlights: $highlights, space: $space, guestAccess: $guestAccess, otherNotes: $otherNotes, safety: $safety, outdoorCameraNote: $outdoorCameraNote, poolNoLifeguardAck: $poolNoLifeguardAck, poolDepthMarked: $poolDepthMarked, checkInFrom: $checkInFrom, checkOutBy: $checkOutBy, petsAllowed: $petsAllowed, smokingAllowed: $smokingAllowed, eventsAllowed: $eventsAllowed, quietHours: $quietHours, quietFrom: $quietFrom, quietTo: $quietTo, nightlyPrice: $nightlyPrice, weekendPrice: $weekendPrice, cleaningFee: $cleaningFee, weeklyDiscountPercent: $weeklyDiscountPercent, minNights: $minNights, instantBook: $instantBook, cancellation: $cancellation, checkInMethod: $checkInMethod, lockboxCode: $lockboxCode, lockboxHint: $lockboxHint, wifiName: $wifiName, wifiPassword: $wifiPassword, poolInstructions: $poolInstructions, houseInstructions: $houseInstructions, checkoutTasks: $checkoutTasks, permitType: $permitType, permitNo: $permitNo, documents: $documents, multiUnitParcel: $multiUnitParcel, onBehalfOfOwner: $onBehalfOfOwner, kbsDeclaration: $kbsDeclaration, permitHolderDeclaration: $permitHolderDeclaration, updateDeclaration: $updateDeclaration, taxType: $taxType, taxId: $taxId, taxOffice: $taxOffice, identityDone: $identityDone, verifiedName: $verifiedName, accountHolder: $accountHolder, iban: $iban, billingAddress: $billingAddress, emergencyPhone: $emergencyPhone, reachableDuringStay: $reachableDuringStay, accuracyConsent: $accuracyConsent, agreementConsent: $agreementConsent, ministryConsent: $ministryConsent)';
}


}

/// @nodoc
abstract mixin class $ListingDraftCopyWith<$Res>  {
  factory $ListingDraftCopyWith(ListingDraft value, $Res Function(ListingDraft) _then) = _$ListingDraftCopyWithImpl;
@useResult
$Res call({
 String id, ListingStatus status, WizardStep resumeStep, DateTime? submittedAt, Set<WizardStep> sectionsInReview, PropertyType? propertyType, Set<ListingSetting> settings, String address, String city, String district, double? latitude, double? longitude, int maxGuests, int bedrooms, int beds, int bathrooms, List<BedCount> bedTypes, int? indoorM2, int? gardenM2, bool wholePlace, bool hasPool, bool poolPrivate, bool poolHeated, int? poolTempC, double? poolWidthM, double? poolLengthM, double? poolDepthMinM, double? poolDepthMaxM, int? poolSeasonStart, int? poolSeasonEnd, Set<AmenityKind> amenities, List<DraftPhoto> photos, String? coverPhotoId, String title, Set<HighlightTag> highlights, String space, String guestAccess, String otherNotes, Set<SafetyKind> safety, String outdoorCameraNote, bool poolNoLifeguardAck, bool poolDepthMarked, String checkInFrom, String checkOutBy, bool petsAllowed, bool smokingAllowed, bool eventsAllowed, bool quietHours, String quietFrom, String quietTo, int? nightlyPrice, int? weekendPrice, int cleaningFee, int weeklyDiscountPercent, int minNights, bool instantBook, CancellationPolicy cancellation, SelfCheckIn checkInMethod, String lockboxCode, String lockboxHint, String wifiName, String wifiPassword, String poolInstructions, String houseInstructions, List<String> checkoutTasks, PermitType? permitType, String permitNo, Map<HostDocKind, HostDocument> documents, bool multiUnitParcel, bool onBehalfOfOwner, bool kbsDeclaration, bool permitHolderDeclaration, bool updateDeclaration, TaxType taxType, String taxId, String taxOffice, Set<IdentityStep> identityDone, String? verifiedName, String accountHolder, String iban, String billingAddress, String emergencyPhone, bool reachableDuringStay, bool accuracyConsent, bool agreementConsent, bool ministryConsent
});




}
/// @nodoc
class _$ListingDraftCopyWithImpl<$Res>
    implements $ListingDraftCopyWith<$Res> {
  _$ListingDraftCopyWithImpl(this._self, this._then);

  final ListingDraft _self;
  final $Res Function(ListingDraft) _then;

/// Create a copy of ListingDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? resumeStep = null,Object? submittedAt = freezed,Object? sectionsInReview = null,Object? propertyType = freezed,Object? settings = null,Object? address = null,Object? city = null,Object? district = null,Object? latitude = freezed,Object? longitude = freezed,Object? maxGuests = null,Object? bedrooms = null,Object? beds = null,Object? bathrooms = null,Object? bedTypes = null,Object? indoorM2 = freezed,Object? gardenM2 = freezed,Object? wholePlace = null,Object? hasPool = null,Object? poolPrivate = null,Object? poolHeated = null,Object? poolTempC = freezed,Object? poolWidthM = freezed,Object? poolLengthM = freezed,Object? poolDepthMinM = freezed,Object? poolDepthMaxM = freezed,Object? poolSeasonStart = freezed,Object? poolSeasonEnd = freezed,Object? amenities = null,Object? photos = null,Object? coverPhotoId = freezed,Object? title = null,Object? highlights = null,Object? space = null,Object? guestAccess = null,Object? otherNotes = null,Object? safety = null,Object? outdoorCameraNote = null,Object? poolNoLifeguardAck = null,Object? poolDepthMarked = null,Object? checkInFrom = null,Object? checkOutBy = null,Object? petsAllowed = null,Object? smokingAllowed = null,Object? eventsAllowed = null,Object? quietHours = null,Object? quietFrom = null,Object? quietTo = null,Object? nightlyPrice = freezed,Object? weekendPrice = freezed,Object? cleaningFee = null,Object? weeklyDiscountPercent = null,Object? minNights = null,Object? instantBook = null,Object? cancellation = null,Object? checkInMethod = null,Object? lockboxCode = null,Object? lockboxHint = null,Object? wifiName = null,Object? wifiPassword = null,Object? poolInstructions = null,Object? houseInstructions = null,Object? checkoutTasks = null,Object? permitType = freezed,Object? permitNo = null,Object? documents = null,Object? multiUnitParcel = null,Object? onBehalfOfOwner = null,Object? kbsDeclaration = null,Object? permitHolderDeclaration = null,Object? updateDeclaration = null,Object? taxType = null,Object? taxId = null,Object? taxOffice = null,Object? identityDone = null,Object? verifiedName = freezed,Object? accountHolder = null,Object? iban = null,Object? billingAddress = null,Object? emergencyPhone = null,Object? reachableDuringStay = null,Object? accuracyConsent = null,Object? agreementConsent = null,Object? ministryConsent = null,}) {
  return _then(ListingDraft(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ListingStatus,resumeStep: null == resumeStep ? _self.resumeStep : resumeStep // ignore: cast_nullable_to_non_nullable
as WizardStep,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sectionsInReview: null == sectionsInReview ? _self.sectionsInReview : sectionsInReview // ignore: cast_nullable_to_non_nullable
as Set<WizardStep>,propertyType: freezed == propertyType ? _self.propertyType : propertyType // ignore: cast_nullable_to_non_nullable
as PropertyType?,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as Set<ListingSetting>,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,maxGuests: null == maxGuests ? _self.maxGuests : maxGuests // ignore: cast_nullable_to_non_nullable
as int,bedrooms: null == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int,beds: null == beds ? _self.beds : beds // ignore: cast_nullable_to_non_nullable
as int,bathrooms: null == bathrooms ? _self.bathrooms : bathrooms // ignore: cast_nullable_to_non_nullable
as int,bedTypes: null == bedTypes ? _self.bedTypes : bedTypes // ignore: cast_nullable_to_non_nullable
as List<BedCount>,indoorM2: freezed == indoorM2 ? _self.indoorM2 : indoorM2 // ignore: cast_nullable_to_non_nullable
as int?,gardenM2: freezed == gardenM2 ? _self.gardenM2 : gardenM2 // ignore: cast_nullable_to_non_nullable
as int?,wholePlace: null == wholePlace ? _self.wholePlace : wholePlace // ignore: cast_nullable_to_non_nullable
as bool,hasPool: null == hasPool ? _self.hasPool : hasPool // ignore: cast_nullable_to_non_nullable
as bool,poolPrivate: null == poolPrivate ? _self.poolPrivate : poolPrivate // ignore: cast_nullable_to_non_nullable
as bool,poolHeated: null == poolHeated ? _self.poolHeated : poolHeated // ignore: cast_nullable_to_non_nullable
as bool,poolTempC: freezed == poolTempC ? _self.poolTempC : poolTempC // ignore: cast_nullable_to_non_nullable
as int?,poolWidthM: freezed == poolWidthM ? _self.poolWidthM : poolWidthM // ignore: cast_nullable_to_non_nullable
as double?,poolLengthM: freezed == poolLengthM ? _self.poolLengthM : poolLengthM // ignore: cast_nullable_to_non_nullable
as double?,poolDepthMinM: freezed == poolDepthMinM ? _self.poolDepthMinM : poolDepthMinM // ignore: cast_nullable_to_non_nullable
as double?,poolDepthMaxM: freezed == poolDepthMaxM ? _self.poolDepthMaxM : poolDepthMaxM // ignore: cast_nullable_to_non_nullable
as double?,poolSeasonStart: freezed == poolSeasonStart ? _self.poolSeasonStart : poolSeasonStart // ignore: cast_nullable_to_non_nullable
as int?,poolSeasonEnd: freezed == poolSeasonEnd ? _self.poolSeasonEnd : poolSeasonEnd // ignore: cast_nullable_to_non_nullable
as int?,amenities: null == amenities ? _self.amenities : amenities // ignore: cast_nullable_to_non_nullable
as Set<AmenityKind>,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<DraftPhoto>,coverPhotoId: freezed == coverPhotoId ? _self.coverPhotoId : coverPhotoId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,highlights: null == highlights ? _self.highlights : highlights // ignore: cast_nullable_to_non_nullable
as Set<HighlightTag>,space: null == space ? _self.space : space // ignore: cast_nullable_to_non_nullable
as String,guestAccess: null == guestAccess ? _self.guestAccess : guestAccess // ignore: cast_nullable_to_non_nullable
as String,otherNotes: null == otherNotes ? _self.otherNotes : otherNotes // ignore: cast_nullable_to_non_nullable
as String,safety: null == safety ? _self.safety : safety // ignore: cast_nullable_to_non_nullable
as Set<SafetyKind>,outdoorCameraNote: null == outdoorCameraNote ? _self.outdoorCameraNote : outdoorCameraNote // ignore: cast_nullable_to_non_nullable
as String,poolNoLifeguardAck: null == poolNoLifeguardAck ? _self.poolNoLifeguardAck : poolNoLifeguardAck // ignore: cast_nullable_to_non_nullable
as bool,poolDepthMarked: null == poolDepthMarked ? _self.poolDepthMarked : poolDepthMarked // ignore: cast_nullable_to_non_nullable
as bool,checkInFrom: null == checkInFrom ? _self.checkInFrom : checkInFrom // ignore: cast_nullable_to_non_nullable
as String,checkOutBy: null == checkOutBy ? _self.checkOutBy : checkOutBy // ignore: cast_nullable_to_non_nullable
as String,petsAllowed: null == petsAllowed ? _self.petsAllowed : petsAllowed // ignore: cast_nullable_to_non_nullable
as bool,smokingAllowed: null == smokingAllowed ? _self.smokingAllowed : smokingAllowed // ignore: cast_nullable_to_non_nullable
as bool,eventsAllowed: null == eventsAllowed ? _self.eventsAllowed : eventsAllowed // ignore: cast_nullable_to_non_nullable
as bool,quietHours: null == quietHours ? _self.quietHours : quietHours // ignore: cast_nullable_to_non_nullable
as bool,quietFrom: null == quietFrom ? _self.quietFrom : quietFrom // ignore: cast_nullable_to_non_nullable
as String,quietTo: null == quietTo ? _self.quietTo : quietTo // ignore: cast_nullable_to_non_nullable
as String,nightlyPrice: freezed == nightlyPrice ? _self.nightlyPrice : nightlyPrice // ignore: cast_nullable_to_non_nullable
as int?,weekendPrice: freezed == weekendPrice ? _self.weekendPrice : weekendPrice // ignore: cast_nullable_to_non_nullable
as int?,cleaningFee: null == cleaningFee ? _self.cleaningFee : cleaningFee // ignore: cast_nullable_to_non_nullable
as int,weeklyDiscountPercent: null == weeklyDiscountPercent ? _self.weeklyDiscountPercent : weeklyDiscountPercent // ignore: cast_nullable_to_non_nullable
as int,minNights: null == minNights ? _self.minNights : minNights // ignore: cast_nullable_to_non_nullable
as int,instantBook: null == instantBook ? _self.instantBook : instantBook // ignore: cast_nullable_to_non_nullable
as bool,cancellation: null == cancellation ? _self.cancellation : cancellation // ignore: cast_nullable_to_non_nullable
as CancellationPolicy,checkInMethod: null == checkInMethod ? _self.checkInMethod : checkInMethod // ignore: cast_nullable_to_non_nullable
as SelfCheckIn,lockboxCode: null == lockboxCode ? _self.lockboxCode : lockboxCode // ignore: cast_nullable_to_non_nullable
as String,lockboxHint: null == lockboxHint ? _self.lockboxHint : lockboxHint // ignore: cast_nullable_to_non_nullable
as String,wifiName: null == wifiName ? _self.wifiName : wifiName // ignore: cast_nullable_to_non_nullable
as String,wifiPassword: null == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String,poolInstructions: null == poolInstructions ? _self.poolInstructions : poolInstructions // ignore: cast_nullable_to_non_nullable
as String,houseInstructions: null == houseInstructions ? _self.houseInstructions : houseInstructions // ignore: cast_nullable_to_non_nullable
as String,checkoutTasks: null == checkoutTasks ? _self.checkoutTasks : checkoutTasks // ignore: cast_nullable_to_non_nullable
as List<String>,permitType: freezed == permitType ? _self.permitType : permitType // ignore: cast_nullable_to_non_nullable
as PermitType?,permitNo: null == permitNo ? _self.permitNo : permitNo // ignore: cast_nullable_to_non_nullable
as String,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as Map<HostDocKind, HostDocument>,multiUnitParcel: null == multiUnitParcel ? _self.multiUnitParcel : multiUnitParcel // ignore: cast_nullable_to_non_nullable
as bool,onBehalfOfOwner: null == onBehalfOfOwner ? _self.onBehalfOfOwner : onBehalfOfOwner // ignore: cast_nullable_to_non_nullable
as bool,kbsDeclaration: null == kbsDeclaration ? _self.kbsDeclaration : kbsDeclaration // ignore: cast_nullable_to_non_nullable
as bool,permitHolderDeclaration: null == permitHolderDeclaration ? _self.permitHolderDeclaration : permitHolderDeclaration // ignore: cast_nullable_to_non_nullable
as bool,updateDeclaration: null == updateDeclaration ? _self.updateDeclaration : updateDeclaration // ignore: cast_nullable_to_non_nullable
as bool,taxType: null == taxType ? _self.taxType : taxType // ignore: cast_nullable_to_non_nullable
as TaxType,taxId: null == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String,taxOffice: null == taxOffice ? _self.taxOffice : taxOffice // ignore: cast_nullable_to_non_nullable
as String,identityDone: null == identityDone ? _self.identityDone : identityDone // ignore: cast_nullable_to_non_nullable
as Set<IdentityStep>,verifiedName: freezed == verifiedName ? _self.verifiedName : verifiedName // ignore: cast_nullable_to_non_nullable
as String?,accountHolder: null == accountHolder ? _self.accountHolder : accountHolder // ignore: cast_nullable_to_non_nullable
as String,iban: null == iban ? _self.iban : iban // ignore: cast_nullable_to_non_nullable
as String,billingAddress: null == billingAddress ? _self.billingAddress : billingAddress // ignore: cast_nullable_to_non_nullable
as String,emergencyPhone: null == emergencyPhone ? _self.emergencyPhone : emergencyPhone // ignore: cast_nullable_to_non_nullable
as String,reachableDuringStay: null == reachableDuringStay ? _self.reachableDuringStay : reachableDuringStay // ignore: cast_nullable_to_non_nullable
as bool,accuracyConsent: null == accuracyConsent ? _self.accuracyConsent : accuracyConsent // ignore: cast_nullable_to_non_nullable
as bool,agreementConsent: null == agreementConsent ? _self.agreementConsent : agreementConsent // ignore: cast_nullable_to_non_nullable
as bool,ministryConsent: null == ministryConsent ? _self.ministryConsent : ministryConsent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ListingDraft].
extension ListingDraftPatterns on ListingDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListingDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListingDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListingDraft value)  $default,){
final _that = this;
switch (_that) {
case _ListingDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListingDraft value)?  $default,){
final _that = this;
switch (_that) {
case _ListingDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ListingStatus status,  WizardStep resumeStep,  DateTime? submittedAt,  Set<WizardStep> sectionsInReview,  PropertyType? propertyType,  Set<ListingSetting> settings,  String address,  String city,  String district,  double? latitude,  double? longitude,  int maxGuests,  int bedrooms,  int beds,  int bathrooms,  List<BedCount> bedTypes,  int? indoorM2,  int? gardenM2,  bool wholePlace,  bool hasPool,  bool poolPrivate,  bool poolHeated,  int? poolTempC,  double? poolWidthM,  double? poolLengthM,  double? poolDepthMinM,  double? poolDepthMaxM,  int? poolSeasonStart,  int? poolSeasonEnd,  Set<AmenityKind> amenities,  List<DraftPhoto> photos,  String? coverPhotoId,  String title,  Set<HighlightTag> highlights,  String space,  String guestAccess,  String otherNotes,  Set<SafetyKind> safety,  String outdoorCameraNote,  bool poolNoLifeguardAck,  bool poolDepthMarked,  String checkInFrom,  String checkOutBy,  bool petsAllowed,  bool smokingAllowed,  bool eventsAllowed,  bool quietHours,  String quietFrom,  String quietTo,  int? nightlyPrice,  int? weekendPrice,  int cleaningFee,  int weeklyDiscountPercent,  int minNights,  bool instantBook,  CancellationPolicy cancellation,  SelfCheckIn checkInMethod,  String lockboxCode,  String lockboxHint,  String wifiName,  String wifiPassword,  String poolInstructions,  String houseInstructions,  List<String> checkoutTasks,  PermitType? permitType,  String permitNo,  Map<HostDocKind, HostDocument> documents,  bool multiUnitParcel,  bool onBehalfOfOwner,  bool kbsDeclaration,  bool permitHolderDeclaration,  bool updateDeclaration,  TaxType taxType,  String taxId,  String taxOffice,  Set<IdentityStep> identityDone,  String? verifiedName,  String accountHolder,  String iban,  String billingAddress,  String emergencyPhone,  bool reachableDuringStay,  bool accuracyConsent,  bool agreementConsent,  bool ministryConsent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListingDraft() when $default != null:
return $default(_that.id,_that.status,_that.resumeStep,_that.submittedAt,_that.sectionsInReview,_that.propertyType,_that.settings,_that.address,_that.city,_that.district,_that.latitude,_that.longitude,_that.maxGuests,_that.bedrooms,_that.beds,_that.bathrooms,_that.bedTypes,_that.indoorM2,_that.gardenM2,_that.wholePlace,_that.hasPool,_that.poolPrivate,_that.poolHeated,_that.poolTempC,_that.poolWidthM,_that.poolLengthM,_that.poolDepthMinM,_that.poolDepthMaxM,_that.poolSeasonStart,_that.poolSeasonEnd,_that.amenities,_that.photos,_that.coverPhotoId,_that.title,_that.highlights,_that.space,_that.guestAccess,_that.otherNotes,_that.safety,_that.outdoorCameraNote,_that.poolNoLifeguardAck,_that.poolDepthMarked,_that.checkInFrom,_that.checkOutBy,_that.petsAllowed,_that.smokingAllowed,_that.eventsAllowed,_that.quietHours,_that.quietFrom,_that.quietTo,_that.nightlyPrice,_that.weekendPrice,_that.cleaningFee,_that.weeklyDiscountPercent,_that.minNights,_that.instantBook,_that.cancellation,_that.checkInMethod,_that.lockboxCode,_that.lockboxHint,_that.wifiName,_that.wifiPassword,_that.poolInstructions,_that.houseInstructions,_that.checkoutTasks,_that.permitType,_that.permitNo,_that.documents,_that.multiUnitParcel,_that.onBehalfOfOwner,_that.kbsDeclaration,_that.permitHolderDeclaration,_that.updateDeclaration,_that.taxType,_that.taxId,_that.taxOffice,_that.identityDone,_that.verifiedName,_that.accountHolder,_that.iban,_that.billingAddress,_that.emergencyPhone,_that.reachableDuringStay,_that.accuracyConsent,_that.agreementConsent,_that.ministryConsent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ListingStatus status,  WizardStep resumeStep,  DateTime? submittedAt,  Set<WizardStep> sectionsInReview,  PropertyType? propertyType,  Set<ListingSetting> settings,  String address,  String city,  String district,  double? latitude,  double? longitude,  int maxGuests,  int bedrooms,  int beds,  int bathrooms,  List<BedCount> bedTypes,  int? indoorM2,  int? gardenM2,  bool wholePlace,  bool hasPool,  bool poolPrivate,  bool poolHeated,  int? poolTempC,  double? poolWidthM,  double? poolLengthM,  double? poolDepthMinM,  double? poolDepthMaxM,  int? poolSeasonStart,  int? poolSeasonEnd,  Set<AmenityKind> amenities,  List<DraftPhoto> photos,  String? coverPhotoId,  String title,  Set<HighlightTag> highlights,  String space,  String guestAccess,  String otherNotes,  Set<SafetyKind> safety,  String outdoorCameraNote,  bool poolNoLifeguardAck,  bool poolDepthMarked,  String checkInFrom,  String checkOutBy,  bool petsAllowed,  bool smokingAllowed,  bool eventsAllowed,  bool quietHours,  String quietFrom,  String quietTo,  int? nightlyPrice,  int? weekendPrice,  int cleaningFee,  int weeklyDiscountPercent,  int minNights,  bool instantBook,  CancellationPolicy cancellation,  SelfCheckIn checkInMethod,  String lockboxCode,  String lockboxHint,  String wifiName,  String wifiPassword,  String poolInstructions,  String houseInstructions,  List<String> checkoutTasks,  PermitType? permitType,  String permitNo,  Map<HostDocKind, HostDocument> documents,  bool multiUnitParcel,  bool onBehalfOfOwner,  bool kbsDeclaration,  bool permitHolderDeclaration,  bool updateDeclaration,  TaxType taxType,  String taxId,  String taxOffice,  Set<IdentityStep> identityDone,  String? verifiedName,  String accountHolder,  String iban,  String billingAddress,  String emergencyPhone,  bool reachableDuringStay,  bool accuracyConsent,  bool agreementConsent,  bool ministryConsent)  $default,) {final _that = this;
switch (_that) {
case _ListingDraft():
return $default(_that.id,_that.status,_that.resumeStep,_that.submittedAt,_that.sectionsInReview,_that.propertyType,_that.settings,_that.address,_that.city,_that.district,_that.latitude,_that.longitude,_that.maxGuests,_that.bedrooms,_that.beds,_that.bathrooms,_that.bedTypes,_that.indoorM2,_that.gardenM2,_that.wholePlace,_that.hasPool,_that.poolPrivate,_that.poolHeated,_that.poolTempC,_that.poolWidthM,_that.poolLengthM,_that.poolDepthMinM,_that.poolDepthMaxM,_that.poolSeasonStart,_that.poolSeasonEnd,_that.amenities,_that.photos,_that.coverPhotoId,_that.title,_that.highlights,_that.space,_that.guestAccess,_that.otherNotes,_that.safety,_that.outdoorCameraNote,_that.poolNoLifeguardAck,_that.poolDepthMarked,_that.checkInFrom,_that.checkOutBy,_that.petsAllowed,_that.smokingAllowed,_that.eventsAllowed,_that.quietHours,_that.quietFrom,_that.quietTo,_that.nightlyPrice,_that.weekendPrice,_that.cleaningFee,_that.weeklyDiscountPercent,_that.minNights,_that.instantBook,_that.cancellation,_that.checkInMethod,_that.lockboxCode,_that.lockboxHint,_that.wifiName,_that.wifiPassword,_that.poolInstructions,_that.houseInstructions,_that.checkoutTasks,_that.permitType,_that.permitNo,_that.documents,_that.multiUnitParcel,_that.onBehalfOfOwner,_that.kbsDeclaration,_that.permitHolderDeclaration,_that.updateDeclaration,_that.taxType,_that.taxId,_that.taxOffice,_that.identityDone,_that.verifiedName,_that.accountHolder,_that.iban,_that.billingAddress,_that.emergencyPhone,_that.reachableDuringStay,_that.accuracyConsent,_that.agreementConsent,_that.ministryConsent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ListingStatus status,  WizardStep resumeStep,  DateTime? submittedAt,  Set<WizardStep> sectionsInReview,  PropertyType? propertyType,  Set<ListingSetting> settings,  String address,  String city,  String district,  double? latitude,  double? longitude,  int maxGuests,  int bedrooms,  int beds,  int bathrooms,  List<BedCount> bedTypes,  int? indoorM2,  int? gardenM2,  bool wholePlace,  bool hasPool,  bool poolPrivate,  bool poolHeated,  int? poolTempC,  double? poolWidthM,  double? poolLengthM,  double? poolDepthMinM,  double? poolDepthMaxM,  int? poolSeasonStart,  int? poolSeasonEnd,  Set<AmenityKind> amenities,  List<DraftPhoto> photos,  String? coverPhotoId,  String title,  Set<HighlightTag> highlights,  String space,  String guestAccess,  String otherNotes,  Set<SafetyKind> safety,  String outdoorCameraNote,  bool poolNoLifeguardAck,  bool poolDepthMarked,  String checkInFrom,  String checkOutBy,  bool petsAllowed,  bool smokingAllowed,  bool eventsAllowed,  bool quietHours,  String quietFrom,  String quietTo,  int? nightlyPrice,  int? weekendPrice,  int cleaningFee,  int weeklyDiscountPercent,  int minNights,  bool instantBook,  CancellationPolicy cancellation,  SelfCheckIn checkInMethod,  String lockboxCode,  String lockboxHint,  String wifiName,  String wifiPassword,  String poolInstructions,  String houseInstructions,  List<String> checkoutTasks,  PermitType? permitType,  String permitNo,  Map<HostDocKind, HostDocument> documents,  bool multiUnitParcel,  bool onBehalfOfOwner,  bool kbsDeclaration,  bool permitHolderDeclaration,  bool updateDeclaration,  TaxType taxType,  String taxId,  String taxOffice,  Set<IdentityStep> identityDone,  String? verifiedName,  String accountHolder,  String iban,  String billingAddress,  String emergencyPhone,  bool reachableDuringStay,  bool accuracyConsent,  bool agreementConsent,  bool ministryConsent)?  $default,) {final _that = this;
switch (_that) {
case _ListingDraft() when $default != null:
return $default(_that.id,_that.status,_that.resumeStep,_that.submittedAt,_that.sectionsInReview,_that.propertyType,_that.settings,_that.address,_that.city,_that.district,_that.latitude,_that.longitude,_that.maxGuests,_that.bedrooms,_that.beds,_that.bathrooms,_that.bedTypes,_that.indoorM2,_that.gardenM2,_that.wholePlace,_that.hasPool,_that.poolPrivate,_that.poolHeated,_that.poolTempC,_that.poolWidthM,_that.poolLengthM,_that.poolDepthMinM,_that.poolDepthMaxM,_that.poolSeasonStart,_that.poolSeasonEnd,_that.amenities,_that.photos,_that.coverPhotoId,_that.title,_that.highlights,_that.space,_that.guestAccess,_that.otherNotes,_that.safety,_that.outdoorCameraNote,_that.poolNoLifeguardAck,_that.poolDepthMarked,_that.checkInFrom,_that.checkOutBy,_that.petsAllowed,_that.smokingAllowed,_that.eventsAllowed,_that.quietHours,_that.quietFrom,_that.quietTo,_that.nightlyPrice,_that.weekendPrice,_that.cleaningFee,_that.weeklyDiscountPercent,_that.minNights,_that.instantBook,_that.cancellation,_that.checkInMethod,_that.lockboxCode,_that.lockboxHint,_that.wifiName,_that.wifiPassword,_that.poolInstructions,_that.houseInstructions,_that.checkoutTasks,_that.permitType,_that.permitNo,_that.documents,_that.multiUnitParcel,_that.onBehalfOfOwner,_that.kbsDeclaration,_that.permitHolderDeclaration,_that.updateDeclaration,_that.taxType,_that.taxId,_that.taxOffice,_that.identityDone,_that.verifiedName,_that.accountHolder,_that.iban,_that.billingAddress,_that.emergencyPhone,_that.reachableDuringStay,_that.accuracyConsent,_that.agreementConsent,_that.ministryConsent);case _:
  return null;

}
}

}

/// @nodoc


class _ListingDraft extends ListingDraft {
  const _ListingDraft({required this.id, this.status = ListingStatus.draft, this.resumeStep = WizardStep.typeAndLocation, this.submittedAt,  Set<WizardStep> sectionsInReview = const <WizardStep>{}, this.propertyType,  Set<ListingSetting> settings = const <ListingSetting>{}, this.address = '', this.city = '', this.district = '', this.latitude, this.longitude, this.maxGuests = 2, this.bedrooms = 1, this.beds = 1, this.bathrooms = 1,  List<BedCount> bedTypes = const <BedCount>[], this.indoorM2, this.gardenM2, this.wholePlace = true, this.hasPool = false, this.poolPrivate = true, this.poolHeated = false, this.poolTempC, this.poolWidthM, this.poolLengthM, this.poolDepthMinM, this.poolDepthMaxM, this.poolSeasonStart, this.poolSeasonEnd,  Set<AmenityKind> amenities = const <AmenityKind>{},  List<DraftPhoto> photos = const <DraftPhoto>[], this.coverPhotoId, this.title = '',  Set<HighlightTag> highlights = const <HighlightTag>{}, this.space = '', this.guestAccess = '', this.otherNotes = '',  Set<SafetyKind> safety = const <SafetyKind>{}, this.outdoorCameraNote = '', this.poolNoLifeguardAck = false, this.poolDepthMarked = false, this.checkInFrom = '14:00', this.checkOutBy = '11:00', this.petsAllowed = false, this.smokingAllowed = false, this.eventsAllowed = false, this.quietHours = true, this.quietFrom = '23:00', this.quietTo = '08:00', this.nightlyPrice, this.weekendPrice, this.cleaningFee = 0, this.weeklyDiscountPercent = 0, this.minNights = 1, this.instantBook = true, this.cancellation = CancellationPolicy.flexible, this.checkInMethod = SelfCheckIn.keybox, this.lockboxCode = '', this.lockboxHint = '', this.wifiName = '', this.wifiPassword = '', this.poolInstructions = '', this.houseInstructions = '',  List<String> checkoutTasks = const <String>[], this.permitType, this.permitNo = '',  Map<HostDocKind, HostDocument> documents = const <HostDocKind, HostDocument>{}, this.multiUnitParcel = false, this.onBehalfOfOwner = false, this.kbsDeclaration = false, this.permitHolderDeclaration = false, this.updateDeclaration = false, this.taxType = TaxType.individual, this.taxId = '', this.taxOffice = '',  Set<IdentityStep> identityDone = const <IdentityStep>{}, this.verifiedName, this.accountHolder = '', this.iban = '', this.billingAddress = '', this.emergencyPhone = '', this.reachableDuringStay = true, this.accuracyConsent = false, this.agreementConsent = false, this.ministryConsent = false}): _sectionsInReview = sectionsInReview,_settings = settings,_bedTypes = bedTypes,_amenities = amenities,_photos = photos,_highlights = highlights,_safety = safety,_checkoutTasks = checkoutTasks,_documents = documents,_identityDone = identityDone,super._();
  

@override final  String id;
@override@JsonKey() final  ListingStatus status;
/// Kaydet ve çık sonrası devam edilecek adım.
@override@JsonKey() final  WizardStep resumeStep;
@override final  DateTime? submittedAt;
/// Yayındaki ilanda yeniden incelemeye giren bölümler.
 final  Set<WizardStep> _sectionsInReview;
/// Yayındaki ilanda yeniden incelemeye giren bölümler.
@override@JsonKey() Set<WizardStep> get sectionsInReview {
  if (_sectionsInReview is EqualUnmodifiableSetView) return _sectionsInReview;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_sectionsInReview);
}

@override final  PropertyType? propertyType;
 final  Set<ListingSetting> _settings;
@override@JsonKey() Set<ListingSetting> get settings {
  if (_settings is EqualUnmodifiableSetView) return _settings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_settings);
}

@override@JsonKey() final  String address;
@override@JsonKey() final  String city;
@override@JsonKey() final  String district;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey() final  int maxGuests;
@override@JsonKey() final  int bedrooms;
@override@JsonKey() final  int beds;
@override@JsonKey() final  int bathrooms;
 final  List<BedCount> _bedTypes;
@override@JsonKey() List<BedCount> get bedTypes {
  if (_bedTypes is EqualUnmodifiableListView) return _bedTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bedTypes);
}

@override final  int? indoorM2;
@override final  int? gardenM2;
/// Bungalovun tamamı misafire mi ait (false: bahçe ortak).
@override@JsonKey() final  bool wholePlace;
@override@JsonKey() final  bool hasPool;
@override@JsonKey() final  bool poolPrivate;
@override@JsonKey() final  bool poolHeated;
@override final  int? poolTempC;
@override final  double? poolWidthM;
@override final  double? poolLengthM;
@override final  double? poolDepthMinM;
@override final  double? poolDepthMaxM;
@override final  int? poolSeasonStart;
@override final  int? poolSeasonEnd;
 final  Set<AmenityKind> _amenities;
@override@JsonKey() Set<AmenityKind> get amenities {
  if (_amenities is EqualUnmodifiableSetView) return _amenities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_amenities);
}

 final  List<DraftPhoto> _photos;
@override@JsonKey() List<DraftPhoto> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override final  String? coverPhotoId;
@override@JsonKey() final  String title;
 final  Set<HighlightTag> _highlights;
@override@JsonKey() Set<HighlightTag> get highlights {
  if (_highlights is EqualUnmodifiableSetView) return _highlights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_highlights);
}

@override@JsonKey() final  String space;
@override@JsonKey() final  String guestAccess;
@override@JsonKey() final  String otherNotes;
 final  Set<SafetyKind> _safety;
@override@JsonKey() Set<SafetyKind> get safety {
  if (_safety is EqualUnmodifiableSetView) return _safety;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_safety);
}

@override@JsonKey() final  String outdoorCameraNote;
@override@JsonKey() final  bool poolNoLifeguardAck;
@override@JsonKey() final  bool poolDepthMarked;
@override@JsonKey() final  String checkInFrom;
@override@JsonKey() final  String checkOutBy;
@override@JsonKey() final  bool petsAllowed;
@override@JsonKey() final  bool smokingAllowed;
@override@JsonKey() final  bool eventsAllowed;
@override@JsonKey() final  bool quietHours;
@override@JsonKey() final  String quietFrom;
@override@JsonKey() final  String quietTo;
@override final  int? nightlyPrice;
@override final  int? weekendPrice;
@override@JsonKey() final  int cleaningFee;
@override@JsonKey() final  int weeklyDiscountPercent;
@override@JsonKey() final  int minNights;
@override@JsonKey() final  bool instantBook;
@override@JsonKey() final  CancellationPolicy cancellation;
@override@JsonKey() final  SelfCheckIn checkInMethod;
@override@JsonKey() final  String lockboxCode;
@override@JsonKey() final  String lockboxHint;
@override@JsonKey() final  String wifiName;
@override@JsonKey() final  String wifiPassword;
@override@JsonKey() final  String poolInstructions;
@override@JsonKey() final  String houseInstructions;
 final  List<String> _checkoutTasks;
@override@JsonKey() List<String> get checkoutTasks {
  if (_checkoutTasks is EqualUnmodifiableListView) return _checkoutTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checkoutTasks);
}

@override final  PermitType? permitType;
@override@JsonKey() final  String permitNo;
 final  Map<HostDocKind, HostDocument> _documents;
@override@JsonKey() Map<HostDocKind, HostDocument> get documents {
  if (_documents is EqualUnmodifiableMapView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_documents);
}

@override@JsonKey() final  bool multiUnitParcel;
@override@JsonKey() final  bool onBehalfOfOwner;
@override@JsonKey() final  bool kbsDeclaration;
@override@JsonKey() final  bool permitHolderDeclaration;
@override@JsonKey() final  bool updateDeclaration;
@override@JsonKey() final  TaxType taxType;
/// TCKN (şahıs) ya da vergi no (şirket). Ekranda maskeli gösterilir.
@override@JsonKey() final  String taxId;
@override@JsonKey() final  String taxOffice;
 final  Set<IdentityStep> _identityDone;
@override@JsonKey() Set<IdentityStep> get identityDone {
  if (_identityDone is EqualUnmodifiableSetView) return _identityDone;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_identityDone);
}

/// Kimlik doğrulamasından gelen ad soyad; IBAN sahibi bununla eşleşmeli.
@override final  String? verifiedName;
@override@JsonKey() final  String accountHolder;
@override@JsonKey() final  String iban;
@override@JsonKey() final  String billingAddress;
@override@JsonKey() final  String emergencyPhone;
@override@JsonKey() final  bool reachableDuringStay;
@override@JsonKey() final  bool accuracyConsent;
@override@JsonKey() final  bool agreementConsent;
@override@JsonKey() final  bool ministryConsent;

/// Create a copy of ListingDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingDraftCopyWith<_ListingDraft> get copyWith => __$ListingDraftCopyWithImpl<_ListingDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListingDraft&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.resumeStep, resumeStep) || other.resumeStep == resumeStep)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&const DeepCollectionEquality().equals(other._sectionsInReview, _sectionsInReview)&&(identical(other.propertyType, propertyType) || other.propertyType == propertyType)&&const DeepCollectionEquality().equals(other._settings, _settings)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.district, district) || other.district == district)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.maxGuests, maxGuests) || other.maxGuests == maxGuests)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.beds, beds) || other.beds == beds)&&(identical(other.bathrooms, bathrooms) || other.bathrooms == bathrooms)&&const DeepCollectionEquality().equals(other._bedTypes, _bedTypes)&&(identical(other.indoorM2, indoorM2) || other.indoorM2 == indoorM2)&&(identical(other.gardenM2, gardenM2) || other.gardenM2 == gardenM2)&&(identical(other.wholePlace, wholePlace) || other.wholePlace == wholePlace)&&(identical(other.hasPool, hasPool) || other.hasPool == hasPool)&&(identical(other.poolPrivate, poolPrivate) || other.poolPrivate == poolPrivate)&&(identical(other.poolHeated, poolHeated) || other.poolHeated == poolHeated)&&(identical(other.poolTempC, poolTempC) || other.poolTempC == poolTempC)&&(identical(other.poolWidthM, poolWidthM) || other.poolWidthM == poolWidthM)&&(identical(other.poolLengthM, poolLengthM) || other.poolLengthM == poolLengthM)&&(identical(other.poolDepthMinM, poolDepthMinM) || other.poolDepthMinM == poolDepthMinM)&&(identical(other.poolDepthMaxM, poolDepthMaxM) || other.poolDepthMaxM == poolDepthMaxM)&&(identical(other.poolSeasonStart, poolSeasonStart) || other.poolSeasonStart == poolSeasonStart)&&(identical(other.poolSeasonEnd, poolSeasonEnd) || other.poolSeasonEnd == poolSeasonEnd)&&const DeepCollectionEquality().equals(other._amenities, _amenities)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.coverPhotoId, coverPhotoId) || other.coverPhotoId == coverPhotoId)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._highlights, _highlights)&&(identical(other.space, space) || other.space == space)&&(identical(other.guestAccess, guestAccess) || other.guestAccess == guestAccess)&&(identical(other.otherNotes, otherNotes) || other.otherNotes == otherNotes)&&const DeepCollectionEquality().equals(other._safety, _safety)&&(identical(other.outdoorCameraNote, outdoorCameraNote) || other.outdoorCameraNote == outdoorCameraNote)&&(identical(other.poolNoLifeguardAck, poolNoLifeguardAck) || other.poolNoLifeguardAck == poolNoLifeguardAck)&&(identical(other.poolDepthMarked, poolDepthMarked) || other.poolDepthMarked == poolDepthMarked)&&(identical(other.checkInFrom, checkInFrom) || other.checkInFrom == checkInFrom)&&(identical(other.checkOutBy, checkOutBy) || other.checkOutBy == checkOutBy)&&(identical(other.petsAllowed, petsAllowed) || other.petsAllowed == petsAllowed)&&(identical(other.smokingAllowed, smokingAllowed) || other.smokingAllowed == smokingAllowed)&&(identical(other.eventsAllowed, eventsAllowed) || other.eventsAllowed == eventsAllowed)&&(identical(other.quietHours, quietHours) || other.quietHours == quietHours)&&(identical(other.quietFrom, quietFrom) || other.quietFrom == quietFrom)&&(identical(other.quietTo, quietTo) || other.quietTo == quietTo)&&(identical(other.nightlyPrice, nightlyPrice) || other.nightlyPrice == nightlyPrice)&&(identical(other.weekendPrice, weekendPrice) || other.weekendPrice == weekendPrice)&&(identical(other.cleaningFee, cleaningFee) || other.cleaningFee == cleaningFee)&&(identical(other.weeklyDiscountPercent, weeklyDiscountPercent) || other.weeklyDiscountPercent == weeklyDiscountPercent)&&(identical(other.minNights, minNights) || other.minNights == minNights)&&(identical(other.instantBook, instantBook) || other.instantBook == instantBook)&&(identical(other.cancellation, cancellation) || other.cancellation == cancellation)&&(identical(other.checkInMethod, checkInMethod) || other.checkInMethod == checkInMethod)&&(identical(other.lockboxCode, lockboxCode) || other.lockboxCode == lockboxCode)&&(identical(other.lockboxHint, lockboxHint) || other.lockboxHint == lockboxHint)&&(identical(other.wifiName, wifiName) || other.wifiName == wifiName)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword)&&(identical(other.poolInstructions, poolInstructions) || other.poolInstructions == poolInstructions)&&(identical(other.houseInstructions, houseInstructions) || other.houseInstructions == houseInstructions)&&const DeepCollectionEquality().equals(other._checkoutTasks, _checkoutTasks)&&(identical(other.permitType, permitType) || other.permitType == permitType)&&(identical(other.permitNo, permitNo) || other.permitNo == permitNo)&&const DeepCollectionEquality().equals(other._documents, _documents)&&(identical(other.multiUnitParcel, multiUnitParcel) || other.multiUnitParcel == multiUnitParcel)&&(identical(other.onBehalfOfOwner, onBehalfOfOwner) || other.onBehalfOfOwner == onBehalfOfOwner)&&(identical(other.kbsDeclaration, kbsDeclaration) || other.kbsDeclaration == kbsDeclaration)&&(identical(other.permitHolderDeclaration, permitHolderDeclaration) || other.permitHolderDeclaration == permitHolderDeclaration)&&(identical(other.updateDeclaration, updateDeclaration) || other.updateDeclaration == updateDeclaration)&&(identical(other.taxType, taxType) || other.taxType == taxType)&&(identical(other.taxId, taxId) || other.taxId == taxId)&&(identical(other.taxOffice, taxOffice) || other.taxOffice == taxOffice)&&const DeepCollectionEquality().equals(other._identityDone, _identityDone)&&(identical(other.verifiedName, verifiedName) || other.verifiedName == verifiedName)&&(identical(other.accountHolder, accountHolder) || other.accountHolder == accountHolder)&&(identical(other.iban, iban) || other.iban == iban)&&(identical(other.billingAddress, billingAddress) || other.billingAddress == billingAddress)&&(identical(other.emergencyPhone, emergencyPhone) || other.emergencyPhone == emergencyPhone)&&(identical(other.reachableDuringStay, reachableDuringStay) || other.reachableDuringStay == reachableDuringStay)&&(identical(other.accuracyConsent, accuracyConsent) || other.accuracyConsent == accuracyConsent)&&(identical(other.agreementConsent, agreementConsent) || other.agreementConsent == agreementConsent)&&(identical(other.ministryConsent, ministryConsent) || other.ministryConsent == ministryConsent));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,status,resumeStep,submittedAt,const DeepCollectionEquality().hash(_sectionsInReview),propertyType,const DeepCollectionEquality().hash(_settings),address,city,district,latitude,longitude,maxGuests,bedrooms,beds,bathrooms,const DeepCollectionEquality().hash(_bedTypes),indoorM2,gardenM2,wholePlace,hasPool,poolPrivate,poolHeated,poolTempC,poolWidthM,poolLengthM,poolDepthMinM,poolDepthMaxM,poolSeasonStart,poolSeasonEnd,const DeepCollectionEquality().hash(_amenities),const DeepCollectionEquality().hash(_photos),coverPhotoId,title,const DeepCollectionEquality().hash(_highlights),space,guestAccess,otherNotes,const DeepCollectionEquality().hash(_safety),outdoorCameraNote,poolNoLifeguardAck,poolDepthMarked,checkInFrom,checkOutBy,petsAllowed,smokingAllowed,eventsAllowed,quietHours,quietFrom,quietTo,nightlyPrice,weekendPrice,cleaningFee,weeklyDiscountPercent,minNights,instantBook,cancellation,checkInMethod,lockboxCode,lockboxHint,wifiName,wifiPassword,poolInstructions,houseInstructions,const DeepCollectionEquality().hash(_checkoutTasks),permitType,permitNo,const DeepCollectionEquality().hash(_documents),multiUnitParcel,onBehalfOfOwner,kbsDeclaration,permitHolderDeclaration,updateDeclaration,taxType,taxId,taxOffice,const DeepCollectionEquality().hash(_identityDone),verifiedName,accountHolder,iban,billingAddress,emergencyPhone,reachableDuringStay,accuracyConsent,agreementConsent,ministryConsent]);

@override
String toString() {
  return 'ListingDraft(id: $id, status: $status, resumeStep: $resumeStep, submittedAt: $submittedAt, sectionsInReview: $sectionsInReview, propertyType: $propertyType, settings: $settings, address: $address, city: $city, district: $district, latitude: $latitude, longitude: $longitude, maxGuests: $maxGuests, bedrooms: $bedrooms, beds: $beds, bathrooms: $bathrooms, bedTypes: $bedTypes, indoorM2: $indoorM2, gardenM2: $gardenM2, wholePlace: $wholePlace, hasPool: $hasPool, poolPrivate: $poolPrivate, poolHeated: $poolHeated, poolTempC: $poolTempC, poolWidthM: $poolWidthM, poolLengthM: $poolLengthM, poolDepthMinM: $poolDepthMinM, poolDepthMaxM: $poolDepthMaxM, poolSeasonStart: $poolSeasonStart, poolSeasonEnd: $poolSeasonEnd, amenities: $amenities, photos: $photos, coverPhotoId: $coverPhotoId, title: $title, highlights: $highlights, space: $space, guestAccess: $guestAccess, otherNotes: $otherNotes, safety: $safety, outdoorCameraNote: $outdoorCameraNote, poolNoLifeguardAck: $poolNoLifeguardAck, poolDepthMarked: $poolDepthMarked, checkInFrom: $checkInFrom, checkOutBy: $checkOutBy, petsAllowed: $petsAllowed, smokingAllowed: $smokingAllowed, eventsAllowed: $eventsAllowed, quietHours: $quietHours, quietFrom: $quietFrom, quietTo: $quietTo, nightlyPrice: $nightlyPrice, weekendPrice: $weekendPrice, cleaningFee: $cleaningFee, weeklyDiscountPercent: $weeklyDiscountPercent, minNights: $minNights, instantBook: $instantBook, cancellation: $cancellation, checkInMethod: $checkInMethod, lockboxCode: $lockboxCode, lockboxHint: $lockboxHint, wifiName: $wifiName, wifiPassword: $wifiPassword, poolInstructions: $poolInstructions, houseInstructions: $houseInstructions, checkoutTasks: $checkoutTasks, permitType: $permitType, permitNo: $permitNo, documents: $documents, multiUnitParcel: $multiUnitParcel, onBehalfOfOwner: $onBehalfOfOwner, kbsDeclaration: $kbsDeclaration, permitHolderDeclaration: $permitHolderDeclaration, updateDeclaration: $updateDeclaration, taxType: $taxType, taxId: $taxId, taxOffice: $taxOffice, identityDone: $identityDone, verifiedName: $verifiedName, accountHolder: $accountHolder, iban: $iban, billingAddress: $billingAddress, emergencyPhone: $emergencyPhone, reachableDuringStay: $reachableDuringStay, accuracyConsent: $accuracyConsent, agreementConsent: $agreementConsent, ministryConsent: $ministryConsent)';
}


}

/// @nodoc
abstract mixin class _$ListingDraftCopyWith<$Res> implements $ListingDraftCopyWith<$Res> {
  factory _$ListingDraftCopyWith(_ListingDraft value, $Res Function(_ListingDraft) _then) = __$ListingDraftCopyWithImpl;
@override @useResult
$Res call({
 String id, ListingStatus status, WizardStep resumeStep, DateTime? submittedAt, Set<WizardStep> sectionsInReview, PropertyType? propertyType, Set<ListingSetting> settings, String address, String city, String district, double? latitude, double? longitude, int maxGuests, int bedrooms, int beds, int bathrooms, List<BedCount> bedTypes, int? indoorM2, int? gardenM2, bool wholePlace, bool hasPool, bool poolPrivate, bool poolHeated, int? poolTempC, double? poolWidthM, double? poolLengthM, double? poolDepthMinM, double? poolDepthMaxM, int? poolSeasonStart, int? poolSeasonEnd, Set<AmenityKind> amenities, List<DraftPhoto> photos, String? coverPhotoId, String title, Set<HighlightTag> highlights, String space, String guestAccess, String otherNotes, Set<SafetyKind> safety, String outdoorCameraNote, bool poolNoLifeguardAck, bool poolDepthMarked, String checkInFrom, String checkOutBy, bool petsAllowed, bool smokingAllowed, bool eventsAllowed, bool quietHours, String quietFrom, String quietTo, int? nightlyPrice, int? weekendPrice, int cleaningFee, int weeklyDiscountPercent, int minNights, bool instantBook, CancellationPolicy cancellation, SelfCheckIn checkInMethod, String lockboxCode, String lockboxHint, String wifiName, String wifiPassword, String poolInstructions, String houseInstructions, List<String> checkoutTasks, PermitType? permitType, String permitNo, Map<HostDocKind, HostDocument> documents, bool multiUnitParcel, bool onBehalfOfOwner, bool kbsDeclaration, bool permitHolderDeclaration, bool updateDeclaration, TaxType taxType, String taxId, String taxOffice, Set<IdentityStep> identityDone, String? verifiedName, String accountHolder, String iban, String billingAddress, String emergencyPhone, bool reachableDuringStay, bool accuracyConsent, bool agreementConsent, bool ministryConsent
});




}
/// @nodoc
class __$ListingDraftCopyWithImpl<$Res>
    implements _$ListingDraftCopyWith<$Res> {
  __$ListingDraftCopyWithImpl(this._self, this._then);

  final _ListingDraft _self;
  final $Res Function(_ListingDraft) _then;

/// Create a copy of ListingDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? resumeStep = null,Object? submittedAt = freezed,Object? sectionsInReview = null,Object? propertyType = freezed,Object? settings = null,Object? address = null,Object? city = null,Object? district = null,Object? latitude = freezed,Object? longitude = freezed,Object? maxGuests = null,Object? bedrooms = null,Object? beds = null,Object? bathrooms = null,Object? bedTypes = null,Object? indoorM2 = freezed,Object? gardenM2 = freezed,Object? wholePlace = null,Object? hasPool = null,Object? poolPrivate = null,Object? poolHeated = null,Object? poolTempC = freezed,Object? poolWidthM = freezed,Object? poolLengthM = freezed,Object? poolDepthMinM = freezed,Object? poolDepthMaxM = freezed,Object? poolSeasonStart = freezed,Object? poolSeasonEnd = freezed,Object? amenities = null,Object? photos = null,Object? coverPhotoId = freezed,Object? title = null,Object? highlights = null,Object? space = null,Object? guestAccess = null,Object? otherNotes = null,Object? safety = null,Object? outdoorCameraNote = null,Object? poolNoLifeguardAck = null,Object? poolDepthMarked = null,Object? checkInFrom = null,Object? checkOutBy = null,Object? petsAllowed = null,Object? smokingAllowed = null,Object? eventsAllowed = null,Object? quietHours = null,Object? quietFrom = null,Object? quietTo = null,Object? nightlyPrice = freezed,Object? weekendPrice = freezed,Object? cleaningFee = null,Object? weeklyDiscountPercent = null,Object? minNights = null,Object? instantBook = null,Object? cancellation = null,Object? checkInMethod = null,Object? lockboxCode = null,Object? lockboxHint = null,Object? wifiName = null,Object? wifiPassword = null,Object? poolInstructions = null,Object? houseInstructions = null,Object? checkoutTasks = null,Object? permitType = freezed,Object? permitNo = null,Object? documents = null,Object? multiUnitParcel = null,Object? onBehalfOfOwner = null,Object? kbsDeclaration = null,Object? permitHolderDeclaration = null,Object? updateDeclaration = null,Object? taxType = null,Object? taxId = null,Object? taxOffice = null,Object? identityDone = null,Object? verifiedName = freezed,Object? accountHolder = null,Object? iban = null,Object? billingAddress = null,Object? emergencyPhone = null,Object? reachableDuringStay = null,Object? accuracyConsent = null,Object? agreementConsent = null,Object? ministryConsent = null,}) {
  return _then(_ListingDraft(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ListingStatus,resumeStep: null == resumeStep ? _self.resumeStep : resumeStep // ignore: cast_nullable_to_non_nullable
as WizardStep,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sectionsInReview: null == sectionsInReview ? _self._sectionsInReview : sectionsInReview // ignore: cast_nullable_to_non_nullable
as Set<WizardStep>,propertyType: freezed == propertyType ? _self.propertyType : propertyType // ignore: cast_nullable_to_non_nullable
as PropertyType?,settings: null == settings ? _self._settings : settings // ignore: cast_nullable_to_non_nullable
as Set<ListingSetting>,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,maxGuests: null == maxGuests ? _self.maxGuests : maxGuests // ignore: cast_nullable_to_non_nullable
as int,bedrooms: null == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int,beds: null == beds ? _self.beds : beds // ignore: cast_nullable_to_non_nullable
as int,bathrooms: null == bathrooms ? _self.bathrooms : bathrooms // ignore: cast_nullable_to_non_nullable
as int,bedTypes: null == bedTypes ? _self._bedTypes : bedTypes // ignore: cast_nullable_to_non_nullable
as List<BedCount>,indoorM2: freezed == indoorM2 ? _self.indoorM2 : indoorM2 // ignore: cast_nullable_to_non_nullable
as int?,gardenM2: freezed == gardenM2 ? _self.gardenM2 : gardenM2 // ignore: cast_nullable_to_non_nullable
as int?,wholePlace: null == wholePlace ? _self.wholePlace : wholePlace // ignore: cast_nullable_to_non_nullable
as bool,hasPool: null == hasPool ? _self.hasPool : hasPool // ignore: cast_nullable_to_non_nullable
as bool,poolPrivate: null == poolPrivate ? _self.poolPrivate : poolPrivate // ignore: cast_nullable_to_non_nullable
as bool,poolHeated: null == poolHeated ? _self.poolHeated : poolHeated // ignore: cast_nullable_to_non_nullable
as bool,poolTempC: freezed == poolTempC ? _self.poolTempC : poolTempC // ignore: cast_nullable_to_non_nullable
as int?,poolWidthM: freezed == poolWidthM ? _self.poolWidthM : poolWidthM // ignore: cast_nullable_to_non_nullable
as double?,poolLengthM: freezed == poolLengthM ? _self.poolLengthM : poolLengthM // ignore: cast_nullable_to_non_nullable
as double?,poolDepthMinM: freezed == poolDepthMinM ? _self.poolDepthMinM : poolDepthMinM // ignore: cast_nullable_to_non_nullable
as double?,poolDepthMaxM: freezed == poolDepthMaxM ? _self.poolDepthMaxM : poolDepthMaxM // ignore: cast_nullable_to_non_nullable
as double?,poolSeasonStart: freezed == poolSeasonStart ? _self.poolSeasonStart : poolSeasonStart // ignore: cast_nullable_to_non_nullable
as int?,poolSeasonEnd: freezed == poolSeasonEnd ? _self.poolSeasonEnd : poolSeasonEnd // ignore: cast_nullable_to_non_nullable
as int?,amenities: null == amenities ? _self._amenities : amenities // ignore: cast_nullable_to_non_nullable
as Set<AmenityKind>,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<DraftPhoto>,coverPhotoId: freezed == coverPhotoId ? _self.coverPhotoId : coverPhotoId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,highlights: null == highlights ? _self._highlights : highlights // ignore: cast_nullable_to_non_nullable
as Set<HighlightTag>,space: null == space ? _self.space : space // ignore: cast_nullable_to_non_nullable
as String,guestAccess: null == guestAccess ? _self.guestAccess : guestAccess // ignore: cast_nullable_to_non_nullable
as String,otherNotes: null == otherNotes ? _self.otherNotes : otherNotes // ignore: cast_nullable_to_non_nullable
as String,safety: null == safety ? _self._safety : safety // ignore: cast_nullable_to_non_nullable
as Set<SafetyKind>,outdoorCameraNote: null == outdoorCameraNote ? _self.outdoorCameraNote : outdoorCameraNote // ignore: cast_nullable_to_non_nullable
as String,poolNoLifeguardAck: null == poolNoLifeguardAck ? _self.poolNoLifeguardAck : poolNoLifeguardAck // ignore: cast_nullable_to_non_nullable
as bool,poolDepthMarked: null == poolDepthMarked ? _self.poolDepthMarked : poolDepthMarked // ignore: cast_nullable_to_non_nullable
as bool,checkInFrom: null == checkInFrom ? _self.checkInFrom : checkInFrom // ignore: cast_nullable_to_non_nullable
as String,checkOutBy: null == checkOutBy ? _self.checkOutBy : checkOutBy // ignore: cast_nullable_to_non_nullable
as String,petsAllowed: null == petsAllowed ? _self.petsAllowed : petsAllowed // ignore: cast_nullable_to_non_nullable
as bool,smokingAllowed: null == smokingAllowed ? _self.smokingAllowed : smokingAllowed // ignore: cast_nullable_to_non_nullable
as bool,eventsAllowed: null == eventsAllowed ? _self.eventsAllowed : eventsAllowed // ignore: cast_nullable_to_non_nullable
as bool,quietHours: null == quietHours ? _self.quietHours : quietHours // ignore: cast_nullable_to_non_nullable
as bool,quietFrom: null == quietFrom ? _self.quietFrom : quietFrom // ignore: cast_nullable_to_non_nullable
as String,quietTo: null == quietTo ? _self.quietTo : quietTo // ignore: cast_nullable_to_non_nullable
as String,nightlyPrice: freezed == nightlyPrice ? _self.nightlyPrice : nightlyPrice // ignore: cast_nullable_to_non_nullable
as int?,weekendPrice: freezed == weekendPrice ? _self.weekendPrice : weekendPrice // ignore: cast_nullable_to_non_nullable
as int?,cleaningFee: null == cleaningFee ? _self.cleaningFee : cleaningFee // ignore: cast_nullable_to_non_nullable
as int,weeklyDiscountPercent: null == weeklyDiscountPercent ? _self.weeklyDiscountPercent : weeklyDiscountPercent // ignore: cast_nullable_to_non_nullable
as int,minNights: null == minNights ? _self.minNights : minNights // ignore: cast_nullable_to_non_nullable
as int,instantBook: null == instantBook ? _self.instantBook : instantBook // ignore: cast_nullable_to_non_nullable
as bool,cancellation: null == cancellation ? _self.cancellation : cancellation // ignore: cast_nullable_to_non_nullable
as CancellationPolicy,checkInMethod: null == checkInMethod ? _self.checkInMethod : checkInMethod // ignore: cast_nullable_to_non_nullable
as SelfCheckIn,lockboxCode: null == lockboxCode ? _self.lockboxCode : lockboxCode // ignore: cast_nullable_to_non_nullable
as String,lockboxHint: null == lockboxHint ? _self.lockboxHint : lockboxHint // ignore: cast_nullable_to_non_nullable
as String,wifiName: null == wifiName ? _self.wifiName : wifiName // ignore: cast_nullable_to_non_nullable
as String,wifiPassword: null == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String,poolInstructions: null == poolInstructions ? _self.poolInstructions : poolInstructions // ignore: cast_nullable_to_non_nullable
as String,houseInstructions: null == houseInstructions ? _self.houseInstructions : houseInstructions // ignore: cast_nullable_to_non_nullable
as String,checkoutTasks: null == checkoutTasks ? _self._checkoutTasks : checkoutTasks // ignore: cast_nullable_to_non_nullable
as List<String>,permitType: freezed == permitType ? _self.permitType : permitType // ignore: cast_nullable_to_non_nullable
as PermitType?,permitNo: null == permitNo ? _self.permitNo : permitNo // ignore: cast_nullable_to_non_nullable
as String,documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as Map<HostDocKind, HostDocument>,multiUnitParcel: null == multiUnitParcel ? _self.multiUnitParcel : multiUnitParcel // ignore: cast_nullable_to_non_nullable
as bool,onBehalfOfOwner: null == onBehalfOfOwner ? _self.onBehalfOfOwner : onBehalfOfOwner // ignore: cast_nullable_to_non_nullable
as bool,kbsDeclaration: null == kbsDeclaration ? _self.kbsDeclaration : kbsDeclaration // ignore: cast_nullable_to_non_nullable
as bool,permitHolderDeclaration: null == permitHolderDeclaration ? _self.permitHolderDeclaration : permitHolderDeclaration // ignore: cast_nullable_to_non_nullable
as bool,updateDeclaration: null == updateDeclaration ? _self.updateDeclaration : updateDeclaration // ignore: cast_nullable_to_non_nullable
as bool,taxType: null == taxType ? _self.taxType : taxType // ignore: cast_nullable_to_non_nullable
as TaxType,taxId: null == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String,taxOffice: null == taxOffice ? _self.taxOffice : taxOffice // ignore: cast_nullable_to_non_nullable
as String,identityDone: null == identityDone ? _self._identityDone : identityDone // ignore: cast_nullable_to_non_nullable
as Set<IdentityStep>,verifiedName: freezed == verifiedName ? _self.verifiedName : verifiedName // ignore: cast_nullable_to_non_nullable
as String?,accountHolder: null == accountHolder ? _self.accountHolder : accountHolder // ignore: cast_nullable_to_non_nullable
as String,iban: null == iban ? _self.iban : iban // ignore: cast_nullable_to_non_nullable
as String,billingAddress: null == billingAddress ? _self.billingAddress : billingAddress // ignore: cast_nullable_to_non_nullable
as String,emergencyPhone: null == emergencyPhone ? _self.emergencyPhone : emergencyPhone // ignore: cast_nullable_to_non_nullable
as String,reachableDuringStay: null == reachableDuringStay ? _self.reachableDuringStay : reachableDuringStay // ignore: cast_nullable_to_non_nullable
as bool,accuracyConsent: null == accuracyConsent ? _self.accuracyConsent : accuracyConsent // ignore: cast_nullable_to_non_nullable
as bool,agreementConsent: null == agreementConsent ? _self.agreementConsent : agreementConsent // ignore: cast_nullable_to_non_nullable
as bool,ministryConsent: null == ministryConsent ? _self.ministryConsent : ministryConsent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$EarningsEstimate {

 int get nights; int get nightly; int get stayTotal; int get cleaningFee;/// Ev sahibinden kesilen hizmet bedeli (backend oranı).
 int get serviceFee; int get hostEarns;/// Bölgedeki benzer ilanların gecelik aralığı.
 int get similarMin; int get similarMax;
/// Create a copy of EarningsEstimate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarningsEstimateCopyWith<EarningsEstimate> get copyWith => _$EarningsEstimateCopyWithImpl<EarningsEstimate>(this as EarningsEstimate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarningsEstimate&&(identical(other.nights, nights) || other.nights == nights)&&(identical(other.nightly, nightly) || other.nightly == nightly)&&(identical(other.stayTotal, stayTotal) || other.stayTotal == stayTotal)&&(identical(other.cleaningFee, cleaningFee) || other.cleaningFee == cleaningFee)&&(identical(other.serviceFee, serviceFee) || other.serviceFee == serviceFee)&&(identical(other.hostEarns, hostEarns) || other.hostEarns == hostEarns)&&(identical(other.similarMin, similarMin) || other.similarMin == similarMin)&&(identical(other.similarMax, similarMax) || other.similarMax == similarMax));
}


@override
int get hashCode => Object.hash(runtimeType,nights,nightly,stayTotal,cleaningFee,serviceFee,hostEarns,similarMin,similarMax);

@override
String toString() {
  return 'EarningsEstimate(nights: $nights, nightly: $nightly, stayTotal: $stayTotal, cleaningFee: $cleaningFee, serviceFee: $serviceFee, hostEarns: $hostEarns, similarMin: $similarMin, similarMax: $similarMax)';
}


}

/// @nodoc
abstract mixin class $EarningsEstimateCopyWith<$Res>  {
  factory $EarningsEstimateCopyWith(EarningsEstimate value, $Res Function(EarningsEstimate) _then) = _$EarningsEstimateCopyWithImpl;
@useResult
$Res call({
 int nights, int nightly, int stayTotal, int cleaningFee, int serviceFee, int hostEarns, int similarMin, int similarMax
});




}
/// @nodoc
class _$EarningsEstimateCopyWithImpl<$Res>
    implements $EarningsEstimateCopyWith<$Res> {
  _$EarningsEstimateCopyWithImpl(this._self, this._then);

  final EarningsEstimate _self;
  final $Res Function(EarningsEstimate) _then;

/// Create a copy of EarningsEstimate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nights = null,Object? nightly = null,Object? stayTotal = null,Object? cleaningFee = null,Object? serviceFee = null,Object? hostEarns = null,Object? similarMin = null,Object? similarMax = null,}) {
  return _then(EarningsEstimate(
nights: null == nights ? _self.nights : nights // ignore: cast_nullable_to_non_nullable
as int,nightly: null == nightly ? _self.nightly : nightly // ignore: cast_nullable_to_non_nullable
as int,stayTotal: null == stayTotal ? _self.stayTotal : stayTotal // ignore: cast_nullable_to_non_nullable
as int,cleaningFee: null == cleaningFee ? _self.cleaningFee : cleaningFee // ignore: cast_nullable_to_non_nullable
as int,serviceFee: null == serviceFee ? _self.serviceFee : serviceFee // ignore: cast_nullable_to_non_nullable
as int,hostEarns: null == hostEarns ? _self.hostEarns : hostEarns // ignore: cast_nullable_to_non_nullable
as int,similarMin: null == similarMin ? _self.similarMin : similarMin // ignore: cast_nullable_to_non_nullable
as int,similarMax: null == similarMax ? _self.similarMax : similarMax // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EarningsEstimate].
extension EarningsEstimatePatterns on EarningsEstimate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarningsEstimate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarningsEstimate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarningsEstimate value)  $default,){
final _that = this;
switch (_that) {
case _EarningsEstimate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarningsEstimate value)?  $default,){
final _that = this;
switch (_that) {
case _EarningsEstimate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int nights,  int nightly,  int stayTotal,  int cleaningFee,  int serviceFee,  int hostEarns,  int similarMin,  int similarMax)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarningsEstimate() when $default != null:
return $default(_that.nights,_that.nightly,_that.stayTotal,_that.cleaningFee,_that.serviceFee,_that.hostEarns,_that.similarMin,_that.similarMax);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int nights,  int nightly,  int stayTotal,  int cleaningFee,  int serviceFee,  int hostEarns,  int similarMin,  int similarMax)  $default,) {final _that = this;
switch (_that) {
case _EarningsEstimate():
return $default(_that.nights,_that.nightly,_that.stayTotal,_that.cleaningFee,_that.serviceFee,_that.hostEarns,_that.similarMin,_that.similarMax);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int nights,  int nightly,  int stayTotal,  int cleaningFee,  int serviceFee,  int hostEarns,  int similarMin,  int similarMax)?  $default,) {final _that = this;
switch (_that) {
case _EarningsEstimate() when $default != null:
return $default(_that.nights,_that.nightly,_that.stayTotal,_that.cleaningFee,_that.serviceFee,_that.hostEarns,_that.similarMin,_that.similarMax);case _:
  return null;

}
}

}

/// @nodoc


class _EarningsEstimate implements EarningsEstimate {
  const _EarningsEstimate({required this.nights, required this.nightly, required this.stayTotal, required this.cleaningFee, required this.serviceFee, required this.hostEarns, required this.similarMin, required this.similarMax});
  

@override final  int nights;
@override final  int nightly;
@override final  int stayTotal;
@override final  int cleaningFee;
/// Ev sahibinden kesilen hizmet bedeli (backend oranı).
@override final  int serviceFee;
@override final  int hostEarns;
/// Bölgedeki benzer ilanların gecelik aralığı.
@override final  int similarMin;
@override final  int similarMax;

/// Create a copy of EarningsEstimate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarningsEstimateCopyWith<_EarningsEstimate> get copyWith => __$EarningsEstimateCopyWithImpl<_EarningsEstimate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarningsEstimate&&(identical(other.nights, nights) || other.nights == nights)&&(identical(other.nightly, nightly) || other.nightly == nightly)&&(identical(other.stayTotal, stayTotal) || other.stayTotal == stayTotal)&&(identical(other.cleaningFee, cleaningFee) || other.cleaningFee == cleaningFee)&&(identical(other.serviceFee, serviceFee) || other.serviceFee == serviceFee)&&(identical(other.hostEarns, hostEarns) || other.hostEarns == hostEarns)&&(identical(other.similarMin, similarMin) || other.similarMin == similarMin)&&(identical(other.similarMax, similarMax) || other.similarMax == similarMax));
}


@override
int get hashCode => Object.hash(runtimeType,nights,nightly,stayTotal,cleaningFee,serviceFee,hostEarns,similarMin,similarMax);

@override
String toString() {
  return 'EarningsEstimate(nights: $nights, nightly: $nightly, stayTotal: $stayTotal, cleaningFee: $cleaningFee, serviceFee: $serviceFee, hostEarns: $hostEarns, similarMin: $similarMin, similarMax: $similarMax)';
}


}

/// @nodoc
abstract mixin class _$EarningsEstimateCopyWith<$Res> implements $EarningsEstimateCopyWith<$Res> {
  factory _$EarningsEstimateCopyWith(_EarningsEstimate value, $Res Function(_EarningsEstimate) _then) = __$EarningsEstimateCopyWithImpl;
@override @useResult
$Res call({
 int nights, int nightly, int stayTotal, int cleaningFee, int serviceFee, int hostEarns, int similarMin, int similarMax
});




}
/// @nodoc
class __$EarningsEstimateCopyWithImpl<$Res>
    implements _$EarningsEstimateCopyWith<$Res> {
  __$EarningsEstimateCopyWithImpl(this._self, this._then);

  final _EarningsEstimate _self;
  final $Res Function(_EarningsEstimate) _then;

/// Create a copy of EarningsEstimate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nights = null,Object? nightly = null,Object? stayTotal = null,Object? cleaningFee = null,Object? serviceFee = null,Object? hostEarns = null,Object? similarMin = null,Object? similarMax = null,}) {
  return _then(_EarningsEstimate(
nights: null == nights ? _self.nights : nights // ignore: cast_nullable_to_non_nullable
as int,nightly: null == nightly ? _self.nightly : nightly // ignore: cast_nullable_to_non_nullable
as int,stayTotal: null == stayTotal ? _self.stayTotal : stayTotal // ignore: cast_nullable_to_non_nullable
as int,cleaningFee: null == cleaningFee ? _self.cleaningFee : cleaningFee // ignore: cast_nullable_to_non_nullable
as int,serviceFee: null == serviceFee ? _self.serviceFee : serviceFee // ignore: cast_nullable_to_non_nullable
as int,hostEarns: null == hostEarns ? _self.hostEarns : hostEarns // ignore: cast_nullable_to_non_nullable
as int,similarMin: null == similarMin ? _self.similarMin : similarMin // ignore: cast_nullable_to_non_nullable
as int,similarMax: null == similarMax ? _self.similarMax : similarMax // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
