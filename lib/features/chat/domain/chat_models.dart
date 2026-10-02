import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_models.freezed.dart';

/// Sohbet türü (62 · filtre çipleri): konaklama/talep ev sahibiyle, destek
/// Kozalak ekibiyle.
enum ConversationKind { stay, request, support }

@freezed
abstract class Conversation with _$Conversation {
  const Conversation._();

  const factory Conversation({
    required String id,
    required ConversationKind kind,

    /// Karşı taraf: "Ayla Hanım", "Kozalak Destek".
    required String title,
    String? listingId,
    String? bookingId,

    /// Destek talep numarası: "2041".
    String? ticketNo,
    required String lastMessage,
    required DateTime lastAt,
    @Default(0) int unread,
    @Default(false) bool online,

    /// Son mesajı ben mi gönderdim (önizlemede "Sen: ...").
    @Default(false) bool lastFromMe,
  }) = _Conversation;

  bool get isSupport => kind == ConversationKind.support;
}

enum MessageStatus { sending, sent, read, failed }

@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required bool fromMe,
    String? text,

    /// Paylaşılan fotoğraf (sunucu adresi ya da gönderilirken yerel yol).
    String? photoUrl,
    required DateTime sentAt,
    @Default(MessageStatus.sent) MessageStatus status,
  }) = _ChatMessage;
}

enum NotificationKind {
  bookingConfirmed,
  requestApproved,
  requestDeclined,
  message,
  priceDrop,
  reviewReminder,
  weather,
}

/// 64 · Bildirim Merkezi. [targetId] türüne göre rezervasyon, sohbet ya da
/// ilan kimliğidir.
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required NotificationKind kind,
    required String title,
    required String body,
    required DateTime at,
    @Default(false) bool read,
    String? targetId,
  }) = _AppNotification;
}

abstract final class ChatPolicy {
  static const maxLength = 1000;
}
