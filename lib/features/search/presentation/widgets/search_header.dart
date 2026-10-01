import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../l10n/l10n.dart';
import '../controllers/search_controller.dart';
import '../search_labels.dart';

/// Sonuçlar / Harita / Sonuç Yok üst satırı: geri, arama özeti (dokununca
/// Arama'yı açar), filtre butonu (etkin filtre sayısı rozetiyle).
class SearchHeader extends ConsumerWidget {
  const SearchHeader({super.key});

  static const double _pillHeight = 52;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final q = ref.watch(searchQueryControllerProvider);
    final location = q.location.isEmpty ? l.searchAnywhere : q.location;
    final summary = querySummary(l, q);
    return Padding(
      padding: const EdgeInsets.only(top: KzSpace.s8, bottom: KzSpace.s10),
      child: Row(
        children: [
          KzNavButton(semanticLabel: l.back),
          const SizedBox(width: KzSpace.s10),
          Expanded(
            child: KzPressable(
              onPressed: () => context.push(AppRoutes.search),
              semanticLabel: '$location, $summary',
              child: Container(
                constraints: const BoxConstraints(minHeight: _pillHeight),
                padding: const EdgeInsets.symmetric(
                  horizontal: KzSpace.s16,
                  vertical: KzSpace.s6,
                ),
                decoration: BoxDecoration(
                  color: kz.surface,
                  borderRadius: KzRadii.all(KzRadii.pill),
                  boxShadow: KzShadows.card,
                ),
                child: Row(
                  children: [
                    KzIcon(KzIcons.search, size: KzSize.iconSm, color: kz.ink),
                    const SizedBox(width: KzSpace.s10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: KzText.bodySm.copyWith(
                              fontWeight: KzText.extraBold,
                              color: kz.ink,
                              height: KzText.tightLeading,
                            ),
                          ),
                          Text(
                            summary,
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
            iconSize: KzSize.iconMd,
            diameter: _pillHeight,
            background: kz.forest,
            iconColor: kz.onForest,
            shadow: KzShadows.card,
            badgeCount: q.filters.activeCount,
            semanticLabel: q.filters.activeCount > 0
                ? '${l.exploreFilters}, ${l.filtersActive(q.filters.activeCount)}'
                : l.exploreFilters,
            onPressed: () => context.push(AppRoutes.filters),
          ),
        ],
      ),
    );
  }
}
