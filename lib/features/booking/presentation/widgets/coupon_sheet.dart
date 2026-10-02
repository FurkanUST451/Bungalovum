import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/payment.dart';
import '../booking_labels.dart';
import '../controllers/checkout_controller.dart';

/// Ödeme ekranından çıkmadan kupon kodu girişi. Uygulanırsa true döner.
Future<bool?> showCouponSheet(BuildContext context) => showKzSheet<bool>(
  context: context,
  title: context.l10n.couponSheetTitle,
  closeLabel: context.l10n.close,
  builder: (_) => const _CouponForm(),
);

class _CouponForm extends ConsumerStatefulWidget {
  const _CouponForm();

  @override
  ConsumerState<_CouponForm> createState() => _CouponFormState();
}

class _CouponFormState extends ConsumerState<_CouponForm> {
  final _code = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _apply() async {
    if (_loading || _code.text.trim().isEmpty) return;
    final l = context.l10n;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref
          .read(checkoutControllerProvider.notifier)
          .applyCoupon(_code.text);
      if (mounted) Navigator.of(context).pop(true);
    } on CouponRejected catch (e) {
      if (mounted) {
        setState(() => _error = e.error.message(l));
      }
    } on Object {
      if (mounted) setState(() => _error = l.errorNetwork);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Padding(
      // Klavye açılınca alan ve buton görünür kalsın.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: KzSpace.s16),
          KzInput(
            label: l.fieldCouponCode,
            icon: KzIcons.ticket,
            controller: _code,
            hint: l.hintCouponCode,
            errorText: _error,
            textCapitalization: TextCapitalization.characters,
            textInputAction: TextInputAction.done,
            onChanged: (_) => setState(() => _error = null),
            onSubmitted: (_) => _apply(),
          ),
          const SizedBox(height: KzSpace.s12),
          KzTip(icon: KzIcons.info, message: l.couponNote),
          const SizedBox(height: KzSpace.s16),
          KzButton(
            label: l.couponApply,
            loading: _loading,
            onPressed: _code.text.trim().isEmpty ? null : _apply,
          ),
        ],
      ),
    );
  }
}
