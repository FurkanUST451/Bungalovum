import 'package:supabase_flutter/supabase_flutter.dart';

import '../../listing/data/listing_json.dart';
import '../domain/explore_category.dart';
import '../domain/explore_feed.dart';
import 'explore_repository.dart';

/// 13 · Keşfet: yayındaki gerçek ilanlar, bölge şeritleri halinde.
///
/// Hava durumu ve "Bu hafta sonu boş olanlar" henüz gerçek veriye bağlı
/// değil; gösterilmez.
class SupabaseExploreRepository implements ExploreRepository {
  SupabaseExploreRepository(this._client, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final SupabaseClient _client;
  final DateTime Function() _clock;

  /// Keşfet'teki bölge şeritleri (sırasıyla). Bölge adı aramayla aynı
  /// kuralla eşleşir (il, ilçe ya da başlık; Türkçe harf farkı önemsiz).
  static const _sections = [
    (ExploreSectionKind.loved, "Sapanca'da", 'Sapanca'),
    (ExploreSectionKind.favorites, "Samsun'da", 'Samsun'),
  ];

  static const _perSection = 10;
  static const _headerLabel = 'Sapanca, Sakarya';

  @override
  Future<ExploreFeed> fetchFeed({required ExploreCategory category}) async {
    final results = await Future.wait([
      for (final (_, _, location) in _sections)
        _client.rpc<dynamic>(
          'search_listing_cards',
          params: {
            'p_location': location,
            'p_category': ListingJson.snake(category.name),
            'p_limit': _perSection,
          },
        ),
    ]);

    final now = _clock();
    final today = DateTime(now.year, now.month, now.day);
    final friday = today.add(
      Duration(days: (DateTime.friday - today.weekday) % DateTime.daysPerWeek),
    );

    // Bir ilan yalnızca ilk eşleştiği şeritte görünür (fotoğraf Hero
    // etiketi ilan kimliğine bağlı; aynı ekranda iki kez olamaz).
    final seen = <String>{};
    return ExploreFeed(
      locationLabel: _headerLabel,
      sections: [
        for (final (i, (kind, locative, location)) in _sections.indexed)
          ExploreSection(
            kind: kind,
            regionLocative: locative,
            location: location,
            listings: [
              for (final c in (results[i] as List).cast<Map<String, dynamic>>())
                if (seen.add(c['id'] as String)) ListingJson.card(c),
            ],
          ),
      ],
      weekendStart: friday,
      weekendEnd: friday.add(const Duration(days: 2)),
    );
  }
}
