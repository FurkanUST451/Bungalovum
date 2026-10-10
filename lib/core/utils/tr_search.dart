/// Türkçe arama: büyük/küçük harf, i/İ/ı/I ve şapka/çengel farklarını yok
/// sayar. "i" yazınca "İstanbul" ve "Iğdır", "sanli" yazınca "Şanlıurfa" çıkar.
abstract final class TrSearch {
  static const _fold = {
    'ı': 'i',
    'ş': 's',
    'ğ': 'g',
    'ü': 'u',
    'ö': 'o',
    'ç': 'c',
    'â': 'a',
    'î': 'i',
    'û': 'u',
  };

  /// Karşılaştırma anahtarı.
  static String key(String s) {
    // toLowerCase "İ"yi "i̇"ye (noktalı) çevirdiği için önce Türkçe eşleme.
    final lower = s
        .trim()
        .replaceAll('İ', 'i')
        .replaceAll('I', 'ı')
        .toLowerCase();
    final b = StringBuffer();
    for (final ch in lower.split('')) {
      b.write(_fold[ch] ?? ch);
    }
    return b.toString();
  }

  /// [query] ile başlayanlar önce, içinde geçenler sonra; sıra korunur.
  /// Boş sorgu tüm listeyi döner.
  static List<String> filter(Iterable<String> items, String query) {
    final q = key(query);
    if (q.isEmpty) return items.toList();
    final starts = <String>[];
    final contains = <String>[];
    for (final item in items) {
      final k = key(item);
      if (k.startsWith(q)) {
        starts.add(item);
      } else if (k.contains(q)) {
        contains.add(item);
      }
    }
    return [...starts, ...contains];
  }
}
