import 'package:bungapp/features/account/data/account_repository.dart';
import 'package:bungapp/features/account/data/mock_account_repository.dart';
import 'package:bungapp/features/account/domain/account_models.dart';
import 'package:bungapp/features/account/presentation/controllers/account_controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  ProviderContainer container({bool upcoming = true}) {
    final c = ProviderContainer(
      overrides: [
        accountRepositoryProvider.overrideWithValue(
          MockAccountRepository(
            latency: Duration.zero,
            clock: fixedClock,
            hasUpcomingBooking: upcoming,
          ),
        ),
      ],
    );
    addTearDown(c.dispose);
    return c;
  }

  group('Bildirim tercihleri', () {
    test('açılan konu varsayılan kanallarını alır, kapanan boşalır', () async {
      final c = container();
      c.listen(notifPrefsProvider, (_, _) {});
      await c.read(notifPrefsProvider.future);
      final n = c.read(notifPrefsProvider.notifier);

      await n.toggle(NotifTopic.surveys, true);
      expect(
        c.read(notifPrefsProvider).requireValue.channels(NotifTopic.surveys),
        NotifTopic.surveys.defaultChannels,
      );

      await n.toggle(NotifTopic.surveys, false);
      expect(
        c.read(notifPrefsProvider).requireValue.isOn(NotifTopic.surveys),
        isFalse,
      );
    });

    test('pazarlamayı kapat yalnızca İYS konularını kapatır', () async {
      final c = container();
      c.listen(notifPrefsProvider, (_, _) {});
      await c.read(notifPrefsProvider.future);
      final n = c.read(notifPrefsProvider.notifier);
      await n.toggle(NotifTopic.stayReminders, true);
      await n.toggle(NotifTopic.promotions, true);

      await n.disableMarketing();
      final p = c.read(notifPrefsProvider).requireValue;
      expect(p.anyMarketingOn, isFalse);
      expect(p.isOn(NotifTopic.stayReminders), isTrue);
    });
  });

  group('Güvenlik', () {
    test('yanlış mevcut şifre reddedilir', () async {
      final repo = MockAccountRepository(latency: Duration.zero);
      expect(
        () => repo.changePassword('yanlis', 'YeniSifre2026'),
        throwsA(isA<PasswordChangeRejected>()),
      );
    });

    test('şifre değişince güncellenme zamanı yenilenir', () async {
      final repo = MockAccountRepository(
        latency: Duration.zero,
        clock: fixedClock,
      );
      final s = await repo.changePassword(
        MockAccountRepository.samplePassword,
        'YeniSifre2026',
      );
      expect(s.passwordUpdatedAt, fixedClock());
    });
  });

  group('Hesabı kapat', () {
    test('yaklaşan rezervasyon varken kapatılamaz', () async {
      final c = container();
      final impact = await c.read(closeAccountImpactProvider.future);
      expect(impact.upcomingBooking, isNotNull);
      await expectLater(
        c
            .read(accountRepositoryProvider)
            .closeAccount(MockAccountRepository.samplePassword),
        throwsA(
          isA<CloseAccountRejected>().having(
            (e) => e.error,
            'error',
            CloseAccountError.upcomingBooking,
          ),
        ),
      );
    });

    test('rezervasyon yoksa doğru şifreyle kapanır', () async {
      final c = container(upcoming: false);
      final impact = await c.read(closeAccountImpactProvider.future);
      expect(impact.upcomingBooking, isNull);
      await c
          .read(accountRepositoryProvider)
          .closeAccount(MockAccountRepository.samplePassword);
    });
  });

  test('her hukuki belge yüklenir ve başlıkla başlar', () async {
    final c = container();
    for (final d in LegalDoc.values) {
      final doc = await c.read(legalDocumentProvider(d).future);
      expect(doc.doc, d);
      expect(doc.paragraphs, isNotEmpty);
    }
  });
}
