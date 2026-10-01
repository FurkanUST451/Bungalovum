import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';

/// Figma sayaç (+/−): 40 çaplı butonlar; sınırda buton devre dışı.
class KzCounter extends StatelessWidget {
  const KzCounter({
    super.key,
    required this.value,
    required this.onChanged,
    required this.decreaseLabel,
    required this.increaseLabel,
    this.min = 0,
    this.max = 99,
    this.enabled = true,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final String decreaseLabel;
  final String increaseLabel;
  final int min;
  final int max;
  final bool enabled;

  static const double _valueWidth = 24;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final canDec = enabled && value > min;
    final canInc = enabled && value < max;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepButton(
          icon: KzIcons.minus,
          enabled: canDec,
          label: decreaseLabel,
          onPressed: () => onChanged(value - 1),
        ),
        SizedBox(
          width: _valueWidth,
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: KzText.title.copyWith(
              color: enabled ? kz.ink : kz.placeholder,
            ),
          ),
        ),
        _StepButton(
          icon: KzIcons.plus,
          enabled: canInc,
          label: increaseLabel,
          onPressed: () => onChanged(value + 1),
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.enabled,
    required this.label,
    required this.onPressed,
  });

  final KzIcons icon;
  final bool enabled;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return KzPressable(
      onPressed: enabled ? onPressed : null,
      semanticLabel: label,
      child: Container(
        width: KzSize.circleSm,
        height: KzSize.circleSm,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kz.surface,
          shape: BoxShape.circle,
          border: Border.all(color: kz.line),
        ),
        child: KzIcon(
          icon,
          size: KzSpace.s16,
          color: enabled ? kz.ink : kz.line,
        ),
      ),
    );
  }
}
