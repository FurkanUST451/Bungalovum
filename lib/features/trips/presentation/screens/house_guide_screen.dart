import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_checkbox.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../chat/presentation/controllers/chat_controllers.dart';
import '../../../booking/data/booking_repository.dart';
import '../../../booking/domain/booking.dart';
import '../../../booking/presentation/widgets/booking_parts.dart';
import '../../../listing/data/listing_repository.dart';
import '../../../listing/domain/house_guide.dart';
import '../../domain/trip_models.dart';
import '../controllers/trips_controller.dart';
import 'trip_detail_screen.dart' show revealLabel;

/// 50 · Ev Kılavuzu.
class HouseGuideScreen extends ConsumerWidget {
  const HouseGuideScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingProvider(bookingId));
    final access = ref.watch(tripAccessProvider(bookingId));
    return switch ((booking, access)) {
      (AsyncData(value: final b), AsyncData(value: final a)) => _Content(
        booking: b,
        access: a,
      ),
      (AsyncError(), _) || (_, AsyncError()) => BookingError(
        onRetry: () => ref
          ..invalidate(bookingProvider(bookingId))
          ..invalidate(tripAccessProvider(bookingId)),
      ),
      _ => const BookingLoading(),
    };
  }
}

class _Content extends ConsumerWidget {
  const _Content({required this.booking, required this.access});

  final Booking booking;
  final TripAccess access;

  static const double _bullet = 6;

  Future<void> _copy(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) showKzToast(context, context.l10n.codeCopied);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final b = booking;
    final title = ref
        .watch(listingDetailProvider(b.listingId))
        .value
        ?.listing
        .title;
    final done = ref.watch(checkoutChecklistProvider(b.id));

