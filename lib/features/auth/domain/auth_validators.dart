/// Form doğrulama kuralları. UI yalnızca sonucu gösterir.
abstract final class AuthValidators {
  static const int minPasswordLength = 8;
  static const int otpLength = 6;
  static const int minAge = 18;

  /// TR cep numarası: 5 ile başlayan 10 hane (ülke kodu hariç).
  static const int phoneDigits = 10;

  static final _email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');
  static final _upper = RegExp(r'[A-ZÇĞİÖŞÜ]');
  static final _digit = RegExp(r'\d');
  static final _special = RegExp(r'[^A-Za-z0-9ÇĞİÖŞÜçğıöşü\s]');

  static bool isEmail(String v) => _email.hasMatch(v.trim());

  /// Giriş için yeterli şifre (uzunluk).
  static bool isPasswordLongEnough(String v) => v.length >= minPasswordLength;

  /// Kayıt kuralı: en az 8 karakter ve 1 rakam.
  static bool isValidNewPassword(String v) =>
      isPasswordLongEnough(v) && _digit.hasMatch(v);

  static bool isName(String v) => v.trim().length >= 2;

  /// Sadece rakamlar ("532 418 42 18" → "5324184218").
  static String phoneDigitsOf(String v) {
    var d = v.replaceAll(RegExp(r'\D'), '');
    if (d.startsWith('90') && d.length > phoneDigits) d = d.substring(2);
    if (d.startsWith('0')) d = d.substring(1);
    return d;
  }

  static bool isTrMobile(String v) {
    final d = phoneDigitsOf(v);
    return d.length == phoneDigits && d.startsWith('5');
  }

  static bool isOtp(String v) =>
      v.length == otpLength && RegExp(r'^\d+$').hasMatch(v);

  /// "GG / AA / YYYY" → tarih; geçersizse null.
  static DateTime? parseBirthDate(String v) {
    final d = v.replaceAll(RegExp(r'\D'), '');
    if (d.length != 8) return null;
    final day = int.parse(d.substring(0, 2));
    final month = int.parse(d.substring(2, 4));
    final year = int.parse(d.substring(4));
    final date = DateTime(year, month, day);
    if (date.day != day || date.month != month || date.year != year) {
      return null;
    }
    return date;
  }

  static bool isAdult(DateTime birth, DateTime today) {
    final adultDay = DateTime(birth.year + minAge, birth.month, birth.day);
    return !adultDay.isAfter(today);
  }
}

/// Yeni şifre kuralları (Yeni Şifre ekranındaki liste).
enum PasswordRule {
  minLength,
  uppercase,
  digit,
  special;

  bool isMet(String v) => switch (this) {
    minLength => v.length >= AuthValidators.minPasswordLength,
    uppercase => AuthValidators._upper.hasMatch(v),
    digit => AuthValidators._digit.hasMatch(v),
    special => AuthValidators._special.hasMatch(v),
  };
}

enum PasswordStrength {
  empty,
  weak,
  medium,
  strong;

  static PasswordStrength of(String v) {
    if (v.isEmpty) return empty;
    final met = PasswordRule.values.where((r) => r.isMet(v)).length;
    if (met == PasswordRule.values.length) return strong;
    if (met >= 2) return medium;
    return weak;
  }
}
