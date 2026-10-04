import 'package:bungapp/app/router.dart';
import 'package:bungapp/core/utils/formatters.dart';
import 'package:bungapp/features/auth/domain/auth_validators.dart';
import 'package:bungapp/features/auth/presentation/screens/register_screen.dart';
import 'package:bungapp/features/auth/presentation/screens/sign_in_screen.dart';
import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/test_app.dart';

Future<void> _pump(WidgetTester tester, Widget app, Size size) async {
  tester.view.physicalSize = size * 3;
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  // Önceki uygulama örneğinin state'i (router) yeniden kullanılmasın.
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pumpWidget(app);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

Future<void> _submitWrongCredentials(WidgetTester tester) async {
  await tester.enterText(find.byType(EditableText).at(0), 'deniz@ornek');
  await tester.enterText(find.byType(EditableText).at(1), '123');
  await tester.tap(find.text('Giriş yap').last);
  await tester.pump();
}

void main() {
  setUpAll(() => initializeDateFormatting(kzLocale));

  testWidgets('05 · Taşma yok (hata durumu, 320 @ 1.3)', (tester) async {
    const size = Size(320, 568);
    await _pump(
      tester,
      testScreen(const SignInScreen(), size: size, textScale: 1.3),
      size,
    );
    await _submitWrongCredentials(tester);
    expect(tester.takeException(), isNull);
  });

  testWidgets('05 · Alan hataları ve deneme hakkı bandı', (tester) async {
    await _pump(
      tester,
      testScreen(const SignInScreen(), size: const Size(390, 844)),
      const Size(390, 844),
    );
    await _submitWrongCredentials(tester);
    expect(find.text('Geçerli bir e-posta adresi gir'), findsOneWidget);
    expect(find.text('Şifren en az 8 karakter olmalı'), findsOneWidget);

    await tester.enterText(find.byType(EditableText).at(0), 'deniz@ornek.com');
    await tester.enterText(find.byType(EditableText).at(1), 'yanlis-sifre');
    await tester.tap(find.text('Giriş yap').last);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 50));
    expect(
      find.text('E-posta veya şifre hatalı. 2 deneme hakkın kaldı.'),
      findsOneWidget,
    );
  });

  testWidgets('Doğru bilgilerle giriş Keşfet\'e götürür', (tester) async {
    await _pump(
      tester,
      testApp(size: const Size(390, 844), initialLocation: AppRoutes.signIn),
      const Size(390, 844),
    );
    await tester.enterText(find.byType(EditableText).at(0), 'deniz@ornek.com');
    await tester.enterText(find.byType(EditableText).at(1), 'Bungalovum2026');
    await tester.tap(find.text('Giriş yap').last);
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.text('Sapanca, Sakarya'), findsOneWidget);
  });

  testWidgets('Kayıt: koşullar onaylanmadan Devam pasif', (tester) async {
    await _pump(
      tester,
      testScreen(
        RegisterScreen(today: fixedClock()),
        size: const Size(390, 844),
      ),
      const Size(390, 844),
    );
    final button = find.bySemanticsLabel('Devam et');
    final handle = tester.ensureSemantics();
    expect(
      tester.getSemantics(button).flagsCollection.isEnabled,
      Tristate.isFalse,
    );
    handle.dispose();
  });

  testWidgets('Misafir kalbe basınca Giriş Gerekli açılır', (tester) async {
    final handle = tester.ensureSemantics();
    await _pump(
      tester,
      testApp(size: const Size(390, 844)),
      const Size(390, 844),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.tap(find.bySemanticsLabel('Kaydet').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Kaydetmek için giriş yap'), findsOneWidget);
    handle.dispose();
  });

  group('Doğrulayıcılar', () {
    test('TR cep numarası', () {
      expect(AuthValidators.isTrMobile('532 418 42 18'), isTrue);
      expect(AuthValidators.isTrMobile('0532 418 42 18'), isTrue);
      expect(AuthValidators.isTrMobile('212 418 42 18'), isFalse);
    });

    test('Doğum tarihi ve 18 yaş', () {
      final today = DateTime(2026, 11, 3);
      expect(AuthValidators.parseBirthDate('31 / 02 / 2000'), isNull);
      final d = AuthValidators.parseBirthDate('03 / 11 / 2008')!;
      expect(AuthValidators.isAdult(d, today), isTrue);
      final young = AuthValidators.parseBirthDate('04 / 11 / 2008')!;
      expect(AuthValidators.isAdult(young, today), isFalse);
    });

    test('Şifre gücü', () {
      expect(PasswordStrength.of(''), PasswordStrength.empty);
      expect(PasswordStrength.of('abc'), PasswordStrength.weak);
      expect(PasswordStrength.of('Bungalovum26'), PasswordStrength.medium);
      expect(PasswordStrength.of('Bungalovum26!'), PasswordStrength.strong);
    });

    test('Maskeleme', () {
      expect(KzFormat.maskedPhone('5324184218'), '+90 532 ••• •• 18');
      expect(KzFormat.maskedEmail('deniz@ornek.com'), 'd***@ornek.com');
    });
  });
}
