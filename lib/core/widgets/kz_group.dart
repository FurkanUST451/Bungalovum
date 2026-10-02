import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_action_row.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';
import 'kz_screen.dart';

/// Figma "Liste grubu" (Hesabım tarzı): overline başlık + `card` köşeli
/// beyaz kart; satırlar arası ayırıcı ikon hizasından başlar (sol 72).
class KzGroup extends StatelessWidget {
  const KzGroup({
    super.key,
    this.title,
    required this.rows,
    this.inset = dividerInset,
  });

  final String? title;
  final List<Widget> rows;

  /// İkonsuz satırlarda [KzSpace.s16].
  final double inset;

  /// Ayırıcının sol boşluğu: satır iç boşluğu + ikon kutusu + aralık.
  static const double dividerInset = KzSpace.s16 + KzRow.iconBox + KzSpace.s14;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) ...[
          KzOverline(title!),
          const SizedBox(height: KzSpace.s10),
        ],
        Container(
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.card),
            border: Border.all(color: kz.line),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (final (i, row) in rows.indexed) ...[
                if (i > 0)
                  Padding(
                    padding: EdgeInsets.only(left: inset, right: KzSpace.s16),
                    child: Container(height: KzSize.border, color: kz.line),
                  ),
                row,
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// [KzGroup] satırı: 42'lik ikon kutusu + başlık (+ alt metin) + sağda
/// chevron, link ya da anahtar.
class KzRow extends StatelessWidget {
  const KzRow({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.tone = KzIconBoxTone.sand,
    this.trailing,
    this.onPressed,
    this.titleColor,
    this.chevron = true,
    this.semanticLabel,
    this.constrainTrailing = true,
  });

  /// Yoksa satır ikonsuz çizilir (ayırıcı için [KzGroup.inset] 16).
  final KzIcons? icon;
  final String title;
  final String? subtitle;
  final KzIconBoxTone tone;

  /// Chevron yerine (link, anahtar, rozet...).
  final Widget? trailing;
  final VoidCallback? onPressed;
  final Color? titleColor;
  final bool chevron;
  final String? semanticLabel;

  /// false: sabit genişlikli sağ öğe (sayaç) için ekran payı sınırı yok.
  final bool constrainTrailing;

  static const double iconBox = 42;

  /// Sağ öğenin ekran genişliğine göre en fazla payı.
  static const double _trailingShare = 0.3;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final content = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KzSpace.s16,
        vertical: KzSpace.s14,
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            KzIconBox(
              icon: icon!,
              tone: tone,
              size: iconBox,
              iconSize: KzSize.iconMd,
            ),
            const SizedBox(width: KzSpace.s14),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: KzText.bodyStrongSm.copyWith(
                    color: titleColor ?? kz.ink,
                    height: KzText.tightLeading,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: KzSpace.s3),
                  Text(
                    subtitle!,
                    style: KzText.labelMedium.copyWith(color: kz.ink2),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: KzSpace.s10),
            // Uzun link/chip dar ekranda başlığı ezmesin; sarabilsin.
            if (constrainTrailing)
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * _trailingShare,
                ),
                child: trailing,
              )
            else
              trailing!,
          ] else if (chevron && onPressed != null) ...[
            const SizedBox(width: KzSpace.s8),
            KzIcon(KzIcons.chev, size: KzSize.iconSm, color: kz.ink2),
          ],
        ],
      ),
    );
    if (onPressed == null) {
      return Semantics(container: true, child: content);
    }
    return KzPressable(
      onPressed: onPressed,
      semanticLabel:
          semanticLabel ?? (subtitle == null ? title : '$title, $subtitle'),
      pressedScale: 1,
      child: content,
    );
  }
}
