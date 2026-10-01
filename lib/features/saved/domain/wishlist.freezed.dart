// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wishlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Wishlist {

 String get id; String get name; List<String> get listingIds; DateTime get updatedAt;
/// Create a copy of Wishlist
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishlistCopyWith<Wishlist> get copyWith => _$WishlistCopyWithImpl<Wishlist>(this as Wishlist, _$identity);

  /// Serializes this Wishlist to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Wishlist&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.listingIds, listingIds)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(listingIds),updatedAt);

@override
String toString() {
  return 'Wishlist(id: $id, name: $name, listingIds: $listingIds, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $WishlistCopyWith<$Res>  {
  factory $WishlistCopyWith(Wishlist value, $Res Function(Wishlist) _then) = _$WishlistCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<String> listingIds, DateTime updatedAt
});




}
/// @nodoc
class _$WishlistCopyWithImpl<$Res>
    implements $WishlistCopyWith<$Res> {
  _$WishlistCopyWithImpl(this._self, this._then);

  final Wishlist _self;
  final $Res Function(Wishlist) _then;

/// Create a copy of Wishlist
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? listingIds = null,Object? updatedAt = null,}) {
  return _then(Wishlist(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,listingIds: null == listingIds ? _self.listingIds : listingIds // ignore: cast_nullable_to_non_nullable
as List<String>,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Wishlist].
extension WishlistPatterns on Wishlist {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Wishlist value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Wishlist() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Wishlist value)  $default,){
final _that = this;
switch (_that) {
case _Wishlist():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Wishlist value)?  $default,){
final _that = this;
switch (_that) {
case _Wishlist() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<String> listingIds,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Wishlist() when $default != null:
return $default(_that.id,_that.name,_that.listingIds,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<String> listingIds,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Wishlist():
return $default(_that.id,_that.name,_that.listingIds,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<String> listingIds,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Wishlist() when $default != null:
return $default(_that.id,_that.name,_that.listingIds,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Wishlist implements Wishlist {
  const _Wishlist({required this.id, required this.name,  List<String> listingIds = const <String>[], required this.updatedAt}): _listingIds = listingIds;
  factory _Wishlist.fromJson(Map<String, dynamic> json) => _$WishlistFromJson(json);

@override final  String id;
@override final  String name;
 final  List<String> _listingIds;
@override@JsonKey() List<String> get listingIds {
  if (_listingIds is EqualUnmodifiableListView) return _listingIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listingIds);
}

@override final  DateTime updatedAt;

/// Create a copy of Wishlist
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishlistCopyWith<_Wishlist> get copyWith => __$WishlistCopyWithImpl<_Wishlist>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WishlistToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Wishlist&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._listingIds, _listingIds)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_listingIds),updatedAt);

@override
String toString() {
  return 'Wishlist(id: $id, name: $name, listingIds: $listingIds, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WishlistCopyWith<$Res> implements $WishlistCopyWith<$Res> {
  factory _$WishlistCopyWith(_Wishlist value, $Res Function(_Wishlist) _then) = __$WishlistCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<String> listingIds, DateTime updatedAt
});




}
/// @nodoc
class __$WishlistCopyWithImpl<$Res>
    implements _$WishlistCopyWith<$Res> {
  __$WishlistCopyWithImpl(this._self, this._then);

  final _Wishlist _self;
  final $Res Function(_Wishlist) _then;

/// Create a copy of Wishlist
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? listingIds = null,Object? updatedAt = null,}) {
  return _then(_Wishlist(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,listingIds: null == listingIds ? _self._listingIds : listingIds // ignore: cast_nullable_to_non_nullable
as List<String>,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
