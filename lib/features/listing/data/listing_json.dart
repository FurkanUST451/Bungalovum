import 'dart:math' as math;

import '../../booking/domain/price_calculator.dart';
import '../../host/domain/listing_draft.dart' show CancellationPolicy;
import '../domain/listing.dart';
import '../domain/listing_detail.dart';

/// Supabase RPC yanıtları (`search_listing_cards`, `listing_cards`,
/// `listing_detail`, `listing_price_estimate`) → uygulama modelleri.
/// Enum'lar veritabanında `snake_case`, Dart'ta `camelCase` (§14).
abstract final class ListingJson {
  /// Kart → [Listing]. `nightlyPrice` tüm ücretler dahil gösterim fiyatıdır.
  static Listing card(Map<String, dynamic> j) {
    final amenities = _strings(j['amenities']).toSet();
    final hasPool = j['has_pool'] == true;
    final heated = j['pool_heated'] == true;
    final photos = _strings(j['photos']);
    return Listing(
      id: j['id'] as String,
      title: j['title'] as String,
      district: j['district'] as String? ?? '',
      propertyType:
          enumOrNull(PropertyType.values, j['property_type']) ??
          PropertyType.bungalow,
      settings: enumList(ListingSetting.values, j['settings']),
      amenities: [
        if (hasPool) Amenity.pool,
        if (hasPool && heated) Amenity.heatedPool,
        for (final a in _cardAmenities)
          if (amenities.contains(snake(a.name))) a,
      ],
      maxGuests: (j['max_guests'] as num).toInt(),
      rating: (j['rating'] as num?)?.toDouble(),
      nightlyPrice: (j['display_price'] as num?)?.toInt() ?? 0,
      highlight: _blankToNull(j['tagline'] as String?),
      photoUrls: photos,
      photoCount: photos.length,
      badge: enumOrNull(ListingBadge.values, j['badge']),
      region: j['region'] as String? ?? '',
      bedrooms: (j['bedrooms'] as num?)?.toInt() ?? 1,
      instantBook: j['instant_book'] as bool? ?? true,
      // Arama filtresiyle aynı kural: katı politika dışındakiler.
      freeCancellation: j['cancellation_policy'] != 'strict',
      petsAllowed: j['pets_allowed'] as bool? ?? false,
      accessible: j['accessible'] as bool? ?? false,
      latitude: (j['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (j['longitude'] as num?)?.toDouble() ?? 0,
    );
  }

  static const _cardAmenities = [
    Amenity.jacuzzi,
    Amenity.fireplace,
    Amenity.airConditioning,
    Amenity.wifi,
    Amenity.parking,
  ];

  /// `offer_price` → [PriceBreakdown].
  static PriceBreakdown price(Map<String, dynamic> j) => PriceBreakdown(
    nightlyRate: (j['nightly_rate'] as num).toInt(),
    nights: (j['nights'] as num).toInt(),
    cleaningFee: (j['cleaning_fee'] as num?)?.toInt() ?? 0,
    serviceFee: (j['service_fee'] as num?)?.toInt() ?? 0,
    discount: (j['discount'] as num?)?.toInt() ?? 0,
    discountKind:
        enumOrNull(DiscountKind.values, j['discount_kind']) ??
        DiscountKind.special,
  );

  /// `listing_detail` → [ListingDetail]. [now] ev sahipliği yılı içindir.
  static ListingDetail detail(Map<String, dynamic> j, {required DateTime now}) {
    final listing = card(j);
    final host = j['host'] as Map<String, dynamic>;
    final since = _date(host['hosting_since']);
    final reviews = [
      for (final r in _maps(j['reviews']))
        Review(
          id: r['id'] as String,
          author: r['author'] as String? ?? '',
          city: r['city'] as String? ?? '',
          rating: (r['rating'] as num).toInt(),
          date: _date(r['date'])!,
          text: r['text'] as String? ?? '',
          topics: enumList(ReviewTopic.values, r['likes']),
        ),
    ];
    final amenityKinds = enumList(AmenityKind.values, j['amenities']);
    final hasPool = j['has_pool'] == true;
    final ratings = j['ratings'] as Map<String, dynamic>? ?? const {};
    double rating(String k) => (ratings[k] as num?)?.toDouble() ?? 0;
    final rules = j['rules'] as Map<String, dynamic>;
    final policy =
        enumOrNull(CancellationPolicy.values, j['cancellation_policy']) ??
        CancellationPolicy.flexible;
    final space = j['space'] as String? ?? '';
    final summary = j['summary'] as String? ?? '';
    final area = [
      listing.district,
      j['city'] as String? ?? '',
    ].where((s) => s.isNotEmpty).join(', ');

    return ListingDetail(
      listing: listing,
      listingNo: j['listing_no'] as String? ?? '',
      permitNo: j['permit_no'] as String? ?? '',
      beds: (j['beds'] as num?)?.toInt() ?? 1,
      bathrooms: (j['bathrooms'] as num?)?.toInt() ?? 1,
      reviewCount: (j['review_count'] as num?)?.toInt() ?? 0,
      host: HostSummary(
        id: host['id'] as String,
        name: host['name'] as String? ?? '',
        level:
            enumOrNull(HostLevel.values, host['level']) ?? HostLevel.standard,
        yearsHosting: since == null ? 0 : math.max(0, now.year - since.year),
        avatarUrl: host['avatar_url'] as String?,
        reviewCount: (host['review_count'] as num?)?.toInt() ?? 0,
        rating: (host['rating'] as num?)?.toDouble() ?? 0,
        responseRate: (host['response_rate'] as num?)?.toInt() ?? 0,
        responseMinutes: (host['response_minutes'] as num?)?.toInt() ?? 0,
        identityVerified: host['identity_verified'] as bool? ?? false,
        about: host['about'] as String? ?? '',
        listingIds: _strings(host['listing_ids']),
      ),
      pool: hasPool ? _pool(j['pool'] as Map<String, dynamic>?) : null,
      description: ListingDescription(
        // Sihirbaz özet istemiyor; özet yoksa "Mekân" metni gösterilir.
        summary: summary.isEmpty ? space : summary,
        space: space,
        guestAccess: j['guest_access'] as String? ?? '',
        otherNotes: j['other_notes'] as String? ?? '',
      ),
      ratings: RatingBreakdown(
        cleanliness: rating('cleanliness'),
        accuracy: rating('accuracy'),
        communication: rating('communication'),
        location: rating('location'),
      ),
      reviewTopics: [
        for (final t in ReviewTopic.values)
          if (reviews.where((r) => r.topics.contains(t)).length case final n
              when n > 0)
            ReviewTopicCount(topic: t, count: n),
      ],
      reviews: reviews,
      amenityItems: [
        if (hasPool && !amenityKinds.contains(AmenityKind.privatePool))
          const AmenityItem(
            kind: AmenityKind.privatePool,
            group: AmenityGroup.outdoor,
          ),
        for (final k in amenityKinds)
          if (k != AmenityKind.pets && k != AmenityKind.stepFreeEntry)
            AmenityItem(kind: k, group: _amenityGroup(k)),
        if (listing.petsAllowed)
          const AmenityItem(kind: AmenityKind.pets, group: AmenityGroup.indoor),
        if (listing.accessible)
          const AmenityItem(
            kind: AmenityKind.stepFreeEntry,
            group: AmenityGroup.indoor,
          ),
        if (!listing.petsAllowed)
          const AmenityItem(
            kind: AmenityKind.pets,
            group: AmenityGroup.notIncluded,
          ),
        if (!listing.accessible)
          const AmenityItem(
            kind: AmenityKind.stepFreeEntry,
            group: AmenityGroup.notIncluded,
          ),
      ],
      locationLabel: area,
      areaLabel: area,
      rules: HouseRules(
        checkInFrom: rules['check_in_from'] as String,
        checkInTo: rules['check_in_to'] as String,
        checkOutBy: rules['check_out_by'] as String,
        selfCheckIn:
            enumOrNull(SelfCheckIn.values, rules['self_check_in']) ??
            SelfCheckIn.none,
        quietFrom: rules['quiet_from'] as String,
        quietTo: rules['quiet_to'] as String,
        smokingAllowed: rules['smoking_allowed'] as bool? ?? false,
      ),
      freeCancelHours: policy.freeCancelHours,
      safety: [
        for (final k in enumList(SafetyKind.values, j['safety']))
          SafetyItem(
            kind: k,
            note: k == SafetyKind.outdoorCamera
                ? _blankToNull(j['outdoor_camera_note'] as String?)
                : null,
          ),
      ],
      photoRooms: [
        for (final room in _maps(j['photo_rooms']))
          PhotoRoom(
            kind: enumOrNull(RoomKind.values, room['room']) ?? RoomKind.living,
            photos: [
              for (final p in _maps(room['photos']))
                ListingPhoto(
                  url: p['url'] as String?,
                  caption: p['caption'] as String? ?? '',
                ),
            ],
          ),
      ],
      nearbyListingIds: _strings(j['nearby_listing_ids']),
    );
  }

  static PoolInfo? _pool(Map<String, dynamic>? p) {
    if (p == null) return null;
    double d(String k) => (p[k] as num?)?.toDouble() ?? 0;
    int m(String k, int fallback) => (p[k] as num?)?.toInt() ?? fallback;
    return PoolInfo(
      private: p['private'] as bool? ?? true,
      heated: p['heated'] as bool? ?? false,
      temperatureC: (p['temperature_c'] as num?)?.toInt(),
      widthM: d('width_m'),
      lengthM: d('length_m'),
      depthMinM: d('depth_min_m'),
      depthMaxM: d('depth_max_m'),
      seasonStartMonth: m('season_start', DateTime.january),
      seasonEndMonth: m('season_end', DateTime.december),
      note: p['note'] as String? ?? '',
    );
  }

  static AmenityGroup _amenityGroup(AmenityKind k) => switch (k) {
    AmenityKind.privatePool ||
    AmenityKind.jacuzzi ||
    AmenityKind.barbecue ||
    AmenityKind.parking => AmenityGroup.outdoor,
    _ => AmenityGroup.indoor,
  };

  // ---------------------------------------------------------------------------
  // Enum ve tip yardımcıları
  // ---------------------------------------------------------------------------

  static String snake(String camel) =>
      camel.replaceAllMapped(RegExp('[A-Z]'), (m) => '_${m[0]!.toLowerCase()}');

  static T? enumOrNull<T extends Enum>(List<T> values, Object? db) {
    if (db == null) return null;
    for (final v in values) {
      if (snake(v.name) == db) return v;
    }
    return null;
  }

  /// Bilinmeyen değerler atlanır (ör. `review_like` → yalnızca 3 konu).
  static List<T> enumList<T extends Enum>(List<T> values, Object? db) => [
    for (final s in (db as List?) ?? const [])
      ?enumOrNull(values, s),
  ];

  static List<String> _strings(Object? v) => [
    for (final s in (v as List?) ?? const []) '$s',
  ];

  static List<Map<String, dynamic>> _maps(Object? v) =>
      ((v as List?) ?? const []).cast<Map<String, dynamic>>();

  static DateTime? _date(Object? v) =>
      v == null ? null : DateTime.parse(v as String).toLocal();

  static String? _blankToNull(String? s) =>
      s == null || s.trim().isEmpty ? null : s;
}
