import '../../listing/data/listing_catalog.dart';
import '../../listing/domain/house_guide.dart';
import '../../listing/domain/listing_offer.dart';
import '../../trips/domain/trip_models.dart';
import '../../search/domain/search_query.dart';
import '../domain/booking.dart';
import '../domain/payment.dart';
import '../domain/price_calculator.dart';
import 'booking_repository.dart';

/// Sahte ödeme ve rezervasyon akışı. 3D Secure'da "000000" girilirse banka
/// reddeder; diğer 6 haneli kodlar onaylanır.
class MockBookingRepository implements BookingRepository {
  MockBookingRepository({
    this.latency = const Duration(milliseconds: 600),
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final Duration latency;
  final DateTime Function() _clock;

  static const declineCode = '000000';

  /// Geçerli örnek kupon: konaklama tutarında %10 indirim.
  static const sampleCoupon = 'KOZALAK10';
  static const expiredCoupon = 'YAZ2025';
  static const _couponRate = 0.10;
  static const _merchant = 'Kozalak Seyahat';
  static const _codeTtl = Duration(minutes: 3);
  static const _hold = Duration(minutes: 15);

  /// Figma örneği: Göl Esintisi, 6 – 8 Kas, 2 yetişkin.
  static const sampleBookingId = 'kz-48k2q';

  /// Figma örnekleri: Çam Yamaç, 20 – 22 Kas talebi (bekliyor / onaylandı /
  /// reddedildi).
  static const sampleRequestId = 'kz-req-1';
  static const sampleApprovedId = 'kz-71p3d';
  static const sampleDeclinedId = 'kz-req-2';
  static const _respondWithin = Duration(hours: 24);

  /// Seyahatler listesinde görünmeyen, yalnızca 42/43 örnekleri.
  static const _detachedSamples = {
    sampleApprovedId,
    sampleDeclinedId,
    sampleRevealedId,
  };

  static const sampleRevealedId = 'kz-soon';
  static const samplePastId = 'kz-p1';

  static const sampleCancelledId = 'kz-c1';

  Future<void> _wait() => Future<void>.delayed(latency);

  late final Map<String, Booking> _bookings = {
    sampleBookingId: Booking(
      id: sampleBookingId,
      code: 'KZ-48K2Q',
      listingId: 'gol-esintisi',
      dates: StayDates(
        checkIn: DateTime(2026, 11, 6),
        checkOut: DateTime(2026, 11, 8),
      ),
      guests: const GuestCount(),
      amountPaid: 10800,
      status: BookingStatus.confirmed,
      cardBrand: CardBrand.visa,
      cardLast4: '4242',
      paidAt: DateTime(2026, 10, 1),
      price: const PriceBreakdown(
        nightlyRate: 5400,
        nights: 2,
        cleaningFee: 600,
        serviceFee: 850,
        discount: 1450,
        discountKind: DiscountKind.earlyBooking,
      ),
    ),
    // Girişi bugün olan (bilgiler açılmış) örnek; listede görünmez.
    sampleRevealedId: Booking(
      id: sampleRevealedId,
      code: 'KZ-5Q2LW',
      listingId: 'gol-esintisi',
      dates: StayDates(
        checkIn: DateTime(2026, 11, 3),
        checkOut: DateTime(2026, 11, 5),
      ),
      guests: const GuestCount(),
      amountPaid: 10800,
      status: BookingStatus.confirmed,
      cardBrand: CardBrand.visa,
      cardLast4: '4242',
      paidAt: DateTime(2026, 10, 12),
    ),
    for (final (id, code, status) in const [
      (sampleRequestId, 'KZ-R8T1M', BookingStatus.pending),
      (sampleApprovedId, 'KZ-71P3D', BookingStatus.confirmed),
      (sampleDeclinedId, 'KZ-R2V9C', BookingStatus.declined),
    ])
      id: Booking(
        id: id,
        code: code,
        listingId: 'cam-yamac',
        dates: StayDates(
          checkIn: DateTime(2026, 11, 20),
          checkOut: DateTime(2026, 11, 22),
        ),
        guests: const GuestCount(),
        amountPaid: 14400,
        status: status,
        isRequest: true,
        cardBrand: CardBrand.visa,
        cardLast4: '4242',
        requestedAt: DateTime(2026, 11, 2, 23, 58),
        respondBy: DateTime(2026, 11, 2, 23, 58).add(_respondWithin),
        // Onaylanınca provizyon tahsilata dönüşür.
        paidAt: status == BookingStatus.confirmed
            ? DateTime(2026, 11, 2, 23, 58)
            : null,
      ),
    // Geçmiş konaklamalar (Figma 44/46).
    for (final (id, listingId, inDay, nights, rating) in [
      ('kz-p1', 'kartepe-yuva', DateTime(2026, 9, 18), 3, 5.0),
      ('kz-p2', 'abant-kulube', DateTime(2026, 8, 14), 2, null),
      ('kz-p3', 'kuzey-kulube', DateTime(2026, 7, 3), 2, 4.0),
      ('kz-p4', 'sapanca-orman-evi', DateTime(2026, 6, 12), 2, 5.0),
    ])
      id: Booking(
        id: id,
        code: 'KZ-${id.toUpperCase()}',
        listingId: listingId,
        dates: StayDates(
          checkIn: inDay,
          checkOut: inDay.add(Duration(days: nights)),
        ),
        guests: const GuestCount(),
        amountPaid: PriceCalculator.total(
          ListingCatalog.quote(ListingCatalog.byId(listingId)!, nights),
        ),
        status: BookingStatus.completed,
        cardBrand: CardBrand.visa,
        cardLast4: '4242',
        myRating: rating,
        price: ListingCatalog.quote(ListingCatalog.byId(listingId)!, nights),
        paidAt: inDay.subtract(const Duration(days: 21)),
      ),
    // İptal edilen (Figma 47).
    sampleCancelledId: Booking(
      id: sampleCancelledId,
      code: 'KZ-C7Y4N',
      listingId: 'cam-yamac',
      dates: StayDates(
        checkIn: DateTime(2026, 9, 12),
        checkOut: DateTime(2026, 9, 14),
      ),
      guests: const GuestCount(),
      amountPaid: 13000,
      status: BookingStatus.cancelled,
      cardBrand: CardBrand.visa,
      cardLast4: '4242',
      paidAt: DateTime(2026, 8, 20),
      cancelledAt: DateTime(2026, 9, 2),
      refundAmount: 13000,
    ),
  };

  late final Map<String, List<StayGuest>> _guests = {
    sampleBookingId: const [
      StayGuest(
        id: 'g1',
        fullName: 'Deniz Yılmaz',
        nationality: Nationality.turkish,
        idLast2: '12',
        isYou: true,
      ),
    ],
  };

  final _pending = <String, (PaymentRequest, ThreeDsChallenge)>{};
  var _seq = 0;

  @override
  Future<List<int>> installmentOptions({String? cardId, String? bin}) async {
    await _wait();
    return const [1, 3, 6];
  }

  PriceBreakdown _couponQuote(String listingId, int nights, String code) {
    final normalized = code.trim().toUpperCase();
    if (normalized == expiredCoupon) {
      throw const CouponRejected(CouponError.expired);
    }
    if (normalized != sampleCoupon) {
      throw const CouponRejected(CouponError.notFound);
    }
    final base = ListingCatalog.quote(ListingCatalog.byId(listingId)!, nights);
    // Kupon, ilandaki diğer indirimlerin yerine geçer (birleştirilmez).
    return base.copyWith(
      discount: (PriceCalculator.stay(base) * _couponRate).round(),
      discountKind: DiscountKind.coupon,
    );
  }

  @override
  Future<PriceBreakdown> applyCoupon({
    required String listingId,
    required int nights,
    required String code,
  }) async {
    await _wait();
    return _couponQuote(listingId, nights, code);
  }

  @override
  Future<ThreeDsChallenge> startPayment(PaymentRequest r) async {
    await _wait();
    final listing = ListingCatalog.byId(r.listingId)!;
    final amount = PriceCalculator.total(
      r.couponCode == null
          ? ListingCatalog.quote(listing, r.dates.nights)
          : _couponQuote(r.listingId, r.dates.nights, r.couponCode!),
    );
    final now = _clock();
    final challenge = ThreeDsChallenge(
      id: 'tds-${++_seq}',
      merchant: _merchant,
      amount: amount,
      cardLast4: r.method.last4,
      expiresAt: now.add(_codeTtl),
      holdUntil: now.add(_hold),
    );
    _pending[challenge.id] = (r, challenge);
    return challenge;
  }

  @override
  Future<Booking> confirmPayment(String challengeId, String code) async {
    await _wait();
    final (r, c) = _pending[challengeId]!;
    if (_clock().isAfter(c.expiresAt)) {
      throw PaymentDeclined(
        PaymentDeclineReason.expired,
        holdUntil: c.holdUntil,
      );
    }
    if (code == declineCode) {
      throw PaymentDeclined(
        PaymentDeclineReason.wrongCode,
        holdUntil: c.holdUntil,
      );
    }
    _pending.remove(challengeId);
    final n = ++_seq;
    final id = 'kz-$n';
    final now = _clock();
    final booking = Booking(
      id: id,
      code: 'KZ-${(48000 + n * 37).toRadixString(36).toUpperCase()}',
      listingId: r.listingId,
      dates: r.dates,
      guests: r.guests,
      amountPaid: c.amount,
      status: r.isRequest ? BookingStatus.pending : BookingStatus.confirmed,
      isRequest: r.isRequest,
      cardBrand: r.method.brand,
      cardLast4: r.method.last4,
      requestedAt: r.isRequest ? now : null,
      respondBy: r.isRequest ? now.add(_respondWithin) : null,
      price: r.couponCode == null
          ? ListingCatalog.quote(
              ListingCatalog.byId(r.listingId)!,
              r.dates.nights,
            )
          : _couponQuote(r.listingId, r.dates.nights, r.couponCode!),
      paidAt: r.isRequest ? null : now,
    );
    _bookings[id] = booking;
    _guests[id] = const [
      StayGuest(
        id: 'g1',
        fullName: 'Deniz Yılmaz',
        nationality: Nationality.turkish,
        idLast2: '12',
        isYou: true,
      ),
    ];
    return booking;
  }

  @override
  Future<DateTime> resendPaymentCode(String challengeId) async {
    await _wait();
    final (r, c) = _pending[challengeId]!;
    final expiresAt = _clock().add(_codeTtl);
    _pending[challengeId] = (r, c.copyWith(expiresAt: expiresAt));
    return expiresAt;
  }

  @override
  Future<void> cancelPayment(String challengeId) async {
    _pending.remove(challengeId);
  }

  @override
  Future<Booking> booking(String id) async {
    await _wait();
    return _bookings[id]!;
  }

  @override
  Future<List<Booking>> myBookings() async {
    await _wait();
    return [
      for (final b in _bookings.values)
        if (!_detachedSamples.contains(b.id)) b,
    ];
  }

  @override
  Future<Booking> withdrawRequest(String bookingId) async {
    await _wait();
    final b = _bookings[bookingId]!;
    assert(b.status == BookingStatus.pending);
    return _bookings[bookingId] = b.copyWith(
      status: BookingStatus.cancelled,
      cancelledAt: _clock(),
      // Provizyon kaldırılır; çekilmiş ücret olmadığı için iade yok.
      refundAmount: 0,
    );
  }

  /// Bilgiler girişten bu kadar önce açılır (§10).
  static const _revealBefore = Duration(days: 1);

  static const _guide = HouseGuide(
    lockboxCode: '4829',
    lockboxHint: 'Kapının sağındaki gri kutu',
    wifiName: 'GolEsintisi_5G',
    wifiPassword: 'kozalak2026',
    sections: [
      GuideSection(
        kind: GuideSectionKind.pool,
        title: 'Havuz ve jakuzi',
        items: [
          'Havuz 09:00 – 23:00 arası kullanılabilir.',
          'Jakuzinin ısınması yaklaşık 30 dakika sürer; panel mutfak '
              'kapısının yanında.',
          'Havuz çevresinde cam eşya kullanmayalım.',
        ],
      ),
      GuideSection(
        kind: GuideSectionKind.house,
        title: 'Ev düzeni',
        items: [
          'Çöpler bahçe kapısının yanındaki konteynere.',
          'Mangal yalnızca bahçedeki mangal alanında yakılır.',
          'Sessiz saatler 23:00 – 08:00.',
        ],
      ),
    ],
    checkoutTasks: [
      'Bulaşıkları makineye koy',
      'Çöpleri konteynere bırak',
      'Klimaları ve ısıtıcıları kapat',
      'Anahtarı kutuya geri bırak',
    ],
  );

  BillingInfo _billing = const BillingInfo(
    fullName: 'Deniz Yılmaz',
    address: 'Kadıköy, İstanbul',
    email: 'deniz@ornek.com',
  );

  @override
  Future<TripAccess> tripAccess(String bookingId) async {
    await _wait();
    final b = _bookings[bookingId]!;
    final listing = ListingCatalog.byId(b.listingId)!;
    final checkIn = DateTime(
      b.dates.checkIn.year,
      b.dates.checkIn.month,
      b.dates.checkIn.day,
      14,
    );
    final revealAt = checkIn.subtract(_revealBefore);
    final open =
        b.status == BookingStatus.confirmed && !_clock().isBefore(revealAt);
    final g = _guide;
    return TripAccess(
      revealAt: revealAt,
      areaLabel: '${listing.district}, ${listing.region}',
      latitude: listing.latitude,
      longitude: listing.longitude,
      checkInFrom: '14:00',
      checkOutBy: '11:00',
      sections: g.sections,
      checkoutTasks: g.checkoutTasks,
      addressLines: open
          ? ['${listing.district} Mah. Göl Sokağı No: 12', 'Sapanca / Sakarya']
          : null,
      hostPhone: open ? '+905324184218' : null,
      lockboxCode: open ? g.lockboxCode : null,
      lockboxHint: open ? g.lockboxHint : null,
      wifiName: open ? g.wifiName : null,
      wifiPassword: open ? g.wifiPassword : null,
    );
  }

  @override
  Future<void> reportIssue(String bookingId, IssueReport report) => _wait();

  @override
  Future<Uri> receiptPdf(String bookingId) async {
    await _wait();
    return Uri.https('kozalak.app', '/makbuz/$bookingId.pdf');
  }

  @override
  Future<String> emailReceipt(String bookingId) async {
    await _wait();
    return 'd***@ornek.com';
  }

  @override
  Future<BillingInfo> billingInfo() async {
    await _wait();
    return _billing;
  }

  @override
  Future<BillingInfo> saveBillingInfo(BillingInput input) async {
    await _wait();
    final t = input.tckn;
    return _billing = input.info.copyWith(
      tcknLast2: t == null || t.isEmpty
          ? input.info.tcknLast2
          : t.substring(t.length - 2),
    );
  }

  /// Ücretsiz iptal süresinden sonra konaklama tutarının yarısı kesilir;
  /// temizlik ve hizmet bedeli iade edilir. Oranlar backend'e aittir.
  static const _lateDeductionRate = 0.5;

  @override
  Future<CancellationQuote> cancellationQuote(String bookingId) async {
    await _wait();
    final b = _bookings[bookingId]!;
    final freeUntil = DateTime(
      b.dates.checkIn.year,
      b.dates.checkIn.month,
      b.dates.checkIn.day,
      14,
    ).subtract(const Duration(hours: 24));
    final late = _clock().isAfter(freeUntil);
    final stay = b.price == null
        ? b.amountPaid
        : PriceCalculator.stay(b.price!);
    final deduction = late ? (stay * _lateDeductionRate).round() : 0;
    return CancellationQuote(
      paid: b.amountPaid,
      deduction: deduction,
      refund: b.amountPaid - deduction,
      freeUntil: freeUntil,
    );
  }

  @override
  Future<Booking> cancelBooking(String bookingId, CancelReason reason) async {
    final q = await cancellationQuote(bookingId);
    return _bookings[bookingId] = _bookings[bookingId]!.copyWith(
      status: BookingStatus.cancelled,
      cancelledAt: _clock(),
      refundAmount: q.refund,
    );
  }

  @override
  Future<Booking> submitReview(String bookingId, ReviewInput review) async {
    await _wait();
    return _bookings[bookingId] = _bookings[bookingId]!.copyWith(
      myRating: review.overall.toDouble(),
    );
  }

  @override
  Future<List<ListingOffer>> similarAvailable(String bookingId) async {
    await _wait();
    final b = _bookings[bookingId]!;
    return [
      for (final l in ListingCatalog.all)
        if (l.instantBook && l.id != b.listingId)
          ListingCatalog.offer(l, b.dates.nights),
    ].take(2).toList();
  }

  @override
  Future<StayGuestList> stayGuests(String bookingId) async {
    await _wait();
    return _list(bookingId);
  }

  @override
  Future<StayGuestList> addStayGuest(
    String bookingId,
    StayGuestInput input,
  ) async {
    await _wait();
    final list = _guests[bookingId]!;
    _guests[bookingId] = [
      ...list,
      StayGuest(
        id: 'g${list.length + 1}',
        fullName: input.fullName,
        nationality: input.nationality,
        idLast2: input.idNumber.substring(input.idNumber.length - 2),
      ),
    ];
    return _list(bookingId);
  }

  StayGuestList _list(String bookingId) {
    final b = _bookings[bookingId]!;
    return StayGuestList(
      guests: _guests[bookingId]!,
      requiredCount: b.guests.total,
      checkIn: b.dates.checkIn,
    );
  }
}
