// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Conversation {

 String get id; ConversationKind get kind;/// Karşı taraf: "Ayla Hanım", "Bungalovum Destek".
 String get title; String? get listingId; String? get bookingId;/// Destek talep numarası: "2041".
 String? get ticketNo; String get lastMessage; DateTime get lastAt; int get unread; bool get online;/// Son mesajı ben mi gönderdim (önizlemede "Sen: ...").
 bool get lastFromMe;
/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationCopyWith<Conversation> get copyWith => _$ConversationCopyWithImpl<Conversation>(this as Conversation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Conversation&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.ticketNo, ticketNo) || other.ticketNo == ticketNo)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastAt, lastAt) || other.lastAt == lastAt)&&(identical(other.unread, unread) || other.unread == unread)&&(identical(other.online, online) || other.online == online)&&(identical(other.lastFromMe, lastFromMe) || other.lastFromMe == lastFromMe));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,title,listingId,bookingId,ticketNo,lastMessage,lastAt,unread,online,lastFromMe);

@override
String toString() {
  return 'Conversation(id: $id, kind: $kind, title: $title, listingId: $listingId, bookingId: $bookingId, ticketNo: $ticketNo, lastMessage: $lastMessage, lastAt: $lastAt, unread: $unread, online: $online, lastFromMe: $lastFromMe)';
}


}

/// @nodoc
abstract mixin class $ConversationCopyWith<$Res>  {
  factory $ConversationCopyWith(Conversation value, $Res Function(Conversation) _then) = _$ConversationCopyWithImpl;
@useResult
$Res call({
 String id, ConversationKind kind, String title, String? listingId, String? bookingId, String? ticketNo, String lastMessage, DateTime lastAt, int unread, bool online, bool lastFromMe
});




}
/// @nodoc
class _$ConversationCopyWithImpl<$Res>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._self, this._then);

  final Conversation _self;
  final $Res Function(Conversation) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? listingId = freezed,Object? bookingId = freezed,Object? ticketNo = freezed,Object? lastMessage = null,Object? lastAt = null,Object? unread = null,Object? online = null,Object? lastFromMe = null,}) {
  return _then(Conversation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ConversationKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,listingId: freezed == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String?,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,ticketNo: freezed == ticketNo ? _self.ticketNo : ticketNo // ignore: cast_nullable_to_non_nullable
as String?,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,lastAt: null == lastAt ? _self.lastAt : lastAt // ignore: cast_nullable_to_non_nullable
as DateTime,unread: null == unread ? _self.unread : unread // ignore: cast_nullable_to_non_nullable
as int,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,lastFromMe: null == lastFromMe ? _self.lastFromMe : lastFromMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Conversation].
extension ConversationPatterns on Conversation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Conversation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Conversation value)  $default,){
final _that = this;
switch (_that) {
case _Conversation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Conversation value)?  $default,){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ConversationKind kind,  String title,  String? listingId,  String? bookingId,  String? ticketNo,  String lastMessage,  DateTime lastAt,  int unread,  bool online,  bool lastFromMe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.kind,_that.title,_that.listingId,_that.bookingId,_that.ticketNo,_that.lastMessage,_that.lastAt,_that.unread,_that.online,_that.lastFromMe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ConversationKind kind,  String title,  String? listingId,  String? bookingId,  String? ticketNo,  String lastMessage,  DateTime lastAt,  int unread,  bool online,  bool lastFromMe)  $default,) {final _that = this;
switch (_that) {
case _Conversation():
return $default(_that.id,_that.kind,_that.title,_that.listingId,_that.bookingId,_that.ticketNo,_that.lastMessage,_that.lastAt,_that.unread,_that.online,_that.lastFromMe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ConversationKind kind,  String title,  String? listingId,  String? bookingId,  String? ticketNo,  String lastMessage,  DateTime lastAt,  int unread,  bool online,  bool lastFromMe)?  $default,) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.kind,_that.title,_that.listingId,_that.bookingId,_that.ticketNo,_that.lastMessage,_that.lastAt,_that.unread,_that.online,_that.lastFromMe);case _:
  return null;

}
}

}

/// @nodoc


