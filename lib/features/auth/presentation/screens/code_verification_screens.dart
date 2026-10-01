import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_otp_field.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/auth_validators.dart';
import '../controllers/auth_controller.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../widgets/auth_page.dart';
import '../widgets/auth_parts.dart';

/// 04 / 07 / 09'un ortak gövdesi: illüstrasyon, 6 hane, tekrar gönder,
/// birincil buton, alt link veya ipucu.
class _CodeView extends StatefulWidget {
  const _CodeView({
    required this.title,
    required this.body,
    required this.bodyInHeader,
    required this.illustration,
    required this.submitLabel,
    required this.submitArrow,
    required this.onSubmit,
    required this.onResend,
    this.footer,
  });

  final String title;
  final Widget body;

  /// 09'da açıklama başlığın hemen altında, 04/07'de form içinde.
  final bool bodyInHeader;
  final Widget illustration;
  final String submitLabel;
  final bool submitArrow;
  final Future<void> Function(String code) onSubmit;
  final Future<void> Function() onResend;
  final Widget? footer;

  @override
  State<_CodeView> createState() => _CodeViewState();
}

class _CodeViewState extends State<_CodeView> {
  final _code = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _code.addListener(() {
      if (_error != null) setState(() => _error = null);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_loading || !AuthValidators.isOtp(_code.text)) return;
    setState(() => _loading = true);
    try {
      await widget.onSubmit(_code.text);
    } on Object catch (e) {
      if (mounted) setState(() => _error = authFailureMessage(context.l10n, e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AuthPage(
      title: widget.title,
      subtitle: widget.bodyInHeader ? widget.body : null,
      gap: KzSpace.s18,
      children: [
        if (!widget.bodyInHeader) widget.body,
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: widget.bodyInHeader ? 0 : KzSpace.s10,
          ),
          child: Center(child: widget.illustration),
        ),
        KzOtpField(
          controller: _code,
          semanticLabel: l.verificationCode,
          hasError: _error != null,
          onCompleted: (_) => _submit(),
        ),
        if (_error != null) KzFieldMessage(text: _error!, isError: true),
        ResendCodeButton(onResend: widget.onResend),
        KzButton(
          label: widget.submitLabel,
          trailingArrow: widget.submitArrow,
          loading: _loading,
          onPressed: AuthValidators.isOtp(_code.text) ? _submit : null,
        ),
        ?widget.footer,
      ],
    );
  }
}

/// 04 · SMS Doğrulama. [phone]: 10 haneli numara.
class SmsVerifyScreen extends ConsumerWidget {
  const SmsVerifyScreen({super.key, required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final masked = KzFormat.maskedPhone(phone);
    final auth = ref.read(authControllerProvider.notifier);
    return _CodeView(
      title: l.smsTitle,
      body: AuthBody(l.smsBody(masked), bold: masked),
      bodyInHeader: false,
      illustration: const KzSpotIllustration(icon: KzIcons.phone),
      submitLabel: l.signInSubmit,
      submitArrow: false,
      onSubmit: (code) async {
        await auth.verifySmsCode(phone, code);
        if (context.mounted) context.go(AppRoutes.explore);
      },
      onResend: () => auth.requestSmsCode(phone),
      footer: Center(
        child: KzLink(
          label: l.smsChangeNumber,
          style: KzText.bodySm,
          onPressed: () => context.pop(),
        ),
      ),
    );
  }
}

/// 07 · Hesabı Doğrula.
class VerifyEmailScreen extends ConsumerWidget {
  const VerifyEmailScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final auth = ref.read(authControllerProvider.notifier);
    return _CodeView(
      title: l.verifyEmailTitle,
      body: AuthBody(l.verifyEmailBody(email), bold: email),
      bodyInHeader: false,
      illustration: const KzSpotIllustration(icon: KzIcons.mail),
      submitLabel: l.verifyEmailSubmit,
      submitArrow: false,
      onSubmit: (code) async {
        await auth.verifyEmail(email, code);
        if (context.mounted) context.go(AppRoutes.explore);
      },
      onResend: () => auth.resendEmailCode(email),
      footer: Center(
        child: KzLink(
          label: l.verifyEmailChange,
          style: KzText.bodySm,
          onPressed: () => context.pop(),
        ),
      ),
    );
  }
}

/// 09 · Sıfırlama Kodu.
class ResetCodeScreen extends ConsumerWidget {
  const ResetCodeScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final masked = KzFormat.maskedEmail(email);
    final auth = ref.read(authControllerProvider.notifier);
    return _CodeView(
      title: l.resetCodeTitle,
      body: AuthBody(l.resetCodeBody(masked), bold: masked),
      bodyInHeader: true,
      illustration: const KzSpotIllustration(
        icon: KzIcons.mail,
        tone: KzSpotTone.pool,
      ),
      submitLabel: l.continueLabel,
      submitArrow: true,
      onSubmit: (code) async {
        final token = await auth.verifyResetCode(email, code);
        if (context.mounted) {
          context.push(AppRoutes.newPassword, extra: token);
        }
      },
      onResend: () => auth.requestPasswordReset(email),
      footer: KzTip(message: l.resetCodeTip, icon: KzIcons.sparkles),
    );
  }
}
