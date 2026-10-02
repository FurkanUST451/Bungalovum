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
import '../../../../core/widgets/kz_dashed_border.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../data/booking_repository.dart';
import '../../domain/payment.dart';
import '../../domain/price_calculator.dart';
import '../booking_labels.dart';
import '../../../wallet/presentation/controllers/wallet_controllers.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/booking_parts.dart';
import '../widgets/card_form.dart';
import '../widgets/coupon_sheet.dart';

/// 34 · Ödeme (kayıtlı kart) ve 35 · Ödeme (yeni kart). Kayıtlı kart yoksa
/// doğrudan kart formu açılır.
class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key, this.newCard = false, this.today});

  final bool newCard;

  /// Son kullanma kontrolü için bugün (testte sabitlenir).
  final DateTime? today;

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  late final _form = CardFormController(fixedToday: widget.today)
    ..addListener(_formChanged);
  bool _loading = false;

  // Taksit sorgusu BIN'e bağlı; numara değişince yeniden çiz.
  void _formChanged() => setState(() {});

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _pay(PaymentMethod? Function() method) async {
    if (_loading) return;
    final m = method();
    if (m == null) return;
    HapticFeedback.lightImpact();
    setState(() => _loading = true);
    try {
      await ref.read(checkoutControllerProvider.notifier).pay(m);
      if (mounted) context.push(AppRoutes.payment3ds);
    } on Object {
      if (mounted) showKzToast(context, context.l10n.errorPaymentStart);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkout = ref.watch(checkoutControllerProvider);
    final listingId = checkout.listingId;
    if (listingId == null) {
      // Akış dışından (ör. uygulama yeniden açıldı) gelindiyse.
      return BookingError(onRetry: () => context.go(AppRoutes.explore));
    }
    final quote = ref.watch(checkoutQuoteProvider).value;
    final cards = widget.newCard
        ? const AsyncData(<PaymentCard>[])
        : ref.watch(savedCardsProvider);

    return switch (cards) {
      AsyncData(:final value) => _content(
        total: quote == null ? null : PriceCalculator.total(quote),
        cards: value,
        checkout: checkout,
      ),
      AsyncError() => BookingError(
        onRetry: () => ref.invalidate(savedCardsProvider),
      ),
      _ => const BookingLoading(),
    };
  }

  Widget _content({
    required int? total,
    required List<PaymentCard> cards,
    required CheckoutState checkout,
  }) {
    final l = context.l10n;
    final useForm = cards.isEmpty;
    final selected = useForm
        ? null
        : cards.where((c) => c.id == checkout.cardId).firstOrNull ??
              cards.where((c) => c.isDefault).firstOrNull ??
              cards.first;
    final amount = total == null ? null : KzFormat.currency(total);

    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.back),
        trailing: amount == null
            ? null
            : Semantics(
                label: l.totalAmount(amount),
                excludeSemantics: true,
                child: KzChip(
                  label: amount,
                  variant: KzChipVariant.selected,
                  size: KzChipSize.large,
                ),
              ),
      ),
      bottomBar: KzBottomBar(
        child: KzButton(
          label: checkout.isRequest
              ? l.sendRequest
              : amount == null
              ? l.paymentTitle
              : l.payAmount(amount),
          trailingArrow: true,
          loading: _loading,
          onPressed: total == null
              ? null
              : () => _pay(() {
                  if (!useForm) return SavedCardMethod(selected!);
                  final input = _form.submit();
                  return input == null ? null : NewCardMethod(input);
                }),
        ),
      ),
      children: [
        KzPageTitle(title: l.paymentTitle),
        if (useForm)
          CardForm(controller: _form)
        else ...[
          KzOverline(l.savedCards),
          const SizedBox(height: KzSpace.s10),
          for (final card in cards) ...[
            _SavedCardTile(
              card: card,
              selected: card.id == selected!.id,
              onPressed: () => ref
                  .read(checkoutControllerProvider.notifier)
                  .selectCard(card.id),
            ),
            const SizedBox(height: KzSpace.s10),
          ],
          _NewCardButton(
            onPressed: () => context.push(AppRoutes.paymentNewCard),
          ),
        ],
        const SizedBox(height: KzSpace.s20),
        _Installments(
          cardId: selected?.id,
          bin: useForm ? _form.bin : null,
          selected: checkout.installments,
          showNote: useForm,
        ),
        const SizedBox(height: KzSpace.s16),
        _CouponRow(checkout: checkout),
        if (checkout.isRequest && amount != null) ...[
          const SizedBox(height: KzSpace.s12),
          KzTip(
            icon: KzIcons.clock,
            tone: KzTipTone.success,
            message: l.provisionNote(amount),
          ),
        ],
        const SizedBox(height: KzSpace.s12),
        KzTip(icon: KzIcons.shield, message: l.paymentSecure),
      ],
    );
  }
}