class _Conversation extends Conversation {
  const _Conversation({required this.id, required this.kind, required this.title, this.listingId, this.bookingId, this.ticketNo, required this.lastMessage, required this.lastAt, this.unread = 0, this.online = false, this.lastFromMe = false}): super._();
  

@override final  String id;
@override final  ConversationKind kind;
/// Karşı taraf: "Ayla Hanım", "Bungalovum Destek".
@override final  String title;
@override final  String? listingId;
@override final  String? bookingId;
/// Destek talep numarası: "2041".
@override final  String? ticketNo;
@override final  String lastMessage;
@override final  DateTime lastAt;
@override@JsonKey() final  int unread;
@override@JsonKey() final  bool online;
/// Son mesajı ben mi gönderdim (önizlemede "Sen: ...").
@override@JsonKey() final  bool lastFromMe;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationCopyWith<_Conversation> get copyWith => __$ConversationCopyWithImpl<_Conversation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Conversation&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.ticketNo, ticketNo) || other.ticketNo == ticketNo)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastAt, lastAt) || other.lastAt == lastAt)&&(identical(other.unread, unread) || other.unread == unread)&&(identical(other.online, online) || other.online == online)&&(identical(other.lastFromMe, lastFromMe) || other.lastFromMe == lastFromMe));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,title,listingId,bookingId,ticketNo,lastMessage,lastAt,unread,online,lastFromMe);

@override
String toString() {
  return 'Conversation(id: $id, kind: $kind, title: $title, listingId: $listingId, bookingId: $bookingId, ticketNo: $ticketNo, lastMessage: $lastMessage, lastAt: $lastAt, unread: $unread, online: $online, lastFromMe: $lastFromMe)';
}


}

/// @nodoc
abstract mixin class _$ConversationCopyWith<$Res> implements $ConversationCopyWith<$Res> {
  factory _$ConversationCopyWith(_Conversation value, $Res Function(_Conversation) _then) = __$ConversationCopyWithImpl;
@override @useResult
$Res call({
 String id, ConversationKind kind, String title, String? listingId, String? bookingId, String? ticketNo, String lastMessage, DateTime lastAt, int unread, bool online, bool lastFromMe
});




}
/// @nodoc
class __$ConversationCopyWithImpl<$Res>
    implements _$ConversationCopyWith<$Res> {
  __$ConversationCopyWithImpl(this._self, this._then);

  final _Conversation _self;
  final $Res Function(_Conversation) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? listingId = freezed,Object? bookingId = freezed,Object? ticketNo = freezed,Object? lastMessage = null,Object? lastAt = null,Object? unread = null,Object? online = null,Object? lastFromMe = null,}) {
  return _then(_Conversation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ConversationKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,listingId: freezed == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String?,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,ticketNo: freezed == ticketNo ? _self.ticketNo : ticketNo // ignore: cast_nullable_to_non_nullable
as String?,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,lastAt: null == lastAt ? _self.lastAt : lastAt // ignore: cast_nullable_to_non_nullable
as DateTime,unread: null == unread ? _self.unread : unread // ignore: cast_nullable_to_non_nullable
as int,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,lastFromMe: null == lastFromMe ? _self.lastFromMe : lastFromMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ChatMessage {

 String get id; bool get fromMe; String? get text;/// Paylaşılan fotoğraf (sunucu adresi ya da gönderilirken yerel yol).
 String? get photoUrl; DateTime get sentAt; MessageStatus get status;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.fromMe, fromMe) || other.fromMe == fromMe)&&(identical(other.text, text) || other.text == text)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,fromMe,text,photoUrl,sentAt,status);

@override
String toString() {
  return 'ChatMessage(id: $id, fromMe: $fromMe, text: $text, photoUrl: $photoUrl, sentAt: $sentAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 String id, bool fromMe, String? text, String? photoUrl, DateTime sentAt, MessageStatus status
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromMe = null,Object? text = freezed,Object? photoUrl = freezed,Object? sentAt = null,Object? status = null,}) {
  return _then(ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromMe: null == fromMe ? _self.fromMe : fromMe // ignore: cast_nullable_to_non_nullable
as bool,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  bool fromMe,  String? text,  String? photoUrl,  DateTime sentAt,  MessageStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.fromMe,_that.text,_that.photoUrl,_that.sentAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  bool fromMe,  String? text,  String? photoUrl,  DateTime sentAt,  MessageStatus status)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.id,_that.fromMe,_that.text,_that.photoUrl,_that.sentAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  bool fromMe,  String? text,  String? photoUrl,  DateTime sentAt,  MessageStatus status)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.fromMe,_that.text,_that.photoUrl,_that.sentAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _ChatMessage implements ChatMessage {
  const _ChatMessage({required this.id, required this.fromMe, this.text, this.photoUrl, required this.sentAt, this.status = MessageStatus.sent});
  

@override final  String id;
@override final  bool fromMe;
@override final  String? text;
/// Paylaşılan fotoğraf (sunucu adresi ya da gönderilirken yerel yol).
@override final  String? photoUrl;
@override final  DateTime sentAt;
@override@JsonKey() final  MessageStatus status;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.fromMe, fromMe) || other.fromMe == fromMe)&&(identical(other.text, text) || other.text == text)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,fromMe,text,photoUrl,sentAt,status);

