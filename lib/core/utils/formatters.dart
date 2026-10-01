import 'package:intl/intl.dart';

/// Uygulamanın tek locale'i.
const kzLocale = 'tr_TR';

/// TRY biçimi: `₺4.900`.
abstract final class KzFormat {
  static final _currency = NumberFormat.currency(
    locale: kzLocale,
    symbol: '₺',
    decimalDigits: 0,
  );
  static final _rating = NumberFormat('0.0#', kzLocale);
  static final _day = DateFormat('d', kzLocale);
  static final _dayMonth = DateFormat('d MMM', kzLocale);
  static final _weekday = DateFormat('EEEE', kzLocale);

  /// `₺4.900` — tutar her zaman tam lira (kuruş backend'de yuvarlanır).
  static String currency(int amount) =>
      _currency.format(amount).replaceAll(' ', '').replaceAll(' ', '');

  /// Puan: `4,93`, `5,0`.
  static String rating(double value) => _rating.format(value);

  /// Kısa tarih aralığı: `20 – 22 Kas`, ay değişirse `30 Kas – 2 Ara`.
  static String dateRange(DateTime start, DateTime end) {
    final sameMonth = start.year == end.year && start.month == end.month;
    final left = sameMonth ? _day.format(start) : _dayMonth.format(start);
    return '$left – ${_dayMonth.format(end)}';
  }

  /// Gün adı: `Cumartesi`.
  static String weekday(DateTime date) => _weekday.format(date);

  static final _monthYear = DateFormat('MMMM y', kzLocale);
  static final _month = DateFormat('MMMM', kzLocale);

  /// "Kasım"
  static String monthName(DateTime d) => _month.format(d);
  static final _dayLong = DateFormat('d MMMM EEEE', kzLocale);

  /// "Kasım 2026"
  static String monthYear(DateTime d) => _monthYear.format(d);

  /// "6 Kasım Cuma"
  static String dayLong(DateTime d) => _dayLong.format(d);

  /// Takvim fiyatı: 6100 → "6,1" (bin).
  static String thousands(int amount) =>
      NumberFormat('0.#', kzLocale).format(amount / 1000);

  /// Ondalıklı ölçü: 1.2 → "1,2", 4.0 → "4".
  static String decimal(double v) => NumberFormat('0.#', kzLocale).format(v);

  static final _dayMonthTime = DateFormat('d MMM HH:mm', kzLocale);

  /// "5 Kas 14:00"
  static String dayMonthTime(DateTime d) => _dayMonthTime.format(d);

  static const _mask = '•';

  /// 10 haneli TR cep: "532 418 42 18".
  static String phone(String digits) {
    final b = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i == 3 || i == 6 || i == 8) b.write(' ');
      b.write(digits[i]);
    }
    return b.toString();
  }

  /// "+90 532 ••• •• 18" (KVKK: ekranlarda maskeli gösterim).
  static String maskedPhone(String digits) {
    if (digits.length < 10) return '+90 $digits';
    final m3 = _mask * 3;
    final m2 = _mask * 2;
    return '+90 ${digits.substring(0, 3)} $m3 $m2 ${digits.substring(8)}';
  }

  /// "d***@ornek.com"
  static String maskedEmail(String email) {
    final at = email.indexOf('@');
    if (at < 1) return email;
    return '${email[0]}***${email.substring(at)}';
  }
}

extension KzTurkishCase on String {
  /// Türkçe kurallarıyla büyük harf (`i → İ`, `ı → I`).
  String toUpperCaseTr() =>
      replaceAll('i', 'İ').replaceAll('ı', 'I').toUpperCase();
}