/// Kayıtlı kart satırı: radyo + marka kutusu + "Visa •••• 4242".
class _SavedCardTile extends StatelessWidget {
  const _SavedCardTile({
    required this.card,
    required this.selected,
    required this.onPressed,
  });

  final PaymentCard card;
  final bool selected;
  final VoidCallback onPressed;

  static const Size _brandBox = Size(44, 30);

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final title = card.title(l);
    final subtitle = card.subtitle(l);
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      child: KzPressable(
        onPressed: onPressed,
        semanticLabel: '$title, $subtitle',
        child: AnimatedContainer(
          duration: KzMotion.of(context, KzMotion.micro),
          padding: const EdgeInsets.symmetric(
            horizontal: KzSpace.s16,
            vertical: KzSpace.s14,
          ),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.field),
            border: Border.all(
              color: selected ? kz.forest : kz.line,
              width: selected ? KzSize.borderFocus : KzSize.border,
            ),
          ),
          child: Row(
            children: [
              KzRadio(value: selected),
              const SizedBox(width: KzSpace.s12),
              Container(
                width: _brandBox.width,
                height: _brandBox.height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? kz.forest : kz.sand,
                  borderRadius: KzRadii.all(KzRadii.xs),
                ),
                child: KzIcon(
                  KzIcons.card,
                  size: KzSpace.s16,
                  color: selected ? kz.onForest : kz.ink,
                ),
              ),
              const SizedBox(width: KzSpace.s12),
              Expanded(
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
                      style: KzText.caption.copyWith(color: kz.ink2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Kesikli çerçeveli "+ Yeni kartla öde".
class _NewCardButton extends StatelessWidget {
  const _NewCardButton({required this.onPressed});

  final VoidCallback onPressed;

  static const double _height = 56;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: l.payWithNewCard,
      child: KzDashedBorder(
        radius: KzRadii.field,
        child: Container(
          height: _height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.field),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              KzIcon(KzIcons.plus, size: KzSpace.s16, color: kz.forest),
              const SizedBox(width: KzSpace.s8),
              Flexible(
                child: Text(
                  l.payWithNewCard,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: KzText.bodySm.copyWith(
                    color: kz.forest,
                    fontWeight: KzText.extraBold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "Taksit seçenekleri" + seçim chip'leri (+ not).
class _Installments extends ConsumerWidget {
  const _Installments({
    required this.cardId,
    required this.bin,
    required this.selected,
    required this.showNote,
  });

  final String? cardId;
  final String? bin;
  final int selected;
  final bool showNote;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final options = ref
        .watch(installmentOptionsProvider(cardId: cardId, bin: bin))
        .value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            l.installmentsTitle,
            style: KzText.titleSm.copyWith(color: kz.ink),
          ),
        ),
        const SizedBox(height: KzSpace.s10),
        if (options == null)
          KzSkeleton(
            width: KzSize.tile * 4,
            height: KzSize.minTouch,
            borderRadius: KzRadii.all(KzRadii.pill),
          )
        else
          Wrap(
            spacing: KzSpace.s8,
            runSpacing: KzSpace.s8,
            children: [
              for (final n in options)
                Semantics(
                  inMutuallyExclusiveGroup: true,
                  checked: n == selected,
                  child: KzChip(
                    label: installmentLabel(l, n),
                    variant: n == selected
                        ? KzChipVariant.filled
                        : KzChipVariant.outline,
                    onPressed: () => ref
                        .read(checkoutControllerProvider.notifier)
                        .setInstallments(n),
                  ),
                ),
            ],
          ),
        if (showNote) ...[
          const SizedBox(height: KzSpace.s10),
          Text(
            l.installmentsNote,
            style: KzText.caption.copyWith(color: kz.ink2),
          ),
        ],
      ],
    );
  }
}

/// "Kupon kodun var mı? · Ekle" ya da uygulanmış kupon + "Kaldır".
class _CouponRow extends ConsumerWidget {
  const _CouponRow({required this.checkout});

  final CheckoutState checkout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final code = checkout.couponCode;
    final q = checkout.couponQuote;
    final linkStyle = KzText.bodySm.copyWith(fontWeight: KzText.extraBold);
    if (code == null || q == null) {
      return KzActionRow(
        icon: KzIcons.ticket,
        tone: KzIconBoxTone.apricot,
        title: l.couponTitle,
        subtitle: l.couponSubtitle,
        chevron: false,
        onPressed: () => showCouponSheet(context),
        trailing: KzLink(
          label: l.add,
          style: linkStyle,
          onPressed: () => showCouponSheet(context),
        ),
      );
    }
    return KzActionRow(
      icon: KzIcons.ticket,
      tone: KzIconBoxTone.forest,
      title: l.couponApplied(code),
      subtitle: l.couponSaving(KzFormat.currency(q.discount)),
      chevron: false,
      trailing: KzLink(
        label: l.couponRemove,
        style: linkStyle,
        onPressed: () =>
            ref.read(checkoutControllerProvider.notifier).removeCoupon(),
      ),
    );
  }
}
