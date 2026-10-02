import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_dashed_border.dart';
import '../../../../core/widgets/kz_group.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/domain/payment.dart';
import '../../../booking/presentation/booking_labels.dart';
import '../../../booking/presentation/widgets/booking_parts.dart';
import '../../../booking/presentation/widgets/card_form.dart';
import '../controllers/wallet_controllers.dart';

/// 73 · Cüzdan.
class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final cards = ref.watch(savedCardsProvider).value;
    final coupons = ref.watch(activeCouponsProvider).value;
    final card =
        cards?.where((c) => c.isDefault).firstOrNull ?? cards?.firstOrNull;
    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      children: [
        KzPageTitle(title: l.walletTitle),
        KzGroup(
          title: l.groupTravelPayments,
          rows: [
            KzRow(
              icon: KzIcons.card,
              tone: KzIconBoxTone.forest,
              title: l.paymentMethodsTitle,
              subtitle: cards == null
                  ? null
                  : card == null
                  ? l.noSavedCards
                  : card.title(l),
              onPressed: () => context.push(AppRoutes.paymentMethods),
            ),
            KzRow(
              icon: KzIcons.receipt,
              tone: KzIconBoxTone.pool,
              title: l.paymentHistoryTitle,
              subtitle: l.paymentHistorySub,
              onPressed: () => context.push(AppRoutes.paymentHistory),
            ),
            KzRow(
              icon: KzIcons.ticket,
              tone: KzIconBoxTone.apricot,
              title: l.couponsTitle,
              subtitle: coupons == null
                  ? null
                  : coupons.isEmpty
                  ? l.noActiveCoupons
                  : l.activeCouponsCount(coupons.length),
              onPressed: () => context.push(AppRoutes.coupons),
            ),
          ],
        ),
      ],
    );
  }
}

/// 74 · Ödeme Yöntemleri (boş) / 75 · (kayıtlı).
class PaymentMethodsScreen extends ConsumerWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(savedCardsProvider);
    return switch (cards) {
      AsyncData(:final value) => _content(context, ref, value),
      AsyncError() => BookingError(
        onRetry: () => ref.invalidate(savedCardsProvider),
      ),
      _ => const BookingLoading(cards: 2),
    };
  }

  Widget _content(
    BuildContext context,
    WidgetRef ref,
    List<PaymentCard> cards,
  ) {
    final l = context.l10n;
    void add() => context.push(AppRoutes.addCard);
    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      children: [
        if (cards.isEmpty) ...[
          KzPageTitle(
            title: l.paymentMethodsTitle,
            subtitle: l.paymentMethodsSubtitle,
          ),
          _AddCardPanel(onPressed: add),
          const SizedBox(height: KzSpace.s20),
          KzTip(
            icon: KzIcons.shield,
            tone: KzTipTone.info,
            title: l.payInAppTitle,
            message: l.payInAppBody,
            link: (l.payInAppLink, () => context.push(AppRoutes.help)),
          ),
        ] else ...[
          KzPageTitle(title: l.paymentMethodsTitle),
          KzGroup(
            title: l.savedCards,
            rows: [
              for (final c in cards)
                KzRow(
                  icon: KzIcons.card,
                  tone: c.isDefault ? KzIconBoxTone.forest : KzIconBoxTone.sand,
                  title: c.title(l),
                  subtitle: c.subtitle(l),
                  onPressed: () => _showCardSheet(context, ref, c),
                ),
            ],
          ),
          const SizedBox(height: KzSpace.s16),
          _AddCardButton(onPressed: add),
          const SizedBox(height: KzSpace.s16),
          KzTip(
            icon: KzIcons.shield,
            tone: KzTipTone.info,
            message: l.cardsStoredSafely,
          ),
        ],
      ],
    );
  }
}

