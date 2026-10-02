import '../../../core/widgets/kz_chip.dart';
import '../../../l10n/l10n.dart';
import '../domain/listing.dart';

extension PropertyTypeLabel on PropertyType {
  String label(AppLocalizations l) => switch (this) {
    PropertyType.bungalow => l.propertyBungalow,
    PropertyType.treeHouse => l.propertyTreeHouse,
    PropertyType.aFrame => l.propertyAFrame,
    PropertyType.cabin => l.propertyCabin,
    PropertyType.stoneHouse => l.propertyStoneHouse,
    PropertyType.glampingTent => l.propertyGlampingTent,
    PropertyType.tinyHouse => l.propertyTinyHouse,
  };
}

extension ListingSettingLabel on ListingSetting {
  String label(AppLocalizations l) => switch (this) {
    ListingSetting.lakeView => l.settingLakeView,
    ListingSetting.lakeside => l.settingLakeside,
    ListingSetting.forest => l.settingForest,
    ListingSetting.mountainView => l.settingMountainView,
    ListingSetting.nearSea => l.settingNearSea,
  };
}

extension AmenityLabel on Amenity {
  String label(AppLocalizations l) => switch (this) {
    Amenity.pool => l.amenityPool,
    Amenity.heatedPool => l.amenityHeatedPool,
    Amenity.jacuzzi => l.amenityJacuzzi,
    Amenity.fireplace => l.amenityFireplace,
    Amenity.airConditioning => l.amenityAirConditioning,
    Amenity.wifi => l.amenityWifi,
    Amenity.parking => l.amenityParking,
  };

  /// Kartlarda çip olarak öne çıkan olanaklar.
  bool get isFeatured => switch (this) {
    Amenity.pool ||
    Amenity.heatedPool ||
    Amenity.jacuzzi ||
    Amenity.fireplace => true,
    _ => false,
  };

  /// Su olanakları havuz tonunda, diğerleri apricot tonunda.
  KzChipVariant get chipVariant => switch (this) {
    Amenity.pool || Amenity.heatedPool => KzChipVariant.pool,
    _ => KzChipVariant.accent,
  };
}

extension ListingSummary on Listing {
  /// "Ağaç ev · Göl manzaralı · 2 misafir"
  String summary(AppLocalizations l) => [
    propertyType.label(l),
    if (settings.isNotEmpty) settings.first.label(l),
    l.listingGuests(maxGuests),
  ].join(' · ');

  /// "Kırkpınar · 10 dk göle yürüme"
  String locationLine() => [district, ?highlight].join(' · ');
}
