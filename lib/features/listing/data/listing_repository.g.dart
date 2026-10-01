// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(listingRepository)
final listingRepositoryProvider = ListingRepositoryProvider._();

final class ListingRepositoryProvider
    extends
        $FunctionalProvider<
          ListingRepository,
          ListingRepository,
          ListingRepository
        >
    with $Provider<ListingRepository> {
  ListingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listingRepositoryHash();

  @$internal
  @override
  $ProviderElement<ListingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ListingRepository create(Ref ref) {
    return listingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListingRepository>(value),
    );
  }
}

String _$listingRepositoryHash() => r'e63712587822ba32a2fefb841a802ef68bdaed95';

@ProviderFor(listingDetail)
final listingDetailProvider = ListingDetailFamily._();

final class ListingDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ListingDetail>,
          ListingDetail,
          FutureOr<ListingDetail>
        >
    with $FutureModifier<ListingDetail>, $FutureProvider<ListingDetail> {
  ListingDetailProvider._({
    required ListingDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'listingDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$listingDetailHash();

  @override
  String toString() {
    return r'listingDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ListingDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ListingDetail> create(Ref ref) {
    final argument = this.argument as String;
    return listingDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ListingDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listingDetailHash() => r'f722743662a226827d400af4f8d3b1a2caac66ab';

final class ListingDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ListingDetail>, String> {
  ListingDetailFamily._()
    : super(
        retry: null,
        name: r'listingDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ListingDetailProvider call(String id) =>
      ListingDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'listingDetailProvider';
}

@ProviderFor(listingsByIds)
final listingsByIdsProvider = ListingsByIdsFamily._();

final class ListingsByIdsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Listing>>,
          List<Listing>,
          FutureOr<List<Listing>>
        >
    with $FutureModifier<List<Listing>>, $FutureProvider<List<Listing>> {
  ListingsByIdsProvider._({
    required ListingsByIdsFamily super.from,
    required List<String> super.argument,
  }) : super(
         retry: null,
         name: r'listingsByIdsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$listingsByIdsHash();

  @override
  String toString() {
    return r'listingsByIdsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Listing>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Listing>> create(Ref ref) {
    final argument = this.argument as List<String>;
    return listingsByIds(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ListingsByIdsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listingsByIdsHash() => r'28f451b422abb651b9d0198edd4dcc448ed91982';

final class ListingsByIdsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Listing>>, List<String>> {
  ListingsByIdsFamily._()
    : super(
        retry: null,
        name: r'listingsByIdsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ListingsByIdsProvider call(List<String> ids) =>
      ListingsByIdsProvider._(argument: ids, from: this);

  @override
  String toString() => r'listingsByIdsProvider';
}
