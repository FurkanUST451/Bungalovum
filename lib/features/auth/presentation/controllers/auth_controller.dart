import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/auth_repository.dart';
import '../../domain/auth_models.dart';

part 'auth_controller.g.dart';

/// Oturum: null = misafir (göz atıyor).
@Riverpod(keepAlive: true)
class AuthSession extends _$AuthSession {
  @override
  AuthUser? build() => null;

  void signedIn(AuthUser user) => state = user;

  void signOut() => state = null;
}

/// Ekranların çağırdığı kimlik akışları. Başarılı girişte oturumu açar;
/// hatalar [AuthFailure] olarak çağırana iletilir.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  void build() {}

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> _open(Future<AuthUser> f) async {
    final user = await f;
    ref.read(authSessionProvider.notifier).signedIn(user);
  }

  Future<void> signInWithEmail(String email, String password, bool remember) =>
      _open(
        _repo.signInWithEmail(
          email: email.trim(),
          password: password,
          rememberMe: remember,
        ),
      );

  Future<void> requestSmsCode(String phone) => _repo.requestSmsCode(phone);

  Future<void> verifySmsCode(String phone, String code) =>
      _open(_repo.verifySmsCode(phone: phone, code: code));

  Future<void> signInWithProvider(SocialProvider provider) =>
      _open(_repo.signInWithProvider(provider));

  Future<void> register(RegistrationData data) => _repo.register(data);

  Future<void> verifyEmail(String email, String code) =>
      _open(_repo.verifyEmail(email: email, code: code));

  Future<void> resendEmailCode(String email) => _repo.resendEmailCode(email);

  Future<void> requestPasswordReset(String email) =>
      _repo.requestPasswordReset(email.trim());

  Future<String> verifyResetCode(String email, String code) =>
      _repo.verifyResetCode(email: email, code: code);

  Future<void> resetPassword(String token, String password) =>
      _repo.resetPassword(token: token, password: password);
}
