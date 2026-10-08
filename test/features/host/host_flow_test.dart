import 'package:bungalovum/app/router.dart';
import 'package:bungalovum/core/utils/formatters.dart';
import 'package:bungalovum/core/widgets/kz_button.dart';
import 'package:bungalovum/core/widgets/kz_input.dart';
import 'package:bungalovum/features/host/presentation/screens/wizard_steps_a.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/test_app.dart';

const _size = Size(390, 844);

Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 4; i++) {
    await tester.pump(const Duration(milliseconds: 300));
  }
}

KzButton _button(WidgetTester tester, String label) => tester.widget<KzButton>(
  find.byWidgetPredicate((w) => w is KzButton && w.label == label),
);

Future<void> _enter(WidgetTester tester, String label, String text) async {
  final field = find.byWidgetPredicate((w) => w is KzInput && w.label == label);
  await tester.enterText(
    find.descendant(of: field, matching: find.byType(EditableText)),
    text,
  );
  await tester.pump();
}

void main() {
  setUpAll(() => initializeDateFormatting(kzLocale));

  testWidgets(
    '1. adım tamamlanmadan Devam pasif; tamamlanınca 2. adıma geçer',
    (tester) async {
      tester.view.physicalSize = _size * 3;
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        testApp(size: _size, initialLocation: AppRoutes.becomeHost),
      );
      await _settle(tester);

      await tester.tap(find.text('Hadi başlayalım'));
      await _settle(tester);
      expect(find.byType(TypeLocationStep), findsOneWidget);
      expect(_button(tester, 'Devam').onPressed, isNull);

      await tester.tap(find.text('A-frame'));
      await tester.pump();
      await tester.ensureVisible(find.text('Orman içi'));
      await tester.pump();
      await tester.tap(find.text('Orman içi'));
      await tester.pump();
      await _enter(tester, 'Açık adres', 'Göl Sk. No: 3');
      await _enter(tester, 'İl', 'Sakarya');
      await _enter(tester, 'İlçe', 'Sapanca');
      expect(_button(tester, 'Devam').onPressed, isNotNull);

      _button(tester, 'Devam').onPressed!();
      await _settle(tester);
      expect(find.byType(BasicsStep), findsOneWidget);
      expect(find.text('Adım 2 / 10'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 1));
    },
  );
}
