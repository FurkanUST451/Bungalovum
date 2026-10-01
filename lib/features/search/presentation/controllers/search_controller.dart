import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../listing/domain/listing_offer.dart';
import '../../data/search_repository.dart';
import '../../domain/search_query.dart';

part 'search_controller.g.dart';

/// Aktif arama: Arama (14) ekranında kurulur, Sonuçlar/Harita/Filtreler
/// ve Tarih/Misafir seçicileri bunu günceller.
@Riverpod(keepAlive: true)
class SearchQueryController extends _$SearchQueryController {
  @override
  SearchQuery build() => const SearchQuery();

  void setLocation(String v) => state = state.copyWith(location: v);

  void setDates(StayDates? v) => state = state.copyWith(dates: v);

  void setGuests(GuestCount v) => state = state.copyWith(guests: v);

  void setFilters(SearchFilters v) => state = state.copyWith(filters: v);

  void setSort(SearchSort v) => state = state.copyWith(sort: v);

  void removeFeature(SearchFeature f) => state = state.copyWith(
    filters: state.filters.copyWith(
      features: {...state.filters.features}..remove(f),
    ),
  );

  void clearPrice() => state = state.copyWith(
    filters: state.filters.copyWith(priceMin: null, priceMax: null),
  );

  void clearFilters() => state = state.copyWith(filters: const SearchFilters());

  /// "Sonuç yok" önerisini uygular.
  void relax(RelaxKind kind) {
    switch (kind) {
      case RelaxKind.flexibleDates:
        setDates(null);
      case RelaxKind.removeHeatedPool:
        removeFeature(SearchFeature.heatedPool);
      case RelaxKind.widenPrice:
        clearPrice();
    }
  }

  void apply(SearchQuery q) => state = q;

  void reset() => state = const SearchQuery();
}

@riverpod
Future<List<ListingOffer>> searchResults(Ref ref) {
  final q = ref.watch(searchQueryControllerProvider);
  return ref.watch(searchRepositoryProvider).search(q);
}

/// Filtreler ekranındaki taslak için canlı sonuç sayısı.
@riverpod
Future<int> searchCount(Ref ref, SearchQuery query) =>
    ref.watch(searchRepositoryProvider).count(query);

@riverpod
Future<PriceHistogram> priceHistogram(Ref ref, SearchQuery query) =>
    ref.watch(searchRepositoryProvider).priceHistogram(query);

@riverpod
Future<List<RelaxSuggestion>> relaxSuggestions(Ref ref) {
  final q = ref.watch(searchQueryControllerProvider);
  return ref.watch(searchRepositoryProvider).relaxSuggestions(q);
}

@riverpod
Future<List<RecentSearch>> recentSearches(Ref ref) =>
    ref.watch(searchRepositoryProvider).recentSearches();

@riverpod
Future<List<String>> popularRoutes(Ref ref) =>
    ref.watch(searchRepositoryProvider).popularRoutes();
