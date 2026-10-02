import 'package:bungapp/app/router.dart';
import 'package:bungapp/core/services/permissions.dart';
import 'package:bungapp/core/utils/formatters.dart';
import 'package:bungapp/core/widgets/kz_switch.dart';
import 'package:bungapp/features/booking/data/mock_booking_repository.dart';
import 'package:bungapp/features/status/presentation/screens/status_screens.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fake_services.dart';
import '../../helpers/test_app.dart';

const _size = Size(390, 844);

Future<void> _pump(WidgetTester tester, Widget app) async {
  tester.view.physicalSize = _size * 3;
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 4; i++) {
    await tester.pump(const Duration(milliseconds: 300));
  }
}

Future<void> _drain(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(seconds: 2));
}

void main() {
  setUpAll(() => initializeDateFormatting(kzLocale));

  testWidgets('bağlantı koparsa 79 açılır, gelince kapanır', (tester) async {
    final net = FakeConnectivityService();
    await _pump(tester, testApp(size: _size, connectivity: net));
    expect(find.byType(OfflineScreen), findsNothing);

    net.set(false);
    await _settle(tester);
    expect(find.byType(OfflineScreen), findsOneWidget);

    net.set(true);
    await _settle(tester);
    expect(find.byType(OfflineScreen), findsNothing);
    await _drain(tester);
  });

  testWidgets('çevrimdışıyken Tekrar dene ekranda kalır', (tester) async {
    final net = FakeConnectivityService();
    await _pump(tester, testApp(size: _size, connectivity: net));
    net.set(false);
    await _settle(tester);
    await tester.tap(find.text('Tekrar dene'));
    await _settle(tester);
    expect(find.byType(OfflineScreen), findsOneWidget);
    await _drain(tester);
  });

  group('Konum izni (Gizlilik)', () {
    Future<KzSwitch> locationSwitch(WidgetTester tester) async =>
        tester.widget<KzSwitch>(
          find.byWidgetPredicate(
            (w) => w is KzSwitch && w.semanticLabel == 'Konum erişimi',
          ),
        );

    testWidgets('izin verilirse anahtar açılır', (tester) async {
      final perms = FakePermissionService(
        statuses: {AppPermission.location: AppPermissionStatus.askable},
      );
      await _pump(
        tester,
        testApp(
          size: _size,
          initialLocation: AppRoutes.privacy,
          permissions: perms,
        ),
      );
      expect((await locationSwitch(tester)).value, isFalse);
      (await locationSwitch(tester)).onChanged!(true);
      await _settle(tester);
      expect(find.byType(LocationPermissionScreen), findsOneWidget);

      await tester.tap(find.text('Konum iznini ver'));
      await _settle(tester);
      expect(find.byType(LocationPermissionScreen), findsNothing);
      expect(perms.requests, 1);
      expect((await locationSwitch(tester)).value, isTrue);
      await _drain(tester);
    });

    testWidgets('Şimdi değil denirse anahtar kapalı kalır', (tester) async {
      final perms = FakePermissionService(
        statuses: {AppPermission.location: AppPermissionStatus.askable},
      );
      await _pump(
        tester,
        testApp(
          size: _size,
          initialLocation: AppRoutes.privacy,
          permissions: perms,
        ),
      );
      (await locationSwitch(tester)).onChanged!(true);
      await _settle(tester);
      await tester.tap(find.text('Şimdi değil'));
      await _settle(tester);
      expect(find.byType(LocationPermissionScreen), findsNothing);
      expect(perms.requests, 0);
      expect((await locationSwitch(tester)).value, isFalse);
      await _drain(tester);
    });

    testWidgets('kalıcı reddedildiyse ayarlar açılır', (tester) async {
      final perms = FakePermissionService(
        statuses: {AppPermission.location: AppPermissionStatus.blocked},
      );
      await _pump(
        tester,
        testScreen(
          const LocationPermissionScreen(),
          size: _size,
          permissions: perms,
        ),
      );
      await tester.tap(find.text('Konum iznini ver'));
      await _settle(tester);
      expect(perms.settingsOpened, 1);
      expect(perms.requests, 0);
      await _drain(tester);
    });
  });

  testWidgets('rezervasyon sonrası bildirim izni bir kez sorulur', (
    tester,
  ) async {
    final perms = FakePermissionService(
      statuses: {AppPermission.notifications: AppPermissionStatus.askable},
    );
    await _pump(
      tester,
      testApp(
        size: _size,
        initialLocation: AppRoutes.bookingDone(
          MockBookingRepository.sampleBookingId,
        ),
        permissions: perms,
      ),
    );
    expect(find.byType(NotificationPermissionScreen), findsNothing);
    await tester.pump(const Duration(milliseconds: 1300));
    await _settle(tester);
    expect(find.byType(NotificationPermissionScreen), findsOneWidget);

    await tester.tap(find.text('Belki sonra'));
    await _settle(tester);
    expect(find.byType(NotificationPermissionScreen), findsNothing);
    expect(perms.requests, 0);
    await _drain(tester);
  });
}
