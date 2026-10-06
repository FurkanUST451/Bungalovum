import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../core/config/backend_config.dart';
import '../domain/auth_models.dart';
import 'auth_repository.dart';

/// Supabase Auth ile gerçek kimlik doğrulama.
///
/// Supabase panelinde gerekenler: Email › "Confirm email" açık; "Confirm
/// signup" ve "Reset password" e-posta şablonları `{{ .Token }}` ile 6 haneli
/// kodu göstermeli; Google sağlayıcısı etkin.
class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._client);

  final sb.SupabaseClient _client;

  sb.GoTrueClient get _auth => _client.auth;

  /// Hatalı şifrede sunucu kalan hakkı bildirmez; tekrar denemeyi uygulama
  /// tarafında sınırlarız (sunucuda ayrıca IP başına hız sınırı vardır).
  static const _maxAttempts = 10;
  static const _lockDuration = Duration(minutes: 5);
  int _attemptsLeft = _maxAttempts;
  DateTime? _lockedUntil;

  static bool _googleReady = false;

  @override
  AuthUser? get currentUser {
    final user = _auth.currentUser;
    return user == null ? null : _toUser(user);
  }

  @override
  Stream<AuthUser?> get userChanges => _auth.onAuthStateChange.map((e) {
    final user = e.session?.user;
    return user == null ? null : _toUser(user);
  });

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
    // Supabase oturumu cihazda her zaman saklar ve yeniler.
    required bool rememberMe,
  }) async {
    final lockedUntil = _lockedUntil;
    if (lockedUntil != null) {
      if (DateTime.now().isBefore(lockedUntil)) {
        throw const InvalidCredentials(0);
      }
      _lockedUntil = null;
      _attemptsLeft = _maxAttempts;
    }
    try {
      final res = await _auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      _attemptsLeft = _maxAttempts;
      return await _withProfile(res.user!);
    } on Object catch (e) {
      final failure = mapAuthError(e, remainingAttempts: _attemptsLeft - 1);
      if (failure is InvalidCredentials) {
        _attemptsLeft = (_attemptsLeft - 1).clamp(0, _maxAttempts);
        if (_attemptsLeft == 0) _lockedUntil = DateTime.now().add(_lockDuration);
        throw InvalidCredentials(_attemptsLeft);
      }
      throw failure;
    }
  }

  @override
  Future<void> requestSmsCode(String phone) => _guard(
    () => _auth.signInWithOtp(phone: _e164(phone)),
  );

  @override
  Future<AuthUser> verifySmsCode({
    required String phone,
    required String code,
  }) => _guard(() async {
    final res = await _auth.verifyOTP(
      phone: _e164(phone),
      token: code,
      type: sb.OtpType.sms,
    );
    return _withProfile(res.user!);
  });

  @override
  Future<AuthUser> signInWithProvider(SocialProvider provider) =>
      switch (provider) {
        SocialProvider.google => _signInWithGoogle(),
        // Apple ile giriş Apple Developer hesabı gerektirir; henüz bağlı değil.
        SocialProvider.apple => throw const NetworkFailure(),
      };

  Future<AuthUser> _signInWithGoogle() => _guard(() async {
    if (BackendConfig.googleWebClientId.isEmpty) {
      throw StateError('GOOGLE_WEB_CLIENT_ID tanımlı değil.');
    }
    if (!_googleReady) {
      await GoogleSignIn.instance.initialize(
        serverClientId: BackendConfig.googleWebClientId,
        clientId: BackendConfig.googleIosClientId.isEmpty
            ? null
            : BackendConfig.googleIosClientId,
      );
      _googleReady = true;
    }
    final GoogleSignInAccount account;
    try {
      account = await GoogleSignIn.instance.authenticate();
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw const SignInCancelled();
      }
      rethrow;
    }
    final idToken = account.authentication.idToken;
    if (idToken == null) throw StateError('Google kimlik jetonu alınamadı.');
    final res = await _auth.signInWithIdToken(
      provider: sb.OAuthProvider.google,
      idToken: idToken,
    );
    return _withProfile(res.user!);
  });

  @override
  Future<void> register(RegistrationData data) => _guard(() async {
    final res = await _auth.signUp(
      email: data.email.trim(),
      password: data.password,
      // handle_new_user trigger'ı bu alanlardan profili oluşturur.
      data: {
        'first_name': data.firstName.trim(),
        'last_name': data.lastName.trim(),
        if (data.phone != null && data.phone!.isNotEmpty) 'phone': data.phone,
        'birth_date': _isoDate(data.birthDate),
        'marketing_consent': data.marketingConsent,
      },
    );
    // E-posta zaten kayıtlıysa Supabase hata vermez (hesap sızdırmamak için),
    // kimlik listesini boş döner.
    if (res.user?.identities?.isEmpty ?? false) throw const EmailInUse();
  });

  @override
  Future<AuthUser> verifyEmail({
    required String email,
    required String code,
  }) => _guard(() async {
    final res = await _auth.verifyOTP(
      email: email.trim(),
      token: code,
      type: sb.OtpType.signup,
    );
    return _withProfile(res.user!);
  });

  @override
  Future<void> resendEmailCode(String email) => _guard(
    () => _auth.resend(type: sb.OtpType.signup, email: email.trim()),
  );

  @override
  Future<void> requestPasswordReset(String email) =>
      _guard(() => _auth.resetPasswordForEmail(email.trim()));

  /// Kod doğrulanınca Supabase kurtarma oturumu açar; şifre bu oturumla
  /// güncellenir. Ayrı bir jeton gerekmediği için sabit bir işaret döner.
  @override
  Future<String> verifyResetCode({
    required String email,
    required String code,
  }) => _guard(() async {
    await _auth.verifyOTP(
      email: email.trim(),
      token: code,
      type: sb.OtpType.recovery,
    );
    return 'recovery-session';
  });

  /// Şifreyi günceller ve tüm cihazlardaki oturumları kapatır; kullanıcı yeni
  /// şifresiyle giriş yapar.
  @override
  Future<void> resetPassword({
    required String token,
    required String password,
  }) => _guard(() async {
    await _auth.updateUser(sb.UserAttributes(password: password));
    await _auth.signOut(scope: sb.SignOutScope.global);
  });

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on Object {
      // Ağ yoksa bile yerel oturumu kapat.
      await _auth.signOut(scope: sb.SignOutScope.local);
    }
  }

  // ---------------------------------------------------------------------------

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on Object catch (e) {
      throw mapAuthError(e);
    }
  }

  /// Ad önce oturum metadata'sından (e-posta kaydı, Google), yoksa profilden.
  Future<AuthUser> _withProfile(sb.User user) async {
    final fromMeta = _toUser(user);
    if (fromMeta.firstName.isNotEmpty) return fromMeta;
    try {
      final row = await _client
          .from('profiles')
          .select('first_name')
          .eq('id', user.id)
          .maybeSingle();
      final name = (row?['first_name'] as String?)?.trim() ?? '';
      return AuthUser(
        id: user.id,
        firstName: name,
        email: user.email,
        phone: _localPhone(user.phone),
      );
    } on Object {
      return fromMeta;
    }
  }

  AuthUser _toUser(sb.User user) {
    final meta = user.userMetadata ?? const <String, dynamic>{};
    final name =
        (meta['first_name'] ?? meta['given_name'] ?? meta['full_name'] ?? '')
            as String;
    return AuthUser(
      id: user.id,
      firstName: name.trim(),
      email: user.email,
      phone: _localPhone(user.phone),
    );
  }

  static String _e164(String tr10) => '+90$tr10';

  /// "905321112233" → "5321112233"
  static String? _localPhone(String? phone) {
    if (phone == null || phone.isEmpty) return null;
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    return digits.length > 10 ? digits.substring(digits.length - 10) : digits;
  }

  static String _isoDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}

/// Supabase/ağ hatasını uygulamanın [AuthFailure] türlerine çevirir.
@visibleForTesting
AuthFailure mapAuthError(Object e, {int remainingAttempts = 0}) {
  if (e is AuthFailure) return e;
  if (e is sb.AuthApiException) {
    return switch (e.code) {
      'invalid_credentials' ||
      'email_not_confirmed' ||
      'user_not_found' => InvalidCredentials(remainingAttempts),
      'over_request_rate_limit' => const InvalidCredentials(0),
      'otp_expired' || 'otp_disabled' || 'invalid_otp' => const InvalidCode(),
      'email_exists' || 'user_already_exists' => const EmailInUse(),
      _ => const NetworkFailure(),
    };
  }
  if (e is sb.AuthRetryableFetchException ||
      e is SocketException ||
      e is TimeoutException) {
    return const NetworkFailure();
  }
  return const NetworkFailure();
}
