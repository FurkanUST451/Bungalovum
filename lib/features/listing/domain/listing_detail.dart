import 'package:freezed_annotation/freezed_annotation.dart';

import 'listing.dart';

part 'listing_detail.freezed.dart';
part 'listing_detail.g.dart';

/// İlan Detayı ve alt ekranlarının (20–27) verisi. [listing] özet modelle
/// aynıdır; bu sınıf yalnızca detay alanlarını ekler. Ev sahibi sihirbazı
/// (83–92) ve İlan Yönetimi (95) bu modeli düzenler (§10).
@freezed
abstract class ListingDetail with _$ListingDetail {
  const factory ListingDetail({
    required Listing listing,

    /// "KZ-1042"
    required String listingNo,

    /// Turizm/kısa dönem kiralama izin belge numarası (yayın için zorunlu).
    required String permitNo,
    required int beds,
    required int bathrooms,
    required int reviewCount,

    /// "En iyi %5" — yalnızca Misafirlerin gözdesi ilanlarda.
    int? topPercent,
    required HostSummary host,
    @Default(<ListingHighlight>[]) List<ListingHighlight> highlights,
    PoolInfo? pool,
    required ListingDescription description,
    required RatingBreakdown ratings,
    @Default(<ReviewTopicCount>[]) List<ReviewTopicCount> reviewTopics,
    @Default(<Review>[]) List<Review> reviews,
    @Default(<AmenityItem>[]) List<AmenityItem> amenityItems,

    /// "Sapanca, Sakarya, Türkiye"
    required String locationLabel,

    /// "Kırkpınar, Sapanca" — yaklaşık konum etiketi.
    required String areaLabel,
    @Default(<NearbyPlace>[]) List<NearbyPlace> nearby,
    required HouseRules rules,

    /// Girişten kaç saat öncesine kadar ücretsiz iptal.
    required int freeCancelHours,
    @Default(<SafetyItem>[]) List<SafetyItem> safety,
    @Default(<PhotoRoom>[]) List<PhotoRoom> photoRooms,
    @Default(<String>[]) List<String> nearbyListingIds,
  }) = _ListingDetail;

  factory ListingDetail.fromJson(Map<String, dynamic> json) =>
      _$ListingDetailFromJson(json);
}

enum HostLevel { standard, superhost }

@freezed
abstract class HostSummary with _$HostSummary {
  const factory HostSummary({
    required String id,
    required String name,
    @Default(HostLevel.standard) HostLevel level,
    required int yearsHosting,
    String? avatarUrl,
    required int reviewCount,
    required double rating,

    /// Yüzde (0–100).
    required int responseRate,

    /// Dakika cinsinden ortalama yanıt süresi.
    required int responseMinutes,
    @Default(<String>[]) List<String> languages,
    @Default(false) bool identityVerified,
    @Default('') String about,
    @Default(<String>[]) List<String> listingIds,
  }) = _HostSummary;

  factory HostSummary.fromJson(Map<String, dynamic> json) =>
      _$HostSummaryFromJson(json);
}

enum HighlightKind { topRated, rarePool, greatCheckIn, lakeView, selfCheckIn }

@freezed
abstract class ListingHighlight with _$ListingHighlight {
  const factory ListingHighlight({
    required HighlightKind kind,
    required String title,
    required String body,
  }) = _ListingHighlight;

  factory ListingHighlight.fromJson(Map<String, dynamic> json) =>
      _$ListingHighlightFromJson(json);
}

@freezed
abstract class PoolInfo with _$PoolInfo {
  const factory PoolInfo({
    /// Sana özel (paylaşımsız) ya da ortak.
    @Default(true) bool private,
    @Default(false) bool heated,
    int? temperatureC,
    required double widthM,
    required double lengthM,
    required double depthMinM,
    required double depthMaxM,

    /// Açık olduğu aylar (1–12).
    required int seasonStartMonth,
    required int seasonEndMonth,
    @Default('') String note,
  }) = _PoolInfo;

  factory PoolInfo.fromJson(Map<String, dynamic> json) =>
      _$PoolInfoFromJson(json);
}

@freezed
abstract class ListingDescription with _$ListingDescription {
  const factory ListingDescription({
    required String summary,
    required String space,
    required String guestAccess,
    required String otherNotes,
  }) = _ListingDescription;

