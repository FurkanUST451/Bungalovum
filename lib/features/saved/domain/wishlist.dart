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

    /// İlan başına kişisel not ("Annemlerle gidebiliriz").
    @Default(<String, String>{}) Map<String, String> notes,

    /// Bağlantıya sahip olanlar listeyi görebilir.
    @Default(false) bool shareable,
  }) = _Wishlist;

  factory Wishlist.fromJson(Map<String, dynamic> json) =>
      _$WishlistFromJson(json);
}

/// 60 · Son baktıkların: ilan ve son görüntülenme anı.
@freezed
abstract class RecentView with _$RecentView {
  const factory RecentView({
    required String listingId,
    required DateTime viewedAt,
  }) = _RecentView;

  factory RecentView.fromJson(Map<String, dynamic> json) =>
      _$RecentViewFromJson(json);
}

abstract final class RecentPolicy {
  /// Son baktıkların bu kadar gün tutulur.
  static const keepDays = 30;
}
