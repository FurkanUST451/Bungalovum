import 'package:bungapp/core/utils/formatters.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'helpers/screen_registry.dart';
import 'helpers/test_app.dart';

const _key = String.fromEnvironment('KEY');
const _w = int.fromEnvironment('W', defaultValue: 390);
const _h = int.fromEnvironment('H', defaultValue: 844);
const _s = String.fromEnvironment('S', defaultValue: '1.0');

void main() {
  setUpAll(() => initializeDateFormatting(kzLocale));
  testWidgets('one', skip: _key.isEmpty, (tester) async {
    final size = Size(_w.toDouble(), _h.toDouble());
    tester.view.physicalSize = size * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      testScreen(allScreens[_key]!(), size: size, textScale: double.parse(_s)),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 400));
  });
}