    Widget section(GuideSection s) => BookingCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              KzIconBox(
                icon: switch (s.kind) {
                  GuideSectionKind.pool => KzIcons.waves,
                  GuideSectionKind.house => KzIcons.home,
                  GuideSectionKind.kitchen => KzIcons.food,
                  GuideSectionKind.outdoor => KzIcons.trees,
                  GuideSectionKind.other => KzIcons.info,
                },
                tone: s.kind == GuideSectionKind.pool
                    ? KzIconBoxTone.pool
                    : KzIconBoxTone.sand,
                size: KzSpace.s36,
              ),
              const SizedBox(width: KzSpace.s10),
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(
                    s.title,
                    style: KzText.bodyStrong.copyWith(
                      color: kz.ink,
                      fontWeight: KzText.extraBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          for (final item in s.items) ...[
            const SizedBox(height: KzSpace.s12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: _bullet,
                  height: _bullet,
                  margin: const EdgeInsets.only(top: KzSpace.s8),
                  decoration: BoxDecoration(
                    color: kz.forest,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: KzSpace.s10),
                Expanded(
                  child: Text(
                    item,
                    style: KzText.bodySm.copyWith(
                      color: kz.ink,
                      height: KzText.body.height,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );

    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      bottomBar: KzBottomBar(
        child: Row(
          children: [
            Expanded(
              child: KzButton(
                label: l.messageHost,
                variant: KzButtonVariant.secondary,
                onPressed: () => openBookingChat(context, ref, b.id),
              ),
            ),
            const SizedBox(width: KzSpace.s10),
            Expanded(
              child: KzButton(
                label: l.reportIssueShort,
                variant: KzButtonVariant.dark,
                onPressed: () => context.push(AppRoutes.reportIssue(b.id)),
              ),
            ),
          ],
        ),
      ),
      children: [
        KzPageTitle(
          title: l.houseGuideTitle,
          subtitle: [
            ?title,
            KzFormat.dateRange(b.dates.checkIn, b.dates.checkOut),
          ].join(' · '),
        ),
        _LockboxCard(access: access, onCopy: (c) => _copy(context, c)),
        const SizedBox(height: KzSpace.s16),
        BookingCard(
          padding: const EdgeInsets.all(KzSpace.s16),
          child: Row(
            children: [
              KzIconBox(
                icon: access.wifiName == null ? KzIcons.lock : KzIcons.wifi,
                tone: KzIconBoxTone.pool,
                size: KzSize.minTouch,
              ),
              const SizedBox(width: KzSpace.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      access.wifiName ?? l.wifiLabel,
                      style: KzText.titleSm.copyWith(color: kz.ink),
                    ),
                    const SizedBox(height: KzSpace.s2),
                    Text(
                      access.wifiPassword == null
                          ? l.wifiLocked
                          : l.wifiPasswordLine(access.wifiPassword!),
                      style: KzText.labelMedium.copyWith(color: kz.ink2),
                    ),
                  ],
                ),
              ),
              if (access.wifiPassword != null)
                KzChip(
                  label: l.copy,
                  icon: KzIcons.copy,
                  variant: KzChipVariant.soft,
                  size: KzChipSize.small,
                  semanticLabel: '${l.copy}, ${l.wifiLabel}',
                  onPressed: () => _copy(context, access.wifiPassword!),
                ),
            ],
          ),
        ),
        for (final s in access.sections) ...[
          const SizedBox(height: KzSpace.s16),
          section(s),
        ],
        if (access.checkoutTasks.isNotEmpty) ...[
          const SizedBox(height: KzSpace.s16),
          BookingCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const KzIconBox(
                      icon: KzIcons.door,
                      tone: KzIconBoxTone.apricot,
                      size: KzSpace.s36,
                    ),
                    const SizedBox(width: KzSpace.s10),
                    Expanded(
                      child: Semantics(
                        header: true,
                        child: Text(
                          l.checkoutAt(
                            KzFormat.dayMonth(b.dates.checkOut),
                            access.checkOutBy,
                          ),
                          style: KzText.bodyStrong.copyWith(
                            color: kz.ink,
                            fontWeight: KzText.extraBold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                for (final (i, task) in access.checkoutTasks.indexed) ...[
                  const SizedBox(height: KzSpace.s12),
                  KzCheckboxTile(
                    value: done.contains(i),
                    size: KzSize.checkboxLg,
                    gap: KzSpace.s12,
                    semanticLabel: task,
                    onChanged: (_) => ref
                        .read(checkoutChecklistProvider(b.id).notifier)
                        .toggle(i),
                    label: Padding(
                      padding: const EdgeInsets.only(top: KzSpace.s2),
                      child: Text(
                        task,
                        style: done.contains(i)
                            ? KzText.bodySm.copyWith(
                                color: kz.ink2,
                                fontWeight: KzText.semiBold,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: kz.ink2,
                              )
                            : KzText.bodySm.copyWith(color: kz.ink),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// Forest kart: anahtar kutusu şifresi (açılmadan önce kilitli).
class _LockboxCard extends StatelessWidget {
  const _LockboxCard({required this.access, required this.onCopy});

  final TripAccess access;
  final ValueChanged<String> onCopy;

  /// Rakamlar arası boşluk (Figma: "4  8  2  9").
  static const String _digitGap = '  ';

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final code = access.lockboxCode;
    return Container(
      padding: const EdgeInsets.all(KzSpace.s20),
      decoration: BoxDecoration(
        color: kz.forest,
        borderRadius: KzRadii.all(KzRadii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              KzIcon(
                code == null ? KzIcons.lock : KzIcons.key,
                size: KzSize.iconSm,
                color: kz.forestSoft,
              ),
              const SizedBox(width: KzSpace.s8),
              Expanded(
                child: Text(
                  l.lockboxCode,
                  style: KzText.labelSemi.copyWith(color: kz.forestSoft),
                ),
              ),
              if (code != null)
                KzChip(
                  label: l.copy,
                  icon: KzIcons.copy,
                  iconColor: kz.forest,
                  labelColor: kz.forest,
                  variant: KzChipVariant.onImage,
                  size: KzChipSize.mini,
                  semanticLabel: '${l.copy}, ${l.lockboxCode}',
                  onPressed: () => onCopy(code),
                ),
            ],
          ),
          const SizedBox(height: KzSpace.s8),
          if (code != null) ...[
            Semantics(
              label: '${l.lockboxCode}: ${code.split('').join(' ')}',
              excludeSemantics: true,
              child: Text(
                code.split('').join(_digitGap),
                style: KzText.display.copyWith(color: kz.onForest),
              ),
            ),
            const SizedBox(height: KzSpace.s8),
            Text(
              l.lockboxHintLine(access.lockboxHint ?? '', access.checkInFrom),
              style: KzText.caption.copyWith(color: kz.forestSoft),
            ),
          ] else
            Text(
              l.lockboxLocked(revealLabel(access.revealAt)),
              style: KzText.bodySm.copyWith(color: kz.onForest),
            ),
        ],
      ),
    );
  }
}
