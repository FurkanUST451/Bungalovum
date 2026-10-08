import 'package:bungalovum/core/utils/clock.dart';
import 'package:bungalovum/core/utils/formatters.dart';
import 'package:bungalovum/features/chat/data/chat_repository.dart';
import 'package:bungalovum/features/chat/data/mock_chat_repository.dart';
import 'package:bungalovum/features/chat/domain/chat_models.dart';
import 'package:bungalovum/features/chat/presentation/chat_labels.dart';
import 'package:bungalovum/features/chat/presentation/controllers/chat_controllers.dart';
import 'package:bungalovum/l10n/app_localizations_tr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/test_app.dart';

void main() {
  setUpAll(() => initializeDateFormatting(kzLocale));

  group('Zaman etiketleri', () {
    final l = AppLocalizationsTr();
    final now = DateTime(2026, 11, 3, 15);

    test('sohbet listesi', () {
      expect(chatListTime(l, DateTime(2026, 11, 3, 9, 41), now), '09:41');
      expect(chatListTime(l, DateTime(2026, 11, 2, 22), now), 'Dün');
      expect(chatListTime(l, DateTime(2026, 9, 12), now), '12 Eyl');
    });

    test('bildirim', () {
      expect(notificationAgo(l, now, now), 'Az önce');
      expect(
        notificationAgo(l, now.subtract(const Duration(minutes: 12)), now),
        '12 dakika önce',
      );
      expect(
        notificationAgo(l, now.subtract(const Duration(hours: 2)), now),
        '2 saat önce',
      );
    });
  });

  group('Sohbet', () {
    late ProviderContainer c;
    setUp(() {
      c = ProviderContainer(
        overrides: [
          chatRepositoryProvider.overrideWithValue(
            MockChatRepository(latency: Duration.zero, clock: fixedClock),
          ),
          clockProvider.overrideWithValue(fixedClock),
        ],
      );
    });
    tearDown(() => c.dispose());

    test('açılınca okundu sayılır, rozet düşer', () async {
      await c.read(conversationsProvider.future);
      expect(c.read(unreadChatsProvider), 3);
      await c.read(chatThreadProvider('c-ayla').future);
      await c.read(conversationsProvider.notifier).refresh();
      expect(c.read(unreadChatsProvider), 1);
    });

    test('gönderilen mesaj listeye ve önizlemeye düşer', () async {
      final sub = c.listen(chatThreadProvider('c-ayla'), (_, _) {});
      await c.read(chatThreadProvider('c-ayla').future);
      await c
          .read(chatThreadProvider('c-ayla').notifier)
          .send(text: 'Otopark var mı?');
      final messages = c.read(chatThreadProvider('c-ayla')).value!;
      expect(messages.last.text, 'Otopark var mı?');
      expect(messages.last.status, MessageStatus.sent);
      final convo = c
          .read(conversationsProvider)
          .value!
          .firstWhere((x) => x.id == 'c-ayla');
      expect(convo.lastFromMe, isTrue);
      sub.close();
    });

    test('rezervasyon sohbeti varsa onu döner, yoksa açar', () async {
      final repo = c.read(chatRepositoryProvider);
      expect(await repo.conversationForBooking('kz-48k2q'), 'c-ayla');
      final created = await repo.conversationForBooking('kz-yeni');
      expect(created, isNot('c-ayla'));
      expect(await repo.conversationForBooking('kz-yeni'), created);
    });

    test('tümünü okundu say zil noktasını kaldırır', () async {
      await c.read(notificationsProvider.future);
      expect(c.read(hasUnreadNotificationsProvider), isTrue);
      await c.read(notificationsProvider.notifier).markAllRead();
      expect(c.read(hasUnreadNotificationsProvider), isFalse);
    });
  });
}
