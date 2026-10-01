import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/input_formatters.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_checkbox.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/auth_models.dart';
import '../../domain/auth_validators.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_page.dart';
import '../widgets/auth_parts.dart';

/// 06 · Kayıt Ol
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key, this.today});

  /// Yaş kontrolü için bugün (testte sabitlenir).
  final DateTime? today;

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _birth = TextEditingController();
  final _password = TextEditingController();
  bool _terms = false;
  bool _marketing = false;
  bool _submitted = false;
  bool _loading = false;
  String? _serverError;

  @override
  void dispose() {
    for (final c in [_first, _last, _email, _phone, _birth, _password]) {
      c.dispose();
    }
    super.dispose();
  }

  DateTime get _today => widget.today ?? DateTime.now();

  String? _err(bool invalid, String msg) => _submitted && invalid ? msg : null;

  String? get _birthError {
    if (!_submitted) return null;
    final date = AuthValidators.parseBirthDate(_birth.text);
    if (date == null) return context.l10n.errorBirthDate;
    if (!AuthValidators.isAdult(date, _today)) {
      return context.l10n.errorUnderage;
    }
    return null;
  }

  bool get _phoneInvalid =>
      _phone.text.isNotEmpty && !AuthValidators.isTrMobile(_phone.text);

  bool get _valid {
    final birth = AuthValidators.parseBirthDate(_birth.text);
    return AuthValidators.isName(_first.text) &&
        AuthValidators.isName(_last.text) &&
        AuthValidators.isEmail(_email.text) &&
        !_phoneInvalid &&
        birth != null &&
        AuthValidators.isAdult(birth, _today) &&
        AuthValidators.isValidNewPassword(_password.text);
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (!_valid || !_terms) return;
    setState(() {
      _loading = true;
      _serverError = null;
    });
    final email = _email.text.trim();
    try {
      await ref
          .read(authControllerProvider.notifier)
          .register(
            RegistrationData(
              firstName: _first.text.trim(),
              lastName: _last.text.trim(),
              email: email,
              phone: _phone.text.isEmpty
                  ? null
                  : AuthValidators.phoneDigitsOf(_phone.text),
              birthDate: AuthValidators.parseBirthDate(_birth.text)!,
              password: _password.text,
              marketingConsent: _marketing,
            ),
          );
      if (mounted) context.push(AppRoutes.verifyEmail, extra: email);
    } on Object catch (e) {
      if (mounted) {
        setState(() => _serverError = authFailureMessage(context.l10n, e));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _changed(String _) => setState(() {});

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final birthError = _birthError;

    return AuthPage(
      title: l.registerTitle,
      subtitle: AuthBody(l.registerSubtitle),
      children: [
        if (_serverError != null)
          KzTip(
            message: _serverError!,
            icon: KzIcons.alert,
            tone: KzTipTone.warning,
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: KzInput(
                label: l.fieldFirstName,
                controller: _first,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.givenName],
                errorText: _err(
                  !AuthValidators.isName(_first.text),
                  l.errorName,
                ),
                onChanged: _changed,
              ),
            ),
            const SizedBox(width: KzSpace.s8),
            Expanded(
              child: KzInput(
                label: l.fieldLastName,
                controller: _last,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.familyName],
                errorText: _err(
                  !AuthValidators.isName(_last.text),
                  l.errorName,
                ),
                onChanged: _changed,
              ),
            ),
          ],
        ),
        KzInput(
          label: l.fieldEmail,
          controller: _email,
          icon: KzIcons.mail,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
          errorText: _err(!AuthValidators.isEmail(_email.text), l.errorEmail),
          onChanged: _changed,
        ),
        KzInput(
          label: l.fieldPhone,
          controller: _phone,
          hint: l.hintPhone,
          prefix: _CountryCode(label: l.countryCodeTr),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.telephoneNumberNational],
          inputFormatters: [TrPhoneInputFormatter()],
          errorText: _err(_phoneInvalid, l.errorPhone),
          onChanged: _changed,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            KzInput(
              label: l.fieldBirthDate,
              controller: _birth,
              icon: KzIcons.calendar,
              hint: l.hintBirthDate,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.birthday],
              inputFormatters: [BirthDateInputFormatter()],
              errorText: birthError == null ? null : '',
              onChanged: _changed,
            ),
            const SizedBox(height: KzSpace.s7),
            KzFieldMessage(
              text: birthError ?? l.registerAgeNote,
              isError: birthError != null,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            KzInput(
              label: l.fieldPassword,
              controller: _password,
              icon: KzIcons.lock,
              obscure: true,
              toggleLabels: (l.showPassword, l.hidePassword),
              autofillHints: const [AutofillHints.newPassword],
              errorText: _err(
                !AuthValidators.isValidNewPassword(_password.text),
                '',
              ),
              onChanged: _changed,
            ),
            const SizedBox(height: KzSpace.s8),
            PasswordStrengthMeter(password: _password.text),
          ],
        ),
        KzCheckboxTile(
          value: _terms,
          size: KzSize.checkboxLg,
          gap: KzSpace.s12,
          semanticLabel: l.registerTermsSemantics,
          onChanged: (v) => setState(() => _terms = v),
          label: Text.rich(
            TextSpan(
              style: KzText.labelMedium.copyWith(
                color: _submitted && !_terms ? kz.apricotText : kz.ink,
                height: KzText.body.height,
              ),
              children: [
                TextSpan(
                  text: l.registerTermsLink,
                  style: TextStyle(
                    fontWeight: KzText.extraBold,
                    color: kz.forest,
                  ),
                ),
                TextSpan(text: l.registerTermsMiddle),
                TextSpan(
                  text: l.registerKvkkLink,
                  style: TextStyle(
                    fontWeight: KzText.extraBold,
                    color: kz.forest,
                  ),
                ),
                TextSpan(text: l.registerTermsEnd),
              ],
            ),
          ),
        ),
        KzCheckboxTile(
          value: _marketing,
          size: KzSize.checkboxLg,
          gap: KzSpace.s12,
          semanticLabel: l.registerMarketing,
          onChanged: (v) => setState(() => _marketing = v),
          label: Text(
            l.registerMarketing,
            style: KzText.labelMedium.copyWith(
              color: kz.ink,
              height: KzText.body.height,
            ),
          ),
        ),
        KzButton(
          label: l.continueLabel,
          trailingArrow: true,
          loading: _loading,
          onPressed: _terms ? _submit : null,
        ),
        KzPromptLink(
          prompt: l.registerHaveAccount,
          action: l.registerSignIn,
          onPressed: () => context.pushReplacement(AppRoutes.signIn),
        ),
      ],
    );
  }
}

/// "+90 ⌄" ülke kodu rozeti (uygulama yalnızca TR).
class _CountryCode extends StatelessWidget {
  const _CountryCode({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: KzSpace.s10,
        vertical: KzSpace.s6,
      ),
      decoration: BoxDecoration(
        color: kz.sand,
        borderRadius: KzRadii.all(KzRadii.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: KzText.bodySm.copyWith(
              fontWeight: KzText.extraBold,
              color: kz.ink,
            ),
          ),
          const SizedBox(width: KzSpace.s4),
          KzIcon(KzIcons.down, size: KzSize.iconXs, color: kz.ink2),
        ],
      ),
    );
  }
}
