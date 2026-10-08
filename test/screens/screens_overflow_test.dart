import 'package:bungalovum/core/utils/formatters.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../helpers/screen_registry.dart';
import '../helpers/test_app.dart';

/// §12: 5 cihaz boyutu × 2 yazı ölçeğinde hiçbir ekranda taşma olmamalı.
void main() {
  setUpAll(() => initializeDateFormatting(kzLocale));

  String describe(Object e) {
    if (e is! FlutterError) return '$e';
    final lines = e
        .toStringDeep()
        .split('\n')
        .where((s) => s.trim().isNotEmpty)
        .toList();
    final widget = lines.indexWhere(
      (s) => s.contains('relevant error-causing widget'),
    );
    return [
      ...lines.take(2),
      if (widget >= 0) ...lines.skip(widget).take(2),
    ].join('\n');
  }

  for (final device in testDevices.entries) {
    for (final scale in const [1.0, 1.3]) {
      testWidgets('Taşma · ${device.key} @ $scale', (tester) async {
        tester.view.physicalSize = device.value * 3;
        tester.view.devicePixelRatio = 3;
        addTearDown(tester.view.reset);
        final failures = <String>[];
        for (final screen in allScreens.entries) {
          await tester.pumpWidget(const SizedBox.shrink());
          await tester.pumpWidget(
            testScreen(screen.value(), size: device.value, textScale: scale),
          );
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 300));
          await tester.pump(const Duration(milliseconds: 400));
          final e = tester.takeException();
          if (e != null) failures.add('${screen.key}: ${describe(e)}');
        }
        // Son ekranın zincirleme mock yanıtlarını boşalt.
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        expect(failures, isEmpty, reason: failures.join('\n\n'));
      });
    }
  }
}
