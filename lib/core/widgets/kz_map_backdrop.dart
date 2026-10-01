import 'package:flutter/widgets.dart';

import '../theme/tokens.dart';

/// Sade harita zemini (göl + yollar). Harita SDK'sı (paket onayı bekliyor)
/// eklendiğinde bu bileşenin yerini gerçek harita alır; pinler ve kartlar
/// aynı kalır.
class KzMapBackdrop extends StatelessWidget {
  const KzMapBackdrop({super.key, this.lakeLabel});

  /// Göl üzerine yazılan ad ("Sapanca Gölü").
  final String? lakeLabel;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _Backdrop(
            land: kz.forestSoft,
            water: kz.poolSoft,
            road: kz.surface,
          ),
        ),
        if (lakeLabel != null)
          FractionallySizedBox(
            alignment: Alignment.topLeft,
            widthFactor: 1,
            heightFactor: _labelTop,
            child: Align(
              alignment: const Alignment(-0.55, 1),
              child: Text(
                lakeLabel!,
                style: KzText.label.copyWith(
                  color: kz.poolText,
                  fontWeight: KzText.extraBold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  static const double _labelTop = 0.2;
}

class _Backdrop extends CustomPainter {
  _Backdrop({required this.land, required this.water, required this.road});

  final Color land;
  final Color water;
  final Color road;

  static const double _roadWidth = 7;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = land);
    final w = size.width;
    final h = size.height;
    final lake = Paint()..color = water;
    canvas.drawOval(
      Rect.fromLTWH(-w * 0.2, -h * 0.07, w * 1.18, h * 0.36),
      lake,
    );
    canvas.drawOval(Rect.fromLTWH(w * 0.6, h * 0.16, w * 0.62, h * 0.2), lake);
    final p = Paint()
      ..color = road
      ..strokeWidth = _roadWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(-w * 0.05, h * 0.5), Offset(w * 1.05, h * 0.44), p);
    canvas.drawLine(Offset(w * 0.4, h * 0.39), Offset(w * 0.5, h * 1.05), p);
  }

  @override
  bool shouldRepaint(_Backdrop old) =>
      old.land != land || old.water != water || old.road != road;
}
