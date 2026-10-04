import '../../listing/domain/listing.dart';
import '../../listing/domain/listing_detail.dart';
import '../domain/listing_draft.dart';
import 'host_repository.dart';

class MockHostRepository implements HostRepository {
  MockHostRepository({
    this.latency = const Duration(milliseconds: 250),
    DateTime Function()? clock,
    ListingDraft? seed,
  }) : _clock = clock ?? DateTime.now,
       _draft = seed;

  final Duration latency;
  final DateTime Function() _clock;
  ListingDraft? _draft;
  int _seq = 0;

  /// Örnek oran; gerçek komisyon backend'den gelir.
  static const _serviceRate = 0.10;
  static const _exampleNights = 2;

  /// Kimlik doğrulamasından dönen ad (mock).
  static const verifiedSampleName = 'Deniz Yılmaz';

  Future<void> _wait() => Future<void>.delayed(latency);

  /// Figma 83–92'deki dolu taslak.
  static ListingDraft sample({String id = 'draft-1'}) => ListingDraft(
    id: id,
    resumeStep: WizardStep.identityAndPayout,
    propertyType: PropertyType.bungalow,
    settings: const {ListingSetting.lakeside, ListingSetting.forest},
    address: 'Kırkpınar Mah. Göl Sk. No: 12',
    city: 'Sakarya',
    district: 'Sapanca',
    latitude: 40.69,
    longitude: 30.27,
    maxGuests: 2,
    bedrooms: 1,
    beds: 2,
    bathrooms: 1,
    bedTypes: const [
      BedCount(type: BedType.double, count: 1),
      BedCount(type: BedType.sofaBed, count: 1),
    ],
    indoorM2: 55,
    gardenM2: 200,
    hasPool: true,
    poolHeated: true,
    poolTempC: 28,
    poolWidthM: 4,
    poolLengthM: 8,
    poolDepthMinM: 1.2,
    poolDepthMaxM: 1.6,
    poolSeasonStart: 4,
    poolSeasonEnd: 11,
    amenities: const {
      AmenityKind.jacuzzi,
      AmenityKind.fireplace,
      AmenityKind.kitchen,
      AmenityKind.wifi,
      AmenityKind.parking,
      AmenityKind.airConditioning,
    },
    photos: [
      for (final (room, n) in const [
        (RoomKind.living, 3),
        (RoomKind.bedroom, 2),
        (RoomKind.bathroom, 1),
        (RoomKind.pool, 3),
        (RoomKind.outdoor, 5),
      ])
        for (var i = 0; i < n; i++)
          DraftPhoto(id: '${room.name}-$i', room: room, url: ''),
    ],
    coverPhotoId: 'pool-0',
    title: 'Göl Esintisi Bungalov',
    highlights: const {
      HighlightTag.lakeView,
      HighlightTag.heatedPool,
      HighlightTag.selfCheckIn,
    },
    space:
        'Göl manzarasına karşı, ahşap kokulu bir kaçamak. Açık mutfaklı salon '
        've terasa açılan geniş camlar.',
    guestAccess: 'Bungalovun tamamı ve bahçe sadece misafire ait.',
    otherNotes: 'Son 50 m toprak yol; kışın zincir önerilir.',
    safety: const {
      SafetyKind.smokeDetector,
      SafetyKind.coAlarm,
      SafetyKind.fireExtinguisher,
      SafetyKind.firstAidKit,
    },
    poolNoLifeguardAck: true,
    nightlyPrice: 4900,
    weekendPrice: 5900,
    cleaningFee: 600,
    weeklyDiscountPercent: 10,
    minNights: 2,
    lockboxCode: '4829',
    lockboxHint: 'Kapının sağındaki gri kutu',
    wifiName: 'GolEsintisi_5G',
    wifiPassword: 'bungalovum2026',
    poolInstructions:
        'Havuz 09:00–23:00 arası açık. Jakuzi ısınması ~30 dk, panel mutfak '
        'kapısının yanında.',
    houseInstructions:
        'Çöpler bahçe kapısındaki konteynere. Mangal sadece bahçede.',
    checkoutTasks: const [
      'Bulaşıkları makineye koy',
      'Çöpleri konteynere bırak',
      'Anahtarı kutuya geri bırak',
    ],
    permitType: PermitType.tourismRental,
    permitNo: '54-2026-000412',
    documents: const {
      HostDocKind.permit: HostDocument(id: 'doc-permit'),
      HostDocKind.deed: HostDocument(id: 'doc-deed'),
      HostDocKind.entrancePlate: HostDocument(id: 'doc-plate'),
    },
    kbsDeclaration: true,
    permitHolderDeclaration: true,
    updateDeclaration: true,
    taxId: '10000000146',
    taxOffice: 'Sapanca Vergi Dairesi',
    identityDone: const {IdentityStep.idFront, IdentityStep.idBack},
    accountHolder: verifiedSampleName,
    iban: 'TR33 0006 1005 1978 6457 8413 26',
    billingAddress: 'Göl Sk. No: 12, Sapanca / Sakarya',
    emergencyPhone: '5320000000',
  );

