// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 62 · Sohbetler (en yeni en üstte).

@ProviderFor(Conversations)
final conversationsProvider = ConversationsProvider._();

/// 62 · Sohbetler (en yeni en üstte).
final class ConversationsProvider
    extends $AsyncNotifierProvider<Conversations, List<Conversation>> {
  /// 62 · Sohbetler (en yeni en üstte).
  ConversationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'conversationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$conversationsHash();

  @$internal
  @override
  Conversations create() => Conversations();
}

String _$conversationsHash() => r'5e309540198faa919b6b652c20c12fdc14184fce';

/// 62 · Sohbetler (en yeni en üstte).

abstract class _$Conversations extends $AsyncNotifier<List<Conversation>> {
  FutureOr<List<Conversation>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Conversation>>, List<Conversation>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Conversation>>, List<Conversation>>,
              AsyncValue<List<Conversation>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Sohbetler sekmesindeki okunmamış mesaj sayısı (tab rozeti).

@ProviderFor(unreadChats)
final unreadChatsProvider = UnreadChatsProvider._();

/// Sohbetler sekmesindeki okunmamış mesaj sayısı (tab rozeti).

final class UnreadChatsProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Sohbetler sekmesindeki okunmamış mesaj sayısı (tab rozeti).
  UnreadChatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadChatsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadChatsHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return unreadChats(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$unreadChatsHash() => r'5ab5526463a65ea9c581df66eea2b74fe5ffbe35';

/// 63 · Sohbet: mesajlar (eskiden yeniye). Açılınca okundu sayılır.

@ProviderFor(ChatThread)
final chatThreadProvider = ChatThreadFamily._();

/// 63 · Sohbet: mesajlar (eskiden yeniye). Açılınca okundu sayılır.
final class ChatThreadProvider
    extends $AsyncNotifierProvider<ChatThread, List<ChatMessage>> {
  /// 63 · Sohbet: mesajlar (eskiden yeniye). Açılınca okundu sayılır.
  ChatThreadProvider._({
    required ChatThreadFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatThreadProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatThreadHash();

  @override
  String toString() {
    return r'chatThreadProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatThread create() => ChatThread();

  @override
  bool operator ==(Object other) {
    return other is ChatThreadProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatThreadHash() => r'0b27f5bafe49508d0f9b13adebdd2041883fddd5';

/// 63 · Sohbet: mesajlar (eskiden yeniye). Açılınca okundu sayılır.

final class ChatThreadFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatThread,
          AsyncValue<List<ChatMessage>>,
          List<ChatMessage>,
          FutureOr<List<ChatMessage>>,
          String
        > {
  ChatThreadFamily._()
    : super(
        retry: null,
        name: r'chatThreadProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 63 · Sohbet: mesajlar (eskiden yeniye). Açılınca okundu sayılır.

  ChatThreadProvider call(String conversationId) =>
      ChatThreadProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'chatThreadProvider';
}

/// 63 · Sohbet: mesajlar (eskiden yeniye). Açılınca okundu sayılır.

abstract class _$ChatThread extends $AsyncNotifier<List<ChatMessage>> {
  late final _$args = ref.$arg as String;
  String get conversationId => _$args;

  FutureOr<List<ChatMessage>> build(String conversationId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ChatMessage>>, List<ChatMessage>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ChatMessage>>, List<ChatMessage>>,
              AsyncValue<List<ChatMessage>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(quickReplies)
final quickRepliesProvider = QuickRepliesFamily._();

final class QuickRepliesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  QuickRepliesProvider._({
    required QuickRepliesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'quickRepliesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$quickRepliesHash();

  @override
  String toString() {
    return r'quickRepliesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    final argument = this.argument as String;
    return quickReplies(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is QuickRepliesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$quickRepliesHash() => r'b628183c25541010e3f6f22b8ade6873362da621';

final class QuickRepliesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<String>>, String> {
  QuickRepliesFamily._()
    : super(
        retry: null,
        name: r'quickRepliesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  QuickRepliesProvider call(String conversationId) =>
      QuickRepliesProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'quickRepliesProvider';
}

/// 64 · Bildirim Merkezi.

@ProviderFor(Notifications)
final notificationsProvider = NotificationsProvider._();

/// 64 · Bildirim Merkezi.
final class NotificationsProvider
    extends $AsyncNotifierProvider<Notifications, List<AppNotification>> {
  /// 64 · Bildirim Merkezi.
  NotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsHash();

  @$internal
  @override
  Notifications create() => Notifications();
}

String _$notificationsHash() => r'36833f64f939e3fdbab563707f3c8594ff46fa99';

/// 64 · Bildirim Merkezi.

abstract class _$Notifications extends $AsyncNotifier<List<AppNotification>> {
  FutureOr<List<AppNotification>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AppNotification>>, List<AppNotification>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AppNotification>>,
                List<AppNotification>
              >,
              AsyncValue<List<AppNotification>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Keşfet'teki zil üzerindeki nokta.

@ProviderFor(hasUnreadNotifications)
final hasUnreadNotificationsProvider = HasUnreadNotificationsProvider._();

/// Keşfet'teki zil üzerindeki nokta.

final class HasUnreadNotificationsProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Keşfet'teki zil üzerindeki nokta.
  HasUnreadNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasUnreadNotificationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasUnreadNotificationsHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return hasUnreadNotifications(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hasUnreadNotificationsHash() =>
    r'9562aa3788a89be4a3aaf8ffb269c79e6e13c07b';
