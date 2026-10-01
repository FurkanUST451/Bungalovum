import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';

import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_tab_bar.dart';
import '../../../../l10n/l10n.dart';
import '../../../listing/domain/listing.dart';
import '../../domain/explore_feed.dart';
import '../controllers/explore_controller.dart';
import '../widgets/category_strip.dart';
import '../widgets/explore_header.dart';
import '../widgets/explore_message.dart';
import '../widgets/explore_search_bar.dart';
import '../widgets/explore_section_header.dart';
import '../widgets/popular_listing_card.dart';
import '../widgets/weather_card.dart';
import '../../../listing/presentation/listing_labels.dart';
import '../../../listing/presentation/widgets/listing_offer_card.dart';
import '../../../../core/widgets/kz_adaptive_grid.dart';

/// 13 · Keşfet
class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  void _openNotifications(BuildContext c) => c.push(AppRoutes.notifications);
  void _openSearch(BuildContext c) => c.push(AppRoutes.search);
  void _openFilters(BuildContext c) => c.push(AppRoutes.filters);
  void _openResults(BuildContext c) => c.push(AppRoutes.results);
  void _openListing(BuildContext c, Listing l) =>
      c.push(AppRoutes.listing(l.id));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final size = context.windowSize;
    final category = ref.watch(selectedExploreCategoryProvider);
    final feedAsync = ref.watch(exploreFeedProvider);
    final feed = feedAsync.value;
    final loading = feed == null && feedAsync.isLoading;
    final failed = feed == null && feedAsync.hasError && !feedAsync.isLoading;

    final bottomSpace = size == KzWindowSize.expanded
        ? KzSpace.xl
        : KzTabBar.reservedHeight(context) + KzSpace.s20;

    return ColoredBox(
      color: kz.bg,
      child: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // medium: içerik 560'a sınırlanıp ortalanır; yatay şeritler yine
            // tam genişlikte kayar ama aynı kenar çizgisinden başlar.
            final gutter = context.screenGutter;
            final maxWidth = size.contentMaxWidth;
            final inset = maxWidth.isFinite
                ? math.max(gutter, (constraints.maxWidth - maxWidth) / 2)
                : gutter;
            Widget padded(Widget child) => Padding(
              padding: EdgeInsets.symmetric(horizontal: inset),
              child: child,
            );

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: padded(
                    ExploreHeader(
                      locationLabel: feed?.locationLabel,
                      hasUnreadNotifications: true,
                      onNotifications: () => _openNotifications(context),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: padded(
                    ExploreSearchBar(
                      onSearch: () => _openSearch(context),
                      onFilters: () => _openFilters(context),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CategoryStrip(
                    selected: category,
                    inset: inset,
                    onSelected: ref
                        .read(selectedExploreCategoryProvider.notifier)
                        .select,
                  ),
                ),
                if (failed)
                  SliverToBoxAdapter(
                    child: padded(
                      ExploreMessage(
                        title: l.exploreErrorTitle,
                        body: l.exploreErrorBody,
                        actionLabel: l.retry,
                        onAction: () => ref.invalidate(exploreFeedProvider),
                      ),
                    ),
                  )
                else if (loading)
                  ..._loadingSlivers(inset, padded)
                else if (feed != null)
                  ..._feedSlivers(context, feed, size, inset, padded),
                SliverToBoxAdapter(child: SizedBox(height: bottomSpace)),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _loadingSlivers(double inset, Widget Function(Widget) padded) {
    return [
      const SliverToBoxAdapter(child: SizedBox(height: KzSpace.s26)),
      SliverToBoxAdapter(
        child: padded(
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: KzSkeleton(
              width: _skeletonTitleWidth,
              height: KzSpace.s24,
              borderRadius: KzRadii.all(KzRadii.xs),
            ),
          ),
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: KzSpace.s20)),
      SliverToBoxAdapter(
        child: PopularCarousel(
          listings: null,
          inset: inset,
          // İskelet kartlara dokunulamaz.
          onOpen: (_) {},
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: KzSpace.s24)),
      SliverToBoxAdapter(child: padded(const ListingOfferCardSkeleton())),
    ];
  }

  static const double _skeletonTitleWidth = 220;

  List<Widget> _feedSlivers(
    BuildContext context,
    ExploreFeed feed,
    KzWindowSize size,
    double inset,
    Widget Function(Widget) padded,
  ) {
    final l = context.l10n;
    if (feed.popular.isEmpty && feed.weekendDeals.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: padded(
            ExploreMessage(
              title: l.exploreEmptyTitle,
              body: l.exploreEmptyBody,
            ),
          ),
        ),
      ];
    }

    final nights = feed.weekendDeals.isEmpty
        ? feed.weekendEnd.difference(feed.weekendStart).inDays
        : feed.weekendDeals.first.price.nights;

    return [
      if (feed.popular.isNotEmpty) ...[
        SliverToBoxAdapter(
          child: padded(
            ExploreSectionHeader(
              title: l.explorePopularTitle(feed.regionLocative),
              subtitle: l.explorePopularSubtitle,
              onSeeAll: () => _openResults(context),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: PopularCarousel(
            listings: feed.popular,
            inset: inset,
            onOpen: (l) => _openListing(context, l),
          ),
        ),
      ],
      if (feed.weather case final weather?)
        SliverToBoxAdapter(
          child: padded(
            Padding(
              padding: const EdgeInsets.only(top: KzSpace.s18),
              child: WeatherCard(
                weather: weather,
                onOpen: () => _openResults(context),
              ),
            ),
          ),
        ),
      if (feed.weekendDeals.isNotEmpty) ...[
        SliverToBoxAdapter(
          child: padded(
            ExploreSectionHeader(
              title: l.exploreWeekendTitle,
              subtitle: l.exploreWeekendSubtitle(
                KzFormat.dateRange(feed.weekendStart, feed.weekendEnd),
                nights,
              ),
              onSeeAll: () => _openResults(context),
            ),
          ),
        ),
        KzAdaptiveSliverGrid(
          items: feed.weekendDeals,
          columns: size.columns,
          inset: inset,
          itemBuilder: (context, offer) => ListingOfferCard(
            offer: offer,
            subtitle: offer.listing.locationLine(),
            heroPrefix: 'weekend',
            onOpen: () => _openListing(context, offer.listing),
          ),
        ),
      ],
    ];
  }
}
