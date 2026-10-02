import '../../../l10n/l10n.dart';
import '../../search/domain/search_query.dart';
import '../domain/payment.dart';
import '../domain/price_calculator.dart';

/// "2 yetişkin", "2 yetişkin, 1 çocuk, 1 bebek".
String guestBreakdown(AppLocalizations l, GuestCount g) => [
  l.guestsAdultsCount(g.adults),
  if (g.children > 0) l.guestsChildrenCount(g.children),
  if (g.infants > 0) l.guestsInfantsCount(g.infants),
  if (g.pets > 0) l.guestsPetsCount(g.pets),
].join(', ');

extension DiscountKindLabel on DiscountKind {
  String label(AppLocalizations l) => switch (this) {
    DiscountKind.earlyBooking => l.discountEarlyBooking,
    DiscountKind.lastMinute => l.discountLastMinute,
    DiscountKind.longStay => l.discountLongStay,
    DiscountKind.coupon => l.discountCoupon,
    DiscountKind.special => l.discountSpecial,
  };
}

extension CardBrandLabel on CardBrand {
  String label(AppLocalizations l) => switch (this) {
    CardBrand.visa => l.cardBrandVisa,
    CardBrand.mastercard => l.cardBrandMastercard,
    CardBrand.troy => l.cardBrandTroy,
    CardBrand.amex => l.cardBrandAmex,
    CardBrand.unknown => l.cardBrandUnknown,
  };
}

extension CouponErrorLabel on CouponError {
  String message(AppLocalizations l) => switch (this) {
    CouponError.notFound => l.couponNotFound,
    CouponError.expired => l.couponExpired,
    CouponError.notApplicable => l.couponNotApplicable,
    CouponError.alreadyAdded => l.couponAlreadyAdded,
  };
}

extension PaymentCardLabel on PaymentCard {
  /// "Visa •••• 4242"
  String title(AppLocalizations l) => l.cardMasked(brand.label(l), last4);

  /// "12/28"
  String get expiry =>
      '${expMonth.toString().padLeft(2, '0')}/'
      '${expYear.toString().padLeft(2, '0')}';

  /// "Varsayılan · SKT 12/28" ya da "SKT 03/27".
  String subtitle(AppLocalizations l) =>
      isDefault ? l.cardDefaultExpiry(expiry) : l.cardExpiryShort(expiry);
}

/// "Tek çekim", "3 taksit".
String installmentLabel(AppLocalizations l, int n) =>
    n <= 1 ? l.installmentSingle : l.installmentCount(n);
