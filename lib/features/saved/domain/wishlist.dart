import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist.freezed.dart';
part 'wishlist.g.dart';

/// Kaydedilenler listesi ("Hafta sonu kaçamağı").
@freezed
abstract class Wishlist with _$Wishlist {
  const factory Wishlist({
    required String id,
    required String name,
    @Default(<String>[]) List<String> listingIds,
    required DateTime updatedAt,
  }) = _Wishlist;

  factory Wishlist.fromJson(Map<String, dynamic> json) =>
      _$WishlistFromJson(json);
}
