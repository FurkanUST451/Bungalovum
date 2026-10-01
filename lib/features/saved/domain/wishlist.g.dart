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
);

Map<String, dynamic> _$WishlistToJson(_Wishlist instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'listingIds': instance.listingIds,
  'updatedAt': instance.updatedAt.toIso8601String(),
};
