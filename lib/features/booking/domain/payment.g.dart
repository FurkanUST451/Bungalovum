// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentCard _$PaymentCardFromJson(Map<String, dynamic> json) => _PaymentCard(
  id: json['id'] as String,
  brand: $enumDecode(_$CardBrandEnumMap, json['brand']),
  last4: json['last4'] as String,
  expMonth: (json['expMonth'] as num).toInt(),
  expYear: (json['expYear'] as num).toInt(),
  isDefault: json['isDefault'] as bool? ?? false,
);

Map<String, dynamic> _$PaymentCardToJson(_PaymentCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brand': _$CardBrandEnumMap[instance.brand]!,
      'last4': instance.last4,
      'expMonth': instance.expMonth,
      'expYear': instance.expYear,
      'isDefault': instance.isDefault,
    };

const _$CardBrandEnumMap = {
  CardBrand.visa: 'visa',
  CardBrand.mastercard: 'mastercard',
  CardBrand.troy: 'troy',
  CardBrand.amex: 'amex',
  CardBrand.unknown: 'unknown',
};
