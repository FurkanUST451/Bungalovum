// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Oturum: null = misafir (göz atıyor).

@ProviderFor(AuthSession)
final authSessionProvider = AuthSessionProvider._();

/// Oturum: null = misafir (göz atıyor).
final class AuthSessionProvider
    extends $NotifierProvider<AuthSession, AuthUser?> {
  /// Oturum: null = misafir (göz atıyor).
  AuthSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSessionHash();

  @$internal
  @override
  AuthSession create() => AuthSession();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthUser? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthUser?>(value),
    );
  }
}

String _$authSessionHash() => r'eea780a259a252be933951ce33b7ad7789b4a3a9';

/// Oturum: null = misafir (göz atıyor).

abstract class _$AuthSession extends $Notifier<AuthUser?> {
  AuthUser? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AuthUser?, AuthUser?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthUser?, AuthUser?>,
              AuthUser?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Ekranların çağırdığı kimlik akışları. Başarılı girişte oturumu açar;
/// hatalar [AuthFailure] olarak çağırana iletilir.

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// Ekranların çağırdığı kimlik akışları. Başarılı girişte oturumu açar;
/// hatalar [AuthFailure] olarak çağırana iletilir.
final class AuthControllerProvider
    extends $NotifierProvider<AuthController, void> {
  /// Ekranların çağırdığı kimlik akışları. Başarılı girişte oturumu açar;
  /// hatalar [AuthFailure] olarak çağırana iletilir.
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$authControllerHash() => r'4e71cce22d7a1ed4d78fdd4683e865f60678a0fe';

/// Ekranların çağırdığı kimlik akışları. Başarılı girişte oturumu açar;
/// hatalar [AuthFailure] olarak çağırana iletilir.

abstract class _$AuthController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
