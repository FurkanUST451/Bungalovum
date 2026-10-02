import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_checkbox.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/data/booking_repository.dart';
import '../../../booking/domain/booking.dart';
import '../../../booking/presentation/widgets/booking_parts.dart';
import '../../../listing/data/listing_repository.dart';
import '../../domain/trip_models.dart';
import '../../domain/trips_overview.dart';
import '../controllers/trips_controller.dart';

/// 54 · Rezervasyonu İptal Et. İade tutarını backend hesaplar.
class CancelBookingScreen extends ConsumerWidget {
  const CancelBookingScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingProvider(bookingId));
    final quote = ref.watch(cancellationQuoteProvider(bookingId));
    return switch ((booking, quote)) {
      (AsyncData(value: final b), AsyncData(value: final q)) => _CancelForm(
        booking: b,
        quote: q,
      ),
      (AsyncError(), _) || (_, AsyncError()) => BookingError(
        onRetry: () => ref
          ..invalidate(bookingProvider(bookingId))
          ..invalidate(cancellationQuoteProvider(bookingId)),
      ),
      _ => const BookingLoading(),
    };
  }
}

class _CancelForm extends ConsumerStatefulWidget {
  const _CancelForm({required this.booking, required this.quote});

  final Booking booking;
  final CancellationQuote quote;

  @override
  ConsumerState<_CancelForm> createState() => _CancelFormState();
}

class _CancelFormState extends ConsumerState<_CancelForm> {
  CancelReason? _reason;
  bool _cancelling = false;

  Future<void> _confirm() async {
    if (_reason == null || _cancelling) return;
    HapticFeedback.mediumImpact();
    setState(() => _cancelling = true);
    try {
      await ref
          .read(tripActionsProvider.notifier)
          .cancelBooking(widget.booking.id, _reason!);
      if (!mounted) return;
      showKzToast(context, context.l10n.bookingCancelled);
      ref.read(selectedTripsTabProvider.notifier).select(TripsTab.cancelled);
      context.go(AppRoutes.trips);
    } on Object {
      if (mounted) showKzToast(context, context.l10n.errorNetwork);
    } finally {
      if (mounted) setState(() => _cancelling = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final b = widget.booking;
    final q = widget.quote;
    final title = ref
        .watch(listingDetailProvider(b.listingId))
        .value
        ?.listing
        .title;
    final deadline = KzFormat.dayMonthTimeAblative(q.freeUntil);
    final reasons = [
      (CancelReason.plansChanged, l.reasonPlansChanged),
      (CancelReason.foundOther, l.reasonFoundOther),
      (CancelReason.hostAsked, l.reasonHostAsked),
      (CancelReason.other, l.reasonOther),
    ];

    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      bottomBar: KzBottomBar(
        child: Row(
          children: [
            Expanded(
              child: KzButton(
                label: l.keepBooking,
                variant: KzButtonVariant.secondary,
                onPressed: () => context.pop(),
              ),
            ),
            const SizedBox(width: KzSpace.s10),
            Expanded(
              child: KzButton(
                label: l.confirmCancel,
                variant: KzButtonVariant.destructive,
                loading: _cancelling,
                onPressed: _reason == null ? null : _confirm,
              ),
            ),
          ],
        ),
      ),
      children: [
        KzPageTitle(
          title: l.cancelTitle,
          subtitle: [
            ?title,
            KzFormat.dateRange(b.dates.checkIn, b.dates.checkOut),
          ].join(' · '),
        ),
        // İade kartı.
        Semantics(
          container: true,
          child: Container(
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
                    Expanded(
                      child: Text(
                        l.refundAmountLabel,
                        style: KzText.labelSemi.copyWith(color: kz.forestSoft),
                      ),
                    ),
                    KzChip(
                      label: q.fullRefund
                          ? l.fullRefundChip
                          : q.noRefund
                          ? l.noRefundChip
                          : l.partialRefundChip,
                      icon: q.noRefund ? KzIcons.x : KzIcons.check,
                      iconColor: q.noRefund ? kz.apricotText : kz.forest,
                      labelColor: q.noRefund ? kz.apricotText : kz.forest,
                      variant: KzChipVariant.onImage,
                      size: KzChipSize.mini,
                    ),
                  ],
                ),
                const SizedBox(height: KzSpace.s14),
                Text(
                  KzFormat.currency(q.refund),
                  style: KzText.display.copyWith(color: kz.onForest),
                ),
                const SizedBox(height: KzSpace.s14),
                Text(
                  q.fullRefund
                      ? l.fullRefundNote(deadline)
                      : l.partialRefundNote(KzFormat.dayMonthTime(q.freeUntil)),
                  style: KzText.labelMedium.copyWith(
                    color: kz.forestSoft,
                    height: KzText.caption.height,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: KzSpace.s16),
        BookingCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BookingValueRow(
                label: l.amountPaid,
                value: KzFormat.currency(q.paid),
              ),
              const SizedBox(height: KzSpace.s14),
              BookingValueRow(
                label: l.deductionLabel,
                value: q.deduction == 0
                    ? KzFormat.currency(0)
                    : l.minusAmount(KzFormat.currency(q.deduction)),
                valueColor: q.deduction == 0 ? null : kz.apricotText,
              ),
              const SizedBox(height: KzSpace.s14),
              const BookingDivider(),
              const SizedBox(height: KzSpace.s14),
              BookingValueRow(
                label: l.refundLabel,
                value: KzFormat.currency(q.refund),
                valueWeight: KzText.extraBold,
              ),
              const SizedBox(height: KzSpace.s14),
              Text(
                l.refundTimingNote,
                style: KzText.caption.copyWith(color: kz.ink2),
              ),
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s20),
        KzOverline(l.cancelReasonTitle),
        const SizedBox(height: KzSpace.s10),
        Container(
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.card),
            border: Border.all(color: kz.line),
          ),
          child: Column(
            children: [
              for (final (reason, label) in reasons)
                Semantics(
                  inMutuallyExclusiveGroup: true,
                  checked: _reason == reason,
                  child: KzPressable(
                    onPressed: () => setState(() => _reason = reason),
                    semanticLabel: label,
                    pressedScale: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: KzSpace.s16,
                        vertical: KzSpace.s14,
                      ),
                      child: Row(
                        children: [
                          KzRadio(value: _reason == reason),
                          const SizedBox(width: KzSpace.s12),
                          Expanded(
                            child: Text(
                              label,
                              style: KzText.bodyStrongSm.copyWith(
                                color: kz.ink,
                                fontWeight: _reason == reason
                                    ? KzText.extraBold
                                    : KzText.medium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: KzSpace.s4),
          child: Row(
            children: [
              KzIcon(KzIcons.alert, size: KzSize.iconSm, color: kz.apricotText),
              const SizedBox(width: KzSpace.s10),
              Expanded(
                child: Text(
                  l.irreversible,
                  style: KzText.label.copyWith(color: kz.apricotText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
