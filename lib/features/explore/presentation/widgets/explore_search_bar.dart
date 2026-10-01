import 'package:flutter/widgets.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../l10n/l10n.dart';

/// Arama hapı + filtre butonu. Hap, Arama (14) ekranını açar.
class ExploreSearchBar extends StatelessWidget {
  const ExploreSearchBar({
    super.key,
    required this.onSearch,
    required this.onFilters,
  });

  final VoidCallback onSearch;
  final VoidCallback onFilters;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(top: KzSpace.s14, bottom: KzSpace.s6),
      child: Row(
        children: [
          Expanded(
            child: KzPressable(
              onPressed: onSearch,
              semanticLabel:
                  '${l.exploreSearchTitle} ${l.exploreSearchSubtitle}',
              child: Container(
                constraints: const BoxConstraints(minHeight: KzSize.circleLg),
                padding: const EdgeInsets.symmetric(
                  horizontal: KzSpace.s20,
                  vertical: KzSpace.s8,
                ),
                decoration: BoxDecoration(
                  color: kz.surface,
                  borderRadius: KzRadii.all(KzRadii.pill),
                  boxShadow: KzShadows.card,
                ),
                child: Row(
                  children: [
                    KzIcon(
                      KzIcons.search,
                      size: KzSize.iconLg,
                      color: kz.forest,
                    ),
                    const SizedBox(width: KzSpace.s12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.exploreSearchTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: KzText.bodyStrongSm.copyWith(
                              color: kz.ink,
                              height: KzText.tightLeading,
                            ),
                          ),
                          const SizedBox(height: KzSpace.s2),
                          Text(
                            l.exploreSearchSubtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: KzText.caption.copyWith(
                              color: kz.ink2,
                              height: KzText.tightLeading,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: KzSpace.s10),
          KzCircleButton(
            icon: KzIcons.sliders,
            iconSize: KzSize.iconLg,
            diameter: KzSize.circleLg,
            background: kz.forest,
            iconColor: kz.onForest,
            shadow: KzShadows.strong,
            semanticLabel: l.exploreFilters,
            onPressed: onFilters,
          ),
        ],
      ),
    );
  }
}
