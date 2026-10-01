import 'package:flutter/widgets.dart';

import '../theme/spacing.dart';

enum KzWindowSize { compact, medium, expanded }

abstract final class KzBreakpoints {
  static const double medium = 600;
  static const double expanded = 840;

  /// Bu genişliğin altındaki telefonlarda kenar boşluğu 16'ya iner.
  static const double narrowPhone = 360;

  /// medium sınıfında içerik, expanded sınıfında bottom sheet genişliği.
  static const double mediumContent = 560;

  /// expanded sınıfında form genişliği.
  static const double formContent = 600;

  static KzWindowSize of(double width) {
    if (width >= expanded) return KzWindowSize.expanded;
    if (width >= medium) return KzWindowSize.medium;
    return KzWindowSize.compact;
  }
}

extension KzResponsiveContext on BuildContext {
  KzWindowSize get windowSize =>
      KzBreakpoints.of(MediaQuery.sizeOf(this).width);

  /// Ekran yatay kenar boşluğu.
  double get screenGutter =>
      MediaQuery.sizeOf(this).width <= KzBreakpoints.narrowPhone
      ? KzSpace.screenNarrow
      : KzSpace.screen;
}

extension KzWindowSizeX on KzWindowSize {
  /// Liste/grid kolon sayısı (§6.2).
  int get columns => switch (this) {
    KzWindowSize.compact => 1,
    KzWindowSize.medium => 2,
    KzWindowSize.expanded => 3,
  };

  /// İçeriğin ortalanacağı azami genişlik; compact'ta sınırsız.
  double get contentMaxWidth => switch (this) {
    KzWindowSize.compact => double.infinity,
    KzWindowSize.medium => KzBreakpoints.mediumContent,
    KzWindowSize.expanded => double.infinity,
  };
}
