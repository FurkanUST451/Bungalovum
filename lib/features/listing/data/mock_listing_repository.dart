import '../../booking/domain/price_calculator.dart';
import '../domain/listing.dart';
import '../domain/listing_detail.dart';
import 'listing_catalog.dart';
import 'listing_repository.dart';

/// Sahte ilan detayları. "Göl Esintisi" Figma içeriğini birebir taşır;
/// diğer ilanlar katalog alanlarından türetilir.
class MockListingRepository implements ListingRepository {
  MockListingRepository({this.latency = const Duration(milliseconds: 350)});

  final Duration latency;

  Future<void> _wait() => Future<void>.delayed(latency);

  static const _host = HostSummary(
    id: 'ayla',
    name: 'Ayla Hanım',
    level: HostLevel.superhost,
    yearsHosting: 2,
    reviewCount: 123,
    rating: 4.89,
    responseRate: 100,
    responseMinutes: 60,
    languages: ['Türkçe', 'İngilizce'],
    identityVerified: true,
    about:
        'Sapanca’da doğup büyüdüm. Misafirlerimin kendi evlerindeymiş gibi '
        'hissetmesi için her ayrıntıyla kendim ilgileniyorum.',
    listingIds: ['gol-esintisi', 'gol-evi-sapanca'],
  );

  static final _reviews = [
    Review(
      id: 'r1',
      author: 'Selin',
      city: 'İstanbul',
      rating: 5,
      date: DateTime(2026, 9, 27),
      text:
          'Sabah kahvesini terasta içmek paha biçilemezdi. Ev tertemiz, her '
          'ayrıntı düşünülmüş.',
      topics: const [ReviewTopic.cleanliness],
    ),
    Review(
      id: 'r2',
      author: 'Mert',
      city: 'Ankara',
      rating: 5,
      date: DateTime(2026, 9, 17),
      text:
          'Havuz tertemizdi, gün batımı manzarası inanılmaz. Kesinlikle tekrar '
          'geleceğiz.',
      topics: const [ReviewTopic.pool, ReviewTopic.cleanliness],
    ),
    Review(
      id: 'r3',
      author: 'Ece',
      city: 'Bursa',
      rating: 5,
      date: DateTime(2026, 9, 1),
      text: 'Ev sahibi çok ilgiliydi, girişte her şeyi tek tek anlattı.',
      topics: const [ReviewTopic.host],
    ),
  ];

  static const _rooms = [
    PhotoRoom(
      kind: RoomKind.living,
      photos: [
        ListingPhoto(caption: 'Şömine köşesi ve göl manzaralı geniş pencere'),
        ListingPhoto(caption: 'Açık mutfaklı salon'),
        ListingPhoto(caption: 'Terasa açılan cam kapılar'),
      ],
    ),
    PhotoRoom(
      kind: RoomKind.bedroom,
      photos: [
        ListingPhoto(caption: 'Çatı katında çift kişilik yatak'),
        ListingPhoto(caption: 'Göl manzaralı yatak odası'),
        ListingPhoto(caption: 'Gardırop ve okuma köşesi'),
      ],
    ),
    PhotoRoom(
      kind: RoomKind.bathroom,
      photos: [
        ListingPhoto(caption: 'Yağmur duşlu banyo'),
        ListingPhoto(caption: 'Lavabo ve ayna'),
        ListingPhoto(caption: 'Havlu ve bakım ürünleri'),
      ],
    ),
    PhotoRoom(
      kind: RoomKind.outdoor,
      photos: [
        ListingPhoto(caption: 'Bahçe ve mangal alanı'),
        ListingPhoto(caption: 'Teras'),
        ListingPhoto(caption: 'Orman manzarası'),
      ],
    ),
    PhotoRoom(
      kind: RoomKind.pool,
      photos: [
        ListingPhoto(caption: 'Isıtmalı özel havuz'),
        ListingPhoto(caption: 'Gün batımında havuz'),
      ],
    ),
  ];

