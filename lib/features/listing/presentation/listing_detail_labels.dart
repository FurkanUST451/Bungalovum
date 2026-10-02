import '../../../core/icons/kz_icons.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/kz_action_row.dart';
import '../../../l10n/l10n.dart';
import '../domain/listing_detail.dart';

extension RoomKindUi on RoomKind {
  String label(AppLocalizations l) => switch (this) {
    RoomKind.living => l.roomLiving,
    RoomKind.bedroom => l.roomBedroom,
    RoomKind.bathroom => l.roomBathroom,
    RoomKind.outdoor => l.roomOutdoor,
    RoomKind.pool => l.roomPool,
  };

  KzIcons get icon => switch (this) {
    RoomKind.living => KzIcons.home,
    RoomKind.bedroom => KzIcons.bed,
    RoomKind.bathroom => KzIcons.bath,
    RoomKind.outdoor => KzIcons.trees,
    RoomKind.pool => KzIcons.waves,
  };

  KzIconBoxTone get tone => switch (this) {
    RoomKind.living => KzIconBoxTone.apricot,
    RoomKind.bedroom => KzIconBoxTone.sand,
    RoomKind.bathroom || RoomKind.pool => KzIconBoxTone.pool,
    RoomKind.outdoor => KzIconBoxTone.forest,
  };
}

extension AmenityKindUi on AmenityKind {
  String label(AppLocalizations l) => switch (this) {
    AmenityKind.privatePool => l.amenPrivatePool,
    AmenityKind.jacuzzi => l.amenJacuzzi,
    AmenityKind.barbecue => l.amenBarbecue,
    AmenityKind.parking => l.amenParking,
    AmenityKind.kitchen => l.amenKitchen,
    AmenityKind.wifi => l.amenWifi,
    AmenityKind.airConditioning => l.amenAirConditioning,
    AmenityKind.orthopedicBed => l.amenOrthopedicBed,
    AmenityKind.fireplace => l.amenFireplace,
    AmenityKind.pets => l.amenPets,
    AmenityKind.stepFreeEntry => l.amenStepFree,
  };

  KzIcons get icon => switch (this) {
    AmenityKind.privatePool => KzIcons.waves,
    AmenityKind.jacuzzi => KzIcons.bath,
    AmenityKind.barbecue || AmenityKind.fireplace => KzIcons.flame,
    AmenityKind.parking => KzIcons.car,
    AmenityKind.kitchen => KzIcons.food,
    AmenityKind.wifi => KzIcons.wifi,
    AmenityKind.airConditioning => KzIcons.snow,
    AmenityKind.orthopedicBed => KzIcons.bed,
    AmenityKind.pets => KzIcons.paw,
    AmenityKind.stepFreeEntry => KzIcons.door,
  };

  /// İlan detayındaki 2 kolon önizlemede ikon kutusu tonu.
  KzIconBoxTone get previewTone => switch (this) {
    AmenityKind.privatePool => KzIconBoxTone.pool,
    AmenityKind.jacuzzi => KzIconBoxTone.apricot,
    _ => KzIconBoxTone.sand,
  };
}

extension AmenityGroupUi on AmenityGroup {
  String label(AppLocalizations l) => switch (this) {
    AmenityGroup.outdoor => l.groupOutdoor,
    AmenityGroup.indoor => l.groupIndoor,
    AmenityGroup.notIncluded => l.groupNotIncluded,
  };
}

extension HighlightKindUi on HighlightKind {
  KzIcons get icon => switch (this) {
    HighlightKind.topRated => KzIcons.award,
    HighlightKind.rarePool => KzIcons.waves,
    HighlightKind.greatCheckIn || HighlightKind.selfCheckIn => KzIcons.key,
    HighlightKind.lakeView => KzIcons.mountain,
  };

  KzIconBoxTone get tone => switch (this) {
    HighlightKind.topRated => KzIconBoxTone.apricot,
    HighlightKind.rarePool || HighlightKind.lakeView => KzIconBoxTone.pool,
    _ => KzIconBoxTone.forest,
  };
}

extension ReviewTopicUi on ReviewTopic {
  String label(AppLocalizations l) => switch (this) {
    ReviewTopic.pool => l.topicPool,
    ReviewTopic.cleanliness => l.topicCleanliness,
    ReviewTopic.host => l.topicHost,
  };

  KzIcons get icon => switch (this) {
    ReviewTopic.pool => KzIcons.waves,
    ReviewTopic.cleanliness => KzIcons.sparkles,
    ReviewTopic.host => KzIcons.heart,
  };

  KzIconBoxTone get tone => switch (this) {
    ReviewTopic.pool => KzIconBoxTone.pool,
    ReviewTopic.cleanliness => KzIconBoxTone.forest,
    ReviewTopic.host => KzIconBoxTone.apricot,
  };
}

extension SafetyKindUi on SafetyKind {
  String label(AppLocalizations l) => switch (this) {
    SafetyKind.coAlarm => l.safetyCo,
    SafetyKind.smokeDetector => l.safetySmoke,
    SafetyKind.firstAidKit => l.safetyFirstAid,
    SafetyKind.fireExtinguisher => l.safetyExtinguisher,
    SafetyKind.poolFence => l.safetyPoolFence,
    SafetyKind.outdoorCamera => l.safetyCamera,
  };

  KzIcons get icon => switch (this) {
    SafetyKind.coAlarm || SafetyKind.smokeDetector => KzIcons.alert,
    SafetyKind.firstAidKit => KzIcons.plus,
    SafetyKind.fireExtinguisher => KzIcons.flame,
    SafetyKind.poolFence => KzIcons.shield,
    SafetyKind.outdoorCamera => KzIcons.camera,
  };
}

extension NearbyKindUi on NearbyKind {
  KzIcons get icon => switch (this) {
    NearbyKind.lake => KzIcons.waves,
    NearbyKind.market => KzIcons.food,
    NearbyKind.mountain => KzIcons.mountain,
    NearbyKind.forest => KzIcons.trees,
  };
}

extension HostUi on HostSummary {
  String levelLabel(AppLocalizations l) =>
      level == HostLevel.superhost ? l.hostSuperhost : l.hostStandard;

  String responseTimeLabel(AppLocalizations l) {
    final hours = (responseMinutes / Duration.minutesPerHour).ceil();
    return hours <= 1 ? l.withinHour : l.withinHours(hours);
  }
}

/// "4 gün önce", "2 hafta önce", "1 ay önce".
String relativeDate(AppLocalizations l, DateTime date, DateTime now) {
  final days = now.difference(date).inDays;
  if (days < 1) return l.today;
  if (days < DateTime.daysPerWeek) return l.daysAgo(days);
  if (days < 30) return l.weeksAgo(days ~/ DateTime.daysPerWeek);
  return l.monthsAgo(days ~/ 30);
}

/// "650 m" / "1,2 km".
String distanceLabel(AppLocalizations l, int meters) => meters < 1000
    ? l.meters('$meters')
    : l.kilometers(KzFormat.thousands(meters));

String nearbyLine(AppLocalizations l, NearbyPlace p) => p.walking
    ? l.distanceWalk(distanceLabel(l, p.distanceMeters), p.minutes)
    : l.distanceDrive(distanceLabel(l, p.distanceMeters), p.minutes);

/// Ondalıklı ölçü: 1.2 → "1,2", 4.0 → "4".
String decimal(double v) => KzFormat.decimal(v);
