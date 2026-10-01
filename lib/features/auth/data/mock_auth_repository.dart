import '../domain/auth_models.dart';
import 'auth_repository.dart';

/// Geliştirme için sahte kimlik doğrulama.
///
/// - E-posta girişi: `deniz@ornek.com` / `Kozalak2026` (başka her çift
///   "hatalı" sayılır ve deneme hakkı düşer).
/// - Her 6 haneli kod geçerlidir; `000000` geçersiz kod örneğidir.
class MockAuthRepository implements AuthRepository {
  MockAuthRepository({this.latency = const Duration(milliseconds: 600)});

  final Duration latency;

  static const demoEmail = 'deniz@ornek.com';
  static const demoPassword = 'Kozalak2026';
  static const invalidCode = '000000';
  static const _maxAttempts = 3;

  int _attemptsLeft = _maxAttempts;

  Future<void> _wait() => Future<void>.delayed(latency);

  AuthUser _user({String? email, String? phone}) =>
      AuthUser(id: 'demo-user', firstName: 'Deniz', email: email, phone: phone);

  void _checkCode(String code) {
    if (code == invalidCode) throw const InvalidCode();
  }

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await _wait();
    if (email.trim().toLowerCase() == demoEmail && password == demoPassword) {
      _attemptsLeft = _maxAttempts;
      return _user(email: email);
    }
    _attemptsLeft = (_attemptsLeft - 1).clamp(0, _maxAttempts);
    throw InvalidCredentials(_attemptsLeft);
  }

  @override
  Future<void> requestSmsCode(String phone) => _wait();

  @override
  Future<AuthUser> verifySmsCode({
    required String phone,
    required String code,
  }) async {
    await _wait();
    _checkCode(code);
    return _user(phone: phone);
  }

  @override
  Future<AuthUser> signInWithProvider(SocialProvider provider) async {
    await _wait();
    return _user();
  }

  @override
  Future<void> register(RegistrationData data) async {
    await _wait();
    if (data.email.trim().toLowerCase() == demoEmail) throw const EmailInUse();
  }

  @override
  Future<AuthUser> verifyEmail({
    required String email,
    required String code,
  }) async {
    await _wait();
    _checkCode(code);
    return _user(email: email);
  }

  @override
  Future<void> resendEmailCode(String email) => _wait();

  @override
  Future<void> requestPasswordReset(String email) => _wait();

  @override
  Future<String> verifyResetCode({
    required String email,
    required String code,
  }) async {
    await _wait();
    _checkCode(code);
    return 'demo-reset-token';
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String password,
  }) => _wait();
}
