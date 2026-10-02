import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';

enum KzIconBoxTone { sand, forest, apricot, pool }

/// 40–42'lik yumuşak zeminli ikon kutusu (satır başı).
class KzIconBox extends StatelessWidget {
  const KzIconBox({
    super.key,
    required this.icon,
    this.tone = KzIconBoxTone.sand,
    this.size = KzSize.circleSm,
    this.iconSize = KzSize.iconSm,
  });

  final KzIcons icon;
  final KzIconBoxTone tone;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final (bg, fg) = switch (tone) {
      KzIconBoxTone.sand => (kz.sand, kz.ink),
      KzIconBoxTone.forest => (kz.forestSoft, kz.forest),
      KzIconBoxTone.apricot => (kz.apricotSoft, kz.apricotText),
      KzIconBoxTone.pool => (kz.poolSoft, kz.poolText),
    };
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: KzRadii.all(KzRadii.icon),
      ),
      child: KzIcon(icon, size: iconSize, color: fg),
    );
  }
}

/// İkon kutusu + başlık + alt metin (+ chevron). Kartlı ya da düz.
class KzActionRow extends StatelessWidget {
  const KzActionRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onPressed,
    this.tone = KzIconBoxTone.forest,
    this.card = true,
    this.chevron = true,
    this.trailing,
    this.titleColor,
  });

  final KzIcons icon;
  final String title;

  /// Geri alınamaz aksiyonlarda apricotText ("Rezervasyonu iptal et").
  final Color? titleColor;
  final String? subtitle;
  final VoidCallback? onPressed;
  final KzIconBoxTone tone;

  /// true: surface + line kenarlıklı kart; false: düz satır.
  final bool card;
  final bool chevron;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final content = Row(
      children: [
        KzIconBox(icon: icon, tone: tone),
        const SizedBox(width: KzSpace.s12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: (card ? KzText.label : KzText.bodyStrongSm).copyWith(
                  color: titleColor ?? kz.ink,
                  fontWeight: card ? KzText.extraBold : KzText.bold,
                  fontSize: card
                      ? KzText.bodySm.fontSize
                      : KzText.bodyStrongSm.fontSize,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: KzSpace.s2),
                Text(subtitle!, style: KzText.caption.copyWith(color: kz.ink2)),
              ],
            ],
          ),
        ),
        ?trailing,
        if (chevron && trailing == null) ...[
          const SizedBox(width: KzSpace.s8),
          KzIcon(KzIcons.chev, size: KzSize.iconSm, color: kz.ink2),
        ],
      ],
    );
    final body = card
        ? Container(
            padding: const EdgeInsets.all(KzSpace.s14),
            decoration: BoxDecoration(
              color: kz.surface,
              borderRadius: KzRadii.all(KzRadii.field),
              border: Border.all(color: kz.line),
            ),
            child: content,
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: KzSpace.s8),
            child: content,
          );
    if (onPressed == null) return body;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: subtitle == null ? title : '$title, $subtitle',
      pressedScale: card ? KzMotion.pressedScale : 1,
      child: body,
    );
  }
}
