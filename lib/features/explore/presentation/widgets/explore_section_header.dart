import 'package:flutter/widgets.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../l10n/l10n.dart';

/// Bölüm başlığı + alt açıklama + "tümünü gör" ok butonu.
class ExploreSectionHeader extends StatelessWidget {
  const ExploreSectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onSeeAll,
  });

  final String title;
  final String subtitle;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Padding(
      padding: const EdgeInsets.only(top: KzSpace.s26, bottom: KzSpace.s14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  child: Text(title, style: KzText.h4.copyWith(color: kz.ink)),
                ),
                const SizedBox(height: KzSpace.s3),
                Text(
                  subtitle,
                  style: KzText.labelMedium.copyWith(color: kz.ink2),
                ),
              ],
            ),
          ),
          const SizedBox(width: KzSpace.s12),
          KzCircleButton(
            icon: KzIcons.arrow,
            background: kz.sand,
            semanticLabel: '${context.l10n.seeAll}: $title',
            onPressed: onSeeAll,
          ),
        ],
      ),
    );
  }
}
