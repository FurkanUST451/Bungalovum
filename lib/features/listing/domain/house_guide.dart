import 'package:freezed_annotation/freezed_annotation.dart';

part 'house_guide.freezed.dart';
part 'house_guide.g.dart';

enum GuideSectionKind { pool, house, kitchen, outdoor, other }

@freezed
abstract class GuideSection with _$GuideSection {
  const factory GuideSection({
    required GuideSectionKind kind,
    required String title,
    @Default(<String>[]) List<String> items,
  }) = _GuideSection;

  factory GuideSection.fromJson(Map<String, dynamic> json) =>
      _$GuideSectionFromJson(json);
}

/// Ev kılavuzu (ev sahibi sihirbazı › Giriş ve Ev Kılavuzu). Şifreli alanlar
/// herkese açık ilan detayında yer almaz; misafire yalnızca onaylı
/// rezervasyonda, girişten 1 gün önce açılır (bkz. `TripAccess`).
@freezed
abstract class HouseGuide with _$HouseGuide {
  const factory HouseGuide({
    required String lockboxCode,

    /// "Kapının sağındaki gri kutu"
    required String lockboxHint,
    required String wifiName,
    required String wifiPassword,
    @Default(<GuideSection>[]) List<GuideSection> sections,
    @Default(<String>[]) List<String> checkoutTasks,
  }) = _HouseGuide;

  factory HouseGuide.fromJson(Map<String, dynamic> json) =>
      _$HouseGuideFromJson(json);
}
