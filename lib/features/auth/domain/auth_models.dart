import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';

@freezed
abstract class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String firstName,
    String? email,
    String? phone,
  }) = _AuthUser;
}

@freezed
abstract class RegistrationData with _$RegistrationData {
  const factory RegistrationData({
    required String firstName,
    required String lastName,
    required String email,

    /// 10 haneli TR cep numarası; isteğe bağlı.
    String? phone,
    required DateTime birthDate,
    required String password,
    required bool marketingConsent,
  }) = _RegistrationData;
}

enum SocialProvider { google, apple }

/// Backend'den dönen hata türleri.
sealed class AuthFailure implements Exception {
  const AuthFailure();
}

final class InvalidCredentials extends AuthFailure {
  const InvalidCredentials(this.remainingAttempts);
  final int remainingAttempts;
}

final class InvalidCode extends AuthFailure {
  const InvalidCode();
}

final class EmailInUse extends AuthFailure {
  const EmailInUse();
}

final class NetworkFailure extends AuthFailure {
  const NetworkFailure();
}
