import 'package:flutter/widgets.dart';

/// Tüm gölgeler aynı yeşilimsi koyu tondadır (Figma r0.10 g0.20 b0.15).
/// Saf siyah gölge yasak; spread her zaman 0.
const _shadowBase = Color.fromRGBO(26, 51, 38, 1);

BoxShadow kzShadow(double y, double blur, double a) => BoxShadow(
  color: _shadowBase.withValues(alpha: a),
  offset: Offset(0, y),
  blurRadius: blur,
);

abstract final class KzShadows {
  /// Seçili segment, ince kart.
  static final soft = [kzShadow(8, 24, 0.06)];

  /// Yuvarlak üst butonlar (geri/kapat), kartlar.
  static final card = [kzShadow(8, 24, 0.08)];

  /// Görsel üstü butonlar, öne çıkan kart.
  static final raised = [kzShadow(8, 24, 0.12)];

  /// Tab bar, harita kartı, yüzen öğeler.
  static final floating = [kzShadow(8, 24, 0.16)];

  /// Harita pini, modal üstü öğeler, birincil yuvarlak aksiyonlar.
  static final strong = [kzShadow(10, 28, 0.18)];

  /// Ekran altı sabit aksiyon barı (yukarı doğru).
  static final bottomBar = [kzShadow(-6, 24, 0.08)];
}
