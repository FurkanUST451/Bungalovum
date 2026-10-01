// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Keşfet'te seçili kategori.

@ProviderFor(SelectedExploreCategory)
final selectedExploreCategoryProvider = SelectedExploreCategoryProvider._();

/// Keşfet'te seçili kategori.
final class SelectedExploreCategoryProvider
    extends $NotifierProvider<SelectedExploreCategory, ExploreCategory> {
  /// Keşfet'te seçili kategori.
  SelectedExploreCategoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedExploreCategoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedExploreCategoryHash();

  @$internal
  @override
  SelectedExploreCategory create() => SelectedExploreCategory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExploreCategory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExploreCategory>(value),
    );
  }
}

String _$selectedExploreCategoryHash() =>
    r'924bed7c41630ee785aa97e15919394e0ca7b94c';

/// Keşfet'te seçili kategori.

abstract class _$SelectedExploreCategory extends $Notifier<ExploreCategory> {
  ExploreCategory build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ExploreCategory, ExploreCategory>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExploreCategory, ExploreCategory>,
              ExploreCategory,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Seçili kategoriye göre Keşfet akışı.

@ProviderFor(exploreFeed)
final exploreFeedProvider = ExploreFeedProvider._();

/// Seçili kategoriye göre Keşfet akışı.

final class ExploreFeedProvider
    extends
        $FunctionalProvider<
          AsyncValue<ExploreFeed>,
          ExploreFeed,
          FutureOr<ExploreFeed>
        >
    with $FutureModifier<ExploreFeed>, $FutureProvider<ExploreFeed> {
  /// Seçili kategoriye göre Keşfet akışı.
  ExploreFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exploreFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exploreFeedHash();

  @$internal
  @override
  $FutureProviderElement<ExploreFeed> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ExploreFeed> create(Ref ref) {
    return exploreFeed(ref);
  }
}

String _$exploreFeedHash() => r'5be90d06f2e8ff65886efd9749000a860d5873b2';
