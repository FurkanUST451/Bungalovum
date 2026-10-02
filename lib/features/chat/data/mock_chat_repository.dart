import '../domain/chat_models.dart';
import 'chat_repository.dart';

/// Sahte sohbetler ve bildirimler (Figma 62–64 içeriği).
class MockChatRepository implements ChatRepository {
  MockChatRepository({
    this.latency = const Duration(milliseconds: 250),
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final Duration latency;
  final DateTime Function() _clock;

  Future<void> _wait() => Future<void>.delayed(latency);

  DateTime _ago(Duration d) => _clock().subtract(d);

  late final _conversations = <String, Conversation>{
    'c-ayla': Conversation(
      id: 'c-ayla',
      kind: ConversationKind.stay,
      title: 'Ayla Hanım',
      listingId: 'gol-esintisi',
      bookingId: 'kz-48k2q',
      lastMessage:
          'Evet, havuz 28°C’ye ısıtılıyor. Gece de jakuzi hazır olacak.',
      lastAt: _ago(const Duration(minutes: 5)),
      unread: 2,
      online: true,
    ),
    'c-murat': Conversation(
      id: 'c-murat',
      kind: ConversationKind.request,
      title: 'Murat Bey',
      listingId: 'cam-yamac',
      bookingId: 'kz-req-1',
      lastMessage: 'Talebinizi aldım, akşam dönüş yapacağım.',
      lastAt: _ago(const Duration(days: 1, hours: 2)),
      unread: 1,
    ),
    'c-destek': Conversation(
      id: 'c-destek',
      kind: ConversationKind.support,
      title: 'Kozalak Destek',
      ticketNo: '2041',
      lastMessage: 'Sorununuz çözüldü, iyi tatiller!',
      lastAt: _ago(const Duration(days: 3)),
    ),
    'c-elif': Conversation(
      id: 'c-elif',
      kind: ConversationKind.stay,
      title: 'Elif Hanım',
      listingId: 'kartepe-yuva',
      bookingId: 'kz-p1',
      lastMessage: 'Tekrar bekleriz!',
      lastAt: _ago(const Duration(days: 45)),
    ),
  };

  late final _messages = <String, List<ChatMessage>>{
    'c-ayla': [
      ChatMessage(
        id: 'm1',
        fromMe: false,
        text:
            'Merhaba! Rezervasyonunuz onaylandı, sizi ağırlamak için '
            'sabırsızlanıyoruz.',
        sentAt: _ago(const Duration(hours: 15, minutes: 39)),
        status: MessageStatus.read,
      ),
      ChatMessage(
        id: 'm2',
        fromMe: true,
        text: 'Teşekkürler! Havuz ısıtmalı mı, kasım ayında girebilir miyiz?',
        sentAt: _ago(const Duration(hours: 15, minutes: 31)),
        status: MessageStatus.read,
      ),
      ChatMessage(
        id: 'm3',
        fromMe: false,
        text: 'Evet, havuz 28°C’ye ısıtılıyor. Gece de jakuzi hazır olacak.',
        sentAt: _ago(const Duration(minutes: 5)),
      ),
      ChatMessage(
        id: 'm4',
        fromMe: false,
        photoUrl: '',
        sentAt: _ago(const Duration(minutes: 4)),
      ),
    ],
    'c-murat': [
      ChatMessage(
        id: 'm1',
        fromMe: true,
        text:
            'Merhaba Murat Bey, eşimle birlikte doğum günü için sakin bir '
            'hafta sonu arıyoruz.',
        sentAt: _ago(const Duration(days: 1, hours: 3)),
        status: MessageStatus.read,
      ),
      ChatMessage(
        id: 'm2',
        fromMe: false,
        text: 'Talebinizi aldım, akşam dönüş yapacağım.',
        sentAt: _ago(const Duration(days: 1, hours: 2)),
      ),
    ],
    'c-destek': [
      ChatMessage(
        id: 'm1',
        fromMe: false,
        text: 'Sorununuz çözüldü, iyi tatiller!',
        sentAt: _ago(const Duration(days: 3)),
        status: MessageStatus.read,
      ),
    ],
    'c-elif': [
      ChatMessage(
        id: 'm1',
        fromMe: false,
        text: 'Tekrar bekleriz!',
        sentAt: _ago(const Duration(days: 45)),
        status: MessageStatus.read,
      ),
    ],
  };

  late final _notifications = <AppNotification>[
    AppNotification(
      id: 'n1',
      kind: NotificationKind.bookingConfirmed,
      title: 'Rezervasyonun onaylandı',
      body: 'Göl Esintisi Bungalov · 6–8 Kas',
      at: _ago(const Duration(hours: 2)),
      targetId: 'kz-48k2q',
    ),
    AppNotification(
      id: 'n2',
      kind: NotificationKind.message,
      title: 'Ayla Hanım sana yazdı',
      body: '“Evet, havuz 28°C’ye ısıtılıyor…”',
      at: _ago(const Duration(hours: 3)),
      targetId: 'c-ayla',
    ),
    AppNotification(
      id: 'n3',
      kind: NotificationKind.priceDrop,
      title: 'Kaydettiğin yerde fiyat düştü',
      body: 'Çam Yamaç Bungalov gecelik ₺850 daha uygun',
      at: _ago(const Duration(days: 2)),
      read: true,
      targetId: 'cam-yamac',
    ),
    AppNotification(
      id: 'n4',
      kind: NotificationKind.reviewReminder,
      title: 'Konaklamanı değerlendir',
      body: 'Abant Göl Kulübesi nasıldı? 1 dakikada puan ver',
      at: _ago(const Duration(days: 4)),
      read: true,
      targetId: 'kz-p2',
    ),
    AppNotification(
      id: 'n5',
      kind: NotificationKind.weather,
      title: 'Hafta sonu hava güneşli',
      body: 'Sapanca’da havuz keyfi için ideal 2 gün',
      at: _ago(const Duration(days: 5)),
      read: true,
    ),
  ];

  var _seq = 0;

  @override
  Future<List<Conversation>> conversations() async {
    await _wait();
    return _conversations.values.toList()
      ..sort((a, b) => b.lastAt.compareTo(a.lastAt));
  }

  @override
  Future<List<ChatMessage>> messages(String conversationId) async {
    await _wait();
    return List.unmodifiable(_messages[conversationId] ?? const []);
  }

  @override
  Future<ChatMessage> send(
    String conversationId, {
    String? text,
    String? photoPath,
  }) async {
    await _wait();
    final m = ChatMessage(
      id: 'local-${++_seq}',
      fromMe: true,
      text: text,
      photoUrl: photoPath,
      sentAt: _clock(),
    );
    (_messages[conversationId] ??= []).add(m);
    final c = _conversations[conversationId]!;
    _conversations[conversationId] = c.copyWith(
      lastMessage: text ?? c.lastMessage,
      lastAt: m.sentAt,
      lastFromMe: true,
    );
    return m;
  }

  @override
  Future<void> markRead(String conversationId) async {
    final c = _conversations[conversationId];
    if (c != null) _conversations[conversationId] = c.copyWith(unread: 0);
  }

  @override
  Future<List<String>> quickReplies(String conversationId) async {
    await _wait();
    final c = _conversations[conversationId];
    return switch (c?.kind) {
      ConversationKind.stay => const [
        'Harika, teşekkürler!',
        'Giriş saati esnek mi?',
        'Otopark var mı?',
      ],
      ConversationKind.request => const [
        'Teşekkürler, bekliyorum.',
        'Evcil hayvan kabul ediyor musunuz?',
      ],
      _ => const [],
    };
  }

  @override
  Future<String> conversationForBooking(String bookingId) async {
    await _wait();
    final existing = _conversations.values
        .where((c) => c.bookingId == bookingId)
        .firstOrNull;
    if (existing != null) return existing.id;
    final id = 'c-$bookingId';
    _conversations[id] = Conversation(
      id: id,
      kind: ConversationKind.stay,
      title: 'Ayla Hanım',
      listingId: 'gol-esintisi',
      bookingId: bookingId,
      lastMessage: '',
      lastAt: _clock(),
    );
    _messages[id] = [];
    return id;
  }

  @override
  Future<String> conversationForListing(
    String listingId, {
    required String hostName,
  }) async {
    await _wait();
    final existing = _conversations.values
        .where((c) => c.listingId == listingId && c.bookingId == null)
        .firstOrNull;
    if (existing != null) return existing.id;
    final id = 'c-ilan-$listingId';
    _conversations[id] = Conversation(
      id: id,
      kind: ConversationKind.stay,
      title: hostName,
      listingId: listingId,
      lastMessage: '',
      lastAt: _clock(),
    );
    _messages[id] = [];
    return id;
  }

  @override
  Future<String> supportConversation() async {
    await _wait();
    return 'c-destek';
  }

  @override
  Future<List<AppNotification>> notifications() async {
    await _wait();
    return List.unmodifiable(_notifications);
  }

  @override
  Future<void> markNotificationRead(String id) async {
    final i = _notifications.indexWhere((n) => n.id == id);
    if (i >= 0) _notifications[i] = _notifications[i].copyWith(read: true);
  }

  @override
  Future<void> markAllNotificationsRead() async {
    await _wait();
    for (var i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(read: true);
    }
  }
}
