import 'package:freezed_annotation/freezed_annotation.dart';

part 'listing.freezed.dart';
part 'listing.g.dart';

/// Bungalov türü (ev sahibi sihirbazı › Tür ve Konum).
enum PropertyType {
  bungalow,
  aFrame,
  treeHouse,
  stoneHouse,
  glampingTent,
  tinyHouse,
  cabin,
}

/// Konum karakteri (ev sahibi sihirbazı › Tür ve Konum).
enum ListingSetting { lakeside, lakeView, forest, mountainView, nearSea }

/// Öne çıkan olanaklar (ev sahibi sihirbazı › Havuz ve Olanaklar).
enum Amenity {
  pool,
  heatedPool,
  jacuzzi,
  fireplace,
  airConditioning,
  wifi,
  parking,
}

/// İlan rozeti; backend hesaplar.
enum ListingBadge { guestFavorite, rareFind }

/// İlan veri modeli — misafir detayı, sihirbaz ve İlan Yönetimi'nin tek
/// kaynağı (§10). Yeni alan: model → sihirbaz adımı → detay ekranı.
@freezed
abstract class Listing with _$Listing {
  const factory Listing({
    required String id,
    required String title,

    /// Semt / mevki: "Kırkpınar".
    required String district,
    required PropertyType propertyType,
    @Default(<ListingSetting>[]) List<ListingSetting> settings,
    @Default(<Amenity>[]) List<Amenity> amenities,
    required int maxGuests,

    /// Ortalama puan (0–5); değerlendirme yoksa null.
    double? rating,

    /// Tüm ücretler dahil gecelik fiyat (TRY). Backend hesaplar.
    required int nightlyPrice,

    /// Ev sahibinin yazdığı kısa öne çıkan bilgi: "10 dk göle yürüme".
    String? highlight,
    @Default(<String>[]) List<String> photoUrls,

    /// Toplam fotoğraf sayısı (liste yanıtında tüm URL'ler gelmeyebilir).
    required int photoCount,
    ListingBadge? badge,

    /// Bölge: "Sapanca". Aramada konum eşleşmesi buna göre yapılır.
    @Default('') String region,
    @Default(1) int bedrooms,

    /// Anında onay (true) ya da ev sahibi onaylı talep (false).
    @Default(true) bool instantBook,

    /// Girişten 24 saat öncesine kadar ücretsiz iptal.
    @Default(false) bool freeCancellation,
    @Default(false) bool petsAllowed,

    /// Basamaksız giriş, geniş kapılar.
    @Default(false) bool accessible,

    /// Yaklaşık konum (tam adres yalnızca onaylı rezervasyonda paylaşılır).
    @Default(0) double latitude,
    @Default(0) double longitude,
  }) = _Listing;

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);
}
