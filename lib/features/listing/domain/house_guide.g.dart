// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_guide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GuideSection _$GuideSectionFromJson(Map<String, dynamic> json) =>
    _GuideSection(
      kind: $enumDecode(_$GuideSectionKindEnumMap, json['kind']),
      title: json['title'] as String,
      items:
          (json['items'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    );

Map<String, dynamic> _$GuideSectionToJson(_GuideSection instance) =>
    <String, dynamic>{
      'kind': _$GuideSectionKindEnumMap[instance.kind]!,
      'title': instance.title,
      'items': instance.items,
    };

const _$GuideSectionKindEnumMap = {
  GuideSectionKind.pool: 'pool',
  GuideSectionKind.house: 'house',
  GuideSectionKind.kitchen: 'kitchen',
  GuideSectionKind.outdoor: 'outdoor',
  GuideSectionKind.other: 'other',
};

_HouseGuide _$HouseGuideFromJson(Map<String, dynamic> json) => _HouseGuide(
  lockboxCode: json['lockboxCode'] as String,
  lockboxHint: json['lockboxHint'] as String,
  wifiName: json['wifiName'] as String,
  wifiPassword: json['wifiPassword'] as String,
  sections:
      (json['sections'] as List<dynamic>?)
          ?.map((e) => GuideSection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <GuideSection>[],
  checkoutTasks:
      (json['checkoutTasks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
);

Map<String, dynamic> _$HouseGuideToJson(_HouseGuide instance) =>
    <String, dynamic>{
      'lockboxCode': instance.lockboxCode,
      'lockboxHint': instance.lockboxHint,
      'wifiName': instance.wifiName,
      'wifiPassword': instance.wifiPassword,
      'sections': instance.sections.map((e) => e.toJson()).toList(),
      'checkoutTasks': instance.checkoutTasks,
    };
