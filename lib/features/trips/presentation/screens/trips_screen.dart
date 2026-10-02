import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/adaptive_layout.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_segmented.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../../../../core/widgets/kz_tab_bar.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/data/booking_repository.dart';
import '../../../booking/domain/booking.dart';
import '../../../explore/presentation/widgets/explore_message.dart';
import '../../domain/trips_overview.dart';
import '../controllers/trips_controller.dart';
import '../widgets/trip_cards.dart';

/// 44 · Seyahatler (+ 45 onay bekliyor, 46 geçmiş, 47 iptal, 48 boş).
class TripsScreen extends ConsumerWidget {
  const TripsScreen({super.key});

  Future<void> _withdraw(BuildContext context, WidgetRef ref, Booking b) async {
    final l = context.l10n;
    final ok = await showKzSheet<bool>(
      context: context,
      title: l.withdrawTitle,
      closeLabel: l.close,
      builder: (ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: KzSpace.s10),
          Text(
            l.withdrawBody(KzFormat.currency(b.amountPaid)),
            style: KzText.bodySm.copyWith(color: ctx.kz.ink2),
          ),
          const SizedBox(height: KzSpace.s20),
          KzButton(
            label: l.withdrawConfirm,
            variant: KzButtonVariant.danger,
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
    if (ok != true || !context.mounted) return;
    try {
      await ref.read(tripActionsProvider.notifier).withdrawRequest(b.id);
      if (context.mounted) showKzToast(context, l.withdrawn);
    } on Object {
      if (context.mounted) showKzToast(context, l.errorNetwork);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final tab = ref.watch(selectedTripsTabProvider);
    final overview = ref.watch(tripsOverviewProvider);
    final o = overview.value;
    final size = context.windowSize;
    final bottomSpace = size == KzWindowSize.expanded
        ? KzSpace.xl
        : KzTabBar.reservedHeight(context) + KzSpace.s20;

    final subtitle = o == null
        ? null
        : switch (tab) {
            TripsTab.upcoming => [
              if (o.pending.isNotEmpty) l.tripsPendingCount(o.pending.length),
              if (o.upcoming.isNotEmpty)
                l.tripsUpcomingCount(o.upcoming.length),
              if (o.pending.isEmpty && o.past.isNotEmpty)
                l.tripsPastCount(o.past.length),
            ].join(' · '),
            TripsTab.past => l.tripsPastStays(o.past.length),
            TripsTab.cancelled => l.tripsCancelledCount(o.cancelled.length),
          };

    return ColoredBox(
      color: kz.bg,
      child: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: kz.forest,
          backgroundColor: kz.surface,
          onRefresh: () => ref.refresh(myBookingsProvider.future),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              context.screenGutter,
              KzSpace.s14,
              context.screenGutter,
              bottomSpace,
            ),
            child: KzMaxWidth(
              maxWidth: KzBreakpoints.mediumContent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      l.tripsTitle,
                      style: KzText.h1.copyWith(color: kz.ink),
                    ),
                  ),
                  if (subtitle != null && subtitle.isNotEmpty) ...[
                    const SizedBox(height: KzSpace.s4),
                    Text(
                      subtitle,
                      style: KzText.labelMedium.copyWith(color: kz.ink2),
                    ),
                  ],
                  const SizedBox(height: KzSpace.s18),
                  KzSegmented<TripsTab>(
                    segments: [
                      (TripsTab.upcoming, l.tabUpcoming),
                      (TripsTab.past, l.tabPast),
                      (TripsTab.cancelled, l.tabCancelled),
                    ],
                    selected: tab,
                    onChanged: ref
                        .read(selectedTripsTabProvider.notifier)
                        .select,
                  ),
                  const SizedBox(height: KzSpace.s18),
                  switch (overview) {
                    AsyncData(:final value) => _tabContent(
                      context,
                      ref,
                      value,
                      tab,
                    ),
                    AsyncError() => ExploreMessage(
                      title: l.loadErrorTitle,
                      body: l.exploreErrorBody,
                      actionLabel: l.retry,
                      onAction: () => ref.invalidate(myBookingsProvider),
                    ),
                    _ => Column(
                      children: [
                        KzSkeleton(
                          height: KzSize.tabBar * 4,
                          borderRadius: KzRadii.all(KzRadii.hero),
                        ),
                        const SizedBox(height: KzSpace.s16),
                        KzSkeleton(
                          height: KzSize.tile + KzSpace.s24,
                          borderRadius: KzRadii.all(KzRadii.card),
                        ),
                      ],
                    ),
                  },
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabContent(
    BuildContext context,
    WidgetRef ref,
    TripsOverview o,
    TripsTab tab,
  ) {
    final kz = context.kz;
    final l = context.l10n;

    Widget section(String title) => Padding(
      padding: const EdgeInsets.only(top: KzSpace.s20, bottom: KzSpace.s10),
      child: Semantics(
        header: true,
        child: Text(title, style: KzText.title.copyWith(color: kz.ink)),
      ),
    );

    List<Widget> gap(List<Widget> items, double space) => [
      for (final (i, w) in items.indexed) ...[
        if (i > 0) SizedBox(height: space),
        w,
      ],
    ];

    switch (tab) {
      case TripsTab.upcoming:
        final featured = o.featured;
        if (featured == null) {
          return _Empty(
            icon: KzIcons.suitcase,
            title: l.emptyUpcomingTitle,
            body: l.emptyUpcomingBody,
            action: KzButton(
              label: l.exploreBungalows,
              trailingArrow: true,
              expand: false,
              onPressed: () => context.go(AppRoutes.explore),
            ),
          );
        }
        final others = [
          for (final b in o.pending.skip(1))
            PendingTripCard(
              booking: b,
              onWithdraw: () => _withdraw(context, ref, b),
            ),
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (featured.status == BookingStatus.pending)
              PendingTripCard(
                booking: featured,
                onWithdraw: () => _withdraw(context, ref, featured),
              )
            else
              UpcomingTripCard(booking: featured),
            if (others.isNotEmpty) ...[
              const SizedBox(height: KzSpace.s16),
              ...gap(others, KzSpace.s16),
            ],
            if (o.otherUpcoming.isNotEmpty) ...[
              section(l.confirmedSection),
              ...gap([
                for (final b in o.otherUpcoming)
                  TripRow(
                    booking: b,
                    subtitle: l.dotJoin2(
                      KzFormat.dateRange(b.dates.checkIn, b.dates.checkOut),
                      l.statusConfirmed,
                    ),
                    subtitleColor: kz.forest,
                    onPressed: () => context.push(AppRoutes.trip(b.id)),
                  ),
              ], KzSpace.s10),
            ],
            if (o.recentPast.isNotEmpty) ...[
              section(l.previousStays),
              ...gap([
                for (final b in o.recentPast)
                  TripRow(
                    booking: b,
                    subtitle: l.dotJoin2(
                      KzFormat.monthYear(b.dates.checkIn),
                      l.nightsCount(b.dates.nights),
                    ),
                    trailing: b.myRating == null
                        ? KzChip(
                            label: l.writeReview,
                            icon: KzIcons.star,
                            variant: KzChipVariant.accent,
                            size: KzChipSize.mini,
                            onPressed: () =>
                                context.push(AppRoutes.writeReview(b.id)),
                          )
                        : null,
                    onPressed: () => context.push(AppRoutes.trip(b.id)),
                  ),
              ], KzSpace.s10),
            ],
          ],
        );
      case TripsTab.past:
        if (o.past.isEmpty) {
          return _Empty(
            icon: KzIcons.calendar,
            title: l.emptyPastTitle,
            body: l.emptyPastBody,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: gap([
            for (final b in o.past) PastTripCard(booking: b),
          ], KzSpace.s16),
        );
      case TripsTab.cancelled:
        if (o.cancelled.isEmpty) {
          return _Empty(
            icon: KzIcons.calx,
            title: l.emptyCancelledTitle,
            body: l.emptyCancelledBody,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...gap([
              for (final b in o.cancelled) CancelledTripCard(booking: b),
            ], KzSpace.s16),
            const SizedBox(height: KzSpace.s14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: KzSpace.s4),
              child: Text(
                l.refundNote,
                style: KzText.caption.copyWith(color: kz.ink2),
              ),
            ),
          ],
        );
    }
  }
}

/// 48 · Boş durum: illüstrasyon + başlık + açıklama (+ aksiyon).
class _Empty extends StatelessWidget {
  const _Empty({
    required this.icon,
    required this.title,
    required this.body,
    this.action,
  });

  final KzIcons icon;
  final String title;
  final String body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KzSpace.s16,
        vertical: KzSpace.s36,
      ),
      child: Column(
        children: [
          KzSpotIllustration(icon: icon, dot: KzSpotDot.apricot, large: true),
          const SizedBox(height: KzSpace.s16),
          Semantics(
            header: true,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: KzText.h4.copyWith(color: kz.ink),
            ),
          ),
          const SizedBox(height: KzSpace.s10),
          Text(
            body,
            textAlign: TextAlign.center,
            style: KzText.bodySm.copyWith(
              color: kz.ink2,
              height: KzText.body.height,
            ),
          ),
          if (action != null) ...[const SizedBox(height: KzSpace.s20), action!],
        ],
      ),
    );
  }
}
