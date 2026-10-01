// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListingOffer _$ListingOfferFromJson(Map<String, dynamic> json) =>
    _ListingOffer(
      listing: Listing.fromJson(json['listing'] as Map<String, dynamic>),
      price: PriceBreakdown.fromJson(json['price'] as Map<String, dynamic>),
      nightsLeft: (json['nightsLeft'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ListingOfferToJson(_ListingOffer instance) =>
    <String, dynamic>{
      'listing': instance.listing.toJson(),
      'price': instance.price.toJson(),
      'nightsLeft': instance.nightsLeft,
    };
