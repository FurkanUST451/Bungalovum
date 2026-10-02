import 'package:flutter/services.dart';

import 'formatters.dart';

/// TR cep numarası girişi: "532 418 42 18" (en fazla 10 hane).
class TrPhoneInputFormatter extends TextInputFormatter {
  static const int _maxDigits = 10;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > _maxDigits) digits = digits.substring(0, _maxDigits);
    final text = KzFormat.phone(digits);
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

/// Tarih girişi: "12 / 05 / 1994".
class BirthDateInputFormatter extends TextInputFormatter {
  static const int _maxDigits = 8;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    // Silmede ayraç silindiyse bir haneyi de sil.
    final deleting = newValue.text.length < oldValue.text.length;
    final oldDigits = oldValue.text.replaceAll(RegExp(r'\D'), '');
    if (deleting && digits.length == oldDigits.length && digits.isNotEmpty) {
      digits = digits.substring(0, digits.length - 1);
    }
    if (digits.length > _maxDigits) digits = digits.substring(0, _maxDigits);
    final b = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i == 2 || i == 4) b.write(' / ');
      b.write(digits[i]);
    }
    final text = b.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

/// Kart numarası: 4'lü gruplar, aralarda iki boşluk (en fazla 16 hane).
class CardNumberInputFormatter extends TextInputFormatter {
  static const int _maxDigits = 16;
  static const String _gap = '  ';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > _maxDigits) digits = digits.substring(0, _maxDigits);
    final b = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) b.write(_gap);
      b.write(digits[i]);
    }
    final text = b.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

/// Kart son kullanma: "12 / 28".
class CardExpiryInputFormatter extends TextInputFormatter {
  static const int _maxDigits = 4;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final deleting = newValue.text.length < oldValue.text.length;
    final oldDigits = oldValue.text.replaceAll(RegExp(r'\D'), '');
    if (deleting && digits.length == oldDigits.length && digits.isNotEmpty) {
      digits = digits.substring(0, digits.length - 1);
    }
    if (digits.length > _maxDigits) digits = digits.substring(0, _maxDigits);
    final text = digits.length > 2
        ? '${digits.substring(0, 2)} / ${digits.substring(2)}'
        : digits;
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

/// TR IBAN: "TR12 0006 4000 …" — büyük harf, 4'lü gruplar, en fazla 26
/// karakter. Kullanıcı "TR" yazmadan rakam girerse ön ek eklenir.
class IbanInputFormatter extends TextInputFormatter {
  static const int _maxChars = 26;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var raw = newValue.text.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
    final digits = raw
        .replaceAll(RegExp(r'^[A-Z]*'), '')
        .replaceAll(RegExp(r'\D'), '');
    raw = raw.isEmpty ? '' : 'TR$digits';
    if (raw.length > _maxChars) raw = raw.substring(0, _maxChars);
    final b = StringBuffer();
    for (var i = 0; i < raw.length; i++) {
      if (i > 0 && i % 4 == 0) b.write(' ');
      b.write(raw[i]);
    }
    final text = b.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