@override
String toString() {
  return 'ChatMessage(id: $id, fromMe: $fromMe, text: $text, photoUrl: $photoUrl, sentAt: $sentAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, bool fromMe, String? text, String? photoUrl, DateTime sentAt, MessageStatus status
});




}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromMe = null,Object? text = freezed,Object? photoUrl = freezed,Object? sentAt = null,Object? status = null,}) {
  return _then(_ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromMe: null == fromMe ? _self.fromMe : fromMe // ignore: cast_nullable_to_non_nullable
as bool,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus,
  ));
}


}

/// @nodoc
mixin _$AppNotification {

 String get id; NotificationKind get kind; String get title; String get body; DateTime get at; bool get read; String? get targetId;
/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppNotificationCopyWith<AppNotification> get copyWith => _$AppNotificationCopyWithImpl<AppNotification>(this as AppNotification, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.at, at) || other.at == at)&&(identical(other.read, read) || other.read == read)&&(identical(other.targetId, targetId) || other.targetId == targetId));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,title,body,at,read,targetId);

@override
String toString() {
  return 'AppNotification(id: $id, kind: $kind, title: $title, body: $body, at: $at, read: $read, targetId: $targetId)';
}


}

/// @nodoc
abstract mixin class $AppNotificationCopyWith<$Res>  {
  factory $AppNotificationCopyWith(AppNotification value, $Res Function(AppNotification) _then) = _$AppNotificationCopyWithImpl;
@useResult
$Res call({
 String id, NotificationKind kind, String title, String body, DateTime at, bool read, String? targetId
});




}
/// @nodoc
class _$AppNotificationCopyWithImpl<$Res>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._self, this._then);

  final AppNotification _self;
  final $Res Function(AppNotification) _then;

/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? body = null,Object? at = null,Object? read = null,Object? targetId = freezed,}) {
  return _then(AppNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as NotificationKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppNotification].
extension AppNotificationPatterns on AppNotification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppNotification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppNotification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppNotification value)  $default,){
final _that = this;
switch (_that) {
case _AppNotification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppNotification value)?  $default,){
final _that = this;
switch (_that) {
case _AppNotification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  NotificationKind kind,  String title,  String body,  DateTime at,  bool read,  String? targetId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppNotification() when $default != null:
return $default(_that.id,_that.kind,_that.title,_that.body,_that.at,_that.read,_that.targetId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  NotificationKind kind,  String title,  String body,  DateTime at,  bool read,  String? targetId)  $default,) {final _that = this;
switch (_that) {
case _AppNotification():
return $default(_that.id,_that.kind,_that.title,_that.body,_that.at,_that.read,_that.targetId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  NotificationKind kind,  String title,  String body,  DateTime at,  bool read,  String? targetId)?  $default,) {final _that = this;
switch (_that) {
case _AppNotification() when $default != null:
return $default(_that.id,_that.kind,_that.title,_that.body,_that.at,_that.read,_that.targetId);case _:
  return null;

}
}

}

/// @nodoc


class _AppNotification implements AppNotification {
  const _AppNotification({required this.id, required this.kind, required this.title, required this.body, required this.at, this.read = false, this.targetId});
  

@override final  String id;
@override final  NotificationKind kind;
@override final  String title;
@override final  String body;
@override final  DateTime at;
@override@JsonKey() final  bool read;
@override final  String? targetId;

/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppNotificationCopyWith<_AppNotification> get copyWith => __$AppNotificationCopyWithImpl<_AppNotification>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.at, at) || other.at == at)&&(identical(other.read, read) || other.read == read)&&(identical(other.targetId, targetId) || other.targetId == targetId));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,title,body,at,read,targetId);

@override
String toString() {
  return 'AppNotification(id: $id, kind: $kind, title: $title, body: $body, at: $at, read: $read, targetId: $targetId)';
}


}

/// @nodoc
abstract mixin class _$AppNotificationCopyWith<$Res> implements $AppNotificationCopyWith<$Res> {
  factory _$AppNotificationCopyWith(_AppNotification value, $Res Function(_AppNotification) _then) = __$AppNotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, NotificationKind kind, String title, String body, DateTime at, bool read, String? targetId
});




}
/// @nodoc
class __$AppNotificationCopyWithImpl<$Res>
    implements _$AppNotificationCopyWith<$Res> {
  __$AppNotificationCopyWithImpl(this._self, this._then);

  final _AppNotification _self;
  final $Res Function(_AppNotification) _then;

/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? body = null,Object? at = null,Object? read = null,Object? targetId = freezed,}) {
  return _then(_AppNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as NotificationKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
