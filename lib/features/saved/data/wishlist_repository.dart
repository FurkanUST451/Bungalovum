import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/wishlist.dart';

part 'wishlist_repository.g.dart';

abstract interface class WishlistRepository {
  Future<List<Wishlist>> all();
  Future<Wishlist> create(String name);
  Future<void> save(Wishlist list);
  Future<void> delete(String id);

  /// Son baktıkların (60) — en yeniden eskiye ilan kimlikleri.
  Future<List<String>> recentlyViewed();
  Future<void> markViewed(String listingId);
}

@Riverpod(keepAlive: true)
WishlistRepository wishlistRepository(Ref ref) => MockWishlistRepository();

/// Sahte listeler (Figma 30 / 56 içeriği).
class MockWishlistRepository implements WishlistRepository {
  MockWishlistRepository({this.latency = const Duration(milliseconds: 250)});

  final Duration latency;

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

  final _recent = <String>[
    'gol-esintisi',
    'cam-kozalak',
    'kartepe-yuva',
    'abant-kulube',
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
  Future<List<String>> recentlyViewed() async {
    await _wait();
    return List.unmodifiable(_recent);
  }

  @override
  Future<void> markViewed(String listingId) async {
    _recent
      ..remove(listingId)
      ..insert(0, listingId);
  }
}
