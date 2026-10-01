import 'package:alchemist/alchemist.dart';
import 'package:bungapp/core/utils/formatters.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'helpers/screen_registry.dart';
import 'helpers/test_app.dart';

const _filter = String.fromEnvironment('SCREENS');

void main() {
  setUpAll(() => initializeDateFormatting(kzLocale));
  const size = Size(390, 844);
  final keys = _filter.split(',');
  goldenTest(
    'sheet',
    fileName: '_sheet',
    pumpBeforeTest: (t) async {
      await t.pump();
      await t.pump(const Duration(milliseconds: 50));
      await t.pump(const Duration(milliseconds: 300));
    },
    builder: () => GoldenTestGroup(
      columns: 4,
      children: [
        for (final s in allScreens.entries)
          if (keys.any((k) => s.key.startsWith(k)))
            GoldenTestScenario(
              name: s.key,
              child: SizedBox.fromSize(
                size: size,
                child: testScreen(s.value(), size: size),
              ),
            ),
      ],
    ),
  );
}
