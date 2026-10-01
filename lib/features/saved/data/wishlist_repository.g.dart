// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(wishlistRepository)
final wishlistRepositoryProvider = WishlistRepositoryProvider._();

final class WishlistRepositoryProvider
    extends
        $FunctionalProvider<
          WishlistRepository,
          WishlistRepository,
          WishlistRepository
        >
    with $Provider<WishlistRepository> {
  WishlistRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wishlistRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wishlistRepositoryHash();

  @$internal
  @override
  $ProviderElement<WishlistRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WishlistRepository create(Ref ref) {
    return wishlistRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WishlistRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WishlistRepository>(value),
    );
  }
}

String _$wishlistRepositoryHash() =>
    r'8b357f6303b0bc97a801afe71787506f80aa8b78';
