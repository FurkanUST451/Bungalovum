import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

enum CardBrand { visa, mastercard, troy, amex, unknown }

/// Ödeme sağlayıcısında saklanan (tokenize) kart. Uygulama yalnızca son 4
/// haneyi ve son kullanma tarihini bilir.
@freezed
abstract class PaymentCard with _$PaymentCard {
  const factory PaymentCard({
    required String id,
    required CardBrand brand,
    required String last4,
    required int expMonth,

    /// İki haneli yıl: 28.
    required int expYear,
    @Default(false) bool isDefault,
  }) = _PaymentCard;

  factory PaymentCard.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardFromJson(json);
}

/// Yeni kart girişi. KVKK/PCI: yalnızca bellekte tutulur, loglanmaz ve
/// cihaza yazılmaz; üretimde ödeme sağlayıcısının SDK'sı tokenize eder.
class NewCardInput {
  const NewCardInput({
    required this.holder,
    required this.number,
    required this.expMonth,
    required this.expYear,
    required this.cvc,
    this.save = false,
  });

  final String holder;

  /// Yalnızca rakamlar.
  final String number;
  final int expMonth;
  final int expYear;
  final String cvc;
  final bool save;

  String get last4 => number.substring(number.length - 4);

  /// Taksit sorgusu için ilk 6 hane (BIN).
  String get bin => number.substring(0, 6);

  @override
  String toString() => 'NewCardInput(•••• $last4)';
}

/// Ödemede kullanılacak kart: kayıtlı ya da yeni.
sealed class PaymentMethod {
  const PaymentMethod();

  String get last4;

  CardBrand get brand;
}

class SavedCardMethod extends PaymentMethod {
  const SavedCardMethod(this.card);

  final PaymentCard card;

  @override
  String get last4 => card.last4;

  @override
  CardBrand get brand => card.brand;
}

class NewCardMethod extends PaymentMethod {
  const NewCardMethod(this.input);

  final NewCardInput input;

  @override
  String get last4 => input.last4;

  @override
  CardBrand get brand => CardValidators.brandOf(input.number);
}

/// Banka doğrulaması (3D Secure). Üretimde bankanın sayfası WebView'de
/// açılır; mock'ta SMS şifresi uygulama içinde girilir.
@freezed
abstract class ThreeDsChallenge with _$ThreeDsChallenge {
  const factory ThreeDsChallenge({
    required String id,

    /// "Kozalak Seyahat"
    required String merchant,
    required int amount,
    required String cardLast4,
    required DateTime expiresAt,

    /// Tarihlerin misafir için tutulduğu son an.
    required DateTime holdUntil,
    @Default(6) int codeLength,
  }) = _ThreeDsChallenge;
}

enum PaymentDeclineReason { insufficientLimit, wrongCode, expired, other }

/// Banka işlemi onaylamadı; karttan ücret çekilmedi.
class PaymentDeclined implements Exception {
  const PaymentDeclined(this.reason, {required this.holdUntil});

  final PaymentDeclineReason reason;
  final DateTime holdUntil;

  @override
  String toString() => 'PaymentDeclined($reason)';
}

enum CouponError { notFound, expired, notApplicable, alreadyAdded }

/// Kupon uygulanamadı.
class CouponRejected implements Exception {
  const CouponRejected(this.error);

  final CouponError error;

  @override
  String toString() => 'CouponRejected($error)';
}

/// Kart alanı doğrulamaları (biçim kontrolü; asıl onay bankada).
abstract final class CardValidators {
  static String digits(String s) => s.replaceAll(RegExp(r'\D'), '');

  static CardBrand brandOf(String number) {
    final n = digits(number);
    if (n.startsWith('4')) return CardBrand.visa;
    if (n.startsWith('9792')) return CardBrand.troy;
    if (RegExp(r'^3[47]').hasMatch(n)) return CardBrand.amex;
    if (RegExp(r'^(5[1-5]|2[2-7])').hasMatch(n)) return CardBrand.mastercard;
    return CardBrand.unknown;
  }

  /// Luhn kontrolü, 15–16 hane.
  static bool isCardNumber(String number) {
    final n = digits(number);
    if (n.length < 15 || n.length > 16) return false;
    var sum = 0;
    for (var i = 0; i < n.length; i++) {
      var d = int.parse(n[n.length - 1 - i]);
      if (i.isOdd) {
        d *= 2;
        if (d > 9) d -= 9;
      }
      sum += d;
    }
    return sum % 10 == 0;
  }

  /// "AA / YY" → (ay, yıl). Geçersizse null.
  static (int, int)? parseExpiry(String text) {
    final n = digits(text);
    if (n.length != 4) return null;
    final m = int.parse(n.substring(0, 2));
    final y = int.parse(n.substring(2));
    if (m < 1 || m > 12) return null;
    return (m, y);
  }

  /// Son kullanma ayı [today] ayından önce değilse geçerli.
  static bool isExpiryValid(String text, DateTime today) {
    final e = parseExpiry(text);
    if (e == null) return false;
    final (m, y) = e;
    final year = 2000 + y;
    return year > today.year || (year == today.year && m >= today.month);
  }

  static bool isCvc(String text, CardBrand brand) =>
      digits(text).length == (brand == CardBrand.amex ? 4 : 3);
}
