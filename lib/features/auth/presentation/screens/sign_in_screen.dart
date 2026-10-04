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
import '../../../../core/widgets/kz_segmented.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/auth_models.dart';
import '../../domain/auth_validators.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_page.dart';
import '../widgets/auth_parts.dart';

enum SignInMethod { email, phone }

/// 02 · Giriş Yap, 03 · Giriş Yap (telefon), 05 · Giriş Hatası.
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key, this.initialMethod = SignInMethod.email});

  final SignInMethod initialMethod;

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  late SignInMethod _method = widget.initialMethod;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phone = TextEditingController();
  bool _remember = true;
  bool _submitted = false;
  bool _loading = false;
  String? _serverError;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _phone.dispose();
    super.dispose();
  }

  String? get _emailError => _submitted && !AuthValidators.isEmail(_email.text)
      ? context.l10n.errorEmail
      : null;

  String? get _passwordError =>
      _submitted && !AuthValidators.isPasswordLongEnough(_password.text)
      ? context.l10n.errorPasswordShort
      : null;

  String? get _phoneError =>
      _submitted && !AuthValidators.isTrMobile(_phone.text)
      ? context.l10n.errorPhone
      : null;

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _loading = true;
      _serverError = null;
    });
    try {
      await action();
    } on SignInCancelled {
      // Kullanıcı Google/Apple penceresini kapattı; hata göstermeye gerek yok.
    } on Object catch (e) {
      if (mounted) {
        setState(() => _serverError = authFailureMessage(context.l10n, e));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _submitEmail() async {
    setState(() => _submitted = true);
    if (_emailError != null || _passwordError != null) return;
    await _run(() async {
      await ref
          .read(authControllerProvider.notifier)
          .signInWithEmail(_email.text, _password.text, _remember);
      if (mounted) context.go(AppRoutes.explore);
    });
  }

  Future<void> _submitPhone() async {
    setState(() => _submitted = true);
    if (_phoneError != null) return;
    final digits = AuthValidators.phoneDigitsOf(_phone.text);
    await _run(() async {
      await ref.read(authControllerProvider.notifier).requestSmsCode(digits);
      if (mounted) context.push(AppRoutes.smsVerify, extra: digits);
    });
  }

  Future<void> _social(SocialProvider p) => _run(() async {
    await ref.read(authControllerProvider.notifier).signInWithProvider(p);
    if (mounted) context.go(AppRoutes.explore);
  });

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final isEmail = _method == SignInMethod.email;
    // Sunucu hatasında alanlar mesajsız kırmızı kenarlık alır.
    final serverBorder = _serverError != null && isEmail ? '' : null;

    return AuthPage(
      title: l.signInTitle,
      subtitle: AuthBody(l.signInSubtitle),
      children: [
        if (_serverError != null)
          KzTip(
            message: _serverError!,
            icon: KzIcons.alert,
            tone: KzTipTone.warning,
          ),
        KzSegmented<SignInMethod>(
          segments: [
            (SignInMethod.email, l.fieldEmail),
            (SignInMethod.phone, l.fieldPhone),
          ],
          selected: _method,
          onChanged: (m) => setState(() {
            _method = m;
            _submitted = false;
            _serverError = null;
          }),
        ),
        if (isEmail) ...[
          KzInput(
            label: l.fieldEmail,
            controller: _email,
            icon: KzIcons.mail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            errorText: _emailError ?? serverBorder,
            onChanged: (_) => setState(() {}),
          ),
          KzInput(
            label: l.fieldPassword,
            controller: _password,
            icon: KzIcons.lock,
            obscure: true,
            toggleLabels: (l.showPassword, l.hidePassword),
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            errorText: _passwordError ?? serverBorder,
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => _submitEmail(),
          ),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: KzCheckboxTile(
                    value: _remember,
                    onChanged: (v) => setState(() => _remember = v),
                    semanticLabel: l.signInRememberMe,
                    label: Text(
                      l.signInRememberMe,
                      style: KzText.labelSemi.copyWith(color: kz.ink),
                    ),
                  ),
                ),
              ),
              KzLink(
                label: l.signInForgot,
                onPressed: () => context.push(AppRoutes.forgotPassword),
              ),
            ],
          ),
          KzButton(
            label: l.signInSubmit,
            loading: _loading,
            onPressed: _submitEmail,
          ),
        ] else ...[
          KzInput(
            label: l.fieldPhoneNumber,
            controller: _phone,
            icon: KzIcons.phone,
            prefixText: '${l.countryCodeTr} ',
            keyboardType: TextInputType.phone,
            autofillHints: const [AutofillHints.telephoneNumberNational],
            inputFormatters: [TrPhoneInputFormatter()],
            errorText: _phoneError,
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => _submitPhone(),
          ),
          Row(
            children: [
              KzIcon(KzIcons.info, size: KzSize.iconXs, color: kz.ink2),
              const SizedBox(width: KzSpace.s8),
              Expanded(
                child: Text(
                  l.signInPhoneNote,
                  style: KzText.captionSemi.copyWith(color: kz.ink2),
                ),
              ),
            ],
          ),
          KzButton(
            label: l.signInSendSms,
            loading: _loading,
            onPressed: _submitPhone,
          ),
        ],
        KzDividerLabel(label: l.or),
        SocialSignInButtons(onPressed: _social),
        KzPromptLink(
          prompt: l.signInNoAccount,
          action: l.signInRegister,
          onPressed: () => context.pushReplacement(AppRoutes.register),
        ),
      ],
    );
  }
}
