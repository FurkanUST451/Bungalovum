import '../../listing/data/listing_catalog.dart';
import '../domain/explore_category.dart';
import '../domain/explore_feed.dart';
import 'explore_repository.dart';

/// Geliştirme için sahte Keşfet akışı ([ListingCatalog] üzerinden).
class MockExploreRepository implements ExploreRepository {
  MockExploreRepository({
    DateTime Function()? clock,
    this.latency = const Duration(milliseconds: 450),
  }) : _clock = clock ?? DateTime.now;

  final DateTime Function() _clock;

  /// Ağ gecikmesi benzetimi; testlerde sıfırlanır.
  final Duration latency;

  static const _popularIds = ['gol-esintisi', 'cam-yamac', 'kuzey-kulube'];
  static const _weekendIds = ['gol-evi-sapanca', 'cam-kozalak'];
  static const _weekendNights = 2;

  @override
  Future<ExploreFeed> fetchFeed({required ExploreCategory category}) async {
    await Future<void>.delayed(latency);
    final now = _clock();
    final today = DateTime(now.year, now.month, now.day);
    final friday = today.add(
      Duration(days: (DateTime.friday - today.weekday) % DateTime.daysPerWeek),
    );
    final saturday = friday.add(const Duration(days: 1));
    final sunday = friday.add(const Duration(days: _weekendNights));

    final popular = [
      for (final id in _popularIds) ListingCatalog.byId(id)!,
    ].where(category.matches).toList();
    final weekend = [
      for (final id in _weekendIds)
        ListingCatalog.offer(
          ListingCatalog.byId(id)!,
          _weekendNights,
          nightsLeft: id == _weekendIds.first ? _weekendNights : null,
        ),
    ].where((o) => category.matches(o.listing)).toList();

    return ExploreFeed(
      locationLabel: 'Sapanca, Sakarya',
      weather: WeatherSummary(
        date: saturday,
        temperatureC: 24,
        condition: WeatherCondition.sunny,
        availableCount: 38,
      ),
      sections: [
        ExploreSection(
          kind: ExploreSectionKind.loved,
          regionLocative: "Sapanca'da",
          location: 'Sapanca',
          listings: popular,
        ),
      ],
      weekendStart: friday,
      weekendEnd: sunday,
      weekendDeals: weekend,
    );
  }
}
