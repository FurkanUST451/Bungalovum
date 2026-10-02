import 'package:flutter/widgets.dart';

import '../theme/tokens.dart';

/// Sihirbaz ilerleme çubuğu: 6 yükseklik, radius 3, line zemin / forest
/// dolgu, animasyonlu (§7).
class KzStepProgress extends StatelessWidget {
  const KzStepProgress({super.key, required this.value, this.semanticLabel});

  /// 0–1 arası.
  final double value;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final radius = KzRadii.all(KzSize.strengthBar / 2);
    return Semantics(
      label: semanticLabel,
      value: '${(value * 100).round()}%',
      child: Container(
        height: KzSize.strengthBar,
        decoration: BoxDecoration(color: kz.line, borderRadius: radius),
        alignment: AlignmentDirectional.centerStart,
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: value.clamp(0, 1)),
          duration: KzMotion.of(context, KzMotion.transition),
          curve: KzMotion.enter,
          builder: (context, v, _) => FractionallySizedBox(
            widthFactor: v,
            child: DecoratedBox(
              decoration: BoxDecoration(color: kz.forest, borderRadius: radius),
              child: const SizedBox.expand(),
            ),
          ),
        ),
      ),
    );
  }
}
