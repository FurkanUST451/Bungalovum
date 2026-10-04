import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../theme/tokens.dart';

/// Bungalovum dokunma geri bildirimi: ripple yerine hafif ölçek + opaklık.
///
/// [minTouchSize] ile görsel öğe küçük olsa bile dokunma alanı en az 44×44
/// olur. [haptic] birincil aksiyonlarda `lightImpact` tetikler.
class KzPressable extends StatefulWidget {
  const KzPressable({
    super.key,
    required this.child,
    required this.onPressed,
    this.semanticLabel,
    this.selected,
    this.haptic = false,
    this.minTouchSize = KzSize.minTouch,
    this.pressedScale = KzMotion.pressedScale,
    this.excludeChildSemantics = true,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final String? semanticLabel;
  final bool? selected;
  final bool haptic;
  final double minTouchSize;
  final double pressedScale;

  /// false ise içerideki etkileşimli öğeler (ör. kart üstü kalp) erişilebilir
  /// kalır; [semanticLabel] yine de bu öğenin etiketi olur.
  final bool excludeChildSemantics;

  @override
  State<KzPressable> createState() => _KzPressableState();
}

class _KzPressableState extends State<KzPressable> {
  bool _pressed = false;

  void _set(bool v) {
    if (_pressed != v) setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    final duration = KzMotion.of(context, KzMotion.micro);
    return Semantics(
      container: true,
      button: true,
      enabled: enabled,
      selected: widget.selected,
      label: widget.semanticLabel,
      excludeSemantics:
          widget.excludeChildSemantics && widget.semanticLabel != null,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: enabled ? (_) => _set(true) : null,
        onTapUp: enabled ? (_) => _set(false) : null,
        onTapCancel: enabled ? () => _set(false) : null,
        onTap: enabled
            ? () {
                if (widget.haptic) HapticFeedback.lightImpact();
                widget.onPressed!();
              }
            : null,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: widget.minTouchSize,
            minHeight: widget.minTouchSize,
          ),
          child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: AnimatedScale(
              scale: _pressed ? widget.pressedScale : 1,
              duration: duration,
              curve: KzMotion.enter,
              child: AnimatedOpacity(
                opacity: _pressed ? KzMotion.pressedOpacity : 1,
                duration: duration,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
