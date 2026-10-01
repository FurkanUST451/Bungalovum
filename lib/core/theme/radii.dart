import 'package:flutter/widgets.dart';

/// Figma `Kozalak / Ölçü` köşe yarıçapları + ekranlarda yoğun kullanılan ara
/// değerler. Keskin köşe (0) yalnızca tam ekran görsellerde.
abstract final class KzRadii {
  static const double xs = 8;
  static const double sm = 12;
  static const double icon = 15;
  static const double tile = 18;
  static const double md = 20;
  static const double field = 22;
  static const double card = 26;
  static const double lg = 28;
  static const double hero = 30;
  static const double xl = 36;
  static const double pill = 999;

  /// Sayfa noktası, ilerleme çubuğu gibi 6 px yüksekliğindeki öğeler.
  static const double hairline = 3;

  static BorderRadius all(double r) => BorderRadius.all(Radius.circular(r));
  static BorderRadius top(double r) =>
      BorderRadius.vertical(top: Radius.circular(r));
}
