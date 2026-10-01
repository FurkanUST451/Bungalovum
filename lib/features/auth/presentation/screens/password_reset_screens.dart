import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/auth_validators.dart';
import '../controllers/auth_controller.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../widgets/auth_page.dart';
import '../widgets/auth_parts.dart';

/// 08 · Şifremi Unuttum
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _email = TextEditingController();
  bool _submitted = false;
  bool _loading = false;
  String? _serverError;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (!AuthValidators.isEmail(_email.text)) return;
    final email = _email.text.trim();
    setState(() {
      _loading = true;
      _serverError = null;
    });
    try {
      await ref
          .read(authControllerProvider.notifier)
          .requestPasswordReset(email);
      if (mounted) context.push(AppRoutes.resetCode, extra: email);
    } on Object catch (e) {
      if (mounted) {
        setState(() => _serverError = authFailureMessage(context.l10n, e));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AuthPage(
      title: l.forgotTitle,
      subtitle: AuthBody(l.forgotBody),
      gap: KzSpace.s18,
      children: [
        const Center(
          child: KzSpotIllustration(
            icon: KzIcons.key,
            tone: KzSpotTone.apricot,
          ),
        ),
        if (_serverError != null)
          KzTip(
            message: _serverError!,
            icon: KzIcons.alert,
            tone: KzTipTone.warning,
          ),
        KzInput(
          label: l.fieldEmail,
          controller: _email,
          icon: KzIcons.mail,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.email],
          errorText: _submitted && !AuthValidators.isEmail(_email.text)
              ? l.errorEmail
              : null,
          onChanged: (_) => setState(() {}),
          onSubmitted: (_) => _submit(),
        ),
        KzButton(
          label: l.forgotSubmit,
          trailingArrow: true,
          loading: _loading,
          onPressed: _submit,
        ),
        KzPromptLink(
          prompt: l.forgotRemembered,
          action: l.forgotSignIn,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go(AppRoutes.signIn),
        ),
      ],
    );
  }
}

/// 10 · Yeni Şifre. [token]: sıfırlama kodu doğrulamasından gelen jeton.
class NewPasswordScreen extends ConsumerStatefulWidget {
  const NewPasswordScreen({super.key, required this.token});

  final String token;

  @override
  ConsumerState<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends ConsumerState<NewPasswordScreen> {
  final _password = TextEditingController();
  final _repeat = TextEditingController();
  bool _submitted = false;
  bool _loading = false;
  String? _serverError;

  @override
  void dispose() {
    _password.dispose();
    _repeat.dispose();
    super.dispose();
  }

  bool get _rulesMet =>
      PasswordRule.values.every((r) => r.isMet(_password.text));

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (!_rulesMet || _password.text != _repeat.text) return;
    setState(() {
      _loading = true;
      _serverError = null;
    });
    try {
      await ref
          .read(authControllerProvider.notifier)
          .resetPassword(widget.token, _password.text);
      if (mounted) context.go(AppRoutes.passwordUpdated);
    } on Object catch (e) {
      if (mounted) {
        setState(() => _serverError = authFailureMessage(context.l10n, e));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final mismatch = _submitted && _password.text != _repeat.text;
    return AuthPage(
      title: l.newPasswordTitle,
      subtitle: AuthBody(l.newPasswordBody),
      children: [
        if (_serverError != null)
          KzTip(
            message: _serverError!,
            icon: KzIcons.alert,
            tone: KzTipTone.warning,
          ),
        KzInput(
          label: l.fieldNewPassword,
          controller: _password,
          icon: KzIcons.lock,
          obscure: true,
          toggleLabels: (l.showPassword, l.hidePassword),
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.newPassword],
          onChanged: (_) => setState(() {}),
        ),
        KzInput(
          label: l.fieldNewPasswordRepeat,
          controller: _repeat,
          icon: KzIcons.lock,
          obscure: true,
          toggleLabels: (l.showPassword, l.hidePassword),
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.newPassword],
          errorText: mismatch ? l.errorPasswordMismatch : null,
          onChanged: (_) => setState(() {}),
          onSubmitted: (_) => _submit(),
        ),
        PasswordRulesCard(password: _password.text),
        KzButton(
          label: l.newPasswordSubmit,
          loading: _loading,
          onPressed: _rulesMet && _repeat.text.isNotEmpty ? _submit : null,
        ),
      ],
    );
  }
}

/// 11 · Şifre Güncellendi
class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final gutter = context.screenGutter;
    return Scaffold(
      backgroundColor: kz.bg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: KzBreakpoints.formContent,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(gutter, 0, gutter, KzSpace.s16),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: KzSpace.s10,
                        vertical: KzSpace.s32,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: KzSpace.s32),
                          const KzSuccessIllustration(),
                          const SizedBox(height: KzSpace.s18),
                          Semantics(
                            header: true,
                            liveRegion: true,
                            child: Text(
                              l.passwordUpdatedTitle,
                              textAlign: TextAlign.center,
                              style: KzText.h3.copyWith(color: kz.ink),
                            ),
                          ),
                          const SizedBox(height: KzSpace.s18),
                          Text(
                            l.passwordUpdatedBody,
                            textAlign: TextAlign.center,
                            style: KzText.body.copyWith(color: kz.ink2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  KzButton(
                    label: l.passwordUpdatedSubmit,
                    trailingArrow: true,
                    onPressed: () => context.go(AppRoutes.signIn),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
