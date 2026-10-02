import '../../booking/data/mock_booking_repository.dart';
import '../../booking/domain/payment.dart';
import '../domain/wallet_models.dart';
import 'wallet_repository.dart';

class MockWalletRepository implements WalletRepository {
  MockWalletRepository({
    this.latency = const Duration(milliseconds: 250),
    DateTime Function()? clock,
    List<PaymentCard>? cards,
  }) : _clock = clock ?? DateTime.now,
       _cards = cards ?? sampleCards;

  final Duration latency;
  final DateTime Function() _clock;

  static const sampleCards = [
    PaymentCard(
      id: 'card-visa',
      brand: CardBrand.visa,
      last4: '4242',
      expMonth: 12,
      expYear: 28,
      isDefault: true,
    ),
    PaymentCard(
      id: 'card-mc',
      brand: CardBrand.mastercard,
      last4: '8812',
      expMonth: 3,
      expYear: 27,
    ),
  ];

  List<PaymentCard> _cards;
  final _coupons = <Coupon>[];
  int _seq = 0;

  Future<void> _wait() => Future<void>.delayed(latency);

  @override
  Future<List<PaymentCard>> cards() async {
    await _wait();
    return _cards;
  }

  @override
  Future<List<PaymentCard>> addCard(NewCardInput input) async {
    await _wait();
    final card = PaymentCard(
      id: 'card-${++_seq}',
      brand: CardValidators.brandOf(input.number),
      last4: input.last4,
      expMonth: input.expMonth,
      expYear: input.expYear,
      isDefault: _cards.isEmpty,
    );
    return _cards = [..._cards, card];
  }

  @override
  Future<List<PaymentCard>> removeCard(String cardId) async {
    await _wait();
    final removed = _cards.firstWhere((c) => c.id == cardId);
    final rest = [
      for (final c in _cards)
        if (c.id != cardId) c,
    ];
    // Varsayılan kart silinirse sıradaki varsayılan olur.
    if (removed.isDefault && rest.isNotEmpty) {
      rest[0] = rest[0].copyWith(isDefault: true);
    }
    return _cards = rest;
  }

  @override
  Future<List<PaymentCard>> setDefaultCard(String cardId) async {
    await _wait();
    return _cards = [
      for (final c in _cards) c.copyWith(isDefault: c.id == cardId),
    ];
  }

  @override
  Future<List<Coupon>> coupons() async {
    await _wait();
    return List.unmodifiable(_coupons);
  }

  @override
  Future<List<Coupon>> redeemCoupon(String code) async {
    await _wait();
    final normalized = code.trim().toUpperCase();
    if (normalized == MockBookingRepository.expiredCoupon) {
      throw const CouponRejected(CouponError.expired);
    }
    if (normalized != MockBookingRepository.sampleCoupon) {
      throw const CouponRejected(CouponError.notFound);
    }
    if (_coupons.any((c) => c.code == normalized)) {
      throw const CouponRejected(CouponError.alreadyAdded);
    }
    final now = _clock();
    _coupons.add(
      Coupon(
        code: normalized,
        kind: CouponKind.percent,
        value: 10,
        expiresAt: DateTime(now.year, 12, 31, 23, 59),
      ),
    );
    return List.unmodifiable(_coupons);
  }
}
