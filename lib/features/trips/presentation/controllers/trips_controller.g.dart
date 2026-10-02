// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trips_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Seyahatler sekmesinin verisi.

@ProviderFor(tripsOverview)
final tripsOverviewProvider = TripsOverviewProvider._();

/// Seyahatler sekmesinin verisi.

final class TripsOverviewProvider
    extends
        $FunctionalProvider<
          AsyncValue<TripsOverview>,
          TripsOverview,
          FutureOr<TripsOverview>
        >
    with $FutureModifier<TripsOverview>, $FutureProvider<TripsOverview> {
  /// Seyahatler sekmesinin verisi.
  TripsOverviewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tripsOverviewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tripsOverviewHash();

  @$internal
  @override
  $FutureProviderElement<TripsOverview> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TripsOverview> create(Ref ref) {
    return tripsOverview(ref);
  }
}

String _$tripsOverviewHash() => r'd540aa000d699f827933eb39cbf169d1043ad6cb';

/// Seçili sekme (geri dönünce korunur).

@ProviderFor(SelectedTripsTab)
final selectedTripsTabProvider = SelectedTripsTabProvider._();

/// Seçili sekme (geri dönünce korunur).
final class SelectedTripsTabProvider
    extends $NotifierProvider<SelectedTripsTab, TripsTab> {
  /// Seçili sekme (geri dönünce korunur).
  SelectedTripsTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTripsTabProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTripsTabHash();

  @$internal
  @override
  SelectedTripsTab create() => SelectedTripsTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TripsTab value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TripsTab>(value),
    );
  }
}

String _$selectedTripsTabHash() => r'e41256adac395963171c7289887bd102ee8aeb1c';

/// Seçili sekme (geri dönünce korunur).

abstract class _$SelectedTripsTab extends $Notifier<TripsTab> {
  TripsTab build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TripsTab, TripsTab>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TripsTab, TripsTab>,
              TripsTab,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Seyahat aksiyonları.

@ProviderFor(TripActions)
final tripActionsProvider = TripActionsProvider._();

/// Seyahat aksiyonları.
final class TripActionsProvider extends $NotifierProvider<TripActions, void> {
  /// Seyahat aksiyonları.
  TripActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tripActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tripActionsHash();

  @$internal
  @override
  TripActions create() => TripActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$tripActionsHash() => r'950c0b2a131c5e8edd728a53616876da5b777941';

/// Seyahat aksiyonları.

abstract class _$TripActions extends $Notifier<void> {
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

/// 50 · Çıkış kontrol listesinde işaretlenenler (oturum boyunca).

@ProviderFor(CheckoutChecklist)
final checkoutChecklistProvider = CheckoutChecklistFamily._();

/// 50 · Çıkış kontrol listesinde işaretlenenler (oturum boyunca).
final class CheckoutChecklistProvider
    extends $NotifierProvider<CheckoutChecklist, Set<int>> {
  /// 50 · Çıkış kontrol listesinde işaretlenenler (oturum boyunca).
  CheckoutChecklistProvider._({
    required CheckoutChecklistFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'checkoutChecklistProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$checkoutChecklistHash();

  @override
  String toString() {
    return r'checkoutChecklistProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CheckoutChecklist create() => CheckoutChecklist();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<int>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CheckoutChecklistProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$checkoutChecklistHash() => r'9922907e3feab4f31d96c62ec0ef54c016d924ae';

/// 50 · Çıkış kontrol listesinde işaretlenenler (oturum boyunca).

final class CheckoutChecklistFamily extends $Family
    with
        $ClassFamilyOverride<
          CheckoutChecklist,
          Set<int>,
          Set<int>,
          Set<int>,
          String
        > {
  CheckoutChecklistFamily._()
    : super(
        retry: null,
        name: r'checkoutChecklistProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// 50 · Çıkış kontrol listesinde işaretlenenler (oturum boyunca).

  CheckoutChecklistProvider call(String bookingId) =>
      CheckoutChecklistProvider._(argument: bookingId, from: this);

  @override
  String toString() => r'checkoutChecklistProvider';
}

/// 50 · Çıkış kontrol listesinde işaretlenenler (oturum boyunca).

abstract class _$CheckoutChecklist extends $Notifier<Set<int>> {
  late final _$args = ref.$arg as String;
  String get bookingId => _$args;

  Set<int> build(String bookingId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<int>, Set<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<int>, Set<int>>,
              Set<int>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
