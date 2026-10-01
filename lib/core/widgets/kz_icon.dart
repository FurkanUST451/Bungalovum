import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';

/// Tek renkli Lucide tarzı SVG ikon. Renk verilmezse `ink` kullanılır.
class KzIcon extends StatelessWidget {
  const KzIcon(
    this.icon, {
    super.key,
    this.size = KzSize.iconXl,
    this.color,
    this.semanticLabel,
  });

  final KzIcons icon;
  final double size;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon.asset,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color ?? context.kz.ink, BlendMode.srcIn),
      semanticsLabel: semanticLabel,
      excludeFromSemantics: semanticLabel == null,
    );
  }
}
