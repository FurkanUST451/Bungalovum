import 'package:alchemist/alchemist.dart';
import 'package:bungalovum/core/utils/formatters.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/test_app.dart';

Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 10));
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  setUpAll(() => initializeDateFormatting(kzLocale));

  for (final scale in const [1.0, 1.3]) {
    goldenTest(
      'Keşfet ekranı @ textScale $scale',
      fileName: 'explore_text_${scale.toStringAsFixed(1)}',
      pumpBeforeTest: _settle,
      builder: () => GoldenTestGroup(
        columns: testDevices.length,
        children: [
          for (final entry in testDevices.entries)
            GoldenTestScenario(
              name: entry.key,
              child: SizedBox.fromSize(
                size: entry.value,
                child: testApp(size: entry.value, textScale: scale),
              ),
            ),
        ],
      ),
    );
  }
}
