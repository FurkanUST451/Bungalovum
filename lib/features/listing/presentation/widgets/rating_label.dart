import 'package:flutter/widgets.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_icon.dart';

/// Yıldız + puan: "★ 4,93".
class RatingLabel extends StatelessWidget {
  const RatingLabel({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        KzIcon(KzIcons.starFilled, size: KzSize.iconXs, color: kz.star),
        const SizedBox(width: KzSpace.s4),
        Text(
          KzFormat.rating(rating),
          style: KzText.label.copyWith(color: kz.ink),
        ),
      ],
    );
  }
}
