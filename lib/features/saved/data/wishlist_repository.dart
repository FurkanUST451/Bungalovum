import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/wishlist.dart';

part 'wishlist_repository.g.dart';

abstract interface class WishlistRepository {
  Future<List<Wishlist>> all();
  Future<Wishlist> create(String name);
  Future<void> save(Wishlist list);
  Future<void> delete(String id);

  /// Son baktıkların (60) — en yeniden eskiye, son 30 gün.
  Future<List<RecentView>> recentlyViewed();

  Future<void> markViewed(String listingId);

  Future<void> clearRecentlyViewed();

  /// Paylaşılabilir liste bağlantısı.
  String shareLink(String listId);
}

@Riverpod(keepAlive: true)
WishlistRepository wishlistRepository(Ref ref) => MockWishlistRepository();

/// Sahte listeler (Figma 30 / 56 içeriği).
class MockWishlistRepository implements WishlistRepository {
  MockWishlistRepository({
    this.latency = const Duration(milliseconds: 250),
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final Duration latency;
  final DateTime Function() _clock;

  Future<void> _wait() => Future<void>.delayed(latency);

  final _lists = <Wishlist>[
    Wishlist(
      id: 'hafta-sonu',
      name: 'Hafta sonu kaçamağı',
      listingIds: const [
        'kuzey-kulube',
        'cam-yamac',
        'gol-evi-sapanca',
        'kartepe-yuva',
      ],
      updatedAt: DateTime(2026, 9, 30),
      notes: const {'cam-yamac': 'Annemlerle gidebiliriz'},
    ),
    Wishlist(
      id: 'havuzlu-yaz',
      name: 'Havuzlu yaz planı',
      listingIds: const ['cam-kozalak', 'sapanca-orman-evi', 'kuzey-kulube'],
      updatedAt: DateTime(2026, 9, 12),
    ),
    Wishlist(
      id: 'kis-icin',
      name: 'Kış için',
      updatedAt: DateTime(2026, 8, 20),
    ),
  ];

  late final _recent = <RecentView>[
    RecentView(listingId: 'gol-esintisi', viewedAt: _clock()),
    RecentView(
      listingId: 'kartepe-yuva',
      viewedAt: _clock().subtract(const Duration(minutes: 40)),
    ),
    RecentView(
      listingId: 'cam-yamac',
      viewedAt: _clock().subtract(const Duration(days: 1)),
    ),
    RecentView(
      listingId: 'abant-kulube',
      viewedAt: _clock().subtract(const Duration(days: 1, hours: 2)),
    ),
  ];

  @override
  Future<List<Wishlist>> all() async {
    await _wait();
    return List.unmodifiable(_lists);
  }

  @override
  Future<Wishlist> create(String name) async {
    await _wait();
    final list = Wishlist(
      id: 'liste-${DateTime.now().microsecondsSinceEpoch}',
      name: name,
      updatedAt: DateTime.now(),
    );
    _lists.insert(0, list);
    return list;
  }

  @override
  Future<void> save(Wishlist list) async {
    await _wait();
    final i = _lists.indexWhere((l) => l.id == list.id);
    if (i >= 0) _lists[i] = list;
  }

  @override
  Future<void> delete(String id) async {
    await _wait();
    _lists.removeWhere((l) => l.id == id);
  }

  @override
  Future<List<RecentView>> recentlyViewed() async {
    await _wait();
    final since = _clock().subtract(
      const Duration(days: RecentPolicy.keepDays),
    );
    return List.unmodifiable(_recent.where((r) => r.viewedAt.isAfter(since)));
  }

  @override
  Future<void> markViewed(String listingId) async {
    _recent
      ..removeWhere((r) => r.listingId == listingId)
      ..insert(0, RecentView(listingId: listingId, viewedAt: _clock()));
  }

  @override
  Future<void> clearRecentlyViewed() async {
    await _wait();
    _recent.clear();
  }

  @override
  String shareLink(String listId) => 'bungalovum.app/l/$listId';
}
