import 'package:flutter/widgets.dart';

/// Plus Jakarta Sans tipografi ölçeği. Stiller renksizdir; renk
/// `copyWith(color: context.kz.…)` ile verilir.
abstract final class KzText {
  static const family = 'PlusJakartaSans';

  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  /// Tek satırlık sıkı metinler (chip, arama hapı) için satır yüksekliği.
  static const double tightLeading = 1.25;

  static TextStyle _s(double size, FontWeight w, double h, [double ls = 0]) =>
      TextStyle(
        fontFamily: family,
        fontSize: size,
        fontWeight: w,
        height: h,
        letterSpacing: size * ls,
        leadingDistribution: TextLeadingDistribution.even,
      );

  /// 40/800 — fiyat vurgusu.
  static final display = _s(40, extraBold, 1.05, -0.03);

  /// 30/800 — tanıtım başlıkları.
  static final h1 = _s(30, extraBold, 1.10, -0.025);

  /// 28/800 — ekran başlığı.
  static final h2 = _s(28, extraBold, 1.15, -0.025);

  /// 26/800 — sihirbaz adım başlığı, Keşfet karşılama başlığı.
  static final h3 = _s(26, extraBold, 1.15, -0.02);

  /// 24/800 — OTP hanesi.
  static final digit = _s(24, extraBold, 1.2);

  /// 22/800 — bölüm büyük başlık.
  static final h4 = _s(22, extraBold, 1.2, -0.01);

  /// 18/800 — üst bar başlığı.
  static final titleLg = _s(18, extraBold, 1.25);

  /// 17/800 — bölüm/kart başlığı.
  static final title = _s(17, extraBold, 1.25);

  /// 15/800 — blok başlığı.
  static final titleSm = _s(15, extraBold, 1.3);

  /// 16/700 — satır başlığı.
  static final bodyStrong = _s(16, bold, 1.4);

  /// 15/700 — küçük satır başlığı.
  static final bodyStrongSm = _s(15, bold, 1.4);

  /// 15/500 — paragraf.
  static final body = _s(15, medium, 1.5);

  /// 14/500 — küçük paragraf.
  static final bodySm = _s(14, medium, 1.45);

  /// 13/700 — link, chip, buton içi küçük.
  static final label = _s(13, bold, 1.3);

  /// 13/600 — ikincil küçük etiket.
  static final labelSemi = _s(13, semiBold, 1.3);

  /// 13/500 — alt başlık açıklaması.
  static final labelMedium = _s(13, medium, 1.4);

  /// 12/500 — alt açıklama.
  static final caption = _s(12, medium, 1.45);

  /// 12/600 — vurgulu alt açıklama.
  static final captionSemi = _s(12, semiBold, 1.45);

  /// 12/700 — rozet/chip metni.
  static final captionBold = _s(12, bold, 1.3);

  /// 12/800 — seçili kategori etiketi.
  static final captionHeavy = _s(12, extraBold, 1.3);

  /// 10/800 — sayı rozeti.
  static final badge = _s(10, extraBold, 1);

  /// 9/600 — takvim günü fiyatı.
  static final nano = _s(9, semiBold, 1.2);

  /// 11/700 — rozet, sayaç.
  static final micro = _s(11, bold, 1.4);

  /// 11/700 sıkı satır — mini chip içi.
  static final microTight = _s(11, bold, tightLeading);

  /// 12/800 +6% — grup başlıkları ("HESAP"). Türkçe büyük harf için
  /// `toUpperCaseTr` kullan.
  static final overline = _s(12, extraBold, 1.3, 0.06);

  /// 17/800 +6% — rezervasyon kodu ("KZ-48K2Q").
  static final code = _s(17, extraBold, 1.25, 0.06);
}
