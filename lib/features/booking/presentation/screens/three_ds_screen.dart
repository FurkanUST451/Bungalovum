import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_otp_field.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/payment.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/booking_parts.dart';

/// 36 · 3D Secure. Arkada "Bankan doğruluyor" bekleme ekranı, önde banka
/// doğrulama paneli.
class ThreeDsScreen extends ConsumerStatefulWidget {
  const ThreeDsScreen({super.key});

  @override
  ConsumerState<ThreeDsScreen> createState() => _ThreeDsScreenState();
}

class _ThreeDsScreenState extends ConsumerState<ThreeDsScreen> {
  final _code = TextEditingController();
  bool _loading = false;

  static const double _spinner = 84;
  static const double _spinnerStroke = 8;

  @override
  void initState() {
    super.initState();
    _code.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _confirm(ThreeDsChallenge c) async {
    if (_loading || _code.text.length != c.codeLength) return;
    HapticFeedback.lightImpact();
    setState(() => _loading = true);
    try {
      final booking = await ref
          .read(checkoutControllerProvider.notifier)
          .confirm(_code.text);
      if (!mounted) return;
      context.go(
        booking.isRequest
            ? AppRoutes.requestSent(booking.id)
            : AppRoutes.bookingDone(booking.id),
      );
    } on PaymentDeclined {
      if (mounted) context.pushReplacement(AppRoutes.paymentFailed);
    } on Object {
      if (mounted) showKzToast(context, context.l10n.errorNetwork);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _close() async {
    await ref.read(checkoutControllerProvider.notifier).cancelChallenge();
    if (mounted) context.pop();
  }

  Future<void> _resend() async {
    _code.clear();
    await ref.read(checkoutControllerProvider.notifier).resendCode();
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final challenge = ref.watch(checkoutControllerProvider).challenge;
    if (challenge == null) {
      return BookingError(onRetry: () => context.go(AppRoutes.explore));
    }
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && !_loading) _close();
      },
      child: Scaffold(
        backgroundColor: kz.bg,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            // Bekleme ekranı (bankaya yönlendirme).
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    KzSpace.s30,
                    KzSpace.s36 + KzSpace.s24,
                    KzSpace.s30,
                    0,
                  ),
                  child: ExcludeSemantics(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox.square(
                          dimension: _spinner,
                          child: CircularProgressIndicator(
                            strokeWidth: _spinnerStroke,
                            color: kz.forest,
                            backgroundColor: kz.line,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        const SizedBox(height: KzSpace.s16),
                        Text(
                          l.tdsVerifying,
                          textAlign: TextAlign.center,
                          style: KzText.h4.copyWith(color: kz.ink),
                        ),
                        const SizedBox(height: KzSpace.s16),
                        Text(
                          l.tdsRedirect,
                          textAlign: TextAlign.center,
                          style: KzText.bodySm.copyWith(
                            color: kz.ink2,
                            height: KzText.body.height,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(child: ColoredBox(color: kz.scrim)),
            Align(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: KzBreakpoints.mediumContent,
                ),
                child: _panel(challenge),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _panel(ThreeDsChallenge c) {
    final kz = context.kz;
    final l = context.l10n;
    final media = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.top(KzRadii.hero),
      ),
      padding: EdgeInsets.fromLTRB(
        KzSpace.s24,
        KzSpace.s14,
        KzSpace.s24,
        KzSpace.s34 + media.padding.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: KzSize.grabberWidth,
                height: KzSize.grabberHeight,
                decoration: BoxDecoration(
                  color: kz.line,
                  borderRadius: KzRadii.all(KzRadii.hairline),
                ),
              ),
            ),
            const SizedBox(height: KzSpace.s16),
            Row(
              children: [
                const KzIconBox(icon: KzIcons.shield, iconSize: KzSize.iconMd),
                const SizedBox(width: KzSpace.s10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        header: true,
                        child: Text(
                          l.tdsTitle,
                          style: KzText.bodyStrong.copyWith(
                            color: kz.ink,
                            fontWeight: KzText.extraBold,
                            height: KzText.tightLeading,
                          ),
                        ),
                      ),
                      const SizedBox(height: KzSpace.s2),
                      Text(
                        l.tdsSubtitle,
                        style: KzText.captionSemi.copyWith(
                          color: kz.ink2,
                          height: KzText.tightLeading,
                        ),
                      ),
                    ],
                  ),
                ),
                KzCircleButton(
                  icon: KzIcons.x,
                  diameter: KzSize.circleSm,
                  iconSize: KzSpace.s16,
                  background: kz.sand,
                  semanticLabel: l.close,
                  onPressed: _loading ? null : _close,
                ),
              ],
            ),
            const SizedBox(height: KzSpace.s16),
            Container(
              padding: const EdgeInsets.all(KzSpace.s16),
              decoration: BoxDecoration(
                color: kz.sand,
                borderRadius: KzRadii.all(KzRadii.card),
              ),
              child: Column(
                children: [
                  BookingValueRow(label: l.tdsMerchant, value: c.merchant),
                  const SizedBox(height: KzSpace.s10),
                  BookingValueRow(
                    label: l.tdsAmount,
                    value: KzFormat.currencyCents(c.amount),
                    valueWeight: KzText.extraBold,
                  ),
                  const SizedBox(height: KzSpace.s10),
                  BookingValueRow(
                    label: l.tdsCard,
                    value: l.cardLast4(c.cardLast4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: KzSpace.s16),
            Text(
              l.tdsCodePrompt(c.codeLength),
              style: KzText.labelSemi.copyWith(color: kz.ink2),
            ),
            const SizedBox(height: KzSpace.s16),
            CountdownBuilder(
              until: c.expiresAt,
              builder: (context, left) {
                final expired = left == Duration.zero;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    KzOtpField(
                      controller: _code,
                      length: c.codeLength,
                      semanticLabel: l.tdsCodeLabel,
                      onCompleted: expired ? null : (_) => _confirm(c),
                    ),
                    const SizedBox(height: KzSpace.s16),
                    Row(
                      children: [
                        Expanded(
                          child: expired
                              ? KzFieldMessage(
                                  text: l.tdsExpired,
                                  isError: true,
                                )
                              : Semantics(
                                  liveRegion: left.inSeconds % 30 == 0,
                                  child: Text(
                                    l.tdsTimeLeft(KzFormat.countdown(left)),
                                    style: KzText.label.copyWith(
                                      color: kz.apricotText,
                                    ),
                                  ),
                                ),
                        ),
                        KzLink(
                          label: l.resend,
                          style: KzText.label.copyWith(
                            fontWeight: KzText.extraBold,
                          ),
                          onPressed: _resend,
                        ),
                      ],
                    ),
                    const SizedBox(height: KzSpace.s16),
                    KzButton(
                      label: l.confirm,
                      loading: _loading,
                      onPressed: !expired && _code.text.length == c.codeLength
                          ? () => _confirm(c)
                          : null,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
