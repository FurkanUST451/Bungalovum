import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_adaptive_grid.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../../../../l10n/l10n.dart';
import '../../../explore/presentation/widgets/explore_message.dart';
import '../../../listing/presentation/widgets/listing_offer_card.dart';
import '../../domain/search_query.dart';
import '../controllers/search_controller.dart';
import '../search_labels.dart';
import '../widgets/search_header.dart';

/// 16 · Arama Sonuçları ve sonuç yoksa 18 · Sonuç Yok.
class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final results = ref.watch(searchResultsProvider);
    final q = ref.watch(searchQueryControllerProvider);
    final size = context.windowSize;
    final gutter = context.screenGutter;
    final offers = results.value;
    final empty = offers != null && offers.isEmpty;

    return Scaffold(
      backgroundColor: kz.bg,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: gutter),
                  sliver: const SliverToBoxAdapter(child: SearchHeader()),
                ),
                if (!empty && q.filters.activeCount > 0)
                  SliverToBoxAdapter(child: _ActiveFilters(gutter: gutter)),
                if (results.hasError && offers == null)
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: gutter),
                    sliver: SliverToBoxAdapter(
                      child: ExploreMessage(
                        title: l.exploreErrorTitle,
                        body: l.exploreErrorBody,
                        actionLabel: l.retry,
                        onAction: () => ref.invalidate(searchResultsProvider),
                      ),
                    ),
                  )
                else if (offers == null)
                  KzAdaptiveSliverGrid(
                    items: List.filled(size.columns, 0),
                    columns: size.columns,
                    inset: gutter,
                    itemBuilder: (_, _) => const ListingOfferCardSkeleton(
                      photoAspect: ListingOfferCard.resultAspect,
                    ),
                  )
                else if (empty)
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: gutter),
                    sliver: const SliverToBoxAdapter(child: _NoResults()),
                  )
                else ...[
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      gutter,
                      KzSpace.s10,
                      gutter,
                      KzSpace.s12,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: _CountRow(count: offers.length, sort: q.sort),
                    ),
                  ),
                  KzAdaptiveSliverGrid(
                    items: offers,
                    columns: size.columns,
                    inset: gutter,
                    itemBuilder: (context, offer) => ListingOfferCard(
                      offer: offer,
                      subtitle: offer.listing.resultLine(l),
                      heroPrefix: 'results',
                      photoAspect: ListingOfferCard.resultAspect,
                      indicator: PhotoIndicator.dots,
                      onOpen: () =>
                          context.push(AppRoutes.listing(offer.listing.id)),
                    ),
                  ),
                ],
                SliverToBoxAdapter(
                  child: SizedBox(
                    height:
                        KzSize.socialButton * 2 +
                        MediaQuery.paddingOf(context).bottom,
                  ),
                ),
              ],
            ),
            if (!empty)
              Positioned(
                left: 0,
                right: 0,
                bottom: KzSpace.s36 + MediaQuery.paddingOf(context).bottom,
                child: Center(
                  child: FloatingPill(
                    icon: KzIcons.map,
                    label: l.resultsMap,
                    onPressed: () => context.pushReplacement(AppRoutes.map),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Ink zeminli yüzen hap buton: "Harita" / "Liste".
class FloatingPill extends StatelessWidget {
  const FloatingPill({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final KzIcons icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: label,
      haptic: true,
      child: Container(
        height: KzSize.circleMd + KzSpace.s4,
        padding: const EdgeInsets.symmetric(horizontal: KzSpace.s22),
        decoration: BoxDecoration(
          color: kz.ink,
          borderRadius: KzRadii.all(KzRadii.pill),
          boxShadow: KzShadows.strong,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            KzIcon(icon, size: KzSize.iconSm, color: kz.onForest),
            const SizedBox(width: KzSpace.s8),
            Text(
              label,
              style: KzText.bodyStrongSm.copyWith(
                fontWeight: KzText.extraBold,
                color: kz.onForest,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveFilters extends ConsumerWidget {
  const _ActiveFilters({required this.gutter});

  final double gutter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final f = ref.watch(searchQueryControllerProvider).filters;
    final c = ref.read(searchQueryControllerProvider.notifier);
    final chips = <(String, VoidCallback)>[
      for (final feature in f.features)
        (feature.label(l), () => c.removeFeature(feature)),
      if (f.priceMin != null || f.priceMax != null)
        (
          l.filtersPriceChip(
            l.dayPriceShort(KzFormat.thousands(f.priceMin ?? 0)),
            l.dayPriceShort(KzFormat.thousands(f.priceMax ?? 0)),
          ),
          c.clearPrice,
        ),
    ];
    if (chips.isEmpty) return const SizedBox.shrink();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(gutter, KzSpace.s4, gutter, KzSpace.s6),
      child: Row(
        children: [
          for (final (i, (label, remove)) in chips.indexed) ...[
            if (i > 0) const SizedBox(width: KzSpace.s8),
            KzChip(
              label: label,
              variant: KzChipVariant.selected,
              size: KzChipSize.small,
              trailingIcon: KzIcons.x,
              semanticLabel: l.removeFilter(label),
              onPressed: remove,
            ),
          ],
        ],
      ),
    );
  }
}

class _CountRow extends ConsumerWidget {
  const _CountRow({required this.count, required this.sort});

  final int count;
  final SearchSort sort;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    return Row(
      children: [
        Expanded(
          child: Semantics(
            liveRegion: true,
            child: Text(
              l.resultsCount(count),
              style: KzText.title.copyWith(color: kz.ink),
            ),
          ),
        ),
        KzPressable(
          onPressed: () => showKzSheet<void>(
            context: context,
            title: l.sortTitle,
            closeLabel: l.close,
            builder: (ctx) => Column(
              children: [
                for (final s in SearchSort.values)
                  KzOptionRow(
                    label: s.label(l),
                    selected: s == sort,
                    onPressed: () {
                      ref
                          .read(searchQueryControllerProvider.notifier)
                          .setSort(s);
                      Navigator.of(ctx).pop();
                    },
                  ),
              ],
            ),
          ),
          semanticLabel: '${l.sortTitle}: ${sort.label(l)}',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(sort.label(l), style: KzText.label.copyWith(color: kz.ink2)),
              const SizedBox(width: KzSpace.s4),
              KzIcon(KzIcons.down, size: KzSpace.s16, color: kz.ink2),
            ],
          ),
        ),
      ],
    );
  }
}

/// 18 · Sonuç Yok
class _NoResults extends ConsumerWidget {
  const _NoResults();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final suggestions = ref.watch(relaxSuggestionsProvider).value ?? const [];
    final c = ref.read(searchQueryControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KzEmptyState(
          illustration: const KzSpotIllustration(
            icon: KzIcons.search,
            tone: KzSpotTone.sand,
            badgeIcon: KzIcons.trees,
            badge: KzSpotBadge.forestSoft,
            dot: KzSpotDot.apricot,
            large: true,
          ),
          title: l.noResultsTitle,
          body: l.noResultsBody,
        ),
        for (final s in suggestions) ...[
          KzActionRow(
            icon: switch (s.kind) {
              RelaxKind.flexibleDates => KzIcons.calendar,
              RelaxKind.removeHeatedPool => KzIcons.thermo,
              RelaxKind.widenPrice => KzIcons.wallet,
            },
            title: switch (s.kind) {
              RelaxKind.flexibleDates => l.relaxDates,
              RelaxKind.removeHeatedPool => l.relaxHeatedPool,
              RelaxKind.widenPrice => l.relaxPrice,
            },
            subtitle: l.relaxExtra(s.extraCount),
            onPressed: () => c.relax(s.kind),
          ),
          const SizedBox(height: KzSpace.s10),
        ],
        const SizedBox(height: KzSpace.s10),
        KzButton(
          label: l.clearAllFilters,
          variant: KzButtonVariant.secondary,
          onPressed: c.clearFilters,
        ),
      ],
    );
  }
}
