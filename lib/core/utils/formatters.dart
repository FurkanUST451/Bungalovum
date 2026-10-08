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

  /// Sabit basamaklı ölçü (seçici satırları): (1.2, 1) → "1,2", (45, 0) → "45".
  static String fixed(double v, int decimals) => NumberFormat(
    decimals == 0 ? '0' : '0.${'0' * decimals}',
    kzLocale,
  ).format(v);

  static final _time = DateFormat('HH:mm', kzLocale);

  /// "14:32"
  static String time(DateTime d) => _time.format(d);

  static final _monthShort = DateFormat('MMM', kzLocale);

  /// 4 → "Nis"
  static String monthShort(int month) =>
      _monthShort.format(DateTime(2000, month));

  static final _dayMonthTime = DateFormat('d MMM HH:mm', kzLocale);

  /// "5 Kas 14:00"
  static String dayMonthTime(DateTime d) => _dayMonthTime.format(d);

  static final _currencyCents = NumberFormat.currency(
    locale: kzLocale,
    symbol: '₺',
    decimalDigits: 2,
  );

  /// Banka ekranındaki kuruşlu tutar: `₺10.800,00`.
  static String currencyCents(int amount) =>
      _currencyCents.format(amount).replaceAll(' ', '').replaceAll(' ', '');

  /// Geri sayım: `02:45`.
  static String countdown(Duration d) {
    final s = d.isNegative ? 0 : d.inSeconds;
    final mm = (s ~/ 60).toString().padLeft(2, '0');
    final ss = (s % 60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  static final _dayMonthLong = DateFormat('d MMMM', kzLocale);

  /// Bulunma ekiyle gün: "6 Kasım’da", "3 Mart’ta", "1 Eylül’de".
  static String dayMonthLocative(DateTime d) {
    final month = _month.format(d);
    final hard = _endsVoiceless(month);
    final back = _lastVowelIsBack(month);
    return "${_dayMonthLong.format(d)}’${hard ? 't' : 'd'}${back ? 'a' : 'e'}";
  }

  /// Yönelme ekiyle tarih-saat: "5 Kas 14:00’e", "5 Kas 16:00’ya",
  /// "5 Kas 09:30’a". Ek, saatin okunuşundaki son kelimeye göre seçilir.
  static String dayMonthTimeDative(DateTime d) =>
      '${dayMonthTime(d)}’${_dativeOfNumber(d.minute == 0 ? d.hour : d.minute)}';

  /// Yönelme ekiyle saat: "11:00" → "11:00’e", "16:00" → "16:00’ya".
  static String timeDative(String hhmm) {
    final [h, m] = hhmm.split(':').map(int.parse).toList();
    return '$hhmm’${_dativeOfNumber(m == 0 ? h : m)}';
  }

  /// Ayrılma ekiyle tarih-saat: "5 Kas 14:00’ten", "5 Kas 16:00’dan".
  static String dayMonthTimeAblative(DateTime d) =>
      '${dayMonthTime(d)}’${_ablativeOfNumber(d.minute == 0 ? d.hour : d.minute)}';

  static String _ablativeOfNumber(int n) {
    const ones = [
      'dan', 'den', 'den', 'ten', 'ten', 'ten', 'dan', 'den', 'den', 'dan', //
    ];
    const tens = ['dan', 'dan', 'den', 'dan', 'tan', 'den'];
    if (n == 0) return ones[0];
    if (n % 10 != 0) return ones[n % 10];
    return tens[n ~/ 10];
  }

  static const _vowels = 'aeıioöuü';
  static const _backVowels = 'aıou';

  static bool _lastVowelIsBack(String w) {
    final lower = w.toLowerCase();
    for (var i = lower.length - 1; i >= 0; i--) {
      if (_vowels.contains(lower[i])) return _backVowels.contains(lower[i]);
    }
    return false;
  }

  static bool _endsVoiceless(String w) => 'fstkçşhp'.contains(w[w.length - 1]);

  /// Sayının okunuşuna göre yönelme eki: 1 bir→e, 2 iki→ye, 6 altı→ya,
  /// 10 on→a, 20 yirmi→ye, 0 sıfır→a...
  static String _dativeOfNumber(int n) {
    const ones = ['a', 'e', 'ye', 'e', 'e', 'e', 'ya', 'ye', 'e', 'a'];
    const tens = ['a', 'a', 'ye', 'a', 'a', 'ye'];
    if (n == 0) return ones[0];
    if (n % 10 != 0) return ones[n % 10];
    return tens[n ~/ 10];
  }

  static final _dayMonthShort = DateFormat('d MMM', kzLocale);
  static final _weekdayDayMonth = DateFormat('EEE d MMM', kzLocale);

  /// "2 Eyl"
  static String dayMonth(DateTime d) => _dayMonthShort.format(d);

  /// "Cum 6 Kas – Paz 8 Kas"
  static String dateRangeWithWeekday(DateTime start, DateTime end) =>
      '${_weekdayDayMonth.format(start)} – ${_weekdayDayMonth.format(end)}';

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
