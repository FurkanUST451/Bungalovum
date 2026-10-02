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
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../controllers/booking_draft.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/booking_parts.dart';

/// 37 · Ödeme Başarısız. Karttan ücret çekilmedi; tarihler bir süre daha
/// tutulur.
class PaymentFailedScreen extends ConsumerStatefulWidget {
  const PaymentFailedScreen({super.key});

  @override
  ConsumerState<PaymentFailedScreen> createState() =>
      _PaymentFailedScreenState();
}

class _PaymentFailedScreenState extends ConsumerState<PaymentFailedScreen> {
  bool _retrying = false;

  static const double _bullet = 8;

  Future<void> _retry() async {
    setState(() => _retrying = true);
    try {
      await ref.read(checkoutControllerProvider.notifier).retry();
      if (mounted) context.pushReplacement(AppRoutes.payment3ds);
    } on Object {
      if (mounted) showKzToast(context, context.l10n.errorPaymentStart);
    } finally {
      if (mounted) setState(() => _retrying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final checkout = ref.watch(checkoutControllerProvider);
    final declined = checkout.declined;
    final listingId = checkout.listingId;
    if (declined == null || listingId == null) {
      return BookingError(onRetry: () => context.go(AppRoutes.explore));
    }
    final dates = ref.watch(bookingDraftControllerProvider(listingId)).dates;
    final canRetry = ref.read(checkoutControllerProvider.notifier).canRetry;
    final gutter = context.screenGutter;

    Widget bullet(String text) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: _bullet,
          height: _bullet,
          margin: const EdgeInsets.only(top: KzSpace.s6),
          decoration: BoxDecoration(color: kz.ink2, shape: BoxShape.circle),
        ),
        const SizedBox(width: KzSpace.s10),
        Expanded(
          child: Text(
            text,
            style: KzText.labelMedium.copyWith(
              color: kz.ink,
              height: KzText.caption.height,
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: kz.bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: gutter),
                child: KzMaxWidth(
                  maxWidth: KzBreakpoints.formContent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: KzSpace.s36 + KzSpace.s14),
                      const Center(
                        child: KzSpotIllustration(
                          icon: KzIcons.card,
                          tone: KzSpotTone.apricot,
                          badge: KzSpotBadge.warning,
                          badgeIcon: KzIcons.alert,
                          dot: KzSpotDot.pool,
                          large: true,
                        ),
                      ),
                      const SizedBox(height: KzSpace.s14),
                      Semantics(
                        header: true,
                        child: Text(
                          l.payFailedTitle,
                          textAlign: TextAlign.center,
                          style: KzText.h4.copyWith(color: kz.ink),
                        ),
                      ),
                      const SizedBox(height: KzSpace.s14),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: KzSpace.s16,
                        ),
                        child: Text(
                          l.payFailedBody,
                          textAlign: TextAlign.center,
                          style: KzText.bodySm.copyWith(
                            color: kz.ink2,
                            height: KzText.body.height,
                          ),
                        ),
                      ),
                      const SizedBox(height: KzSpace.s18),
                      BookingCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Semantics(
                              header: true,
                              child: Text(
                                l.payFailedReasons,
                                style: KzText.titleSm.copyWith(color: kz.ink),
                              ),
                            ),
                            const SizedBox(height: KzSpace.s12),
                            bullet(l.payFailedLimit),
                            const SizedBox(height: KzSpace.s12),
                            bullet(l.payFailedCode),
                            const SizedBox(height: KzSpace.s12),
                            bullet(l.payFailedOnline),
                          ],
                        ),
                      ),
                      if (dates != null) ...[
                        const SizedBox(height: KzSpace.s16),
                        CountdownBuilder(
                          until: declined.holdUntil,
                          builder: (context, left) {
                            final range = KzFormat.dateRange(
                              dates.checkIn,
                              dates.checkOut,
                            );
                            return KzTip(
                              icon: KzIcons.clock,
                              tone: left == Duration.zero
                                  ? KzTipTone.warning
                                  : KzTipTone.success,
                              message: left == Duration.zero
                                  ? l.payFailedHoldOver(range)
                                  : l.payFailedHold(
                                      range,
                                      KzFormat.countdown(left),
                                    ),
                            );
                          },
                        ),
                      ],
                      const SizedBox(height: KzSpace.s24),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                gutter,
                KzSpace.s10,
                gutter,
                KzSpace.s14,
              ),
              child: KzMaxWidth(
                maxWidth: KzBreakpoints.formContent,
                child: Column(
                  children: [
                    KzButton(
                      label: l.payOtherCard,
                      onPressed: _retrying ? null : () => context.pop(),
                    ),
                    if (canRetry) ...[
                      const SizedBox(height: KzSpace.s10),
                      KzButton(
                        label: l.payRetrySame,
                        variant: KzButtonVariant.secondary,
                        loading: _retrying,
                        onPressed: _retry,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
