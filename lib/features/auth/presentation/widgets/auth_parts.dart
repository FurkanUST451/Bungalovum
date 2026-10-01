import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_checkbox.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/auth_models.dart';
import '../../domain/auth_validators.dart';

/// Google + Apple ile devam et.
class SocialSignInButtons extends StatelessWidget {
  const SocialSignInButtons({super.key, required this.onPressed});

  final ValueChanged<SocialProvider> onPressed;

  static const double _badge = 28;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return Column(
      children: [
        KzButton(
          label: l.signInGoogle,
          variant: KzButtonVariant.outline,
          size: KzButtonSize.social,
          leading: Container(
            width: _badge,
            height: _badge,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: kz.sand, shape: BoxShape.circle),
            child: Text(
              l.signInGoogleBadge,
              style: KzText.bodySm.copyWith(
                fontWeight: KzText.extraBold,
                color: kz.ink,
                height: KzText.tightLeading,
              ),
            ),
          ),
          onPressed: () => onPressed(SocialProvider.google),
        ),
        const SizedBox(height: KzSpace.s10),
        KzButton(
          label: l.signInApple,
          variant: KzButtonVariant.dark,
          size: KzButtonSize.social,
          onPressed: () => onPressed(SocialProvider.apple),
        ),
      ],
    );
  }
}

/// "Kodu tekrar gönder · 00:42". Süre dolunca dokunulabilir olur.
class ResendCodeButton extends StatefulWidget {
  const ResendCodeButton({super.key, required this.onResend});

  final Future<void> Function() onResend;

  static const cooldown = Duration(seconds: 60);

  @override
  State<ResendCodeButton> createState() => _ResendCodeButtonState();
}

class _ResendCodeButtonState extends State<ResendCodeButton> {
  Timer? _timer;
  int _left = ResendCodeButton.cooldown.inSeconds;

  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() {
    _timer?.cancel();
    setState(() => _left = ResendCodeButton.cooldown.inSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_left <= 1) t.cancel();
      setState(() => _left--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _resend() async {
    await widget.onResend();
    if (mounted) _start();
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final waiting = _left > 0;
    final mm = (_left ~/ 60).toString().padLeft(2, '0');
    final ss = (_left % 60).toString().padLeft(2, '0');
    final base = KzText.labelSemi.copyWith(color: kz.ink2);
    return Center(
      child: KzPressable(
        onPressed: waiting ? null : _resend,
        semanticLabel: waiting ? '${l.resendCodeIn}$mm:$ss' : l.resendCode,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            KzIcon(
              KzIcons.refresh,
              size: KzSpace.s16,
              color: waiting ? kz.ink2 : kz.forest,
            ),
            const SizedBox(width: KzSpace.s8),
            Flexible(
              child: waiting
                  ? Text.rich(
                      TextSpan(
                        style: base,
                        children: [
                          TextSpan(text: l.resendCodeIn),
                          TextSpan(
                            text: '$mm:$ss',
                            style: TextStyle(
                              fontWeight: KzText.extraBold,
                              color: kz.ink,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(
                      l.resendCode,
                      style: base.copyWith(
                        color: kz.forest,
                        fontWeight: KzText.extraBold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 4 parçalı şifre gücü çubuğu + etiket + kural ipucu.
class PasswordStrengthMeter extends StatelessWidget {
  const PasswordStrengthMeter({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final strength = PasswordStrength.of(password);
    final colors = switch (strength) {
      PasswordStrength.empty => [kz.line, kz.line, kz.line, kz.line],
      PasswordStrength.weak => [kz.apricot, kz.line, kz.line, kz.line],
      PasswordStrength.medium => [kz.apricot, kz.apricot, kz.star, kz.line],
      PasswordStrength.strong => [kz.forest, kz.forest, kz.forest, kz.forest],
    };
    final (label, labelColor) = switch (strength) {
      PasswordStrength.empty => (null, kz.ink2),
      PasswordStrength.weak => (l.passwordWeak, kz.apricotText),
      PasswordStrength.medium => (l.passwordMedium, kz.apricotText),
      PasswordStrength.strong => (l.passwordStrong, kz.forest),
    };
    final duration = KzMotion.of(context, KzMotion.toggle);
    return Semantics(
      label: label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              for (final (i, c) in colors.indexed) ...[
                if (i > 0) const SizedBox(width: KzSpace.s6),
                Expanded(
                  child: AnimatedContainer(
                    duration: duration,
                    height: KzSize.strengthBar,
                    decoration: BoxDecoration(
                      color: c,
                      borderRadius: KzRadii.all(KzRadii.hairline),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: KzSpace.s8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KzSpace.s6),
            child: Row(
              children: [
                if (label != null)
                  Text(
                    label,
                    style: KzText.captionHeavy.copyWith(color: labelColor),
                  ),
                const Spacer(),
                Flexible(
                  flex: 3,
                  child: Text(
                    l.registerPasswordHint,
                    textAlign: TextAlign.end,
                    style: KzText.captionSemi.copyWith(color: kz.ink2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// "Şifren şunları içermeli" kartı.
class PasswordRulesCard extends StatelessWidget {
  const PasswordRulesCard({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    String label(PasswordRule r) => switch (r) {
      PasswordRule.minLength => l.ruleMinLength,
      PasswordRule.uppercase => l.ruleUppercase,
      PasswordRule.digit => l.ruleDigit,
      PasswordRule.special => l.ruleSpecial,
    };
    return Container(
      padding: const EdgeInsets.all(KzSpace.s18),
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.all(KzRadii.card),
        border: Border.all(color: kz.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.newPasswordRulesTitle,
            style: KzText.label.copyWith(
              fontWeight: KzText.extraBold,
              color: kz.ink2,
            ),
          ),
          for (final rule in PasswordRule.values) ...[
            const SizedBox(height: KzSpace.s12),
            Semantics(
              checked: rule.isMet(password),
              child: Row(
                children: [
                  KzCheckbox(value: rule.isMet(password), circular: true),
                  const SizedBox(width: KzSpace.s10),
                  Expanded(
                    child: Text(
                      label(rule),
                      style: KzText.bodySm.copyWith(
                        fontWeight: rule.isMet(password)
                            ? KzText.semiBold
                            : KzText.medium,
                        color: rule.isMet(password) ? kz.ink : kz.ink2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Backend hatasını kullanıcı metnine çevirir.
String authFailureMessage(AppLocalizations l, Object e) => switch (e) {
  InvalidCredentials(:final remainingAttempts) when remainingAttempts > 0 =>
    l.signInInvalidCredentials(remainingAttempts),
  InvalidCredentials() => l.signInLocked,
  InvalidCode() => l.errorInvalidCode,
  EmailInUse() => l.errorEmailInUse,
  _ => l.errorNetwork,
};
