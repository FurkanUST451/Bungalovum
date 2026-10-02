import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/clock.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../../../../l10n/l10n.dart';
import '../../../explore/presentation/widgets/explore_message.dart';
import '../../domain/chat_models.dart';
import '../chat_labels.dart';
import '../controllers/chat_controllers.dart';

extension NotificationKindUi on NotificationKind {
  (KzIcons, KzIconBoxTone) get look => switch (this) {
    NotificationKind.bookingConfirmed ||
    NotificationKind.requestApproved => (KzIcons.check, KzIconBoxTone.forest),
    NotificationKind.requestDeclined => (KzIcons.calx, KzIconBoxTone.apricot),
    NotificationKind.message => (KzIcons.chat, KzIconBoxTone.pool),
    NotificationKind.priceDrop => (KzIcons.heart, KzIconBoxTone.apricot),
    NotificationKind.reviewReminder => (KzIcons.star, KzIconBoxTone.sand),
    NotificationKind.weather => (KzIcons.sun, KzIconBoxTone.apricot),
  };

  /// Dokununca gidilecek ekran; hedefsizse null.
  String? route(String? id) => switch (this) {
    _ when id == null && this != NotificationKind.weather => null,
    NotificationKind.bookingConfirmed => AppRoutes.trip(id!),
    NotificationKind.requestApproved => AppRoutes.requestApproved(id!),
    NotificationKind.requestDeclined => AppRoutes.requestDeclined(id!),
    NotificationKind.message => AppRoutes.chat(id!),
    NotificationKind.priceDrop => AppRoutes.listing(id!),
    NotificationKind.reviewReminder => AppRoutes.writeReview(id!),
    NotificationKind.weather => AppRoutes.explore,
  };
}

/// 64 · Bildirim Merkezi: Bugün / Bu hafta / Daha önce.
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  static const int _weekDays = 7;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final list = ref.watch(notificationsProvider);
    final now = ref.watch(clockProvider)();
    final today = DateUtils.dateOnly(now);
    final items = list.value ?? const <AppNotification>[];
    final hasUnread = items.any((n) => !n.read);

    final sections = <(String, List<AppNotification>)>[
      (
        l.sectionToday,
        [
          for (final n in items)
            if (!DateUtils.dateOnly(n.at).isBefore(today)) n,
        ],
      ),
      (
        l.sectionThisWeek,
        [
          for (final n in items)
            if (DateUtils.dateOnly(n.at).isBefore(today) &&
                today.difference(DateUtils.dateOnly(n.at)).inDays < _weekDays)
              n,
        ],
      ),
      (
        l.sectionEarlier,
        [
          for (final n in items)
            if (today.difference(DateUtils.dateOnly(n.at)).inDays >= _weekDays)
              n,
        ],
      ),
    ];

    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.back),
        trailing: hasUnread
            ? KzLink(
                label: l.markAllRead,
                onPressed: () =>
                    ref.read(notificationsProvider.notifier).markAllRead(),
              )
            : null,
      ),
      children: [
        KzPageTitle(title: l.notificationsTitle),
        switch (list) {
          AsyncData() when items.isEmpty => Padding(
            padding: const EdgeInsets.symmetric(vertical: KzSpace.s36),
            child: Column(
              children: [
                const KzSpotIllustration(
                  icon: KzIcons.bell,
                  dot: KzSpotDot.apricot,
                  large: true,
                ),
                const SizedBox(height: KzSpace.s16),
                Text(
                  l.notificationsEmptyTitle,
                  textAlign: TextAlign.center,
                  style: KzText.h4.copyWith(color: kz.ink),
                ),
                const SizedBox(height: KzSpace.s10),
                Text(
                  l.notificationsEmptyBody,
                  textAlign: TextAlign.center,
                  style: KzText.bodySm.copyWith(color: kz.ink2),
                ),
              ],
            ),
          ),
          AsyncData() => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (title, group) in sections)
                if (group.isNotEmpty) ...[
                  const SizedBox(height: KzSpace.s6),
                  KzOverline(title),
                  const SizedBox(height: KzSpace.s8),
                  for (final n in group) ...[
                    _NotificationTile(notification: n, now: now),
                    const SizedBox(height: KzSpace.s8),
                  ],
                  const SizedBox(height: KzSpace.s10),
                ],
            ],
          ),
          AsyncError() => ExploreMessage(
            title: l.loadErrorTitle,
            body: l.exploreErrorBody,
            actionLabel: l.retry,
            onAction: () => ref.invalidate(notificationsProvider),
          ),
          _ => Column(
            children: [
              for (var i = 0; i < 3; i++) ...[
                KzSkeleton(
                  height: KzSize.tile + KzSpace.s20,
                  borderRadius: KzRadii.all(KzRadii.card),
                ),
                const SizedBox(height: KzSpace.s8),
              ],
            ],
          ),
        },
      ],
    );
  }
}

class _NotificationTile extends ConsumerWidget {
  const _NotificationTile({required this.notification, required this.now});

  final AppNotification notification;
  final DateTime now;

  static const double _dot = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final n = notification;
    final (icon, tone) = n.kind.look;
    final route = n.kind.route(n.targetId);
    final ago = notificationAgo(l, n.at, now);
    return KzPressable(
      onPressed: () {
        ref.read(notificationsProvider.notifier).markRead(n.id);
        if (route == null) return;
        route == AppRoutes.explore ? context.go(route) : context.push(route);
      },
      semanticLabel: [n.title, n.body, ago, if (!n.read) l.unread].join(', '),
      pressedScale: 1,
      child: Container(
        padding: const EdgeInsets.all(KzSpace.s14),
        decoration: BoxDecoration(
          color: n.read ? null : kz.surface,
          borderRadius: KzRadii.all(KzRadii.card),
          border: n.read ? null : Border.all(color: kz.line),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KzIconBox(
              icon: icon,
              tone: tone,
              size: KzSize.backButton,
              iconSize: KzSize.iconMd,
            ),
            const SizedBox(width: KzSpace.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    n.title,
                    style: KzText.bodySm.copyWith(
                      color: kz.ink,
                      fontWeight: KzText.extraBold,
                      height: KzText.tightLeading,
                    ),
                  ),
                  const SizedBox(height: KzSpace.s3),
                  Text(
                    n.body,
                    style: KzText.labelMedium.copyWith(
                      color: kz.ink2,
                      height: KzText.caption.height,
                    ),
                  ),
                  const SizedBox(height: KzSpace.s3),
                  Text(
                    ago,
                    style: KzText.microTight.copyWith(
                      color: kz.ink2,
                      fontWeight: KzText.semiBold,
                    ),
                  ),
                ],
              ),
            ),
            if (!n.read) ...[
              const SizedBox(width: KzSpace.s8),
              Container(
                width: _dot,
                height: _dot,
                margin: const EdgeInsets.only(top: KzSpace.s4),
                decoration: BoxDecoration(
                  color: kz.apricot,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
