import 'package:flutter/widgets.dart';

import '../theme/tokens.dart';

/// Sand tonlu shimmer iskelet. Animasyonlar kapalıysa düz sand gösterir.
class KzSkeleton extends StatefulWidget {
  const KzSkeleton({super.key, this.borderRadius, this.width, this.height});

  final BorderRadius? borderRadius;
  final double? width;
  final double? height;

  @override
  State<KzSkeleton> createState() => _KzSkeletonState();
}

class _KzSkeletonState extends State<KzSkeleton>
    with SingleTickerProviderStateMixin {
  static const _period = Duration(milliseconds: 1300);
  static const double _highlightMix = 0.55;

  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: _period,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _c.stop();
    } else if (!_c.isAnimating) {
      _c.repeat();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final highlight = Color.lerp(kz.sand, kz.surface, _highlightMix)!;
    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          // -1 → 2 aralığında kayan parlama bandı.
          final t = _c.value * 3 - 1;
          return Container(
            width: widget.width ?? double.infinity,
            height: widget.height ?? double.infinity,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              gradient: LinearGradient(
                begin: Alignment(t - 1, 0),
                end: Alignment(t + 1, 0),
                colors: [kz.sand, highlight, kz.sand],
              ),
            ),
          );
        },
      ),
    );
  }
}
