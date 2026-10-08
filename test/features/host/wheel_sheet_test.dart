import 'package:bungalovum/core/widgets/kz_wheel_picker.dart';
import 'package:bungalovum/features/host/domain/listing_draft.dart';
import 'package:bungalovum/features/host/presentation/widgets/wizard_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  /// Sheet'i açan tek butonlu ekran; sonucu [onResult]'a yazar.
  Future<void> open(
    WidgetTester tester, {
    required List<WheelField> fields,
    required ValueChanged<List<double>?> onResult,
    bool ordered = false,
    Size? size,
    double textScale = 1,
  }) async {
    final s = size ?? testDevices['phone_390x844']!;
    tester.view.physicalSize = s * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      testScreen(
        Builder(
          builder: (context) => Center(
            child: GestureDetector(
              onTap: () async => onResult(
                await showWheelSheet(
                  context,
                  title: 'Test',
                  fields: fields,
                  ordered: ordered,
                ),
              ),
              child: const Text('aç'),
            ),
          ),
        ),
        size: s,
        textScale: textScale,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('aç'));
    await tester.pumpAndSettle();
  }

  Future<void> save(WidgetTester tester) async {
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
  }

  testWidgets('boş alan tipik değerden açılır ve kaydedince onu döner', (
    tester,
  ) async {
    List<double>? result;
    await open(
      tester,
      fields: const [
        WheelField(label: 'Kapalı alan', range: ListingRules.indoorM2),
      ],
      onResult: (r) => result = r,
    );
    expect(
      tester.widget<KzWheelPicker>(find.byType(KzWheelPicker)).selected,
      ListingRules.indoorM2.indexOf(45),
    );
    await save(tester);
    expect(result, [45]);
  });

  testWidgets('kaydırınca değer değişir', (tester) async {
    List<double>? result;
    await open(
      tester,
      fields: const [
        WheelField(label: 'Sıcaklık', range: ListingRules.poolTempC, value: 28),
      ],
      onResult: (r) => result = r,
    );
    // İki satır yukarı sürükle → 30.
    await tester.drag(find.byType(KzWheelPicker), const Offset(0, -88));
    await tester.pumpAndSettle();
    await save(tester);
    expect(result, [30]);
  });

  testWidgets('ortadaki değere dokunup yazılır, adıma ve aralığa oturur', (
    tester,
  ) async {
    List<double>? result;
    await open(
      tester,
      fields: const [WheelField(label: 'Bahçe', range: ListingRules.gardenM2)],
      onResult: (r) => result = r,
    );
    await tester.tap(find.byType(KzWheelPicker));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '320');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await save(tester);
    expect(result, [320]);
  });

  testWidgets(
    'yazıp klavye açıkken Kaydet\'e basınca yazılan değer kaydedilir',
    (tester) async {
      List<double>? result;
      await open(
        tester,
        fields: const [
          WheelField(label: 'Bahçe', range: ListingRules.gardenM2),
        ],
        onResult: (r) => result = r,
      );
      await tester.tap(find.byType(KzWheelPicker));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), '900');
      await tester.pump();

      // Parmak Kaydet'te bir süre basılı kalır: bu arada klavye kapanır ve
      // tekerlek 900'e doğru kaymaya başlar.
      final g = await tester.startGesture(
        tester.getCenter(find.text('Kaydet')),
      );
      for (var i = 0; i < 6; i++) {
        await tester.pump(const Duration(milliseconds: 16));
      }
      await g.up();
      await tester.pumpAndSettle();
      expect(result, [900]);
    },
  );

  testWidgets('derinlik: en az, en çoğu geçince en çok onu izler', (
    tester,
  ) async {
    List<double>? result;
    await open(
      tester,
      ordered: true,
      fields: const [
        WheelField(label: 'En az', range: ListingRules.poolDepthMinM),
        WheelField(label: 'En çok', range: ListingRules.poolDepthMaxM),
      ],
      onResult: (r) => result = r,
    );
    expect(find.text('1,2'), findsOneWidget);
    expect(find.text('1,6'), findsWidgets);

    await tester.tap(find.byType(KzWheelPicker).first);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '2,1');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await save(tester);
    expect(result, [2.1, 2.1]);
  });

  testWidgets('320 dp ve yazı ölçeği 1.3 ile taşma yok', (tester) async {
    await open(
      tester,
      size: testDevices['phone_320x568'],
      textScale: 1.3,
      fields: const [
        WheelField(label: 'En (m)', range: ListingRules.poolWidthM),
        WheelField(label: 'Boy (m)', range: ListingRules.poolLengthM),
      ],
      onResult: (_) {},
    );
    expect(tester.takeException(), isNull);
  });
}
