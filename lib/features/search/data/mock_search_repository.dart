import 'dart:math' as math;

import '../../listing/data/listing_catalog.dart';
import '../../listing/domain/listing.dart';
import '../../listing/domain/listing_offer.dart';
import '../domain/search_query.dart';
import 'search_repository.dart';

/// Sahte arama servisi ([ListingCatalog] üzerinde süzme/sıralama).
class MockSearchRepository implements SearchRepository {
  MockSearchRepository({this.latency = const Duration(milliseconds: 350)});

  final Duration latency;

  static const _bins = 18;

  /// Bazı ilanların ay içindeki dolu günleri.
  static const _bookedDays = {13, 14, 15, 21, 22};

  /// Uygun fiyatlı günler (Pzt–Çar) ve hafta sonu çarpanları; backend'de
  /// dinamik fiyatlamayı taklit eder.
  static const _dealFactor = 0.85;
  static const _peakFactor = 1.13;

  Future<void> _wait() => Future<void>.delayed(latency);

  static String _norm(String s) =>
      s.replaceAll('İ', 'i').replaceAll('I', 'ı').toLowerCase().trim();

  bool _matchesLocation(Listing l, String location) {
    final q = _norm(location);
    if (q.isEmpty) return true;
    return [l.region, l.district, l.title].any((s) => _norm(s).contains(q));
  }

  bool _isBusy(Listing l) => ListingCatalog.all.indexOf(l) % 3 == 0;

  bool _available(Listing l, StayDates? dates) {
    if (dates == null || !_isBusy(l)) return true;
    for (
      var d = dates.checkIn;
      d.isBefore(dates.checkOut);
      d = d.add(const Duration(days: 1))
    ) {
      if (_bookedDays.contains(d.day)) return false;
    }
    return true;
  }

  @override
  Future<Set<String>> unavailable(
    List<String> listingIds,
    StayDates dates,
  ) async {
    await _wait();
    return {
      for (final id in listingIds)
        if (ListingCatalog.byId(id) case final l?)
          if (!_available(l, dates)) id,
    };
  }

  List<Listing> _match(SearchQuery q) => ListingCatalog.all
      .where(
        (l) =>
            _matchesLocation(l, q.location) &&
            l.maxGuests >= q.guests.total &&
            (q.guests.pets == 0 || l.petsAllowed) &&
            _available(l, q.dates) &&
            q.filters.matches(l),
      )
      .toList();

  @override
  Future<List<ListingOffer>> search(SearchQuery query) async {
    await _wait();
    final offers = [
      for (final l in _match(query)) ListingCatalog.offer(l, query.nights),
    ];
    int total(ListingOffer o) =>
        o.price.nightlyRate * o.price.nights - o.price.discount;
    switch (query.sort) {
      case SearchSort.recommended:
        break;
      case SearchSort.priceLow:
        offers.sort((a, b) => total(a).compareTo(total(b)));
      case SearchSort.priceHigh:
        offers.sort((a, b) => total(b).compareTo(total(a)));
      case SearchSort.rating:
        offers.sort(
          (a, b) => (b.listing.rating ?? 0).compareTo(a.listing.rating ?? 0),
        );
    }
    return offers;
  }

  @override
  Future<int> count(SearchQuery query) async {
    await _wait();
    return _match(query).length;
  }

  @override
  Future<PriceHistogram> priceHistogram(SearchQuery query) async {
    await _wait();
    const min = 2000;
    const max = 12000;
    final step = (max - min) / _bins;
    final unfiltered = query.copyWith(
      filters: query.filters.copyWith(priceMin: null, priceMax: null),
    );
    final bins = List.filled(_bins, 0);
    for (final l in _match(unfiltered)) {
      final i = ((l.nightlyPrice - min) / step).floor().clamp(0, _bins - 1);
      bins[i]++;
    }
    // Yoğunluk eğrisi: boş dilimler de görünür olsun diye yumuşatılır.
    final smooth = [
      for (var i = 0; i < _bins; i++)
        1 +
            bins[i] * 3 +
            (i > 0 ? bins[i - 1] : 0) +
            (i < _bins - 1 ? bins[i + 1] : 0),
    ];
    return PriceHistogram(min: min, max: max, bins: smooth);
  }

  @override
  Future<List<RelaxSuggestion>> relaxSuggestions(SearchQuery query) async {
    await _wait();
    final base = _match(query).length;
    final out = <RelaxSuggestion>[];
    if (query.dates != null) {
      final flexible = _match(query.copyWith(dates: null)).length - base;
      if (flexible > 0) {
        out.add(
          RelaxSuggestion(kind: RelaxKind.flexibleDates, extraCount: flexible),
        );
      }
    }
    if (query.filters.features.contains(SearchFeature.heatedPool)) {
      final without = _match(
        query.copyWith(
          filters: query.filters.copyWith(
            features: {...query.filters.features}
              ..remove(SearchFeature.heatedPool),
          ),
        ),
      ).length;
      if (without > base) {
        out.add(
          RelaxSuggestion(
            kind: RelaxKind.removeHeatedPool,
            extraCount: without - base,
          ),
        );
      }
    }
    if (query.filters.priceMin != null || query.filters.priceMax != null) {
      final wide = _match(
        query.copyWith(
          filters: query.filters.copyWith(priceMin: null, priceMax: null),
        ),
      ).length;
      if (wide > base) {
        out.add(
          RelaxSuggestion(kind: RelaxKind.widenPrice, extraCount: wide - base),
        );
      }
    }
    return out;
  }

  @override
  Future<List<RecentSearch>> recentSearches() async {
    await _wait();
    final now = DateTime.now();
    final friday = DateTime(now.year, now.month, now.day).add(
      Duration(days: (DateTime.friday - now.weekday) % DateTime.daysPerWeek),
    );
    return [
      RecentSearch(
        location: 'Sapanca',
        dates: StayDates(
          checkIn: friday,
          checkOut: friday.add(const Duration(days: 2)),
        ),
        guests: const GuestCount(),
      ),
      const RecentSearch(location: 'Kartepe', guests: GuestCount(adults: 4)),
    ];
  }

  @override
  Future<List<String>> popularRoutes() async {
    await _wait();
    return const ['Sapanca', 'Kartepe', 'Abant'];
  }

  @override
  Future<List<CalendarDay>> calendar({
    required DateTime month,
    String? listingId,
    String location = '',
  }) async {
    await _wait();
    final listing = listingId == null ? null : ListingCatalog.byId(listingId);
    final pool = listing == null
        ? ListingCatalog.all.where((l) => _matchesLocation(l, location))
        : [listing];
    final base = pool.isEmpty
        ? 0
        : pool.map((l) => l.nightlyPrice).reduce((a, b) => a + b) ~/
              pool.length;
    final busy = listing == null || _isBusy(listing);
    final days = DateUtils.daysInMonth(month.year, month.month);
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    return [
      for (var d = 1; d <= days; d++)
        () {
          final date = DateTime(month.year, month.month, d);
          final past = date.isBefore(todayDate);
          final booked = busy && _bookedDays.contains(d);
          final deal = date.weekday <= DateTime.wednesday;
          return CalendarDay(
            date: date,
            available: !past && !booked,
            price: past || booked
                ? null
                : (base * (deal ? _dealFactor : _peakFactor)).round(),
            isDeal: deal,
          );
        }(),
    ];
  }
}

/// `package:flutter` olmadan ay uzunluğu.
abstract final class DateUtils {
  static int daysInMonth(int year, int month) =>
      DateTime(year, month + 1, 0).day;

  static int clamp(int v, int lo, int hi) => math.max(lo, math.min(hi, v));
}
