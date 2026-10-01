import 'package:flutter/widgets.dart';

/// İçeriği [maxWidth] ile sınırlayıp yatayda ortalar.
class KzMaxWidth extends StatelessWidget {
  const KzMaxWidth({super.key, required this.maxWidth, required this.child});

  final double maxWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (maxWidth == double.infinity) return child;
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
