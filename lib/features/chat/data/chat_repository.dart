import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/chat_models.dart';
import 'mock_chat_repository.dart';

part 'chat_repository.g.dart';

abstract interface class ChatRepository {
  Future<List<Conversation>> conversations();

  /// En eskiden yeniye.
  Future<List<ChatMessage>> messages(String conversationId);

  /// Metin ya da fotoğraf (yerel dosya yolu) gönderir.
  Future<ChatMessage> send(
    String conversationId, {
    String? text,
    String? photoPath,
  });

  Future<void> markRead(String conversationId);

  /// Bağlama göre önerilen kısa yanıtlar.
  Future<List<String>> quickReplies(String conversationId);

  /// Rezervasyonun ev sahibiyle sohbeti; yoksa açar.
  Future<String> conversationForBooking(String bookingId);

  /// Rezervasyon öncesi ilan hakkında soru sohbeti; yoksa açar.
  Future<String> conversationForListing(
    String listingId, {
    required String hostName,
  });

  /// Bungalovum destek sohbeti; yoksa açar.
  Future<String> supportConversation();

  Future<List<AppNotification>> notifications();

  Future<void> markNotificationRead(String id);

  Future<void> markAllNotificationsRead();
}

@Riverpod(keepAlive: true)
ChatRepository chatRepository(Ref ref) => MockChatRepository();
