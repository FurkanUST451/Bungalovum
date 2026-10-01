// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_listings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Kullanıcının listeleri (56 · Kaydettiklerim, 30 · Listeye Ekle).

@ProviderFor(Wishlists)
final wishlistsProvider = WishlistsProvider._();

/// Kullanıcının listeleri (56 · Kaydettiklerim, 30 · Listeye Ekle).
final class WishlistsProvider
    extends $AsyncNotifierProvider<Wishlists, List<Wishlist>> {
  /// Kullanıcının listeleri (56 · Kaydettiklerim, 30 · Listeye Ekle).
  WishlistsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wishlistsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wishlistsHash();

  @$internal
  @override
  Wishlists create() => Wishlists();
}

String _$wishlistsHash() => r'c341b756052cfb8032bda9566403bb5031752c47';

/// Kullanıcının listeleri (56 · Kaydettiklerim, 30 · Listeye Ekle).

abstract class _$Wishlists extends $AsyncNotifier<List<Wishlist>> {
  FutureOr<List<Wishlist>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Wishlist>>, List<Wishlist>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Wishlist>>, List<Wishlist>>,
              AsyncValue<List<Wishlist>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Herhangi bir listede olan ilanlar (kalp dolu görünür).

@ProviderFor(savedListingIds)
final savedListingIdsProvider = SavedListingIdsProvider._();

/// Herhangi bir listede olan ilanlar (kalp dolu görünür).

final class SavedListingIdsProvider
    extends $FunctionalProvider<Set<String>, Set<String>, Set<String>>
    with $Provider<Set<String>> {
  /// Herhangi bir listede olan ilanlar (kalp dolu görünür).
  SavedListingIdsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedListingIdsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedListingIdsHash();

  @$internal
  @override
  $ProviderElement<Set<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Set<String> create(Ref ref) {
    return savedListingIds(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$savedListingIdsHash() => r'9eda810b7ab128adf763ef307400c499b0afd24a';

@ProviderFor(recentlyViewed)
final recentlyViewedProvider = RecentlyViewedProvider._();

final class RecentlyViewedProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  RecentlyViewedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentlyViewedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentlyViewedHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return recentlyViewed(ref);
  }
}

String _$recentlyViewedHash() => r'fb7e8d6921d5897069b94b6d31e6c2d2e9cfc6a6';
