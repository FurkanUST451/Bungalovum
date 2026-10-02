import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/input_formatters.dart';
import '../../../../core/widgets/kz_checkbox.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/payment.dart';

/// Kart formunun durumu (35 · Yeni kart, 74 · Kart ekle). KVKK/PCI: değerler
/// yalnızca bellekte tutulur; [dispose] alanları temizler.
class CardFormController extends ChangeNotifier {
  CardFormController({this.fixedToday, this.saveCard = false});

  /// Son kullanma kontrolü için bugün (testte sabitlenir).
  final DateTime? fixedToday;
  final holder = TextEditingController();
  final number = TextEditingController();
  final expiry = TextEditingController();
  final cvc = TextEditingController();

  bool saveCard;
  bool _submitted = false;

  bool get submitted => _submitted;

  DateTime get today => fixedToday ?? DateTime.now();

  String get digits => CardValidators.digits(number.text);

  CardBrand get brand => CardValidators.brandOf(digits);

  /// Taksit sorgusu için ilk 6 hane, yeterli değilse null.
  String? get bin => digits.length >= 6 ? digits.substring(0, 6) : null;

  bool get holderValid => holder.text.trim().isNotEmpty;

  bool get numberValid => CardValidators.isCardNumber(digits);

  bool get expiryValid => CardValidators.isExpiryValid(expiry.text, today);

  bool get cvcValid => CardValidators.isCvc(cvc.text, brand);

  bool get isValid => holderValid && numberValid && expiryValid && cvcValid;

  void changed() => notifyListeners();

  void setSave(bool v) {
    saveCard = v;
    notifyListeners();
  }

  /// Hataları gösterir; geçerliyse girişi döner.
  NewCardInput? submit() {
    _submitted = true;
    notifyListeners();
    if (!isValid) return null;
    final (m, y) = CardValidators.parseExpiry(expiry.text)!;
    return NewCardInput(
      holder: holder.text.trim(),
      number: digits,
      expMonth: m,
      expYear: y,
      cvc: CardValidators.digits(cvc.text),
      save: saveCard,
    );
  }

  @override
  void dispose() {
    // Kart bilgisi ekrandan çıkınca bellekte kalmasın.
    for (final c in [holder, number, expiry, cvc]) {
      c.clear();
      c.dispose();
    }
    super.dispose();
  }
}

/// Kart sahibi, numara, SKT/CVC (+ isteğe bağlı "kartı kaydet").
class CardForm extends StatelessWidget {
  const CardForm({
    super.key,
    required this.controller,
    this.showSaveOption = true,
  });

  final CardFormController controller;
  final bool showSaveOption;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: controller,
    builder: (context, _) => _fields(context),
  );

  Widget _fields(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final c = controller;
    String? err(bool valid, String msg) => c.submitted && !valid ? msg : null;
    void changed(String _) => c.changed();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KzInput(
          label: l.fieldCardHolder,
          icon: KzIcons.user,
          controller: c.holder,
          errorText: err(c.holderValid, l.errorName),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.creditCardName],
          onChanged: changed,
        ),
        const SizedBox(height: KzSpace.s12),
        KzInput(
          label: l.fieldCardNumber,
          icon: KzIcons.card,
          controller: c.number,
          errorText: err(c.numberValid, l.errorCardNumber),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.creditCardNumber],
          inputFormatters: [CardNumberInputFormatter()],
          onChanged: changed,
        ),
        const SizedBox(height: KzSpace.s12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: KzInput(
                label: l.fieldCardExpiry,
                controller: c.expiry,
                errorText: err(c.expiryValid, l.errorCardExpiry),
                hint: l.hintCardExpiry,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.creditCardExpirationDate],
                inputFormatters: [CardExpiryInputFormatter()],
                onChanged: changed,
              ),
            ),
            const SizedBox(width: KzSpace.s8),
            Expanded(
              child: KzInput(
                label: l.fieldCardCvc,
                controller: c.cvc,
                errorText: err(c.cvcValid, l.errorCardCvc),
                hint: l.hintCardCvc,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.creditCardSecurityCode],
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(
                    c.brand == CardBrand.amex ? 4 : 3,
                  ),
                ],
                onChanged: changed,
              ),
            ),
          ],
        ),
        if (showSaveOption) ...[
          const SizedBox(height: KzSpace.s12),
          KzCheckboxTile(
            value: c.saveCard,
            size: KzSize.checkboxLg,
            gap: KzSpace.s12,
            semanticLabel: l.saveCardForLater,
            onChanged: c.setSave,
            label: Padding(
              padding: const EdgeInsets.only(top: KzSpace.s3),
              child: Text(
                l.saveCardForLater,
                style: KzText.labelSemi.copyWith(color: kz.ink),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
