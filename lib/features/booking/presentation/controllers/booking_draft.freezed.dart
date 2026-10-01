// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingDraft {

 String get listingId; StayDates? get dates; GuestCount get guests;
/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDraftCopyWith<BookingDraft> get copyWith => _$BookingDraftCopyWithImpl<BookingDraft>(this as BookingDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDraft&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.dates, dates) || other.dates == dates)&&(identical(other.guests, guests) || other.guests == guests));
}


@override
int get hashCode => Object.hash(runtimeType,listingId,dates,guests);

@override
String toString() {
  return 'BookingDraft(listingId: $listingId, dates: $dates, guests: $guests)';
}


}

/// @nodoc
abstract mixin class $BookingDraftCopyWith<$Res>  {
  factory $BookingDraftCopyWith(BookingDraft value, $Res Function(BookingDraft) _then) = _$BookingDraftCopyWithImpl;
@useResult
$Res call({
 String listingId, StayDates? dates, GuestCount guests
});


$StayDatesCopyWith<$Res>? get dates;$GuestCountCopyWith<$Res> get guests;

}
/// @nodoc
class _$BookingDraftCopyWithImpl<$Res>
    implements $BookingDraftCopyWith<$Res> {
  _$BookingDraftCopyWithImpl(this._self, this._then);

  final BookingDraft _self;
  final $Res Function(BookingDraft) _then;

/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listingId = null,Object? dates = freezed,Object? guests = null,}) {
  return _then(BookingDraft(
listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,dates: freezed == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as StayDates?,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as GuestCount,
  ));
}
/// Create a copy of BookingDraft
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
}/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuestCountCopyWith<$Res> get guests {
  
  return $GuestCountCopyWith<$Res>(_self.guests, (value) {
    return _then(_self.copyWith(guests: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingDraft].
extension BookingDraftPatterns on BookingDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingDraft value)  $default,){
final _that = this;
switch (_that) {
case _BookingDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingDraft value)?  $default,){
final _that = this;
switch (_that) {
case _BookingDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String listingId,  StayDates? dates,  GuestCount guests)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingDraft() when $default != null:
return $default(_that.listingId,_that.dates,_that.guests);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String listingId,  StayDates? dates,  GuestCount guests)  $default,) {final _that = this;
switch (_that) {
case _BookingDraft():
return $default(_that.listingId,_that.dates,_that.guests);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String listingId,  StayDates? dates,  GuestCount guests)?  $default,) {final _that = this;
switch (_that) {
case _BookingDraft() when $default != null:
return $default(_that.listingId,_that.dates,_that.guests);case _:
  return null;

}
}

}

/// @nodoc


class _BookingDraft extends BookingDraft {
  const _BookingDraft({required this.listingId, this.dates, this.guests = const GuestCount()}): super._();
  

@override final  String listingId;
@override final  StayDates? dates;
@override@JsonKey() final  GuestCount guests;

/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingDraftCopyWith<_BookingDraft> get copyWith => __$BookingDraftCopyWithImpl<_BookingDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingDraft&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.dates, dates) || other.dates == dates)&&(identical(other.guests, guests) || other.guests == guests));
}


@override
int get hashCode => Object.hash(runtimeType,listingId,dates,guests);

@override
String toString() {
  return 'BookingDraft(listingId: $listingId, dates: $dates, guests: $guests)';
}


}

/// @nodoc
abstract mixin class _$BookingDraftCopyWith<$Res> implements $BookingDraftCopyWith<$Res> {
  factory _$BookingDraftCopyWith(_BookingDraft value, $Res Function(_BookingDraft) _then) = __$BookingDraftCopyWithImpl;
@override @useResult
$Res call({
 String listingId, StayDates? dates, GuestCount guests
});


@override $StayDatesCopyWith<$Res>? get dates;@override $GuestCountCopyWith<$Res> get guests;

}
/// @nodoc
class __$BookingDraftCopyWithImpl<$Res>
    implements _$BookingDraftCopyWith<$Res> {
  __$BookingDraftCopyWithImpl(this._self, this._then);

  final _BookingDraft _self;
  final $Res Function(_BookingDraft) _then;

/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listingId = null,Object? dates = freezed,Object? guests = null,}) {
  return _then(_BookingDraft(
listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,dates: freezed == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as StayDates?,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as GuestCount,
  ));
}

/// Create a copy of BookingDraft
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
}/// Create a copy of BookingDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuestCountCopyWith<$Res> get guests {
  
  return $GuestCountCopyWith<$Res>(_self.guests, (value) {
    return _then(_self.copyWith(guests: value));
  });
}
}

// dart format on
