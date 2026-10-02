// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(permissionService)
final permissionServiceProvider = PermissionServiceProvider._();

final class PermissionServiceProvider
    extends
        $FunctionalProvider<
          PermissionService,
          PermissionService,
          PermissionService
        >
    with $Provider<PermissionService> {
  PermissionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'permissionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$permissionServiceHash();

  @$internal
  @override
  $ProviderElement<PermissionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PermissionService create(Ref ref) {
    return permissionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PermissionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PermissionService>(value),
    );
  }
}

String _$permissionServiceHash() => r'3979d7683dca4da36e8dc5a6cc5d671e6a78dc16';

@ProviderFor(permissionStatus)
final permissionStatusProvider = PermissionStatusFamily._();

final class PermissionStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppPermissionStatus>,
          AppPermissionStatus,
          FutureOr<AppPermissionStatus>
        >
    with
        $FutureModifier<AppPermissionStatus>,
        $FutureProvider<AppPermissionStatus> {
  PermissionStatusProvider._({
    required PermissionStatusFamily super.from,
    required AppPermission super.argument,
  }) : super(
         retry: null,
         name: r'permissionStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$permissionStatusHash();

  @override
  String toString() {
    return r'permissionStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AppPermissionStatus> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppPermissionStatus> create(Ref ref) {
    final argument = this.argument as AppPermission;
    return permissionStatus(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PermissionStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$permissionStatusHash() => r'b7a7df1e8cc483195f04dfcd4b5dc9e59b2e10ac';

final class PermissionStatusFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<AppPermissionStatus>,
          AppPermission
        > {
  PermissionStatusFamily._()
    : super(
        retry: null,
        name: r'permissionStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PermissionStatusProvider call(AppPermission p) =>
      PermissionStatusProvider._(argument: p, from: this);

  @override
  String toString() => r'permissionStatusProvider';
}

/// Bildirim ön-izni (81) bu oturumda gösterildi mi; tekrar rahatsız etmeyiz.

@ProviderFor(NotificationPromptShown)
final notificationPromptShownProvider = NotificationPromptShownProvider._();

/// Bildirim ön-izni (81) bu oturumda gösterildi mi; tekrar rahatsız etmeyiz.
final class NotificationPromptShownProvider
    extends $NotifierProvider<NotificationPromptShown, bool> {
  /// Bildirim ön-izni (81) bu oturumda gösterildi mi; tekrar rahatsız etmeyiz.
  NotificationPromptShownProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPromptShownProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPromptShownHash();

  @$internal
  @override
  NotificationPromptShown create() => NotificationPromptShown();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$notificationPromptShownHash() =>
    r'91f1a6456a09b7013ae98b63af53b635365a2f8c';

/// Bildirim ön-izni (81) bu oturumda gösterildi mi; tekrar rahatsız etmeyiz.

abstract class _$NotificationPromptShown extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
