import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../listing/data/listing_json.dart';
import '../../listing/domain/listing_offer.dart';
import '../domain/search_query.dart';
import 'search_repository.dart';

/// 14–18 · Arama Supabase'te (`search_listing_cards`, `listing_calendar_days`).
/// Konum, il/ilçe/başlıkta Türkçe harf farkı gözetmeden aranır.
///
/// İlanla ilgisi olmayan öneriler (son aramalar) henüz backend'de yok;
/// [_fallback]'ten gelir.
class SupabaseSearchRepository implements SearchRepository {
  SupabaseSearchRepository(this._client, this._fallback);

  final SupabaseClient _client;
  final SearchRepository _fallback;

  /// search_listings üst sınırı.
  static const _limit = 50;
  static const _bins = 18;
  static final _day = DateFormat('yyyy-MM-dd');

  /// Arama ekranındaki hızlı öneriler: Keşfet'teki bölgelerle aynı.
  static const _routes = ['Sapanca', 'Samsun'];

  Map<String, dynamic> _params(SearchQuery q) {
    final f = q.filters;
    return {
      'p_location': q.location.trim().isEmpty ? null : q.location.trim(),
      'p_check_in': q.dates == null ? null : _day.format(q.dates!.checkIn),
      'p_check_out': q.dates == null ? null : _day.format(q.dates!.checkOut),
      'p_guests': q.guests.total,
      'p_pets': q.guests.pets > 0,
      'p_price_min': f.priceMin,
      'p_price_max': f.priceMax,
      'p_features': [for (final x in f.features) ListingJson.snake(x.name)],
      'p_bedrooms': f.bedrooms,
      'p_instant_book': f.instantBook,
      'p_free_cancellation': f.freeCancellation,
      'p_pets_allowed': f.petsAllowed,
      'p_accessible': f.accessible,
      'p_sort': ListingJson.snake(q.sort.name),
      'p_limit': _limit,
      'p_nights': q.nights,
    };
  }

  Future<List<Map<String, dynamic>>> _cards(SearchQuery q) async {
    final json = await _client.rpc<dynamic>(
      'search_listing_cards',
      params: _params(q),
    );
    return (json as List).cast<Map<String, dynamic>>();
  }

  @override
  Future<List<ListingOffer>> search(SearchQuery query) async => [
    for (final c in await _cards(query))
      ListingOffer(
        listing: ListingJson.card(c),
        price: ListingJson.price(c['price'] as Map<String, dynamic>),
      ),
  ];

  @override
  Future<int> count(SearchQuery query) async => (await _cards(query)).length;

  @override
  Future<Set<String>> unavailable(
    List<String> listingIds,
    StayDates dates,
  ) async {
    final lastNight = dates.checkOut.subtract(const Duration(days: 1));
    final results = await Future.wait([
      for (final id in listingIds)
        _client.rpc<dynamic>(
          'listing_calendar_days',
          params: {
            'p_listing': id,
            'p_from': _day.format(dates.checkIn),
            'p_to': _day.format(lastNight),
          },
        ),
    ]);
    return {
      for (final (i, days) in results.indexed)
        // Yayında olmayan ilan (boş yanıt) da müsait sayılmaz.
        if ((days as List).isEmpty ||
            days.any((d) => (d as Map)['available'] != true))
          listingIds[i],
    };
  }

  @override
  Future<PriceHistogram> priceHistogram(SearchQuery query) async {
    final unfiltered = query.copyWith(
      filters: query.filters.copyWith(priceMin: null, priceMax: null),
    );
    final prices = [
      for (final c in await _cards(unfiltered))
        (c['display_price'] as num?)?.toInt() ?? 0,
    ];
    if (prices.isEmpty) {
      return PriceHistogram(min: 0, max: _bins, bins: List.filled(_bins, 0));
    }
    final lo = prices.reduce((a, b) => a < b ? a : b);
    var hi = prices.reduce((a, b) => a > b ? a : b);
    // Tek fiyat varsa da aralık sıfır olmasın.
    if (hi <= lo) hi = lo + _bins;
    final step = (hi - lo) / _bins;
    final bins = List.filled(_bins, 0);
    for (final p in prices) {
      bins[((p - lo) / step).floor().clamp(0, _bins - 1)]++;
    }
    return PriceHistogram(min: lo, max: hi, bins: bins);
  }

  @override
  Future<List<RelaxSuggestion>> relaxSuggestions(SearchQuery query) async {
    final base = await count(query);
    final out = <RelaxSuggestion>[];
    Future<void> tryRelax(RelaxKind kind, SearchQuery relaxed) async {
      final extra = await count(relaxed) - base;
      if (extra > 0) out.add(RelaxSuggestion(kind: kind, extraCount: extra));
    }

    if (query.dates != null) {
      await tryRelax(RelaxKind.flexibleDates, query.copyWith(dates: null));
    }
    if (query.filters.features.contains(SearchFeature.heatedPool)) {
      await tryRelax(
        RelaxKind.removeHeatedPool,
        query.copyWith(
          filters: query.filters.copyWith(
            features: {...query.filters.features}
              ..remove(SearchFeature.heatedPool),
          ),
        ),
      );
    }
    if (query.filters.priceMin != null || query.filters.priceMax != null) {
      await tryRelax(
        RelaxKind.widenPrice,
        query.copyWith(
          filters: query.filters.copyWith(priceMin: null, priceMax: null),
        ),
      );
    }
    return out;
  }

  @override
  Future<List<RecentSearch>> recentSearches() => _fallback.recentSearches();

  @override
  Future<List<String>> popularRoutes() async => _routes;

  /// İlan takvimi gerçek; bölge takviminde (ilan seçilmeden) fiyat
  /// gösterilmez, yalnızca geçmiş günler kapalıdır.
  @override
  Future<List<CalendarDay>> calendar({
    required DateTime month,
    String? listingId,
    String location = '',
  }) async {
    final first = DateTime(month.year, month.month);
    final last = DateTime(month.year, month.month + 1, 0);
    if (listingId == null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      return [
        for (
          var d = first;
          !d.isAfter(last);
          d = d.add(const Duration(days: 1))
        )
          CalendarDay(date: d, available: !d.isBefore(today)),
      ];
    }
    final json = await _client.rpc<dynamic>(
      'listing_calendar_days',
      params: {
        'p_listing': listingId,
        'p_from': _day.format(first),
        'p_to': _day.format(last),
      },
    );
    final byDay = {
      for (final d in (json as List).cast<Map<String, dynamic>>())
        d['day'] as String: d,
    };
    return [
      for (var d = first; !d.isAfter(last); d = d.add(const Duration(days: 1)))
        if (byDay[_day.format(d)] case final row?)
          CalendarDay(
            date: d,
            available: row['available'] == true,
            price: row['available'] == true
                ? (row['price'] as num?)?.toInt()
                : null,
            isDeal: row['is_deal'] == true,
          )
        else
          CalendarDay(date: d, available: false),
    ];
  }
}
