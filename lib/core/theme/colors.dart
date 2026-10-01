import 'package:flutter/material.dart';

/// Figma `Kozalak / Renk` koleksiyonu. Hex değerleri yalnızca burada yaşar.
///
/// [ThemeExtension] olarak kurulu; karanlık tema eklendiğinde `KzColors.dark`
/// tanımlanıp `ThemeData.extensions` üzerinden verilir. Ekranlarda renklere
/// `context.kz` ile erişilir.
@immutable
class KzColors extends ThemeExtension<KzColors> {
  const KzColors({
    required this.bg,
    required this.surface,
    required this.sand,
    required this.line,
    required this.ink,
    required this.ink2,
    required this.forest,
    required this.forestSoft,
    required this.apricot,
    required this.apricotSoft,
    required this.apricotText,
    required this.pool,
    required this.poolSoft,
    required this.poolText,
    required this.star,
    required this.onForest,
    required this.placeholder,
  });

  /// Ekran arka planı (sıcak krem).
  final Color bg;

  /// Kart, input, alt bar.
  final Color surface;

  /// İkincil yüzey, segment arka planı, ikon kutuları.
  final Color sand;

  /// Kenarlık, ayırıcı.
  final Color line;

  /// Ana metin.
  final Color ink;

  /// İkincil metin (AA kontrastlı).
  final Color ink2;

  /// Marka rengi, birincil buton, seçili durum.
  final Color forest;

  /// Seçili kart/chip zemini.
  final Color forestSoft;

  /// Vurgu (rozet, kalp, uyarı ikonu). Metin rengi olarak kullanılmaz.
  final Color apricot;

  /// Uyarı/bilgi kutusu zemini.
  final Color apricotSoft;

  /// apricot tonlu metin (AA kontrastlı).
  final Color apricotText;

  /// Havuz/su vurgusu. Metin rengi olarak kullanılmaz.
  final Color pool;

  /// Havuz bilgi kutuları.
  final Color poolSoft;

  /// pool tonlu metin (AA kontrastlı).
  final Color poolText;

  /// Puan yıldızı.
  final Color star;

  /// forest / ink zemin üzerindeki metin ve ikon.
  final Color onForest;

  /// Boş input yer tutucu metni ("GG / AA / YYYY"). Figma: #A9B0AC.
  /// Yalnızca yer tutucu içindir; içerik metni için kullanılmaz.
  final Color placeholder;

  static const light = KzColors(
    bg: Color(0xFFFBF7F0),
    surface: Color(0xFFFFFFFF),
    sand: Color(0xFFF3ECE0),
    line: Color(0xFFEAE2D4),
    ink: Color(0xFF1B2420),
    ink2: Color(0xFF5E6762),
    forest: Color(0xFF1E4D3B),
    forestSoft: Color(0xFFDDEBE2),
    apricot: Color(0xFFF2895C),
    apricotSoft: Color(0xFFFDE8DC),
    apricotText: Color(0xFFA84A24),
    pool: Color(0xFF2F9BB8),
    poolSoft: Color(0xFFDCF0F5),
    poolText: Color(0xFF1F6F85),
    star: Color(0xFFF4B63F),
    onForest: Color(0xFFFFFFFF),
    placeholder: Color(0xFFA9B0AC),
  );

  /// Karartma katmanı: `ink` %40–50 opaklık.
  Color get scrim => ink.withValues(alpha: 0.45);

  @override
  KzColors copyWith({
    Color? bg,
    Color? surface,
    Color? sand,
    Color? line,
    Color? ink,
    Color? ink2,
    Color? forest,
    Color? forestSoft,
    Color? apricot,
    Color? apricotSoft,
    Color? apricotText,
    Color? pool,
    Color? poolSoft,
    Color? poolText,
    Color? star,
    Color? onForest,
    Color? placeholder,
  }) {
    return KzColors(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      sand: sand ?? this.sand,
      line: line ?? this.line,
      ink: ink ?? this.ink,
      ink2: ink2 ?? this.ink2,
      forest: forest ?? this.forest,
      forestSoft: forestSoft ?? this.forestSoft,
      apricot: apricot ?? this.apricot,
      apricotSoft: apricotSoft ?? this.apricotSoft,
      apricotText: apricotText ?? this.apricotText,
      pool: pool ?? this.pool,
      poolSoft: poolSoft ?? this.poolSoft,
      poolText: poolText ?? this.poolText,
      star: star ?? this.star,
      onForest: onForest ?? this.onForest,
      placeholder: placeholder ?? this.placeholder,
    );
  }

  @override
  KzColors lerp(ThemeExtension<KzColors>? other, double t) {
    if (other is! KzColors) return this;
    return KzColors(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      sand: Color.lerp(sand, other.sand, t)!,
      line: Color.lerp(line, other.line, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      ink2: Color.lerp(ink2, other.ink2, t)!,
      forest: Color.lerp(forest, other.forest, t)!,
      forestSoft: Color.lerp(forestSoft, other.forestSoft, t)!,
      apricot: Color.lerp(apricot, other.apricot, t)!,
      apricotSoft: Color.lerp(apricotSoft, other.apricotSoft, t)!,
      apricotText: Color.lerp(apricotText, other.apricotText, t)!,
      pool: Color.lerp(pool, other.pool, t)!,
      poolSoft: Color.lerp(poolSoft, other.poolSoft, t)!,
      poolText: Color.lerp(poolText, other.poolText, t)!,
      star: Color.lerp(star, other.star, t)!,
      onForest: Color.lerp(onForest, other.onForest, t)!,
      placeholder: Color.lerp(placeholder, other.placeholder, t)!,
    );
  }
}

extension KzColorsContext on BuildContext {
  /// Aktif temanın Kozalak renkleri.
  KzColors get kz => Theme.of(this).extension<KzColors>() ?? KzColors.light;
}
