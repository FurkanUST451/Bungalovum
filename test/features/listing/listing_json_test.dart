import 'package:bungalovum/features/booking/domain/price_calculator.dart';
import 'package:bungalovum/features/listing/data/listing_json.dart';
import 'package:bungalovum/features/listing/domain/listing.dart';
import 'package:bungalovum/features/listing/domain/listing_detail.dart';
import 'package:flutter_test/flutter_test.dart';

/// `listing_card` / `listing_detail` RPC yanıtının biçimi (veritabanında
/// doğrulanmış alan adlarıyla).
Map<String, dynamic> _card() => {
  'id': '6d3c3387-84a2-4a0e-b65a-4a2051e21d89',
  'title': 'Antik Bungalov',
  'region': 'Atakum',
  'city': 'Samsun',
  'district': 'Atakum',
  'property_type': 'a_frame',
  'settings': ['near_sea', 'forest'],
  'amenities': ['jacuzzi', 'wifi', 'kitchen', 'orthopedic_bed'],
  'has_pool': true,
  'pool_heated': true,
  'max_guests': 4,
  'bedrooms': 2,
  'rating': null,
  'review_count': 0,
  'badge': null,
  'tagline': null,
  'instant_book': false,
  'cancellation_policy': 'moderate',
  'pets_allowed': true,
  'accessible': false,
  'latitude': null,
  'longitude': null,
  'display_price': 24200,
  'photos': ['https://cdn/a.jpg', 'https://cdn/b.jpg'],
};

Map<String, dynamic> _detail() => {
  ..._card(),
  'listing_no': 'BV-1003',
  'permit_no': '',
  'beds': 3,
  'bathrooms': 1,
  'min_nights': 2,
  'ratings': {
    'cleanliness': null,
    'accuracy': null,
    'communication': null,
    'location': null,
  },
  'pool': {
    'private': true,
    'heated': true,
    'temperature_c': 28,
    'width_m': 4.0,
    'length_m': 8.0,
    'depth_min_m': 1.2,
    'depth_max_m': 1.6,
    'season_start': 5,
    'season_end': 10,
    'note': '',
  },
  'summary': '',
  'space': 'Denize yakın, ahşap bir kaçamak.',
  'guest_access': 'Bahçe sana ait.',
  'other_notes': '',
  'highlights': ['heated_pool'],
  'rules': {
    'check_in_from': '14:00',
    'check_in_to': '22:00',
    'check_out_by': '11:00',
    'self_check_in': 'keybox',
    'quiet_hours': true,
    'quiet_from': '23:00',
    'quiet_to': '08:00',
    'smoking_allowed': false,
    'events_allowed': false,
  },
  'safety': ['smoke_detector', 'outdoor_camera'],
  'outdoor_camera_note': 'Giriş kapısında',
  'photo_rooms': [
    {
      'room': 'pool',
      'photos': [
        {'url': 'https://cdn/a.jpg', 'caption': ''},
      ],
    },
    {
      'room': 'bedroom',
      'photos': [
        {'url': 'https://cdn/b.jpg', 'caption': 'Yatak odası'},
      ],
    },
  ],
  'host': {
    'id': 'host-1',
    'name': 'Furkan',
    'avatar_url': null,
    'level': 'standard',
    'hosting_since': '2024-10-09',
    'identity_verified': false,
    'about': '',
    'languages': ['tr'],
    'response_rate': null,
    'response_minutes': null,
    'listing_ids': ['6d3c3387-84a2-4a0e-b65a-4a2051e21d89'],
    'review_count': 0,
    'rating': null,
  },
  'reviews': [
    {
      'id': 'r1',
      'author': 'Selin',
      'city': 'İstanbul',
      'rating': 5,
      'date': '2026-09-27T10:00:00+00:00',
      'text': 'Harika',
      'likes': ['pool', 'view', 'host'],
    },
  ],
  'nearby_listing_ids': ['other-1'],
};

void main() {
  test('kart: enum, havuz ve fiyat alanları', () {
    final l = ListingJson.card(_card());
    expect(l.propertyType, PropertyType.aFrame);
    expect(l.settings, [ListingSetting.nearSea, ListingSetting.forest]);
    expect(l.amenities, [
      Amenity.pool,
      Amenity.heatedPool,
      Amenity.jacuzzi,
      Amenity.wifi,
    ]);
    expect(l.nightlyPrice, 24200);
    expect(l.photoUrls.first, 'https://cdn/a.jpg');
    expect(l.photoCount, 2);
    expect(l.rating, isNull);
    expect(l.freeCancellation, isTrue);
    expect(l.instantBook, isFalse);
    expect(l.latitude, 0);
  });

  test('fiyat kalemleri', () {
    final p = ListingJson.price({
      'nights': 2,
      'nightly_rate': 22000,
      'cleaning_fee': 500,
      'service_fee': 4450,
      'discount': 0,
      'discount_kind': null,
    });
    expect(PriceCalculator.total(p), 22000 * 2 + 500 + 4450);
    expect(p.discountKind, DiscountKind.special);
    expect(
      ListingJson.price({
        'nights': 7,
        'nightly_rate': 1000,
        'discount': 700,
        'discount_kind': 'long_stay',
      }).discountKind,
      DiscountKind.longStay,
    );
  });

  test('detay: ev sahibi, kurallar, odalar, olanaklar', () {
    final d = ListingJson.detail(_detail(), now: DateTime(2026, 10, 10));
    expect(d.listingNo, 'BV-1003');
    expect(d.host.name, 'Furkan');
    expect(d.host.yearsHosting, 2);
    expect(d.host.rating, 0);
    // Özet yoksa "Mekân" metni gösterilir.
    expect(d.description.summary, 'Denize yakın, ahşap bir kaçamak.');
    expect(d.rules.selfCheckIn, SelfCheckIn.keybox);
    expect(d.freeCancelHours, 5 * 24);
    expect(d.pool!.temperatureC, 28);
    expect(d.photoRooms.map((r) => r.kind), [RoomKind.pool, RoomKind.bedroom]);
    expect(
      d.safety.singleWhere((s) => s.kind == SafetyKind.outdoorCamera).note,
      'Giriş kapısında',
    );
    final kinds = d.amenityItems.map((a) => (a.kind, a.group)).toList();
    expect(kinds, contains((AmenityKind.privatePool, AmenityGroup.outdoor)));
    expect(kinds, contains((AmenityKind.kitchen, AmenityGroup.indoor)));
    expect(kinds, contains((AmenityKind.pets, AmenityGroup.indoor)));
    expect(
      kinds,
      contains((AmenityKind.stepFreeEntry, AmenityGroup.notIncluded)),
    );
    expect(d.nearbyListingIds, ['other-1']);
  });

  test('değerlendirme: bilinmeyen beğeni konuları atlanır', () {
    final d = ListingJson.detail(_detail(), now: DateTime(2026, 10, 10));
    expect(d.reviews.single.topics, [ReviewTopic.pool, ReviewTopic.host]);
    expect(d.reviewTopics.map((t) => t.topic), [
      ReviewTopic.pool,
      ReviewTopic.host,
    ]);
  });
}
