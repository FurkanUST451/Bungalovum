import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';

/// Yuvarlak buton (geri, kapat, paylaş, kalp, bildirim, filtre...).
///
/// Görsel çap [diameter]; dokunma alanı her durumda en az 44×44'tür.
class KzCircleButton extends StatelessWidget {
  const KzCircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    this.diameter = KzSize.circleSm,
    this.iconSize = KzSize.iconSm,
    this.background,
    this.iconColor,
    this.shadow,
    this.showBadge = false,
    this.badgeCount,
    this.haptic = false,
    this.selected,
  });

  final KzIcons icon;
  final VoidCallback? onPressed;
  final String semanticLabel;
  final double diameter;
  final double iconSize;
  final Color? background;
  final Color? iconColor;
  final List<BoxShadow>? shadow;

  /// Sağ üstte apricot bildirim noktası.
  final bool showBadge;

  /// Sağ üstte sayılı rozet (ör. etkin filtre sayısı); 0 ise gizli.
  final int? badgeCount;
  final bool haptic;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final inset = (diameter - iconSize) / 2;
    final count = badgeCount ?? 0;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: semanticLabel,
      haptic: haptic,
      selected: selected,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          color: background ?? kz.surface,
          shape: BoxShape.circle,
          boxShadow: shadow,
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            KzIcon(icon, size: iconSize, color: iconColor ?? kz.ink),
            if (showBadge)
              PositionedDirectional(
                // Figma btn/bell: nokta ikonun sağ üst köşesine biner.
                top: inset - KzSpace.s3,
                end: inset - KzSpace.s5,
                child: Container(
                  width: KzSize.badgeDot,
                  height: KzSize.badgeDot,
                  decoration: BoxDecoration(
                    color: kz.apricot,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kz.surface,
                      width: KzSize.badgeStroke,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                ),
              ),
            if (count > 0)
              PositionedDirectional(
                top: -KzSpace.s2,
                end: -KzSpace.s2,
                child: Container(
                  width: KzSize.countBadge,
                  height: KzSize.countBadge,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kz.apricot,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kz.surface,
                      width: KzSize.badgeStroke,
                    ),
                  ),
                  child: Text(
                    '$count',
                    style: KzText.badge.copyWith(color: kz.ink),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
