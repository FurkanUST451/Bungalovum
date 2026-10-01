// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Aktif arama: Arama (14) ekranında kurulur, Sonuçlar/Harita/Filtreler
/// ve Tarih/Misafir seçicileri bunu günceller.

@ProviderFor(SearchQueryController)
final searchQueryControllerProvider = SearchQueryControllerProvider._();

/// Aktif arama: Arama (14) ekranında kurulur, Sonuçlar/Harita/Filtreler
/// ve Tarih/Misafir seçicileri bunu günceller.
final class SearchQueryControllerProvider
    extends $NotifierProvider<SearchQueryController, SearchQuery> {
  /// Aktif arama: Arama (14) ekranında kurulur, Sonuçlar/Harita/Filtreler
  /// ve Tarih/Misafir seçicileri bunu günceller.
  SearchQueryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryControllerHash();

  @$internal
  @override
  SearchQueryController create() => SearchQueryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchQuery value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchQuery>(value),
    );
  }
}

String _$searchQueryControllerHash() =>
    r'b37297b285756a7cda3fceddf19813becd38ef5e';

/// Aktif arama: Arama (14) ekranında kurulur, Sonuçlar/Harita/Filtreler
/// ve Tarih/Misafir seçicileri bunu günceller.

abstract class _$SearchQueryController extends $Notifier<SearchQuery> {
  SearchQuery build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SearchQuery, SearchQuery>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SearchQuery, SearchQuery>,
              SearchQuery,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(searchResults)
final searchResultsProvider = SearchResultsProvider._();

final class SearchResultsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ListingOffer>>,
          List<ListingOffer>,
          FutureOr<List<ListingOffer>>
        >
    with
        $FutureModifier<List<ListingOffer>>,
        $FutureProvider<List<ListingOffer>> {
  SearchResultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchResultsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchResultsHash();

  @$internal
  @override
  $FutureProviderElement<List<ListingOffer>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ListingOffer>> create(Ref ref) {
    return searchResults(ref);
  }
}

String _$searchResultsHash() => r'9c8988f4d147693c3dbceab40813dd62525c733a';

/// Filtreler ekranındaki taslak için canlı sonuç sayısı.

@ProviderFor(searchCount)
final searchCountProvider = SearchCountFamily._();

/// Filtreler ekranındaki taslak için canlı sonuç sayısı.

final class SearchCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Filtreler ekranındaki taslak için canlı sonuç sayısı.
  SearchCountProvider._({
    required SearchCountFamily super.from,
    required SearchQuery super.argument,
  }) : super(
         retry: null,
         name: r'searchCountProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchCountHash();

  @override
  String toString() {
    return r'searchCountProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    final argument = this.argument as SearchQuery;
    return searchCount(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchCountProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchCountHash() => r'c826c0636222f0fecd5d72acde1db4081d53f218';

/// Filtreler ekranındaki taslak için canlı sonuç sayısı.

final class SearchCountFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int>, SearchQuery> {
  SearchCountFamily._()
    : super(
        retry: null,
        name: r'searchCountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Filtreler ekranındaki taslak için canlı sonuç sayısı.

  SearchCountProvider call(SearchQuery query) =>
      SearchCountProvider._(argument: query, from: this);

  @override
  String toString() => r'searchCountProvider';
}

@ProviderFor(priceHistogram)
final priceHistogramProvider = PriceHistogramFamily._();

final class PriceHistogramProvider
    extends
        $FunctionalProvider<
          AsyncValue<PriceHistogram>,
          PriceHistogram,
          FutureOr<PriceHistogram>
        >
    with $FutureModifier<PriceHistogram>, $FutureProvider<PriceHistogram> {
  PriceHistogramProvider._({
    required PriceHistogramFamily super.from,
    required SearchQuery super.argument,
  }) : super(
         retry: null,
         name: r'priceHistogramProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$priceHistogramHash();

  @override
  String toString() {
    return r'priceHistogramProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PriceHistogram> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PriceHistogram> create(Ref ref) {
    final argument = this.argument as SearchQuery;
    return priceHistogram(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PriceHistogramProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$priceHistogramHash() => r'39401bb1ad871268d0344c558c3da2f46d52e0bf';

final class PriceHistogramFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PriceHistogram>, SearchQuery> {
  PriceHistogramFamily._()
    : super(
        retry: null,
        name: r'priceHistogramProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PriceHistogramProvider call(SearchQuery query) =>
      PriceHistogramProvider._(argument: query, from: this);

  @override
  String toString() => r'priceHistogramProvider';
}

@ProviderFor(relaxSuggestions)
final relaxSuggestionsProvider = RelaxSuggestionsProvider._();

final class RelaxSuggestionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RelaxSuggestion>>,
          List<RelaxSuggestion>,
          FutureOr<List<RelaxSuggestion>>
        >
    with
        $FutureModifier<List<RelaxSuggestion>>,
        $FutureProvider<List<RelaxSuggestion>> {
  RelaxSuggestionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'relaxSuggestionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$relaxSuggestionsHash();

  @$internal
  @override
  $FutureProviderElement<List<RelaxSuggestion>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RelaxSuggestion>> create(Ref ref) {
    return relaxSuggestions(ref);
  }
}

String _$relaxSuggestionsHash() => r'1b513a8ea5ced32f3152a0294ef202ab7c0d1263';

@ProviderFor(recentSearches)
final recentSearchesProvider = RecentSearchesProvider._();

final class RecentSearchesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RecentSearch>>,
          List<RecentSearch>,
          FutureOr<List<RecentSearch>>
        >
    with
        $FutureModifier<List<RecentSearch>>,
        $FutureProvider<List<RecentSearch>> {
  RecentSearchesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentSearchesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentSearchesHash();

  @$internal
  @override
  $FutureProviderElement<List<RecentSearch>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RecentSearch>> create(Ref ref) {
    return recentSearches(ref);
  }
}

String _$recentSearchesHash() => r'06406de1c3cf83f6d016d716ceba44fc77c50fa1';

@ProviderFor(popularRoutes)
final popularRoutesProvider = PopularRoutesProvider._();

final class PopularRoutesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  PopularRoutesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'popularRoutesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$popularRoutesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return popularRoutes(ref);
  }
}

String _$popularRoutesHash() => r'e322f218f0b570900c22cdee35dced1acc97e814';