  ListingDetail _build(Listing l) {
    final hasPool = l.amenities.any(
      (a) => a == Amenity.pool || a == Amenity.heatedPool,
    );
    final heated = l.amenities.contains(Amenity.heatedPool);
    return ListingDetail(
      listing: l,
      listingNo: 'KZ-${1042 + ListingCatalog.all.indexOf(l)}',
      permitNo:
          '54-2026-${(412 + ListingCatalog.all.indexOf(l)).toString().padLeft(6, '0')}',
      beds: l.bedrooms + 1,
      bathrooms: l.bedrooms >= 3 ? 2 : 1,
      reviewCount: 84,
      topPercent: l.badge == ListingBadge.guestFavorite ? 5 : null,
      host: _host,
      highlights: [
        if (l.badge == ListingBadge.guestFavorite)
          const ListingHighlight(
            kind: HighlightKind.topRated,
            title: 'En sevilen %5 ev arasında',
            body: 'Puan, yorum ve güvenilirliğe göre üst sıralarda.',
          ),
        if (hasPool)
          const ListingHighlight(
            kind: HighlightKind.rarePool,
            title: 'Balıklama dalın',
            body: 'Bölgede havuzu olan nadir yerlerden biri.',
          ),
        const ListingHighlight(
          kind: HighlightKind.greatCheckIn,
          title: 'Kusursuz giriş deneyimi',
          body: 'Son misafirler girişe 5 yıldız verdi.',
        ),
      ],
      pool: hasPool
          ? PoolInfo(
              heated: heated,
              temperatureC: heated ? 28 : null,
              widthM: 4,
              lengthM: 8,
              depthMinM: 1.2,
              depthMaxM: 1.6,
              seasonStartMonth: 4,
              seasonEndMonth: 11,
              note: 'Havuz her misafirden önce temizlenir ve bakımı yapılır.',
            )
          : null,
      description: const ListingDescription(
        summary:
            'Göl manzarasına karşı, ahşap kokulu bir kaçamak. Gün batımında '
            'havuz, gece jakuzi; sabah kahvaltıyı terasta yapın.',
        space:
            'Göl manzarasına karşı, ahşap kokulu bir kaçamak. Açık mutfaklı '
            'salon, çatı katında yatak odası ve terasa açılan geniş camlar. '
            'Gün batımında havuz, gece jakuzi.',
        guestAccess:
            'Bungalovun tamamı ve bahçe sadece sana ait. Havuz ve jakuzi '
            'başka misafirlerle paylaşılmaz.',
        otherNotes:
            'Bungalova son 50 m toprak yoldan ulaşılır. Kış aylarında zincir '
            'bulundurmanı öneririz.',
      ),
      ratings: const RatingBreakdown(
        cleanliness: 5.0,
        accuracy: 4.95,
        communication: 5.0,
        location: 4.9,
      ),
      reviewTopics: const [
        ReviewTopicCount(topic: ReviewTopic.pool, count: 15),
        ReviewTopicCount(topic: ReviewTopic.cleanliness, count: 44),
        ReviewTopicCount(topic: ReviewTopic.host, count: 56),
      ],
      reviews: _reviews,
      amenityItems: [
        if (hasPool)
          AmenityItem(
            kind: AmenityKind.privatePool,
            group: AmenityGroup.outdoor,
            note: heated ? 'Isıtmalı · 28°C' : null,
          ),
        if (l.amenities.contains(Amenity.jacuzzi))
          const AmenityItem(
            kind: AmenityKind.jacuzzi,
            group: AmenityGroup.outdoor,
            note: 'Açık hava',
          ),
        const AmenityItem(
          kind: AmenityKind.barbecue,
          group: AmenityGroup.outdoor,
        ),
        if (l.amenities.contains(Amenity.parking))
          const AmenityItem(
            kind: AmenityKind.parking,
            group: AmenityGroup.outdoor,
            note: 'Mülk içinde',
          ),
        const AmenityItem(
          kind: AmenityKind.kitchen,
          group: AmenityGroup.indoor,
        ),
        if (l.amenities.contains(Amenity.wifi))
          const AmenityItem(
            kind: AmenityKind.wifi,
            group: AmenityGroup.indoor,
            note: '100 Mbps',
          ),
        if (l.amenities.contains(Amenity.airConditioning))
          const AmenityItem(
            kind: AmenityKind.airConditioning,
            group: AmenityGroup.indoor,
          ),
        if (l.amenities.contains(Amenity.fireplace))
          const AmenityItem(
            kind: AmenityKind.fireplace,
            group: AmenityGroup.indoor,
          ),
        const AmenityItem(
          kind: AmenityKind.orthopedicBed,
          group: AmenityGroup.indoor,
        ),
        if (!l.petsAllowed)
          const AmenityItem(
            kind: AmenityKind.pets,
            group: AmenityGroup.notIncluded,
          ),
        if (!l.accessible)
          const AmenityItem(
            kind: AmenityKind.stepFreeEntry,
            group: AmenityGroup.notIncluded,
          ),
      ],
      locationLabel: '${l.region}, Sakarya, Türkiye',
      areaLabel: '${l.district}, ${l.region}',
      nearby: const [
        NearbyPlace(
          kind: NearbyKind.lake,
          name: 'Göl kıyısı',
          distanceMeters: 650,
          minutes: 8,
          walking: true,
        ),
        NearbyPlace(
          kind: NearbyKind.market,
          name: 'Market',
          distanceMeters: 1200,
          minutes: 3,
        ),
        NearbyPlace(
          kind: NearbyKind.mountain,
          name: 'Maşukiye',
          distanceMeters: 18000,
          minutes: 25,
        ),
      ],
      rules: const HouseRules(
        checkInFrom: '14:00',
        checkInTo: '22:00',
        checkOutBy: '11:00',
        selfCheckIn: SelfCheckIn.keybox,
        quietFrom: '23:00',
        quietTo: '08:00',
      ),
      freeCancelHours: 24,
      safety: const [
        SafetyItem(kind: SafetyKind.coAlarm),
        SafetyItem(kind: SafetyKind.smokeDetector),
        SafetyItem(kind: SafetyKind.firstAidKit),
        SafetyItem(
          kind: SafetyKind.outdoorCamera,
          note: 'Otopark girişinde, yalnızca araç yolunu görür',
        ),
      ],
      photoRooms: _rooms,
      nearbyListingIds: [
        for (final o in ListingCatalog.all)
          if (o.id != l.id && o.region == l.region) o.id,
      ].take(3).toList(),
    );
  }

  @override
  Future<ListingDetail> detail(String id) async {
    await _wait();
    final l = ListingCatalog.byId(id);
    if (l == null) throw StateError('İlan bulunamadı: $id');
    return _build(l);
  }

  @override
  Future<PriceBreakdown> quote(String id, int nights) async {
    await _wait();
    return ListingCatalog.quote(ListingCatalog.byId(id)!, nights);
  }

  @override
  Future<List<Listing>> byIds(List<String> ids) async {
    await _wait();
    return [for (final id in ids) ?ListingCatalog.byId(id)];
  }

  @override
  String shareLink(String id) => 'kozalak.app/b/$id';

  @override
  Future<void> report(String id, ReportReason reason, String details) =>
      _wait();
}
