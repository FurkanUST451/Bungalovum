import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../booking/domain/price_calculator.dart';
import '../../../listing/data/listing_repository.dart';
import '../../../listing/domain/listing.dart';
import '../../../search/data/search_repository.dart';
import '../../../search/presentation/controllers/search_controller.dart';
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

  /// 59 · Listeyi Düzenle: ad ve paylaşım.
  Future<void> updateDetails(
    String id, {
    required String name,
    required bool shareable,
  }) async {
    final list = _current.firstWhere((l) => l.id == id);
    await _repo.save(
      list.copyWith(
        name: name,
        shareable: shareable,
        updatedAt: DateTime.now(),
      ),
    );
    await _reload();
  }

  /// Boş not, notu siler.
  Future<void> setNote(String id, String listingId, String note) async {
    final list = _current.firstWhere((l) => l.id == id);
    final notes = {...list.notes};
    note.trim().isEmpty
        ? notes.remove(listingId)
        : notes[listingId] = note.trim();
    await _repo.save(list.copyWith(notes: notes));
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
Future<List<RecentView>> recentlyViewed(Ref ref) =>
    ref.watch(wishlistRepositoryProvider).recentlyViewed();

/// Tek ilanın özet bilgisi (kapak mozaikleri, kartlar).
@riverpod
Future<Listing> listingSummary(Ref ref, String id) async {
  final r = await ref.watch(listingRepositoryProvider).byIds([id]);
  return r.single;
}

/// 58 · Liste Detayı satırı: ilan + aktif tarihlere göre fiyat / doluluk + not.
class WishlistItem {
  const WishlistItem({
    required this.listing,
    required this.price,
    required this.unavailable,
    this.note,
  });

  final Listing listing;
  final PriceBreakdown price;

  /// Seçili tarihlerde dolu.
  final bool unavailable;
  final String? note;
}

/// Liste silinmişse null.
@riverpod
Future<List<WishlistItem>?> wishlistItems(Ref ref, String listId) async {
  final lists = await ref.watch(wishlistsProvider.future);
  final list = lists.where((l) => l.id == listId).firstOrNull;
  if (list == null) return null;
  final q = ref.watch(searchQueryControllerProvider);
  final listings = ref.watch(listingRepositoryProvider);
  final items = await listings.byIds(list.listingIds);
  final prices = await Future.wait([
    for (final l in items) listings.quote(l.id, q.nights),
  ]);
  final busy = q.dates == null
      ? const <String>{}
      : await ref
            .watch(searchRepositoryProvider)
            .unavailable(list.listingIds, q.dates!);
  return [
    for (final (i, l) in items.indexed)
      WishlistItem(
        listing: l,
        price: prices[i],
        unavailable: busy.contains(l.id),
        note: list.notes[l.id],
      ),
  ];
}
