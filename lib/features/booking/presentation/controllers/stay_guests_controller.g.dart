// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stay_guests_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 39 · Misafir Bilgileri: kimlik bildirimi için kayıtlı misafirler.

@ProviderFor(StayGuestsController)
final stayGuestsControllerProvider = StayGuestsControllerFamily._();

/// 39 · Misafir Bilgileri: kimlik bildirimi için kayıtlı misafirler.
final class StayGuestsControllerProvider
    extends $AsyncNotifierProvider<StayGuestsController, StayGuestList> {
  /// 39 · Misafir Bilgileri: kimlik bildirimi için kayıtlı misafirler.
  StayGuestsControllerProvider._({
    required StayGuestsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'stayGuestsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$stayGuestsControllerHash();

  @override
  String toString() {
    return r'stayGuestsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  StayGuestsController create() => StayGuestsController();

  @override
  bool operator ==(Object other) {
    return other is StayGuestsControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stayGuestsControllerHash() =>
    r'ca3d1f43522d0d85ea0f82eb0462598d19bc8bda';

/// 39 · Misafir Bilgileri: kimlik bildirimi için kayıtlı misafirler.

final class StayGuestsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          StayGuestsController,
          AsyncValue<StayGuestList>,
          StayGuestList,
          FutureOr<StayGuestList>,
          String
        > {
  StayGuestsControllerFamily._()
    : super(
        retry: null,
        name: r'stayGuestsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 39 · Misafir Bilgileri: kimlik bildirimi için kayıtlı misafirler.

  StayGuestsControllerProvider call(String bookingId) =>
      StayGuestsControllerProvider._(argument: bookingId, from: this);

  @override
  String toString() => r'stayGuestsControllerProvider';
}

/// 39 · Misafir Bilgileri: kimlik bildirimi için kayıtlı misafirler.

abstract class _$StayGuestsController extends $AsyncNotifier<StayGuestList> {
  late final _$args = ref.$arg as String;
  String get bookingId => _$args;

  FutureOr<StayGuestList> build(String bookingId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<StayGuestList>, StayGuestList>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<StayGuestList>, StayGuestList>,
              AsyncValue<StayGuestList>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
