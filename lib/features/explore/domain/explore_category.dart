import '../../listing/domain/listing.dart';

/// Keşfet kategori şeridi.
enum ExploreCategory {
  all,
  pool,
  lakeView,
  forest,
  jacuzzi,
  fireplace,
  aFrame;

  /// İlanın bu kategoriye girip girmediği. Gerçek API'de filtre sunucuda
  /// uygulanır; mock depo da aynı kuralı kullanır.
  bool matches(Listing l) => switch (this) {
    all => true,
    pool => l.amenities.any(
      (a) => a == Amenity.pool || a == Amenity.heatedPool,
    ),
    lakeView => l.settings.any(
      (s) => s == ListingSetting.lakeView || s == ListingSetting.lakeside,
    ),
    forest => l.settings.contains(ListingSetting.forest),
    jacuzzi => l.amenities.contains(Amenity.jacuzzi),
    fireplace => l.amenities.contains(Amenity.fireplace),
    aFrame => l.propertyType == PropertyType.aFrame,
  };
}
