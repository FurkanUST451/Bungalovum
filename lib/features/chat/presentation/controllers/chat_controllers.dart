import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../app/routes.dart';
import '../../../../core/utils/clock.dart';
import '../../data/chat_repository.dart';
import '../../domain/chat_models.dart';

part 'chat_controllers.g.dart';

/// 62 · Sohbetler (en yeni en üstte).
@Riverpod(keepAlive: true)
class Conversations extends _$Conversations {
  @override
  Future<List<Conversation>> build() =>
      ref.watch(chatRepositoryProvider).conversations();

  Future<void> refresh() async =>
      state = AsyncData(await ref.read(chatRepositoryProvider).conversations());
}

/// Sohbetler sekmesindeki okunmamış mesaj sayısı (tab rozeti).
@Riverpod(keepAlive: true)
int unreadChats(Ref ref) => (ref.watch(conversationsProvider).value ?? const [])
    .fold(0, (sum, c) => sum + c.unread);

/// 63 · Sohbet: mesajlar (eskiden yeniye). Açılınca okundu sayılır.
@riverpod
class ChatThread extends _$ChatThread {
  var _tempSeq = 0;

  @override
  Future<List<ChatMessage>> build(String conversationId) async {
    final repo = ref.watch(chatRepositoryProvider);
    final messages = await repo.messages(conversationId);
    await repo.markRead(conversationId);
    // Liste ve rozet güncellensin.
    Future.microtask(() => ref.read(conversationsProvider.notifier).refresh());
    return messages;
  }

  /// İyimser gönderim: mesaj hemen "gönderiliyor" olarak görünür.
  Future<void> send({String? text, String? photoPath}) async {
    final temp = ChatMessage(
      id: 'temp-${++_tempSeq}',
      fromMe: true,
      text: text,
      photoUrl: photoPath,
      sentAt: ref.read(clockProvider)(),
      status: MessageStatus.sending,
    );
    final current = state.value ?? const <ChatMessage>[];
    state = AsyncData([...current, temp]);
    try {
      final sent = await ref
          .read(chatRepositoryProvider)
          .send(conversationId, text: text, photoPath: photoPath);
      state = AsyncData([
        for (final m in state.value ?? const <ChatMessage>[])
          m.id == temp.id ? sent : m,
      ]);
      await ref.read(conversationsProvider.notifier).refresh();
    } on Object {
      state = AsyncData([
        for (final m in state.value ?? const <ChatMessage>[])
          m.id == temp.id ? m.copyWith(status: MessageStatus.failed) : m,
      ]);
    }
  }

  /// Başarısız mesajı yeniden dener.
  Future<void> retry(ChatMessage failed) async {
    state = AsyncData([
      for (final m in state.value ?? const <ChatMessage>[])
        if (m.id != failed.id) m,
    ]);
    await send(text: failed.text, photoPath: failed.photoUrl);
  }
}

@riverpod
Future<List<String>> quickReplies(Ref ref, String conversationId) =>
    ref.watch(chatRepositoryProvider).quickReplies(conversationId);

/// 64 · Bildirim Merkezi.
@Riverpod(keepAlive: true)
class Notifications extends _$Notifications {
  @override
  Future<List<AppNotification>> build() =>
      ref.watch(chatRepositoryProvider).notifications();

  ChatRepository get _repo => ref.read(chatRepositoryProvider);

  Future<void> markRead(String id) async {
    await _repo.markNotificationRead(id);
    state = AsyncData([
      for (final n in state.value ?? const <AppNotification>[])
        n.id == id ? n.copyWith(read: true) : n,
    ]);
  }

  Future<void> markAllRead() async {
    await _repo.markAllNotificationsRead();
    state = AsyncData([
      for (final n in state.value ?? const <AppNotification>[])
        n.copyWith(read: true),
    ]);
  }
}

/// Keşfet'teki zil üzerindeki nokta.
@Riverpod(keepAlive: true)
bool hasUnreadNotifications(Ref ref) =>
    (ref.watch(notificationsProvider).value ?? const []).any((n) => !n.read);

/// Bungalovum destek sohbetini açar.
Future<void> openSupportChat(BuildContext context, WidgetRef ref) async {
  final id = await ref.read(chatRepositoryProvider).supportConversation();
  await ref.read(conversationsProvider.notifier).refresh();
  if (context.mounted) await context.push(AppRoutes.chat(id));
}

/// İlan hakkında ev sahibine soru sohbetini açar (rezervasyon öncesi).
Future<void> openListingChat(
  BuildContext context,
  WidgetRef ref,
  String listingId,
  String hostName,
) async {
  final id = await ref
      .read(chatRepositoryProvider)
      .conversationForListing(listingId, hostName: hostName);
  await ref.read(conversationsProvider.notifier).refresh();
  if (context.mounted) await context.push(AppRoutes.chat(id));
}

/// Rezervasyonun ev sahibiyle sohbetini açar (yoksa oluşturur).
Future<void> openBookingChat(
  BuildContext context,
  WidgetRef ref,
  String bookingId,
) async {
  final id = await ref
      .read(chatRepositoryProvider)
      .conversationForBooking(bookingId);
  await ref.read(conversationsProvider.notifier).refresh();
  if (context.mounted) await context.push(AppRoutes.chat(id));
}