  factory ListingDescription.fromJson(Map<String, dynamic> json) =>
      _$ListingDescriptionFromJson(json);
}

@freezed
abstract class RatingBreakdown with _$RatingBreakdown {
  const factory RatingBreakdown({
    required double cleanliness,
    required double accuracy,
    required double communication,
    required double location,
  }) = _RatingBreakdown;

  factory RatingBreakdown.fromJson(Map<String, dynamic> json) =>
      _$RatingBreakdownFromJson(json);
}

enum ReviewTopic { pool, cleanliness, host }

@freezed
abstract class ReviewTopicCount with _$ReviewTopicCount {
  const factory ReviewTopicCount({
    required ReviewTopic topic,
    required int count,
  }) = _ReviewTopicCount;

  factory ReviewTopicCount.fromJson(Map<String, dynamic> json) =>
      _$ReviewTopicCountFromJson(json);
}

@freezed
abstract class Review with _$Review {
  const factory Review({
    required String id,
    required String author,
    required String city,
    required int rating,
    required DateTime date,
    required String text,
    @Default(<ReviewTopic>[]) List<ReviewTopic> topics,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}

enum AmenityGroup { outdoor, indoor, notIncluded }

enum AmenityKind {
  privatePool,
  jacuzzi,
  barbecue,
  parking,
  kitchen,
  wifi,
  airConditioning,
  orthopedicBed,
  fireplace,
  pets,
  stepFreeEntry,
}

@freezed
abstract class AmenityItem with _$AmenityItem {
  const factory AmenityItem({
    required AmenityKind kind,
    required AmenityGroup group,

    /// Ek açıklama: "Isıtmalı · 28°C", "100 Mbps".
    String? note,
  }) = _AmenityItem;

  factory AmenityItem.fromJson(Map<String, dynamic> json) =>
      _$AmenityItemFromJson(json);
}

enum NearbyKind { lake, market, mountain, forest }

@freezed
abstract class NearbyPlace with _$NearbyPlace {
  const factory NearbyPlace({
    required NearbyKind kind,
    required String name,
    required int distanceMeters,
    required int minutes,

    /// true: yürüme, false: araçla.
    @Default(false) bool walking,
  }) = _NearbyPlace;

  factory NearbyPlace.fromJson(Map<String, dynamic> json) =>
      _$NearbyPlaceFromJson(json);
}

enum SelfCheckIn { none, keybox, smartLock }

@freezed
abstract class HouseRules with _$HouseRules {
  const factory HouseRules({
    /// "14:00" biçiminde yerel saat.
    required String checkInFrom,
    required String checkInTo,
    required String checkOutBy,
    @Default(SelfCheckIn.none) SelfCheckIn selfCheckIn,
    required String quietFrom,
    required String quietTo,
    @Default(false) bool smokingAllowed,
  }) = _HouseRules;

  factory HouseRules.fromJson(Map<String, dynamic> json) =>
      _$HouseRulesFromJson(json);
}

enum SafetyKind {
  coAlarm,
  smokeDetector,
  firstAidKit,
  fireExtinguisher,
  outdoorCamera,
}

@freezed
abstract class SafetyItem with _$SafetyItem {
  const factory SafetyItem({
    required SafetyKind kind,

    /// Dış kamera için konum açıklaması (zorunlu, §10).
    String? note,
  }) = _SafetyItem;

  factory SafetyItem.fromJson(Map<String, dynamic> json) =>
      _$SafetyItemFromJson(json);
}

enum RoomKind { living, bedroom, bathroom, outdoor, pool }

@freezed
abstract class ListingPhoto with _$ListingPhoto {
  const factory ListingPhoto({String? url, @Default('') String caption}) =
      _ListingPhoto;

  factory ListingPhoto.fromJson(Map<String, dynamic> json) =>
      _$ListingPhotoFromJson(json);
}

@freezed
abstract class PhotoRoom with _$PhotoRoom {
  const factory PhotoRoom({
    required RoomKind kind,
    required List<ListingPhoto> photos,
  }) = _PhotoRoom;

  factory PhotoRoom.fromJson(Map<String, dynamic> json) =>
      _$PhotoRoomFromJson(json);
}
