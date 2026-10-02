import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/services/permissions.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_group.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_switch.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/presentation/widgets/booking_parts.dart';
import '../../../status/presentation/screens/status_screens.dart';
import '../../data/account_repository.dart';
import '../../domain/account_models.dart';
import '../controllers/account_controllers.dart';

extension NotifTopicUi on NotifTopic {
  String label(AppLocalizations l) => switch (this) {
    NotifTopic.promotions => l.topicPromotions,
    NotifTopic.stayReminders => l.topicStayReminders,
    NotifTopic.news => l.topicNews,
    NotifTopic.surveys => l.topicSurveys,
    NotifTopic.ruleUpdates => l.topicRuleUpdates,
  };

  (KzIcons, KzIconBoxTone) get look => switch (this) {
    NotifTopic.promotions => (KzIcons.sparkles, KzIconBoxTone.apricot),
    NotifTopic.stayReminders => (KzIcons.calendar, KzIconBoxTone.forest),
    NotifTopic.news => (KzIcons.megaphone, KzIconBoxTone.sand),
    NotifTopic.surveys => (KzIcons.chat, KzIconBoxTone.sand),
    NotifTopic.ruleUpdates => (KzIcons.doc, KzIconBoxTone.sand),
  };
}

String _channels(AppLocalizations l, Set<NotifChannel> c) => c.isEmpty
    ? l.off
    : [
        for (final ch in NotifChannel.values)
          if (c.contains(ch))
            switch (ch) {
              NotifChannel.push => l.channelPush,
              NotifChannel.email => l.channelEmail,
              NotifChannel.sms => l.channelSms,
            },
      ].join(' · ');

/// 69 · Bildirim Tercihleri.
class NotificationPrefsScreen extends ConsumerWidget {
  const NotificationPrefsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(notifPrefsProvider);
    final p = prefs.value;
    if (p == null) {
      return prefs.hasError
          ? BookingError(onRetry: () => ref.invalidate(notifPrefsProvider))
          : const BookingLoading(cards: 2);
    }
    final l = context.l10n;
    final notifier = ref.read(notifPrefsProvider.notifier);

    KzRow row(NotifTopic t) {
      final (icon, tone) = t.look;
      return KzRow(
        icon: icon,
        tone: tone,
        title: t.label(l),
        subtitle: _channels(l, p.channels(t)),
        trailing: KzSwitch(
          value: p.isOn(t),
          semanticLabel: t.label(l),
          onChanged: (v) => notifier.toggle(t, v),
        ),
      );
    }

    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      children: [
        KzPageTitle(title: l.notifPrefsTitle, subtitle: l.notifPrefsSubtitle),
        if (ref
                .watch(permissionStatusProvider(AppPermission.notifications))
                .value
            case final s? when s != AppPermissionStatus.granted) ...[
          KzTip(
            icon: KzIcons.bell,
            tone: KzTipTone.warning,
            title: l.systemNotifOffTitle,
            message: l.systemNotifOffBody,
            link: (
              l.turnOnNotifications,
              () => s == AppPermissionStatus.blocked
                  ? ref.read(permissionServiceProvider).openSettings()
                  : context.push(AppRoutes.notificationPermission),
            ),
          ),
          const SizedBox(height: KzSpace.s16),
        ],
        KzGroup(
          title: l.groupForYou,
          rows: [row(NotifTopic.promotions), row(NotifTopic.stayReminders)],
        ),
        const SizedBox(height: KzSpace.s20),
        KzGroup(
          title: l.groupFromKozalak,
          rows: [
            row(NotifTopic.news),
            row(NotifTopic.surveys),
            row(NotifTopic.ruleUpdates),
          ],
        ),
        const SizedBox(height: KzSpace.s20),
        KzButton(
          label: l.disableMarketing,
          variant: KzButtonVariant.outline,
          onPressed: p.anyMarketingOn
              ? () async {
                  await notifier.disableMarketing();
                  if (context.mounted) {
                    showKzToast(context, l.marketingDisabled);
                  }
                }
              : null,
        ),
      ],
    );
  }
}

/// 70 · Gizlilik.
class PrivacyScreen extends ConsumerWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final privacy = ref.watch(privacyProvider);
    final p = privacy.value;
    if (p == null) {
      return privacy.hasError
          ? BookingError(onRetry: () => ref.invalidate(privacyProvider))
          : const BookingLoading(cards: 2);
    }
    final kz = context.kz;
    final l = context.l10n;
    final notifier = ref.read(privacyProvider.notifier);

    KzSwitch toggle(bool v, String label, PrivacySettings Function(bool) set) =>
        KzSwitch(
          value: v,
          semanticLabel: label,
          onChanged: (x) => notifier.save(set(x)),
        );

    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      children: [
        KzPageTitle(title: l.privacyTitle, subtitle: l.privacySubtitle),
        KzGroup(
          title: l.groupVisibility,
          rows: [
            KzRow(
              icon: KzIcons.user,
              title: l.showProfileTitle,
              subtitle: l.showProfileBody,
              trailing: toggle(
                p.showProfileToHosts,
                l.showProfileTitle,
                (v) => p.copyWith(showProfileToHosts: v),
              ),
            ),
            KzRow(
              icon: KzIcons.star,
              title: l.showNameTitle,
              subtitle: l.showNameBody,
              trailing: toggle(
                p.showNameInReviews,
                l.showNameTitle,
                (v) => p.copyWith(showNameInReviews: v),
              ),
            ),
          ],
        ),
        const SizedBox(height: KzSpace.s20),
        KzGroup(
          title: l.groupDataPermissions,
          rows: [
            KzRow(
              icon: KzIcons.pin,
              tone: KzIconBoxTone.pool,
              title: l.locationTitle,
              subtitle: l.locationBody,
              // Açarken sistem izni yoksa önce 80 · Konum İzni sorulur.
              trailing: KzSwitch(
                value: p.locationAccess,
                semanticLabel: l.locationTitle,
                onChanged: (v) async {
                  if (v && !await ensureLocationPermission(context, ref)) {
                    return;
                  }
                  await notifier.save(p.copyWith(locationAccess: v));
                },
              ),
            ),
            KzRow(
              icon: KzIcons.sparkles,
              tone: KzIconBoxTone.apricot,
              title: l.personalizedTitle,
              subtitle: l.personalizedBody,
              trailing: toggle(
                p.personalizedRecs,
                l.personalizedTitle,
                (v) => p.copyWith(personalizedRecs: v),
              ),
            ),
          ],
        ),
        const SizedBox(height: KzSpace.s20),
        KzGroup(
          title: l.groupYourData,
          rows: [
            KzRow(
              icon: KzIcons.doc,
              title: l.downloadData,
              subtitle: l.downloadDataSub,
              onPressed: () async {
                await ref.read(accountRepositoryProvider).requestDataExport();
                if (context.mounted) {
                  showKzToast(context, l.dataExportRequested);
                }
              },
            ),
            KzRow(
              icon: KzIcons.doc,
              title: l.privacyNoticeRow,
              onPressed: () =>
                  context.push(AppRoutes.legalDoc(LegalDoc.kvkk.name)),
            ),
            KzRow(
              icon: KzIcons.trash,
              tone: KzIconBoxTone.apricot,
              title: l.deleteAccountData,
              titleColor: kz.apricotText,
              onPressed: () => context.push(AppRoutes.closeAccount),
            ),
          ],
        ),
      ],
    );
  }
}
