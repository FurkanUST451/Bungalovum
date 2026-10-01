import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';

/// Figma `Chip` bileşen seti (Dolu / Açık / Yumuşak / Vurgu) ve ekranlarda
/// görsel üstünde kullanılan türevleri.
enum KzChipVariant {
  /// Dolu: forest zemin, beyaz metin.
  filled,

  /// Açık: surface zemin + line kenarlık.
  outline,

  /// Yumuşak: sand zemin.
  soft,

  /// Vurgu: apricotSoft zemin, apricotText metin.
  accent,

  /// Havuz: poolSoft zemin, poolText metin.
  pool,

  /// Görsel üstü rozet: kenarlıksız surface zemin.
  onImage,

  /// Görsel üstü dikkat rozeti: apricot zemin, ink metin.
  highlight,

  /// Görsel üstü sayaç: ink zemin, beyaz metin.
  dark,

  /// Etkin filtre: forestSoft zemin, forest metin.
  selected,
}

enum KzChipSize {
  /// 13/700, padding 9×13 — filtre ve seçim chip'leri.
  regular,

  /// 12/700, padding 7×12 — görsel üstü rozetler.
  small,

  /// 11/700, padding 5×9 — kart içi olanak etiketleri, sayaç.
  mini,
}

class KzChip extends StatelessWidget {
  const KzChip({
    super.key,
    required this.label,
    this.variant = KzChipVariant.filled,
    this.size = KzChipSize.regular,
    this.icon,
    this.iconColor,
    this.onPressed,
    this.trailingIcon,
    this.semanticLabel,
  });

  /// Etiketten sonra gelen ikon (ör. kaldırmak için X).
  final KzIcons? trailingIcon;

  /// Verilmezse etiket okunur.
  final String? semanticLabel;

  final String label;
  final KzChipVariant variant;
  final KzChipSize size;
  final KzIcons? icon;

  /// Verilmezse metin rengiyle aynıdır.
  final Color? iconColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final (bg, fg, border) = switch (variant) {
      KzChipVariant.filled => (kz.forest, kz.onForest, null),
      KzChipVariant.outline => (kz.surface, kz.ink, kz.line),
      KzChipVariant.soft => (kz.sand, kz.ink, null),
      KzChipVariant.accent => (kz.apricotSoft, kz.apricotText, null),
      KzChipVariant.pool => (kz.poolSoft, kz.poolText, null),
      KzChipVariant.onImage => (kz.surface, kz.ink, null),
      KzChipVariant.highlight => (kz.apricot, kz.ink, null),
      KzChipVariant.dark => (kz.ink, kz.onForest, null),
      KzChipVariant.selected => (kz.forestSoft, kz.forest, null),
    };
    final (padding, style) = switch (size) {
      KzChipSize.regular => (
        const EdgeInsets.symmetric(
          horizontal: KzSpace.s13,
          vertical: KzSpace.s9,
        ),
        KzText.label,
      ),
      KzChipSize.small => (
        const EdgeInsets.symmetric(
          horizontal: KzSpace.s12,
          vertical: KzSpace.s7,
        ),
        KzText.captionBold,
      ),
      KzChipSize.mini => (
        const EdgeInsets.symmetric(
          horizontal: KzSpace.s9,
          vertical: KzSpace.s5,
        ),
        KzText.microTight,
      ),
    };

    final chip = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: KzRadii.all(KzRadii.pill),
        border: border == null ? null : Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            KzIcon(icon!, size: KzSize.iconXs, color: iconColor ?? fg),
            const SizedBox(width: KzSpace.s6),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style.copyWith(color: fg),
            ),
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: KzSpace.s6),
            KzIcon(trailingIcon!, size: KzSize.iconXs - KzSpace.s2, color: fg),
          ],
        ],
      ),
    );

    if (onPressed == null) return chip;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: semanticLabel ?? label,
      child: chip,
    );
  }
}
