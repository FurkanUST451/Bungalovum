import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/adaptive_layout.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/clock.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_dashed_border.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../../../../core/widgets/kz_tab_bar.dart';
import '../../../../l10n/l10n.dart';
import '../../../explore/presentation/widgets/explore_message.dart';
import '../../../listing/presentation/listing_detail_labels.dart';
import '../../domain/wishlist.dart';
import '../controllers/saved_listings_controller.dart';
import '../widgets/add_to_list_sheet.dart';

/// "Bugün", "Dün", "3 gün önce".
String viewedWhen(AppLocalizations l, DateTime at, DateTime now) {
  final days = DateUtils.dateOnly(
    now,
  ).difference(DateUtils.dateOnly(at)).inDays;
  if (days == 1) return l.yesterday;
  return relativeDate(l, at, now);
}

/// 56 · Kaydettiklerim (+ 57 boş durum).
class SavedScreen extends ConsumerWidget {
  const SavedScreen({super.key});

  Future<void> _create(BuildContext context) async {
    final list = await showCreateListSheet(context);
    if (list != null && context.mounted) {
      context.push(AppRoutes.wishlist(list.id));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final lists = ref.watch(wishlistsProvider);
    final recent = ref.watch(recentlyViewedProvider).value ?? const [];
    final now = ref.watch(clockProvider)();
    final size = context.windowSize;
    final bottomSpace = size == KzWindowSize.expanded
        ? KzSpace.xl
        : KzTabBar.reservedHeight(context) + KzSpace.s20;
    final value = lists.value;
    final empty = value != null && value.isEmpty && recent.isEmpty;
    final saved = {
      for (final w in value ?? const <Wishlist>[]) ...w.listingIds,
    };

    return ColoredBox(
      color: kz.bg,
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            context.screenGutter,
            KzSpace.s14,
            context.screenGutter,
            bottomSpace,
          ),
          child: KzMaxWidth(
            maxWidth: size.contentMaxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Semantics(
                            header: true,
                            child: Text(
                              l.savedTitle,
                              style: KzText.h1.copyWith(color: kz.ink),
                            ),
                          ),
                          if (value != null && !empty) ...[
                            const SizedBox(height: KzSpace.s4),
                            Text(
                              l.savedSummary(value.length, saved.length),
                              style: KzText.labelMedium.copyWith(
                                color: kz.ink2,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (!empty)
                      KzCircleButton(
                        icon: KzIcons.plus,
                        diameter: KzSize.backButton,
                        iconSize: KzSize.iconMd,
                        background: kz.forest,
                        iconColor: kz.onForest,
                        shadow: KzShadows.card,
                        semanticLabel: l.newList,
                        onPressed: () => _create(context),
                      ),
                  ],
                ),
                const SizedBox(height: KzSpace.s20),
                switch (lists) {
                  AsyncData() when empty => _Empty(
                    onExplore: () => context.go(AppRoutes.explore),
                  ),
                  AsyncData(:final value) => LayoutBuilder(
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
                        runSpacing: KzSpace.s24,
                        children: [
                          if (recent.isNotEmpty)
                            _ListTile(
                              width: w,
                              title: l.recentlyViewedTitle,
                              subtitle: l.recentTileSub(
                                viewedWhen(l, recent.first.viewedAt, now),
                                recent.length,
                              ),
                              listingIds: [for (final r in recent) r.listingId],
                              onPressed: () =>
                                  context.push(AppRoutes.recentlyViewed),
                            ),
                          for (final w0 in value)
                            _ListTile(
                              width: w,
                              title: w0.name,
                              subtitle: w0.listingIds.isEmpty
                                  ? l.emptyList
                                  : l.listItems(w0.listingIds.length),
                              listingIds: w0.listingIds,
                              onPressed: () =>
                                  context.push(AppRoutes.wishlist(w0.id)),
                            ),
                          _NewListTile(
                            width: w,
                            onPressed: () => _create(context),
                          ),
                        ],
                      );
                    },
                  ),
                  AsyncError() => ExploreMessage(
                    title: l.loadErrorTitle,
                    body: l.exploreErrorBody,
                    actionLabel: l.retry,
                    onAction: () => ref.invalidate(wishlistsProvider),
                  ),
                  _ => Row(
                    children: [
                      for (var i = 0; i < 2; i++) ...[
                        if (i > 0) const SizedBox(width: KzSpace.s16),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: KzSkeleton(
                              borderRadius: KzRadii.all(KzRadii.card),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                },
                if (!empty && value != null) ...[
                  const SizedBox(height: KzSpace.s24),
                  _Tip(text: l.savedTip),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Kapak mozaiği (2×2 fotoğraf) + ad + alt satır.
class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.width,
    required this.title,
    required this.subtitle,
    required this.listingIds,
    required this.onPressed,
  });

  final double width;
  final String title;
  final String subtitle;
  final List<String> listingIds;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return SizedBox(
      width: width,
      child: KzPressable(
        onPressed: onPressed,
        semanticLabel: '$title, $subtitle',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListMosaic(listingIds: listingIds),
            const SizedBox(height: KzSpace.s10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: KzSpace.s4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.titleSm.copyWith(color: kz.ink),
                  ),
                  const SizedBox(height: KzSpace.s2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.caption.copyWith(color: kz.ink2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// İlk dört ilanın kapak fotoğrafından 2×2 mozaik; eksik hücreler sand.
class ListMosaic extends ConsumerWidget {
  const ListMosaic({super.key, required this.listingIds});

  final List<String> listingIds;

  static const int _cells = 4;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    Widget cell(int i) {
      if (i >= listingIds.length) return ColoredBox(color: kz.sand);
      final l = ref.watch(listingSummaryProvider(listingIds[i])).value;
      return KzPhoto(url: l?.photoUrls.firstOrNull);
    }

    return ExcludeSemantics(
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: KzRadii.all(KzRadii.card),
          child: Column(
            children: [
              for (var row = 0; row < _cells ~/ 2; row++) ...[
                if (row > 0) const SizedBox(height: KzSpace.s4),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: cell(row * 2)),
                      const SizedBox(width: KzSpace.s4),
                      Expanded(child: cell(row * 2 + 1)),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Kesikli forestSoft kutu: "+ Yeni liste".
class _NewListTile extends StatelessWidget {
  const _NewListTile({required this.width, required this.onPressed});

  final double width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return SizedBox(
      width: width,
      child: KzPressable(
        onPressed: onPressed,
        semanticLabel: l.newList,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: KzDashedBorder(
                radius: KzRadii.card,
                child: Container(
                  decoration: BoxDecoration(
                    color: kz.forestSoft,
                    borderRadius: KzRadii.all(KzRadii.card),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: KzSize.circleMd,
                        height: KzSize.circleMd,
                        decoration: BoxDecoration(
                          color: kz.forest,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: KzIcon(
                            KzIcons.plus,
                            size: KzSize.iconMd,
                            color: kz.onForest,
                          ),
                        ),
                      ),
                      const SizedBox(height: KzSpace.s10),
                      Text(
                        l.newListTile,
                        style: KzText.bodySm.copyWith(
                          color: kz.forest,
                          fontWeight: KzText.extraBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: KzSpace.s10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: KzSpace.s4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.createListTitle,
                    style: KzText.titleSm.copyWith(color: kz.ink),
                  ),
                  const SizedBox(height: KzSpace.s2),
                  Text(
                    l.groupYourTrips,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.caption.copyWith(color: kz.ink2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tip extends StatelessWidget {
  const _Tip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Container(
      padding: const EdgeInsets.all(KzSpace.s16),
      decoration: BoxDecoration(
        color: kz.apricotSoft,
        borderRadius: KzRadii.all(KzRadii.card),
      ),
      child: Row(
        children: [
          Container(
            width: KzSize.minTouch,
            height: KzSize.minTouch,
            decoration: BoxDecoration(
              color: kz.surface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: KzIcon(
                KzIcons.heartFilled,
                size: KzSize.iconSm,
                color: kz.apricotText,
              ),
            ),
          ),
          const SizedBox(width: KzSpace.s14),
          Expanded(
            child: Text(
              text,
              style: KzText.labelSemi.copyWith(
                color: kz.ink,
                height: KzText.caption.height,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KzSpace.s16,
        vertical: KzSpace.s36,
      ),
      child: Column(
        children: [
          const KzSpotIllustration(
            icon: KzIcons.heart,
            tone: KzSpotTone.apricot,
            dot: KzSpotDot.forest,
            large: true,
          ),
          const SizedBox(height: KzSpace.s16),
          Semantics(
            header: true,
            child: Text(
              l.savedEmptyTitle,
              textAlign: TextAlign.center,
              style: KzText.h4.copyWith(color: kz.ink),
            ),
          ),
          const SizedBox(height: KzSpace.s10),
          Text(
            l.savedEmptyBody,
            textAlign: TextAlign.center,
            style: KzText.bodySm.copyWith(
              color: kz.ink2,
              height: KzText.body.height,
            ),
          ),
          const SizedBox(height: KzSpace.s20),
          KzButton(
            label: l.startExploring,
            trailingArrow: true,
            expand: false,
            onPressed: onExplore,
          ),
        ],
      ),
    );
  }
}
