import 'package:flutter/widgets.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/explore_category.dart';

extension ExploreCategoryUi on ExploreCategory {
  KzIcons get icon => switch (this) {
    ExploreCategory.all => KzIcons.grid,
    ExploreCategory.pool => KzIcons.waves,
    ExploreCategory.lakeView => KzIcons.mountain,
    ExploreCategory.forest => KzIcons.trees,
    ExploreCategory.jacuzzi => KzIcons.bath,
    ExploreCategory.fireplace => KzIcons.flame,
    ExploreCategory.aFrame => KzIcons.home,
  };

  String label(AppLocalizations l) => switch (this) {
    ExploreCategory.all => l.categoryAll,
    ExploreCategory.pool => l.categoryPool,
    ExploreCategory.lakeView => l.categoryLakeView,
    ExploreCategory.forest => l.categoryForest,
    ExploreCategory.jacuzzi => l.categoryJacuzzi,
    ExploreCategory.fireplace => l.categoryFireplace,
    ExploreCategory.aFrame => l.categoryAFrame,
  };
}

/// Yatay kaydırılan kategori şeridi.
class CategoryStrip extends StatelessWidget {
  const CategoryStrip({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.inset,
  });

  final ExploreCategory selected;
  final ValueChanged<ExploreCategory> onSelected;

  /// İçeriğin ekran kenarından yatay boşluğu.
  final double inset;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // Gölgeler kesilmesin.
      clipBehavior: Clip.none,
      padding: EdgeInsets.fromLTRB(inset, KzSpace.s18, inset, KzSpace.s8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final c in ExploreCategory.values) ...[
            if (c != ExploreCategory.values.first)
              const SizedBox(width: KzSpace.s12),
            _CategoryItem(
              category: c,
              selected: c == selected,
              onPressed: () => onSelected(c),
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.category,
    required this.selected,
    required this.onPressed,
  });

  final ExploreCategory category;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final label = category.label(context.l10n);
    final duration = KzMotion.of(context, KzMotion.toggle);
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: label,
      selected: selected,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: KzSize.circleLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: duration,
              curve: KzMotion.enter,
              width: KzSize.circleLg,
              height: KzSize.circleLg,
              decoration: BoxDecoration(
                color: selected ? kz.forest : kz.surface,
                shape: BoxShape.circle,
                boxShadow: selected ? KzShadows.strong : KzShadows.soft,
              ),
              alignment: Alignment.center,
              child: KzIcon(
                category.icon,
                size: KzSize.iconXl,
                color: selected ? kz.onForest : kz.forest,
              ),
            ),
            const SizedBox(height: KzSpace.s8),
            Text(
              label,
              maxLines: 1,
              style: (selected ? KzText.captionHeavy : KzText.captionSemi)
                  .copyWith(
                    color: selected ? kz.ink : kz.ink2,
                    height: KzText.tightLeading,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