Future<void> _showCardSheet(
  BuildContext context,
  WidgetRef ref,
  PaymentCard card,
) async {
  final l = context.l10n;
  final notifier = ref.read(savedCardsProvider.notifier);
  final action = await showKzSheet<_CardAction>(
    context: context,
    title: card.title(l),
    closeLabel: l.close,
    builder: (ctx) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          card.subtitle(l),
          style: KzText.bodySm.copyWith(color: ctx.kz.ink2),
        ),
        const SizedBox(height: KzSpace.s20),
        if (!card.isDefault) ...[
          KzButton(
            label: l.makeDefaultCard,
            variant: KzButtonVariant.secondary,
            onPressed: () => Navigator.of(ctx).pop(_CardAction.makeDefault),
          ),
          const SizedBox(height: KzSpace.s10),
        ],
        KzButton(
          label: l.removeCard,
          variant: KzButtonVariant.destructive,
          onPressed: () => Navigator.of(ctx).pop(_CardAction.remove),
        ),
      ],
    ),
  );
  if (action == null) return;
  try {
    switch (action) {
      case _CardAction.makeDefault:
        await notifier.makeDefault(card.id);
        if (context.mounted) showKzToast(context, l.defaultCardSet);
      case _CardAction.remove:
        await notifier.remove(card.id);
        if (context.mounted) showKzToast(context, l.cardRemoved);
    }
  } on Object {
    if (context.mounted) showKzToast(context, l.errorNetwork);
  }
}

enum _CardAction { makeDefault, remove }

/// 74 · Kesikli büyük "Kart ekle" alanı.
class _AddCardPanel extends StatelessWidget {
  const _AddCardPanel({required this.onPressed});

  final VoidCallback onPressed;

  static const double _height = 180;
  static const double _plus = 56;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: l.addCard,
      child: KzDashedBorder(
        radius: KzRadii.card,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: _height),
          padding: const EdgeInsets.all(KzSpace.s20),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.card),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: _plus,
                height: _plus,
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
              const SizedBox(height: KzSpace.s12),
              Text(
                l.addCard,
                textAlign: TextAlign.center,
                style: KzText.title.copyWith(color: kz.forest),
              ),
              const SizedBox(height: KzSpace.s4),
              Text(
                l.cardBrandsAccepted,
                textAlign: TextAlign.center,
                style: KzText.caption.copyWith(color: kz.ink2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 75 · Kesikli "+ Yeni kart ekle".
class _AddCardButton extends StatelessWidget {
  const _AddCardButton({required this.onPressed});

  final VoidCallback onPressed;

  static const double _height = 58;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: l.addNewCard,
      child: KzDashedBorder(
        radius: KzRadii.field,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: _height),
          padding: const EdgeInsets.symmetric(horizontal: KzSpace.s16),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.field),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KzIcon(KzIcons.plus, size: KzSize.iconSm, color: kz.forest),
              const SizedBox(width: KzSpace.s8),
              Flexible(
                child: Text(
                  l.addNewCard,
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

/// 74 → Kart ekle formu. Kart ödeme kuruluşunda doğrulanıp tokenize edilir.
class AddCardScreen extends ConsumerStatefulWidget {
  const AddCardScreen({super.key, this.today});

  /// Son kullanma kontrolü için bugün (testte sabitlenir).
  final DateTime? today;

  @override
  ConsumerState<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  late final _form = CardFormController(
    fixedToday: widget.today,
    saveCard: true,
  );
  bool _loading = false;

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_loading) return;
    final input = _form.submit();
    if (input == null) return;
    final l = context.l10n;
    HapticFeedback.lightImpact();
    setState(() => _loading = true);
    try {
      await ref.read(savedCardsProvider.notifier).add(input);
      if (!mounted) return;
      showKzToast(context, l.cardAdded);
      context.pop();
    } on Object {
      if (mounted) showKzToast(context, l.errorCardAdd);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      bottomBar: KzBottomBar(
        child: KzButton(
          label: l.saveCardCta,
          loading: _loading,
          onPressed: _save,
        ),
      ),
      children: [
        KzPageTitle(title: l.addCard, subtitle: l.paymentMethodsSubtitle),
        CardForm(controller: _form, showSaveOption: false),
        const SizedBox(height: KzSpace.s16),
        KzTip(
          icon: KzIcons.shield,
          tone: KzTipTone.info,
          message: l.cardsStoredSafely,
        ),
      ],
    );
  }
}
