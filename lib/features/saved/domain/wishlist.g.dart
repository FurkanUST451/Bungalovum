// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Wishlist _$WishlistFromJson(Map<String, dynamic> json) => _Wishlist(
  id: json['id'] as String,
  name: json['name'] as String,
  listingIds:
      (json['listingIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  notes:
      (json['notes'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  shareable: json['shareable'] as bool? ?? false,
);

Map<String, dynamic> _$WishlistToJson(_Wishlist instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'listingIds': instance.listingIds,
  'updatedAt': instance.updatedAt.toIso8601String(),
  'notes': instance.notes,
  'shareable': instance.shareable,
};

_RecentView _$RecentViewFromJson(Map<String, dynamic> json) => _RecentView(
  listingId: json['listingId'] as String,
  viewedAt: DateTime.parse(json['viewedAt'] as String),
);

Map<String, dynamic> _$RecentViewToJson(_RecentView instance) =>
    <String, dynamic>{
      'listingId': instance.listingId,
      'viewedAt': instance.viewedAt.toIso8601String(),
    };
