import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/wishlist_repository.dart';
import '../../domain/wishlist.dart';

part 'saved_listings_controller.g.dart';

/// Kullanıcının listeleri (56 · Kaydettiklerim, 30 · Listeye Ekle).
@Riverpod(keepAlive: true)
class Wishlists extends _$Wishlists {
  @override
  Future<List<Wishlist>> build() => ref.watch(wishlistRepositoryProvider).all();

  WishlistRepository get _repo => ref.read(wishlistRepositoryProvider);

  List<Wishlist> get _current => state.value ?? const [];

  Future<void> _reload() async => state = AsyncData(await _repo.all());

  /// İlanı seçilen listelere yerleştirir, diğerlerinden çıkarır.
  Future<void> setMembership(String listingId, Set<String> listIds) async {
    final now = DateTime.now();
    for (final list in _current) {
      final has = list.listingIds.contains(listingId);
      final want = listIds.contains(list.id);
      if (has == want) continue;
      await _repo.save(
        list.copyWith(
          listingIds: want
              ? [listingId, ...list.listingIds]
              : (list.listingIds.where((id) => id != listingId).toList()),
          updatedAt: now,
        ),
      );
    }
    await _reload();
  }

  /// Tüm listelerden çıkarır (kalbe ikinci dokunuş).
  Future<void> unsave(String listingId) => setMembership(listingId, const {});

  Future<Wishlist> create(String name) async {
    final list = await _repo.create(name);
    await _reload();
    return list;
  }

  Future<void> rename(String id, String name) async {
    final list = _current.firstWhere((l) => l.id == id);
    await _repo.save(list.copyWith(name: name, updatedAt: DateTime.now()));
    await _reload();
  }

  Future<void> removeItems(String id, Set<String> listingIds) async {
    final list = _current.firstWhere((l) => l.id == id);
    await _repo.save(
      list.copyWith(
        listingIds: list.listingIds
            .where((x) => !listingIds.contains(x))
            .toList(),
        updatedAt: DateTime.now(),
      ),
    );
    await _reload();
  }

  Future<void> delete(String id) async {
    await _repo.delete(id);
    await _reload();
  }
}

/// Herhangi bir listede olan ilanlar (kalp dolu görünür).
@Riverpod(keepAlive: true)
Set<String> savedListingIds(Ref ref) => {
  for (final l in ref.watch(wishlistsProvider).value ?? const <Wishlist>[])
    ...l.listingIds,
};

@riverpod
Future<List<String>> recentlyViewed(Ref ref) =>
    ref.watch(wishlistRepositoryProvider).recentlyViewed();
