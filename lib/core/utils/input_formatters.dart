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
