// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'house_guide.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GuideSection {

 GuideSectionKind get kind; String get title; List<String> get items;
/// Create a copy of GuideSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuideSectionCopyWith<GuideSection> get copyWith => _$GuideSectionCopyWithImpl<GuideSection>(this as GuideSection, _$identity);

  /// Serializes this GuideSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuideSection&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,title,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'GuideSection(kind: $kind, title: $title, items: $items)';
}


}

/// @nodoc
abstract mixin class $GuideSectionCopyWith<$Res>  {
  factory $GuideSectionCopyWith(GuideSection value, $Res Function(GuideSection) _then) = _$GuideSectionCopyWithImpl;
@useResult
$Res call({
 GuideSectionKind kind, String title, List<String> items
});




}
/// @nodoc
class _$GuideSectionCopyWithImpl<$Res>
    implements $GuideSectionCopyWith<$Res> {
  _$GuideSectionCopyWithImpl(this._self, this._then);

  final GuideSection _self;
  final $Res Function(GuideSection) _then;

/// Create a copy of GuideSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? title = null,Object? items = null,}) {
  return _then(GuideSection(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as GuideSectionKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [GuideSection].
extension GuideSectionPatterns on GuideSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuideSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuideSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuideSection value)  $default,){
final _that = this;
switch (_that) {
case _GuideSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuideSection value)?  $default,){
final _that = this;
switch (_that) {
case _GuideSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GuideSectionKind kind,  String title,  List<String> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuideSection() when $default != null:
return $default(_that.kind,_that.title,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GuideSectionKind kind,  String title,  List<String> items)  $default,) {final _that = this;
switch (_that) {
case _GuideSection():
return $default(_that.kind,_that.title,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GuideSectionKind kind,  String title,  List<String> items)?  $default,) {final _that = this;
switch (_that) {
case _GuideSection() when $default != null:
return $default(_that.kind,_that.title,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GuideSection implements GuideSection {
  const _GuideSection({required this.kind, required this.title,  List<String> items = const <String>[]}): _items = items;
  factory _GuideSection.fromJson(Map<String, dynamic> json) => _$GuideSectionFromJson(json);

@override final  GuideSectionKind kind;
@override final  String title;
 final  List<String> _items;
@override@JsonKey() List<String> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of GuideSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuideSectionCopyWith<_GuideSection> get copyWith => __$GuideSectionCopyWithImpl<_GuideSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GuideSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuideSection&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,title,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'GuideSection(kind: $kind, title: $title, items: $items)';
}


}

/// @nodoc
abstract mixin class _$GuideSectionCopyWith<$Res> implements $GuideSectionCopyWith<$Res> {
  factory _$GuideSectionCopyWith(_GuideSection value, $Res Function(_GuideSection) _then) = __$GuideSectionCopyWithImpl;
@override @useResult
$Res call({
 GuideSectionKind kind, String title, List<String> items
});




}
/// @nodoc
class __$GuideSectionCopyWithImpl<$Res>
    implements _$GuideSectionCopyWith<$Res> {
  __$GuideSectionCopyWithImpl(this._self, this._then);

  final _GuideSection _self;
  final $Res Function(_GuideSection) _then;

/// Create a copy of GuideSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? title = null,Object? items = null,}) {
  return _then(_GuideSection(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as GuideSectionKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$HouseGuide {

 String get lockboxCode;/// "Kapının sağındaki gri kutu"
 String get lockboxHint; String get wifiName; String get wifiPassword; List<GuideSection> get sections; List<String> get checkoutTasks;
/// Create a copy of HouseGuide
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HouseGuideCopyWith<HouseGuide> get copyWith => _$HouseGuideCopyWithImpl<HouseGuide>(this as HouseGuide, _$identity);

  /// Serializes this HouseGuide to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HouseGuide&&(identical(other.lockboxCode, lockboxCode) || other.lockboxCode == lockboxCode)&&(identical(other.lockboxHint, lockboxHint) || other.lockboxHint == lockboxHint)&&(identical(other.wifiName, wifiName) || other.wifiName == wifiName)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword)&&const DeepCollectionEquality().equals(other.sections, sections)&&const DeepCollectionEquality().equals(other.checkoutTasks, checkoutTasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lockboxCode,lockboxHint,wifiName,wifiPassword,const DeepCollectionEquality().hash(sections),const DeepCollectionEquality().hash(checkoutTasks));

@override
String toString() {
  return 'HouseGuide(lockboxCode: $lockboxCode, lockboxHint: $lockboxHint, wifiName: $wifiName, wifiPassword: $wifiPassword, sections: $sections, checkoutTasks: $checkoutTasks)';
}


}

/// @nodoc
abstract mixin class $HouseGuideCopyWith<$Res>  {
  factory $HouseGuideCopyWith(HouseGuide value, $Res Function(HouseGuide) _then) = _$HouseGuideCopyWithImpl;
@useResult
$Res call({
 String lockboxCode, String lockboxHint, String wifiName, String wifiPassword, List<GuideSection> sections, List<String> checkoutTasks
});




}
/// @nodoc
class _$HouseGuideCopyWithImpl<$Res>
    implements $HouseGuideCopyWith<$Res> {
  _$HouseGuideCopyWithImpl(this._self, this._then);

  final HouseGuide _self;
  final $Res Function(HouseGuide) _then;

/// Create a copy of HouseGuide
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lockboxCode = null,Object? lockboxHint = null,Object? wifiName = null,Object? wifiPassword = null,Object? sections = null,Object? checkoutTasks = null,}) {
  return _then(HouseGuide(
lockboxCode: null == lockboxCode ? _self.lockboxCode : lockboxCode // ignore: cast_nullable_to_non_nullable
as String,lockboxHint: null == lockboxHint ? _self.lockboxHint : lockboxHint // ignore: cast_nullable_to_non_nullable
as String,wifiName: null == wifiName ? _self.wifiName : wifiName // ignore: cast_nullable_to_non_nullable
as String,wifiPassword: null == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<GuideSection>,checkoutTasks: null == checkoutTasks ? _self.checkoutTasks : checkoutTasks // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [HouseGuide].
extension HouseGuidePatterns on HouseGuide {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HouseGuide value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HouseGuide() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HouseGuide value)  $default,){
final _that = this;
switch (_that) {
case _HouseGuide():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HouseGuide value)?  $default,){
final _that = this;
switch (_that) {
case _HouseGuide() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lockboxCode,  String lockboxHint,  String wifiName,  String wifiPassword,  List<GuideSection> sections,  List<String> checkoutTasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HouseGuide() when $default != null:
return $default(_that.lockboxCode,_that.lockboxHint,_that.wifiName,_that.wifiPassword,_that.sections,_that.checkoutTasks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lockboxCode,  String lockboxHint,  String wifiName,  String wifiPassword,  List<GuideSection> sections,  List<String> checkoutTasks)  $default,) {final _that = this;
switch (_that) {
case _HouseGuide():
return $default(_that.lockboxCode,_that.lockboxHint,_that.wifiName,_that.wifiPassword,_that.sections,_that.checkoutTasks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lockboxCode,  String lockboxHint,  String wifiName,  String wifiPassword,  List<GuideSection> sections,  List<String> checkoutTasks)?  $default,) {final _that = this;
switch (_that) {
case _HouseGuide() when $default != null:
return $default(_that.lockboxCode,_that.lockboxHint,_that.wifiName,_that.wifiPassword,_that.sections,_that.checkoutTasks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HouseGuide implements HouseGuide {
  const _HouseGuide({required this.lockboxCode, required this.lockboxHint, required this.wifiName, required this.wifiPassword,  List<GuideSection> sections = const <GuideSection>[],  List<String> checkoutTasks = const <String>[]}): _sections = sections,_checkoutTasks = checkoutTasks;
  factory _HouseGuide.fromJson(Map<String, dynamic> json) => _$HouseGuideFromJson(json);

@override final  String lockboxCode;
/// "Kapının sağındaki gri kutu"
@override final  String lockboxHint;
@override final  String wifiName;
@override final  String wifiPassword;
 final  List<GuideSection> _sections;
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


/// Create a copy of HouseGuide
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HouseGuideCopyWith<_HouseGuide> get copyWith => __$HouseGuideCopyWithImpl<_HouseGuide>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HouseGuideToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HouseGuide&&(identical(other.lockboxCode, lockboxCode) || other.lockboxCode == lockboxCode)&&(identical(other.lockboxHint, lockboxHint) || other.lockboxHint == lockboxHint)&&(identical(other.wifiName, wifiName) || other.wifiName == wifiName)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword)&&const DeepCollectionEquality().equals(other._sections, _sections)&&const DeepCollectionEquality().equals(other._checkoutTasks, _checkoutTasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lockboxCode,lockboxHint,wifiName,wifiPassword,const DeepCollectionEquality().hash(_sections),const DeepCollectionEquality().hash(_checkoutTasks));

@override
String toString() {
  return 'HouseGuide(lockboxCode: $lockboxCode, lockboxHint: $lockboxHint, wifiName: $wifiName, wifiPassword: $wifiPassword, sections: $sections, checkoutTasks: $checkoutTasks)';
}


}

/// @nodoc
abstract mixin class _$HouseGuideCopyWith<$Res> implements $HouseGuideCopyWith<$Res> {
  factory _$HouseGuideCopyWith(_HouseGuide value, $Res Function(_HouseGuide) _then) = __$HouseGuideCopyWithImpl;
@override @useResult
$Res call({
 String lockboxCode, String lockboxHint, String wifiName, String wifiPassword, List<GuideSection> sections, List<String> checkoutTasks
});




}
/// @nodoc
class __$HouseGuideCopyWithImpl<$Res>
    implements _$HouseGuideCopyWith<$Res> {
  __$HouseGuideCopyWithImpl(this._self, this._then);

  final _HouseGuide _self;
  final $Res Function(_HouseGuide) _then;

/// Create a copy of HouseGuide
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lockboxCode = null,Object? lockboxHint = null,Object? wifiName = null,Object? wifiPassword = null,Object? sections = null,Object? checkoutTasks = null,}) {
  return _then(_HouseGuide(
lockboxCode: null == lockboxCode ? _self.lockboxCode : lockboxCode // ignore: cast_nullable_to_non_nullable
as String,lockboxHint: null == lockboxHint ? _self.lockboxHint : lockboxHint // ignore: cast_nullable_to_non_nullable
as String,wifiName: null == wifiName ? _self.wifiName : wifiName // ignore: cast_nullable_to_non_nullable
as String,wifiPassword: null == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<GuideSection>,checkoutTasks: null == checkoutTasks ? _self._checkoutTasks : checkoutTasks // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
