import 'package:alchemist/alchemist.dart';
import 'package:bungalovum/core/utils/formatters.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../helpers/screen_registry.dart';
import '../helpers/test_app.dart';

Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
  // Mock depoların sıfır gecikmeli yanıtları zincirleme gelir; kalan
  // zamanlayıcıları boşalt.
  await tester.pump(const Duration(milliseconds: 300));
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  setUpAll(() => initializeDateFormatting(kzLocale));

  for (final screen in allScreens.entries) {
    for (final scale in const [1.0, 1.3]) {
      goldenTest(
        '${screen.key} @ textScale $scale',
        fileName: '${screen.key}_text_${scale.toStringAsFixed(1)}',
        pumpBeforeTest: _settle,
        builder: () => GoldenTestGroup(
          columns: testDevices.length,
          children: [
            for (final device in testDevices.entries)
              GoldenTestScenario(
                name: device.key,
                child: SizedBox.fromSize(
                  size: device.value,
                  child: testScreen(
                    screen.value(),
                    size: device.value,
                    textScale: scale,
                  ),
                ),
              ),
          ],
        ),
      );
    }
  }
}
