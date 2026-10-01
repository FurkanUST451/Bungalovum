import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';

/// Figma `Anahtar` (Açık / Kapalı): açıkken forest zemin, topuzda check.
class KzSwitch extends StatelessWidget {
  const KzSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.semanticLabel,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String semanticLabel;

  static const double _width = 52;
  static const double _height = 32;
  static const double _knob = 26;
  static const double _pad = 3;
  static const double _check = 13;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final duration = KzMotion.of(context, KzMotion.toggle);
    return Semantics(
      toggled: value,
      child: KzPressable(
        onPressed: onChanged == null ? null : () => onChanged!(!value),
        semanticLabel: semanticLabel,
        pressedScale: 1,
        child: AnimatedContainer(
          duration: duration,
          curve: KzMotion.enter,
          width: _width,
          height: _height,
          padding: const EdgeInsets.all(_pad),
          decoration: BoxDecoration(
            color: value ? kz.forest : kz.line,
            borderRadius: KzRadii.all(KzRadii.pill),
          ),
          child: AnimatedAlign(
            duration: duration,
            curve: KzMotion.enter,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: _knob,
              height: _knob,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kz.surface,
                shape: BoxShape.circle,
              ),
              child: AnimatedOpacity(
                duration: duration,
                opacity: value ? 1 : 0,
                child: KzIcon(KzIcons.check, size: _check, color: kz.forest),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Başlık + açıklama + anahtar satırı.
class KzSwitchRow extends StatelessWidget {
  const KzSwitchRow({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: KzSpace.s12),
      child: Row(
        children: [
          Expanded(
            child: ExcludeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: KzText.bodyStrongSm.copyWith(color: kz.ink),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: KzSpace.s2),
                    Text(
                      subtitle!,
                      style: KzText.caption.copyWith(color: kz.ink2),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(width: KzSpace.s12),
          KzSwitch(value: value, onChanged: onChanged, semanticLabel: title),
        ],
      ),
    );
  }
}
