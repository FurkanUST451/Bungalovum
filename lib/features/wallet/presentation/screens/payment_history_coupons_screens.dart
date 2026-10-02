import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/clock.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_accordion.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_group.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_segmented.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/domain/payment.dart';
import '../../../booking/presentation/booking_labels.dart';
import '../../../listing/data/listing_repository.dart';
import '../../domain/wallet_models.dart';
import '../controllers/wallet_controllers.dart';

enum _HistoryTab { payments, refunds }

/// 76 · Ödeme Geçmişi.
class PaymentHistoryScreen extends ConsumerStatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  ConsumerState<PaymentHistoryScreen> createState() =>
      _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends ConsumerState<PaymentHistoryScreen> {
  _HistoryTab _tab = _HistoryTab.payments;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final history = ref.watch(paymentHistoryProvider);
    final records = history.value;
    final shown = records
        ?.where(
          (r) => _tab == _HistoryTab.refunds
              ? r.kind == PaymentKind.refund
              : r.kind != PaymentKind.refund,
        )
        .toList();

    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      children: [
        KzPageTitle(title: l.paymentHistoryTitle),
        KzSegmented<_HistoryTab>(
          segments: [
            (_HistoryTab.payments, l.paymentsTab),
            (_HistoryTab.refunds, l.refundsTab),
          ],
          selected: _tab,
          onChanged: (t) => setState(() => _tab = t),
        ),
        const SizedBox(height: KzSpace.s16),
        if (history.hasError && records == null)
          KzTip(
            icon: KzIcons.info,
            tone: KzTipTone.warning,
            message: l.errorNetwork,
            link: (l.retry, () => ref.invalidate(paymentHistoryProvider)),
          )
        else if (shown == null)
          KzSkeleton(
            height: KzSize.tabBar * 2,
            borderRadius: KzRadii.all(KzRadii.card),
          )
        else if (shown.isEmpty)
          KzEmptyState(
            illustration: const KzSpotIllustration(
              icon: KzIcons.receipt,
              tone: KzSpotTone.pool,
              dot: KzSpotDot.forest,
            ),
            title: _tab == _HistoryTab.payments
                ? l.noPaymentsTitle
                : l.noRefundsTitle,
            body: _tab == _HistoryTab.payments
                ? l.noPaymentsBody
                : l.noRefundsBody,
          )
        else
          KzGroup(rows: [for (final r in shown) _PaymentRow(record: r)]),
        const SizedBox(height: KzSpace.s16),
        KzTip(
          icon: KzIcons.help,
          title: l.lookingForPaymentTitle,
          message: l.lookingForPaymentBody,
          link: (l.lookingForPaymentLink, () => context.push(AppRoutes.help)),
        ),
      ],
    );
  }
}

class _PaymentRow extends ConsumerWidget {
  const _PaymentRow({required this.record});

  final PaymentRecord record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final r = record;
    final title =
        ref.watch(listingDetailProvider(r.listingId)).value?.listing.title ??
        '';
    final card = r.cardLast4 == null
        ? r.cardBrand.label(l)
        : l.cardMasked(r.cardBrand.label(l), r.cardLast4!);
    final date = KzFormat.dayMonth(r.at);
    final (icon, tone, subtitle, amount, color) = switch (r.kind) {
      PaymentKind.payment => (
        KzIcons.receipt,
        KzIconBoxTone.pool,
        l.paymentLine(date, card),
        KzFormat.currency(r.amount),
        kz.ink,
      ),
      PaymentKind.provision => (
        KzIcons.clock,
        KzIconBoxTone.sand,
        l.provisionLine(date),
        KzFormat.currency(r.amount),
        kz.ink2,
      ),
      PaymentKind.refund => (
        KzIcons.receipt,
        KzIconBoxTone.forest,
        l.refundLine(date, card),
        l.refundAmount(KzFormat.currency(r.amount)),
        kz.forest,
      ),
    };
    return KzRow(
      icon: icon,
      tone: tone,
      title: title,
      subtitle: subtitle,
      trailing: Text(
        amount,
        textAlign: TextAlign.end,
        style: KzText.bodySm.copyWith(
          color: color,
          fontWeight: KzText.extraBold,
        ),
      ),
      onPressed: () => context.push(
        r.kind == PaymentKind.payment
            ? AppRoutes.receipt(r.bookingId)
            : AppRoutes.trip(r.bookingId),
      ),
    );
  }
}

/// 77 · Kuponlar.
class CouponsScreen extends ConsumerStatefulWidget {
  const CouponsScreen({super.key});

  @override
  ConsumerState<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends ConsumerState<CouponsScreen> {
  final _code = TextEditingController();
  bool _loading = false;
  String? _error;
  int? _open;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _redeem() async {
    final code = _code.text.trim();
    if (_loading || code.isEmpty) return;
    final l = context.l10n;
    HapticFeedback.lightImpact();
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref.read(couponsProvider.notifier).redeem(code);
      if (!mounted) return;
      _code.clear();
      FocusScope.of(context).unfocus();
      showKzToast(context, l.couponAdded);
    } on CouponRejected catch (e) {
      if (mounted) setState(() => _error = e.error.message(l));
    } on Object {
      if (mounted) setState(() => _error = l.errorNetwork);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final coupons = ref.watch(activeCouponsProvider).value;
    final now = ref.watch(clockProvider)();
    final faq = [
      (l.couponFaq1Q, l.couponFaq1A),
      (l.couponFaq2Q, l.couponFaq2A),
      (l.couponFaq3Q, l.couponFaq3A),
    ];

    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      children: [
        KzPageTitle(title: l.couponsTitle),
        KzInput(
          label: l.fieldCouponCode,
          hint: l.hintCouponCode,
          controller: _code,
          errorText: _error,
          textCapitalization: TextCapitalization.characters,
          textInputAction: TextInputAction.done,
          onChanged: (_) => setState(() => _error = null),
          onSubmitted: (_) => _redeem(),
        ),
        const SizedBox(height: KzSpace.s12),
        KzButton(
          label: l.applyCode,
          loading: _loading,
          onPressed: _code.text.trim().isEmpty ? null : _redeem,
        ),
        const SizedBox(height: KzSpace.s12),
        Text(l.couponTermsNote, style: KzText.caption.copyWith(color: kz.ink2)),
        const SizedBox(height: KzSpace.s16),
        KzGroup(
          rows: [
            if (coupons == null || coupons.isEmpty)
              KzRow(
                icon: KzIcons.ticket,
                tone: KzIconBoxTone.apricot,
                title: l.yourCoupons,
                subtitle: coupons == null ? null : l.noActiveCoupons,
              )
            else
              for (final c in coupons)
                KzRow(
                  icon: KzIcons.ticket,
                  tone: KzIconBoxTone.apricot,
                  title: _couponTitle(l, c),
                  subtitle: l.couponLine(
                    c.code,
                    KzFormat.dayMonth(c.expiresAt),
                    c.expiresAt.difference(now).inDays,
                  ),
                ),
          ],
        ),
        const SizedBox(height: KzSpace.s20),
        KzGroup(
          title: l.groupCouponFaq,
          rows: [
            for (final (i, (q, a)) in faq.indexed)
              KzAccordionRow(
                title: q,
                body: a,
                open: _open == i,
                onPressed: () => setState(() => _open = _open == i ? null : i),
              ),
          ],
        ),
      ],
    );
  }

  String _couponTitle(AppLocalizations l, Coupon c) => switch (c.kind) {
    CouponKind.percent => l.couponPercentOff(c.value),
    CouponKind.amount => l.couponSaving(KzFormat.currency(c.value)),
  };
}
