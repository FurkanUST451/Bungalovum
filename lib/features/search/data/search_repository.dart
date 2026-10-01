import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../listing/domain/listing_offer.dart';
import '../domain/search_query.dart';
import 'mock_search_repository.dart';

part 'search_repository.g.dart';

/// Fiyat dağılımı (Filtreler histogramı).
class PriceHistogram {
  const PriceHistogram({
    required this.min,
    required this.max,
    required this.bins,
  });

  /// Gecelik fiyat aralığı (TRY).
  final int min;
  final int max;

  /// Eşit aralıklı dilimlerdeki ilan sayıları.
  final List<int> bins;

  int get step => ((max - min) / bins.length).ceil();
}

abstract interface class SearchRepository {
  Future<List<ListingOffer>> search(SearchQuery query);
  Future<int> count(SearchQuery query);
  Future<PriceHistogram> priceHistogram(SearchQuery query);
  Future<List<RelaxSuggestion>> relaxSuggestions(SearchQuery query);
  Future<List<RecentSearch>> recentSearches();
  Future<List<String>> popularRoutes();

  /// [listingId] verilirse o ilanın takvimi, yoksa bölge ortalaması.
  Future<List<CalendarDay>> calendar({
    required DateTime month,
    String? listingId,
    String location = '',
  });
}

@Riverpod(keepAlive: true)
SearchRepository searchRepository(Ref ref) => MockSearchRepository();
