import 'package:flutter/widgets.dart';

import '../theme/tokens.dart';

/// Kesikli çerçeve (Figma: 1.5px forest, dashed): "Yeni kartla öde",
/// fotoğraf ekle kutuları. Çerçeve içeriğin üstüne çizilir.
class KzDashedBorder extends StatelessWidget {
  const KzDashedBorder({
    super.key,
    required this.child,
    required this.radius,
    this.color,
  });

  final Widget child;
  final double radius;

  /// Varsayılan forest.
  final Color? color;

  static const double _dash = 6;

  @override
  Widget build(BuildContext context) => CustomPaint(
    foregroundPainter: _DashedBorderPainter(
      color: color ?? context.kz.forest,
      radius: radius,
      width: KzSize.borderCheckbox,
      dash: _dash,
    ),
    child: child,
  );
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({
    required this.color,
    required this.radius,
    required this.width,
    required this.dash,
  });

  final Color color;
  final double radius;
  final double width;
  final double dash;

  @override
  void paint(Canvas canvas, Size size) {
    final inset = width / 2;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(inset, inset, size.width - width, size.height - width),
      Radius.circular(radius - inset),
    );
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    for (final metric in (Path()..addRRect(rrect)).computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += dash * 2) {
        canvas.drawPath(metric.extractPath(d, d + dash), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color || old.radius != radius || old.width != width;
}
