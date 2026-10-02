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

String _$wishlistsHash() => r'c66267e3ecfec4f1da4e7326b0ec91a43577500a';

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
          AsyncValue<List<RecentView>>,
          List<RecentView>,
          FutureOr<List<RecentView>>
        >
    with $FutureModifier<List<RecentView>>, $FutureProvider<List<RecentView>> {
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
  $FutureProviderElement<List<RecentView>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RecentView>> create(Ref ref) {
    return recentlyViewed(ref);
  }
}

String _$recentlyViewedHash() => r'197a4ec4e6e9380ab64a3dd3416171458dce42d6';

/// Tek ilanın özet bilgisi (kapak mozaikleri, kartlar).

@ProviderFor(listingSummary)
final listingSummaryProvider = ListingSummaryFamily._();

/// Tek ilanın özet bilgisi (kapak mozaikleri, kartlar).

final class ListingSummaryProvider
    extends $FunctionalProvider<AsyncValue<Listing>, Listing, FutureOr<Listing>>
    with $FutureModifier<Listing>, $FutureProvider<Listing> {
  /// Tek ilanın özet bilgisi (kapak mozaikleri, kartlar).
  ListingSummaryProvider._({
    required ListingSummaryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'listingSummaryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$listingSummaryHash();

  @override
  String toString() {
    return r'listingSummaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Listing> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Listing> create(Ref ref) {
    final argument = this.argument as String;
    return listingSummary(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ListingSummaryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listingSummaryHash() => r'89a579d42fc68a5954c3cf9465b692c5ba9a496f';

/// Tek ilanın özet bilgisi (kapak mozaikleri, kartlar).

final class ListingSummaryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Listing>, String> {
  ListingSummaryFamily._()
    : super(
        retry: null,
        name: r'listingSummaryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Tek ilanın özet bilgisi (kapak mozaikleri, kartlar).

  ListingSummaryProvider call(String id) =>
      ListingSummaryProvider._(argument: id, from: this);

  @override
  String toString() => r'listingSummaryProvider';
}

/// Liste silinmişse null.

@ProviderFor(wishlistItems)
final wishlistItemsProvider = WishlistItemsFamily._();

/// Liste silinmişse null.

final class WishlistItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WishlistItem>?>,
          List<WishlistItem>?,
          FutureOr<List<WishlistItem>?>
        >
    with
        $FutureModifier<List<WishlistItem>?>,
        $FutureProvider<List<WishlistItem>?> {
  /// Liste silinmişse null.
  WishlistItemsProvider._({
    required WishlistItemsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'wishlistItemsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$wishlistItemsHash();

  @override
  String toString() {
    return r'wishlistItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<WishlistItem>?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WishlistItem>?> create(Ref ref) {
    final argument = this.argument as String;
    return wishlistItems(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WishlistItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wishlistItemsHash() => r'4e54e7c71a69cba1899a171250956621c2aa9ec8';

/// Liste silinmişse null.

final class WishlistItemsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<WishlistItem>?>, String> {
  WishlistItemsFamily._()
    : super(
        retry: null,
        name: r'wishlistItemsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Liste silinmişse null.

  WishlistItemsProvider call(String listId) =>
      WishlistItemsProvider._(argument: listId, from: this);

  @override
  String toString() => r'wishlistItemsProvider';
}
