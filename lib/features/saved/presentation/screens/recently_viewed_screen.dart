import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/clock.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../../../../l10n/l10n.dart';
import '../../data/wishlist_repository.dart';
import '../../domain/wishlist.dart';
import '../controllers/saved_listings_controller.dart';
import '../widgets/save_listing_button.dart';
import 'saved_screen.dart' show viewedWhen;

/// 60 · Son Baktıkların: gün gün gruplanmış, son 30 gün.
class RecentlyViewedScreen extends ConsumerWidget {
  const RecentlyViewedScreen({super.key});

  Future<void> _clear(BuildContext context, WidgetRef ref) async {
    final l = context.l10n;
    final ok = await showKzSheet<bool>(
      context: context,
      title: l.clearRecentTitle,
      closeLabel: l.close,
      builder: (ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: KzSpace.s10),
          Text(
            l.clearRecentBody,
            style: KzText.bodySm.copyWith(color: ctx.kz.ink2),
          ),
          const SizedBox(height: KzSpace.s20),
          KzButton(
            label: l.clear,
            variant: KzButtonVariant.destructive,
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
          const SizedBox(height: KzSpace.s10),
          KzButton(
            label: l.keepRequest,
            variant: KzButtonVariant.secondary,
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(wishlistRepositoryProvider).clearRecentlyViewed();
    ref.invalidate(recentlyViewedProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final recent = ref.watch(recentlyViewedProvider);
    final now = ref.watch(clockProvider)();
    final items = recent.value ?? const <RecentView>[];

    // Gün gün grupla (en yeni gün önce).
    final groups = <DateTime, List<RecentView>>{};
    for (final r in items) {
      groups.putIfAbsent(DateUtils.dateOnly(r.viewedAt), () => []).add(r);
    }

    return KzScaffold(
      maxWidth: context.windowSize.contentMaxWidth,
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.back),
        trailing: items.isEmpty
            ? null
            : KzLink(
                label: l.clear,
                style: KzText.bodySm,
                onPressed: () => _clear(context, ref),
              ),
      ),
      children: [
        KzPageTitle(
          title: l.recentlyViewedTitle,
          subtitle: l.recentSubtitle(RecentPolicy.keepDays),
        ),
        switch (recent) {
          AsyncData() when items.isEmpty => Padding(
            padding: const EdgeInsets.symmetric(vertical: KzSpace.s36),
            child: Column(
              children: [
                const KzSpotIllustration(
                  icon: KzIcons.clock,
                  dot: KzSpotDot.apricot,
                  large: true,
                ),
                const SizedBox(height: KzSpace.s16),
                Text(
                  l.recentEmptyTitle,
                  textAlign: TextAlign.center,
                  style: KzText.h4.copyWith(color: kz.ink),
                ),
                const SizedBox(height: KzSpace.s10),
                Text(
                  l.recentEmptyBody,
                  textAlign: TextAlign.center,
                  style: KzText.bodySm.copyWith(color: kz.ink2),
                ),
              ],
            ),
          ),
          AsyncData() => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final MapEntry(key: day, value: views)
                  in groups.entries) ...[
                Padding(
                  padding: const EdgeInsets.only(
                    top: KzSpace.s10,
                    bottom: KzSpace.s12,
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Semantics(
                          header: true,
                          child: Text(
                            viewedWhen(l, day, now),
                            style: KzText.title.copyWith(color: kz.ink),
                          ),
                        ),
                      ),
                      const SizedBox(width: KzSpace.s10),
                      KzChip(
                        label: l.placesCount(views.length),
                        variant: KzChipVariant.soft,
                        size: KzChipSize.mini,
                      ),
                    ],
                  ),
                ),
                LayoutBuilder(
                  builder: (context, c) {
                    final columns = c.maxWidth < KzBreakpoints.medium
                        ? 2
                        : c.maxWidth < KzBreakpoints.expanded
                        ? 3
                        : 4;
                    final w =
                        (c.maxWidth - KzSpace.s16 * (columns - 1)) / columns;
                    return Wrap(
                      spacing: KzSpace.s16,
                      runSpacing: KzSpace.s20,
                      children: [
                        for (final v in views)
                          SizedBox(
                            width: w,
                            child: _RecentCard(listingId: v.listingId),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: KzSpace.s14),
              ],
            ],
          ),
          AsyncError() => const SizedBox.shrink(),
          _ => KzSkeleton(
            height: KzSize.tabBar * 3,
            borderRadius: KzRadii.all(KzRadii.card),
          ),
        },
      ],
    );
  }
}

class _RecentCard extends ConsumerWidget {
  const _RecentCard({required this.listingId});

  final String listingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final listing = ref.watch(listingSummaryProvider(listingId)).value;
    if (listing == null) {
      return AspectRatio(
        aspectRatio: 1,
        child: KzSkeleton(borderRadius: KzRadii.all(KzRadii.card)),
      );
    }
    return KzPressable(
      onPressed: () => context.push(AppRoutes.listing(listingId)),
      semanticLabel: listing.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: KzRadii.all(KzRadii.card),
                  child: KzPhoto(url: listing.photoUrls.firstOrNull),
                ),
                Positioned(
                  top: KzSpace.s10,
                  right: KzSpace.s10,
                  child: SaveListingButton(listingId: listingId),
                ),
              ],
            ),
          ),
          const SizedBox(height: KzSpace.s8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KzSpace.s4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listing.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: KzText.bodySm.copyWith(
                    color: kz.ink,
                    fontWeight: KzText.extraBold,
                  ),
                ),
                const SizedBox(height: KzSpace.s2),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        l.bedsCount(listing.bedrooms),
                        maxLines: 1,
                        style: KzText.caption.copyWith(color: kz.ink2),
                      ),
                    ),
                    if (listing.rating != null) ...[
                      const SizedBox(width: KzSpace.s6),
                      KzIcon(
                        KzIcons.starFilled,
                        size: KzSpace.s12,
                        color: kz.star,
                      ),
                      const SizedBox(width: KzSpace.s4),
                      Text(
                        KzFormat.rating(listing.rating!),
                        style: KzText.captionBold.copyWith(color: kz.ink),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
