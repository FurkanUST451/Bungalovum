import 'package:bungalovum/core/data/tr_districts.dart';
import 'package:bungalovum/core/utils/tr_search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('İl/ilçe verisi', () {
    test('81 il ve 973 ilçe', () {
      expect(trDistricts.length, 81);
      expect(trDistricts.values.fold<int>(0, (a, v) => a + v.length), 973);
    });

    test('kaynak tabloyla birebir aynı (sağlama değeri)', () {
      // Kaynak sayfada (Ereğli düzeltmesiyle) hesaplanan değerler:
      // "il:ilçe,ilçe|il:…" metninin uzunluğu ve 31 tabanlı hash'i.
      final all = [
        for (final e in trDistricts.entries) '${e.key}:${e.value.join(',')}',
      ].join('|');
      var h = 0;
      for (final r in all.runes) {
        h = (h * 31 + r) & 0xFFFFFFFF;
      }
      expect(all.length, 8511);
      expect(h, 3596435545);
    });

    test('bir ilde aynı ilçe iki kez yok', () {
      for (final e in trDistricts.entries) {
        expect(e.value.toSet().length, e.value.length, reason: e.key);
      }
    });
  });

  group('Türkçe arama', () {
    final iller = trDistricts.keys;

    test('"i" ile başlayan iller (İ ve I dahil) önce gelir', () {
      final r = TrSearch.filter(iller, 'i');
      expect(r.take(4), ['Iğdır', 'Isparta', 'İstanbul', 'İzmir']);
    });

    test('büyük/küçük harf ve Türkçe karakter farkı önemsiz', () {
      expect(TrSearch.filter(iller, 'İST'), ['İstanbul']);
      expect(TrSearch.filter(iller, 'sanli'), ['Şanlıurfa']);
      expect(TrSearch.filter(iller, 'ÇANAK'), ['Çanakkale']);
    });

    test('başta olmayan eşleşmeler sonra gelir', () {
      expect(TrSearch.filter(iller, 'maraş'), ['Kahramanmaraş']);
      expect(TrSearch.filter(['Sapanca', 'Arsapan'], 'sapan'), [
        'Sapanca',
        'Arsapan',
      ]);
    });

    test('boş sorgu tüm listeyi döner', () {
      expect(TrSearch.filter(iller, '  ').length, 81);
    });
  });
}