  @override
  Future<ListingDraft?> current() async {
    await _wait();
    return _draft;
  }

  @override
  Future<ListingDraft> start() async {
    await _wait();
    return _draft ??= ListingDraft(id: 'draft-${++_seq}');
  }

  @override
  Future<ListingDraft> save(ListingDraft draft) async {
    await _wait();
    final before = _draft;
    var next = draft;
    if (before != null && before.isLive) {
      // Yayındaki ilanda yalnızca değişen hassas bölüm incelemeye girer.
      next = next.copyWith(
        sectionsInReview: {
          ...next.sectionsInReview,
          if (_legalChanged(before, next)) WizardStep.legal,
          if (_payoutChanged(before, next)) WizardStep.identityAndPayout,
        },
      );
    }
    return _draft = next;
  }

  static bool _legalChanged(ListingDraft a, ListingDraft b) =>
      a.permitType != b.permitType ||
      a.permitNo != b.permitNo ||
      a.documents != b.documents ||
      a.taxId != b.taxId;

  static bool _payoutChanged(ListingDraft a, ListingDraft b) =>
      a.iban != b.iban ||
      a.accountHolder != b.accountHolder ||
      a.identityDone != b.identityDone;

  @override
  Future<DraftPhoto> uploadPhoto(RoomKind room, String localPath) async {
    await _wait();
    // Gerçekte CDN adresi döner; mock yerel yolu gösterir.
    return DraftPhoto(id: 'p-${++_seq}', room: room, url: localPath);
  }

  @override
  Future<HostDocument> uploadDocument(
    HostDocKind kind,
    String localPath,
  ) async {
    await _wait();
    return HostDocument(id: 'doc-${kind.name}-${++_seq}');
  }

  @override
  Future<ListingDraft> verifyIdentity(
    IdentityStep step,
    String localPath,
  ) async {
    await _wait();
    final d = _draft!;
    final done = {...d.identityDone, step};
    return _draft = d.copyWith(
      identityDone: done,
      verifiedName: done.length == IdentityStep.values.length
          ? verifiedSampleName
          : d.verifiedName,
    );
  }

  @override
  Future<EarningsEstimate> earnings({
    required int nightly,
    required int cleaningFee,
    required String city,
  }) async {
    await _wait();
    final stay = nightly * _exampleNights;
    final fee = ((stay + cleaningFee) * _serviceRate).round();
    return EarningsEstimate(
      nights: _exampleNights,
      nightly: nightly,
      stayTotal: stay,
      cleaningFee: cleaningFee,
      serviceFee: fee,
      hostEarns: stay + cleaningFee - fee,
      similarMin: 4200,
      similarMax: 6100,
    );
  }

  @override
  Future<ListingDraft> submitForReview() async {
    await _wait();
    return _draft = _draft!.copyWith(
      status: ListingStatus.inReview,
      submittedAt: _clock(),
    );
  }

  @override
  Future<ListingDraft> setPaused(bool paused) async {
    await _wait();
    return _draft = _draft!.copyWith(
      status: paused ? ListingStatus.paused : ListingStatus.published,
    );
  }

  @override
  Future<ListingDraft> unpublish() async {
    await _wait();
    return _draft = _draft!.copyWith(status: ListingStatus.draft);
  }
}
