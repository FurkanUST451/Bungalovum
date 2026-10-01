import '../../booking/domain/price_calculator.dart';
import '../domain/listing.dart';
import '../domain/listing_offer.dart';

/// Geliştirme için sahte ilan kataloğu — tüm mock depolar (Keşfet, Arama,
/// Kaydedilenler, Seyahatler...) aynı ilanları buradan okur. Figma'daki
/// örnek içerikle uyumludur; production build'de kullanılmaz.
abstract final class ListingCatalog {
  static const all = <Listing>[
    Listing(
      id: 'gol-esintisi',
      title: 'Göl Esintisi Bungalov',
      district: 'Kurtköy',
      region: 'Sapanca',
      propertyType: PropertyType.treeHouse,
      settings: [ListingSetting.lakeView],
      amenities: [
        Amenity.heatedPool,
        Amenity.jacuzzi,
        Amenity.wifi,
        Amenity.parking,
      ],
      maxGuests: 2,
      bedrooms: 1,
      rating: 4.93,
      nightlyPrice: 5400,
      photoCount: 12,
      badge: ListingBadge.guestFavorite,
      instantBook: true,
      freeCancellation: true,
      latitude: 40.700,
      longitude: 30.262,
    ),
    Listing(
      id: 'cam-yamac',
      title: 'Çam Yamaç Bungalov',
      district: 'Mahmudiye',
      region: 'Sapanca',
      propertyType: PropertyType.aFrame,
      settings: [ListingSetting.forest],
      amenities: [
        Amenity.pool,
        Amenity.jacuzzi,
        Amenity.fireplace,
        Amenity.wifi,
      ],
      maxGuests: 4,
      bedrooms: 2,
      rating: 4.87,
      nightlyPrice: 6850,
      photoCount: 9,
      badge: ListingBadge.guestFavorite,
      instantBook: false,
      freeCancellation: true,
      petsAllowed: true,
      latitude: 40.688,
      longitude: 30.240,
    ),
    Listing(
      id: 'kuzey-kulube',
      title: 'Kuzey Kulübe',
      district: 'Göl kıyısı',
      region: 'Sapanca',
      propertyType: PropertyType.cabin,
      settings: [ListingSetting.lakeside],
      amenities: [Amenity.jacuzzi, Amenity.airConditioning],
      maxGuests: 2,
      bedrooms: 1,
      rating: 5.0,
      nightlyPrice: 4900,
      photoCount: 7,
      badge: ListingBadge.guestFavorite,
      latitude: 40.712,
      longitude: 30.278,
    ),
    Listing(
      id: 'gol-evi-sapanca',
      title: 'Göl Evi Sapanca',
      district: 'Kırkpınar',
      region: 'Sapanca',
      propertyType: PropertyType.bungalow,
      settings: [ListingSetting.lakeView],
      amenities: [
        Amenity.heatedPool,
        Amenity.wifi,
        Amenity.parking,
        Amenity.airConditioning,
      ],
      maxGuests: 4,
      bedrooms: 2,
      rating: 4.93,
      nightlyPrice: 5400,
      highlight: '10 dk göle yürüme',
      photoCount: 18,
      badge: ListingBadge.rareFind,
      freeCancellation: true,
      latitude: 40.704,
      longitude: 30.255,
    ),
    Listing(
      id: 'cam-kozalak',
      title: 'Çam Kozalak Bungalov',
      district: 'Uzunkum',
      region: 'Sapanca',
      propertyType: PropertyType.bungalow,
      settings: [ListingSetting.forest],
      amenities: [Amenity.heatedPool, Amenity.fireplace, Amenity.wifi],
      maxGuests: 4,
      bedrooms: 2,
      rating: 5.0,
      nightlyPrice: 6500,
      highlight: 'Kapalı ısıtmalı havuz',
      photoCount: 18,
      accessible: true,
      latitude: 40.680,
      longitude: 30.270,
    ),
    Listing(
      id: 'kartepe-yuva',
      title: 'Kartepe Yuva',
      district: 'Maşukiye',
      region: 'Kartepe',
      propertyType: PropertyType.aFrame,
      settings: [ListingSetting.forest],
      amenities: [Amenity.jacuzzi, Amenity.fireplace, Amenity.parking],
      maxGuests: 4,
      bedrooms: 2,
      rating: 4.78,
      nightlyPrice: 5900,
      photoCount: 10,
      petsAllowed: true,
      latitude: 40.690,
      longitude: 30.150,
    ),
    Listing(
      id: 'abant-kulube',
      title: 'Abant Göl Kulübesi',
      district: 'Abant',
      region: 'Abant',
      propertyType: PropertyType.cabin,
      settings: [ListingSetting.lakeside],
      amenities: [Amenity.fireplace, Amenity.wifi],
      maxGuests: 3,
      bedrooms: 1,
      rating: 4.81,
      nightlyPrice: 4400,
      photoCount: 8,
      freeCancellation: true,
      latitude: 40.605,
      longitude: 31.282,
    ),
    Listing(
      id: 'sapanca-orman-evi',
      title: 'Orman Evi Sapanca',
      district: 'Kurtköy',
      region: 'Sapanca',
      propertyType: PropertyType.bungalow,
      settings: [ListingSetting.forest, ListingSetting.lakeView],
      amenities: [
        Amenity.pool,
        Amenity.heatedPool,
        Amenity.airConditioning,
        Amenity.wifi,
        Amenity.parking,
      ],
      maxGuests: 6,
      bedrooms: 3,
      rating: 4.72,
      nightlyPrice: 8100,
      photoCount: 14,
      latitude: 40.695,
      longitude: 30.285,
    ),
  ];

  static Listing? byId(String id) {
    for (final l in all) {
      if (l.id == id) return l;
    }
    return null;
  }

  /// Backend'in uyguladığı ücretleri taklit eder: temizlik ilan başına sabit,
  /// hizmet bedeli konaklamanın %12'si, "Nadir fırsat" ilanlarında indirim.
  /// Uygulama bu oranları bilmez; gerçek API kalemleri hazır döner.
  static PriceBreakdown quote(Listing l, int nights) {
    final rate = l.badge == ListingBadge.rareFind
        ? (l.nightlyPrice * 1.22).round()
        : l.nightlyPrice;
    final stay = rate * nights;
    final cleaning = 300 * l.bedrooms;
    final service = (stay * 0.12).round();
    final discount = l.badge == ListingBadge.rareFind
        ? stay + cleaning + service - l.nightlyPrice * nights
        : 0;
    return PriceBreakdown(
      nightlyRate: rate,
      nights: nights,
      cleaningFee: cleaning,
      serviceFee: service,
      discount: discount,
    );
  }

  static ListingOffer offer(Listing l, int nights, {int? nightsLeft}) =>
      ListingOffer(listing: l, price: quote(l, nights), nightsLeft: nightsLeft);
}
