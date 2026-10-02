import 'package:bungapp/core/utils/formatters.dart';
import 'package:bungapp/core/widgets/kz_sheet.dart';
import 'package:bungapp/core/widgets/kz_skeleton.dart';
import 'package:bungapp/features/auth/domain/auth_models.dart';
import 'package:bungapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:bungapp/features/saved/presentation/controllers/saved_listings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/test_app.dart';

Future<void> pumpExplore(
  WidgetTester tester, {
  Size size = const Size(390, 844),
  double textScale = 1,
}) async {
  tester.view.physicalSize = size * 3;
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(testApp(size: size, textScale: textScale));
  // Mock depo (sıfır gecikme) + SVG asset yüklemesi.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 10));
  await tester.pump(const Duration(milliseconds: 500));
}

Future<void> scrollTo(WidgetTester tester, Finder finder) => tester
    .scrollUntilVisible(finder, 200, scrollable: find.byType(Scrollable).first);

void main() {
  setUpAll(() => initializeDateFormatting(kzLocale));

  // 78 · Yükleniyor: akış gelene kadar iskelet, spinner yok.
  testWidgets('Yükleniyor durumu iskelet gösterir', (tester) async {
    tester.view.physicalSize = const Size(390, 844) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(testApp(size: const Size(390, 844)));
    expect(find.byType(KzSkeleton), findsWidgets);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(KzSkeleton), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });

  group('Keşfet taşma testi', () {
    for (final entry in testDevices.entries) {
      for (final scale in const [1.0, 1.3]) {
        testWidgets('${entry.key} @ textScale $scale', (tester) async {
          await pumpExplore(tester, size: entry.value, textScale: scale);
          // Sayfayı adım adım sonuna kadar kaydır: her bölüm çizilsin.
          await scrollTo(tester, find.text('Çam Kozalak Bungalov'));
          await tester.pump(const Duration(milliseconds: 500));
          expect(tester.takeException(), isNull);
        });
      }
    }
  });

  testWidgets('Figma içeriği ve biçimler', (tester) async {
    await pumpExplore(tester);
    expect(find.text('Sapanca, Sakarya'), findsOneWidget);
    expect(find.text("Sapanca'da en sevilenler"), findsOneWidget);
    expect(find.text('Göl Esintisi Bungalov'), findsOneWidget);
    expect(find.text('Misafirlerin gözdesi'), findsWidgets);

    await scrollTo(tester, find.text('Göl Evi Sapanca'));
    expect(find.text('24°'), findsOneWidget);
    expect(find.text('Cumartesi · Güneşli'), findsOneWidget);
    expect(
      find.text('6 – 8 Kas · 2 gecelik toplam, ücretler dahil'),
      findsOneWidget,
    );
    expect(find.text('Son 2 gece!'), findsOneWidget);
    expect(find.text('1 / 18'), findsWidgets);
    expect(find.textContaining('₺10.800', findRichText: true), findsOneWidget);
  });

  testWidgets('Kategori seçimi akışı filtreler', (tester) async {
    await pumpExplore(tester);
    expect(find.text('Çam Yamaç Bungalov'), findsOneWidget);

    await tester.ensureVisible(find.text('Göl manzaralı'));
    await tester.pump();
    await tester.tap(find.text('Göl manzaralı'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Göl Esintisi Bungalov'), findsOneWidget);
    expect(find.text('Çam Yamaç Bungalov'), findsNothing);
  });

  testWidgets('Kalp kaydeder ve geri alır', (tester) async {
    final handle = tester.ensureSemantics();
    await pumpExplore(tester);
    final container = ProviderScope.containerOf(
      tester.element(find.byType(CustomScrollView)),
    );
    container
        .read(authSessionProvider.notifier)
        .signedIn(const AuthUser(id: 'u', firstName: 'Deniz'));
    await tester.pump(const Duration(milliseconds: 100));
    int saved() => container.read(savedListingIdsProvider).length;
    final before = saved();

    // Kalp → 30 · Listeye kaydet → Kaydet.
    await tester.tap(find.bySemanticsLabel('Kaydet').first);
    // İlk kare sheet animasyonunu başlatır, ikincisi bitirir.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Listeye kaydet'), findsOneWidget);
    final saveButton = find.descendant(
      of: find.byType(KzSheet),
      matching: find.text('Kaydet'),
    );
    await tester.ensureVisible(saveButton);
    await tester.pump();
    await tester.tap(saveButton);
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(saved(), before + 1);

    // Dolu kalbe dokununca tüm listelerden çıkar.
    await tester.tap(find.bySemanticsLabel('Kayıtlılardan çıkar').first);
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(saved(), before);
    handle.dispose();
  });

  testWidgets('Dokunma alanları en az 44×44', (tester) async {
    final handle = tester.ensureSemantics();
    await pumpExplore(tester);
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    handle.dispose();
  });
}
