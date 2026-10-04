import 'dart:async';
import 'dart:io';

import 'package:bungapp/features/auth/data/supabase_auth_repository.dart';
import 'package:bungapp/features/auth/domain/auth_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

void main() {
  group('mapAuthError', () {
    sb.AuthApiException api(String code) =>
        sb.AuthApiException('hata', statusCode: '400', code: code);

    test('hatalı şifre kalan hakla birlikte döner', () {
      final f = mapAuthError(api('invalid_credentials'), remainingAttempts: 2);
      expect(f, isA<InvalidCredentials>());
      expect((f as InvalidCredentials).remainingAttempts, 2);
    });

    test('doğrulanmamış e-posta, hesap sızdırmamak için aynı hata', () {
      expect(mapAuthError(api('email_not_confirmed')), isA<InvalidCredentials>());
    });

    test('hız sınırı kilitli giriş sayılır', () {
      final f = mapAuthError(api('over_request_rate_limit'));
      expect((f as InvalidCredentials).remainingAttempts, 0);
    });

    test('süresi dolmuş ya da yanlış kod', () {
      expect(mapAuthError(api('otp_expired')), isA<InvalidCode>());
    });

    test('kayıtlı e-posta', () {
      expect(mapAuthError(api('user_already_exists')), isA<EmailInUse>());
    });

    test('ağ ve bilinmeyen hatalar bağlantı hatası olur', () {
      expect(mapAuthError(const SocketException('x')), isA<NetworkFailure>());
      expect(mapAuthError(TimeoutException('x')), isA<NetworkFailure>());
      expect(mapAuthError(StateError('x')), isA<NetworkFailure>());
      expect(mapAuthError(api('beklenmeyen')), isA<NetworkFailure>());
    });

    test('iptal edilen sağlayıcı girişi olduğu gibi iletilir', () {
      expect(mapAuthError(const SignInCancelled()), isA<SignInCancelled>());
    });
  });
}
