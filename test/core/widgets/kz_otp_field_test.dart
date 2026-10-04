import 'package:bungapp/core/widgets/kz_otp_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  Future<TextEditingController> pumpField(
    WidgetTester tester, {
    ValueChanged<String>? onCompleted,
  }) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      testScreen(
        Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: KzOtpField(
                controller: controller,
                semanticLabel: 'Doğrulama kodu',
                autofocus: false,
                onCompleted: onCompleted,
              ),
            ),
          ),
        ),
        size: testDevices['phone_390x844']!,
      ),
    );
    await tester.pumpAndSettle();
    return controller;
  }

  void mockClipboard(WidgetTester tester, String text) {
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async => switch (call.method) {
        'Clipboard.getData' => {'text': text},
        'Clipboard.hasStrings' => {'value': true},
        _ => null,
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
  }

  EditableText editable(WidgetTester tester) =>
      tester.widget<EditableText>(find.byType(EditableText));


  group('codeFromText', () {
    String? code(String? t) => KzOtpField.codeFromText(t, 6);

    test('düz kod, boşluklu ve tireli kod', () {
      expect(code('482913'), '482913');
      expect(code('482 913'), '482913');
      expect(code('482-913'), '482913');
      expect(code('Bungalovum doğrulama kodun: 482913'), '482913');
    });

    test('kod olmayan pano içeriği reddedilir', () {
      expect(code(null), isNull);
      expect(code(''), isNull);
      expect(code('Merhaba'), isNull);
      expect(code('12345'), isNull);
      expect(code('1234567'), isNull);
      expect(code('Tarih 12.10.2026 saat 14:30'), isNull);
    });

    test('birden fazla aday varsa tahmin edilmez', () {
      expect(code('Eski kod 111111, yeni kod 222222'), isNull);
    });
  });

  testWidgets('uygulamaya dönünce panodaki kod kutuyu doldurur', (
    tester,
  ) async {
    final calls = <String>[];
    final controller = await pumpField(tester, onCompleted: calls.add);
    mockClipboard(tester, 'Doğrulama kodun: 731 904');

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(const Duration(seconds: 1));

    expect(controller.text, '731904');
    expect(calls, ['731904']);
  });

  testWidgets('kutu doluysa ya da pano kod değilse dokunulmaz', (tester) async {
    final controller = await pumpField(tester);
    mockClipboard(tester, 'alışveriş listesi');
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(const Duration(seconds: 1));
    expect(controller.text, isEmpty);

    controller.text = '123';
    mockClipboard(tester, '999999');
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(const Duration(seconds: 1));
    expect(controller.text, '123');
  });

  testWidgets('kutucuğun ortasına dokununca alan odaklanır', (tester) async {
    await pumpField(tester);
    expect(editable(tester).focusNode.hasFocus, isFalse);

    // Kutucukların aralığına değil, ilk kutucuğun tam ortasına dokun.
    final field = tester.getRect(find.byType(KzOtpField));
    await tester.tapAt(Offset(field.left + 20, field.center.dy));
    await tester.pump();

    expect(editable(tester).focusNode.hasFocus, isTrue);
  });

  testWidgets('klavye kapandıktan sonra tekrar dokununca klavye açılır', (
    tester,
  ) async {
    await pumpField(tester);
    final field = tester.getRect(find.byType(KzOtpField));
    await tester.tapAt(field.center);
    await tester.pump();
    expect(tester.testTextInput.isVisible, isTrue);

    // Android geri tuşu / uygulama değişimi: odak kalır, klavye kapanır.
    tester.testTextInput.hide();
    await tester.pump();
    expect(editable(tester).focusNode.hasFocus, isTrue);
    expect(tester.testTextInput.isVisible, isFalse);

    await tester.tapAt(Offset(field.right - 20, field.center.dy));
    await tester.pump();
    expect(tester.testTextInput.isVisible, isTrue);
  });

  testWidgets('basılı tutunca yapıştır ile kod girilir', (tester) async {
    final calls = <String>[];
    final controller = await pumpField(tester, onCompleted: calls.add);
    // Mailden kopyalanan metin boşluk/harf içerebilir; yalnızca rakamlar alınır.
    // Test ortamında pano yok; telefon panosunu taklit et.
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async => switch (call.method) {
        'Clipboard.getData' => {'text': 'Kodun: 482 913'},
        'Clipboard.hasStrings' => {'value': true},
        _ => null,
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    await tester.longPressAt(tester.getCenter(find.byType(KzOtpField)));
    await tester.pumpAndSettle();
    final paste = find.byWidgetPredicate(
      (w) =>
          w is TextSelectionToolbarTextButton ||
          w is CupertinoTextSelectionToolbarButton,
    );
    expect(paste, findsWidgets);

    // Test ekranı telefon boyutundan küçük olduğu için menü görünür alanın
    // dışına düşebilir; düğmeye doğrudan basılır.
    final button = tester.widget(paste.last);
    switch (button) {
      case TextSelectionToolbarTextButton(:final onPressed):
        onPressed!();
      case CupertinoTextSelectionToolbarButton(:final onPressed):
        onPressed!();
    }
    await tester.pumpAndSettle();
    expect(controller.text, '482913');
    expect(calls, ['482913']);
  });

  testWidgets('tam kod yalnızca bir kez bildirilir', (tester) async {
    final calls = <String>[];
    await pumpField(tester, onCompleted: calls.add);
    await tester.tapAt(tester.getCenter(find.byType(KzOtpField)));
    await tester.enterText(find.byType(EditableText), '123456');
    await tester.pump();

    // Odak gidip gelir (uygulama arkaya atılıp geri dönülür).
    editable(tester).focusNode.unfocus();
    await tester.pump();
    editable(tester).focusNode.requestFocus();
    await tester.pump();

    expect(calls, ['123456']);
  });
}
