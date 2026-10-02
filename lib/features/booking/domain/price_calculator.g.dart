// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_calculator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PriceBreakdown _$PriceBreakdownFromJson(Map<String, dynamic> json) =>
    _PriceBreakdown(
      nightlyRate: (json['nightlyRate'] as num).toInt(),
      nights: (json['nights'] as num).toInt(),
      cleaningFee: (json['cleaningFee'] as num?)?.toInt() ?? 0,
      serviceFee: (json['serviceFee'] as num?)?.toInt() ?? 0,
      discount: (json['discount'] as num?)?.toInt() ?? 0,
      discountKind:
          $enumDecodeNullable(_$DiscountKindEnumMap, json['discountKind']) ??
          DiscountKind.special,
    );

Map<String, dynamic> _$PriceBreakdownToJson(_PriceBreakdown instance) =>
    <String, dynamic>{
      'nightlyRate': instance.nightlyRate,
      'nights': instance.nights,
      'cleaningFee': instance.cleaningFee,
      'serviceFee': instance.serviceFee,
      'discount': instance.discount,
      'discountKind': _$DiscountKindEnumMap[instance.discountKind]!,
    };

const _$DiscountKindEnumMap = {
  DiscountKind.earlyBooking: 'earlyBooking',
  DiscountKind.lastMinute: 'lastMinute',
  DiscountKind.longStay: 'longStay',
  DiscountKind.coupon: 'coupon',
  DiscountKind.special: 'special',
};
