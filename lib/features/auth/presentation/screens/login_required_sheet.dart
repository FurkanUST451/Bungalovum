import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/auth_models.dart';
import '../controllers/auth_controller.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../widgets/auth_page.dart';
import '../widgets/auth_parts.dart';

/// 12 · Giriş Gerekli — misafir korumalı bir aksiyona (kaydet, rezervasyon)
/// dokunduğunda açılır. Kullanıcı giriş yaparsa true döner.
Future<bool> showLoginRequiredSheet(BuildContext context) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    barrierColor: context.kz.scrim,
    constraints: const BoxConstraints(maxWidth: KzBreakpoints.mediumContent),
    sheetAnimationStyle: AnimationStyle(
      duration: KzMotion.of(context, KzMotion.sheet),
      curve: KzMotion.enter,
      reverseCurve: KzMotion.exit,
    ),
    builder: (_) => const LoginRequiredSheet(),
  );
  return result ?? false;
}

class LoginRequiredSheet extends ConsumerWidget {
  const LoginRequiredSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final gutter = context.screenGutter + KzSpace.s4;

    // Sheet'in kendi navigator bağlamı kapanınca kullanılmaz; rota
    // geçişleri uygulama router'ı üzerinden yapılır.
    final router = GoRouter.of(context);

    Future<void> social(SocialProvider p) async {
      try {
        await ref.read(authControllerProvider.notifier).signInWithProvider(p);
        if (context.mounted) Navigator.of(context).pop(true);
      } on AuthFailure {
        // Sağlayıcı penceresi iptal edildi / başarısız: sayfa açık kalır,
        // kullanıcı başka yöntem seçebilir.
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.top(KzRadii.hero),
      ),
      padding: EdgeInsets.fromLTRB(
        gutter,
        KzSpace.s14,
        gutter,
        KzSpace.s24 + MediaQuery.paddingOf(context).bottom,
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
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: KzCircleButton(
                icon: KzIcons.x,
                iconSize: KzSpace.s16,
                background: kz.sand,
                semanticLabel: l.close,
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ),
            const SizedBox(height: KzSpace.s16),
            const Center(
              child: KzSpotIllustration(
                icon: KzIcons.heart,
                tone: KzSpotTone.apricot,
                badgeIcon: KzIcons.lock,
                badge: KzSpotBadge.forest,
                dot: KzSpotDot.pool,
                large: true,
              ),
            ),
            const SizedBox(height: KzSpace.s10),
            Semantics(
              header: true,
              child: Text(
                l.loginRequiredTitle,
                textAlign: TextAlign.center,
                style: KzText.h4.copyWith(color: kz.ink),
              ),
            ),
            const SizedBox(height: KzSpace.s10),
            AuthBody(l.loginRequiredBody, center: true),
            const SizedBox(height: KzSpace.s16),
            KzButton(
              label: l.loginRequiredEmail,
              onPressed: () {
                Navigator.of(context).pop(false);
                router.push(AppRoutes.signIn);
              },
            ),
            const SizedBox(height: KzSpace.s10),
            SocialSignInButtons(onPressed: social),
            const SizedBox(height: KzSpace.s16),
            KzPromptLink(
              prompt: l.signInNoAccount,
              action: l.signInRegister,
              onPressed: () {
                Navigator.of(context).pop(false);
                router.push(AppRoutes.register);
              },
            ),
          ],
        ),
      ),
    );
  }
}
