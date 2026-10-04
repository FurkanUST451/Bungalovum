import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/auth_models.dart';
import 'mock_auth_repository.dart';

part 'auth_repository.g.dart';

/// Kimlik doğrulama API'si. Hatalar [AuthFailure] olarak fırlatılır.
abstract interface class AuthRepository {
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
    required bool rememberMe,
  });

  /// SMS kodu gönderir.
  Future<void> requestSmsCode(String phone);
  Future<AuthUser> verifySmsCode({required String phone, required String code});

  Future<AuthUser> signInWithProvider(SocialProvider provider);

  /// Hesabı oluşturur ve e-postaya doğrulama kodu gönderir.
  Future<void> register(RegistrationData data);
  Future<AuthUser> verifyEmail({required String email, required String code});
  Future<void> resendEmailCode(String email);

  Future<void> requestPasswordReset(String email);

  /// Kodu doğrular, şifre sıfırlama jetonunu döner.
  Future<String> verifyResetCode({required String email, required String code});

  /// Şifreyi günceller; diğer cihazlardaki oturumlar backend'de kapatılır.
  Future<void> resetPassword({required String token, required String password});

  /// Cihazda saklı oturumun kullanıcısı; yoksa null (misafir).
  AuthUser? get currentUser;

  /// Oturum dışarıdan sonlandığında (süre doldu, başka cihazdan çıkış) null yayar.
  Stream<AuthUser?> get userChanges;

  Future<void> signOut();
}

/// Varsayılan sahte uygulamadır (testler, önizleme); `main.dart` gerçek
/// Supabase uygulamasıyla değiştirir.
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => MockAuthRepository();
