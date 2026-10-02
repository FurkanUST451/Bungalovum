import 'package:flutter/widgets.dart';

abstract final class KzMotion {
  static const micro = Duration(milliseconds: 150);
  static const toggle = Duration(milliseconds: 180);
  static const transition = Duration(milliseconds: 280);
  static const sheet = Duration(milliseconds: 350);

  static const Curve enter = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;

  /// Basılı durum ölçeği (KzButton ve tüm dokunulabilirler).
  static const double pressedScale = 0.97;
  static const double pressedOpacity = 0.85;

  /// Kaydet kalbinin "pop" tepe ölçeği.
  static const double popScale = 1.2;

  /// `MediaQuery.disableAnimations` açıkken süre sıfırlanır.
  static Duration of(BuildContext context, Duration d) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : d;
}

/// Opaklık düzeyleri.
abstract final class KzOpacity {
  /// Pasif bileşen (buton, satır).
  static const double disabled = 0.4;

  /// Soluk ikon/öğe (dahil olmayan olanak).
  static const double muted = 0.5;

  /// İllüstrasyonlarda hafif renk katmanı (konum halkası).
  static const double tint = 0.12;

  /// İllüstrasyonlarda belirgin renk katmanı (tepe).
  static const double wash = 0.35;
}
