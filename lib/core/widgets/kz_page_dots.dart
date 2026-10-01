import 'package:flutter/widgets.dart';

import '../theme/tokens.dart';

/// Görsel üstü fotoğraf sayfa göstergesi. Aktif nokta uzar.
class KzPageDots extends StatelessWidget {
  const KzPageDots({
    super.key,
    required this.count,
    required this.index,
    this.maxDots = 5,
  });

  final int count;
  final int index;

  /// Çok fotoğraflı ilanlarda gösterilen en fazla nokta.
  final int maxDots;

  static const double _inactiveAlpha = 0.6;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final n = count.clamp(0, maxDots);
    if (n == 0) return const SizedBox.shrink();
    final active = index.clamp(0, n - 1);
    final duration = KzMotion.of(context, KzMotion.toggle);
    return ExcludeSemantics(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < n; i++) ...[
            if (i > 0) const SizedBox(width: KzSpace.s5),
            AnimatedContainer(
              duration: duration,
              curve: KzMotion.enter,
              width: i == active ? KzSize.dotActive : KzSize.dot,
              height: KzSize.dot,
              decoration: BoxDecoration(
                color: i == active
                    ? kz.surface
                    : kz.surface.withValues(alpha: _inactiveAlpha),
                borderRadius: KzRadii.all(KzRadii.hairline),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
