import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_checkbox.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';

/// Seçim kartı (§7): seçili = forestSoft zemin + 2px forest kenarlık;
/// değil = surface + 1px line.
class KzChoiceCard extends StatelessWidget {
  const KzChoiceCard({
    super.key,
    required this.label,
    required this.selected,
    required this.onPressed,
    this.icon,
    this.vertical = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;
  final KzIcons? icon;

  /// İkon üstte, metin altta (olanak ızgarası).
  final bool vertical;

  static const double _minHeight = 50;
  static const double _verticalHeight = 84;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final fg = selected ? kz.forest : kz.ink;
    final text = Text(
      label,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: vertical ? TextAlign.center : TextAlign.start,
      style: KzText.label.copyWith(color: fg),
    );
    final iconW = icon == null
        ? null
        : KzIcon(icon!, size: KzSize.iconMd, color: fg);
    return Semantics(
      selected: selected,
      child: KzPressable(
        onPressed: onPressed,
        semanticLabel: label,
        child: AnimatedContainer(
          duration: KzMotion.of(context, KzMotion.micro),
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: vertical ? _verticalHeight : _minHeight,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: KzSpace.s14,
            vertical: KzSpace.s10,
          ),
          decoration: BoxDecoration(
            color: selected ? kz.forestSoft : kz.surface,
            borderRadius: KzRadii.all(vertical ? KzRadii.md : KzRadii.field),
            border: Border.all(
              color: selected ? kz.forest : kz.line,
              width: selected ? KzSize.borderFocus : KzSize.border,
            ),
          ),
          child: vertical
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ?iconW,
                    const SizedBox(height: KzSpace.s6),
                    text,
                  ],
                )
              : Row(
                  children: [
                    if (iconW != null) ...[
                      iconW,
                      const SizedBox(width: KzSpace.s10),
                    ],
                    Flexible(child: text),
                  ],
                ),
        ),
      ),
    );
  }
}

/// Radyo kartı (§7): radyo + başlık (+ alt metin), seçim kartı renkleriyle.
class KzRadioCard extends StatelessWidget {
  const KzRadioCard({
    super.key,
    required this.title,
    required this.selected,
    required this.onPressed,
    this.subtitle,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final KzIcons? icon;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      child: KzPressable(
        onPressed: onPressed,
        semanticLabel: [title, ?subtitle].join(', '),
        child: AnimatedContainer(
          duration: KzMotion.of(context, KzMotion.micro),
          padding: const EdgeInsets.all(KzSpace.s16),
          decoration: BoxDecoration(
            color: selected ? kz.forestSoft : kz.surface,
            borderRadius: KzRadii.all(KzRadii.md),
            border: Border.all(
              color: selected ? kz.forest : kz.line,
              width: selected ? KzSize.borderFocus : KzSize.border,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: KzSpace.s2),
                child: KzRadio(value: selected),
              ),
              const SizedBox(width: KzSpace.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (icon != null) ...[
                          KzIcon(icon!, size: KzSize.iconSm, color: kz.ink),
                          const SizedBox(width: KzSpace.s6),
                        ],
                        Flexible(
                          child: Text(
                            title,
                            style: KzText.bodyStrongSm.copyWith(color: kz.ink),
                          ),
                        ),
                      ],
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: KzSpace.s3),
                      Text(
                        subtitle!,
                        style: KzText.caption.copyWith(color: kz.ink2),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
