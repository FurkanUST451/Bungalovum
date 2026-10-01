import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/adaptive_layout.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../l10n/l10n.dart';

/// 01 · Hoş Geldin
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  /// Tanıtım fotoğrafı; CDN adresi backend/remote config'ten gelecek.
  static const String? heroPhotoUrl = null;

  /// Figma: fotoğraf 432 yüksekliğinde, alt sayfa üstüne 36 biner.
  static const double _heroHeight = 432;
  static const double _overlap = KzRadii.xl;

  /// Fotoğrafın ekran yüksekliğine oranı (432 / 844).
  static const double _heroRatio = 0.51;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final gutter = context.screenGutter + KzSpace.s4;
    final topInset = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: kz.bg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Kısa ekranlarda fotoğraf küçülür, içerik kayar.
          final hero = (constraints.maxHeight * _heroRatio).clamp(
            KzSize.input * 4,
            _heroHeight,
          );
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: hero,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const KzPhoto(url: heroPhotoUrl),
                      Positioned(
                        left: gutter,
                        top: topInset + KzSpace.s16,
                        child: _BrandChip(label: l.welcomeBrand),
                      ),
                      Positioned(
                        left: gutter,
                        bottom: _overlap + KzSpace.s10,
                        child: _StatsChip(label: l.welcomeStats),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -_overlap),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kz.bg,
                      borderRadius: KzRadii.top(KzRadii.xl),
                    ),
                    padding: EdgeInsets.fromLTRB(
                      gutter,
                      KzSpace.s30,
                      gutter,
                      KzSpace.s36 -
                          _overlap +
                          MediaQuery.paddingOf(context).bottom,
                    ),
                    child: KzMaxWidth(
                      maxWidth: KzBreakpoints.formContent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Semantics(
                            header: true,
                            child: Text(
                              l.welcomeTitle,
                              style: KzText.h1.copyWith(color: kz.ink),
                            ),
                          ),
                          const SizedBox(height: KzSpace.s18),
                          Text(
                            l.welcomeBody,
                            style: KzText.body.copyWith(color: kz.ink2),
                          ),
                          const SizedBox(height: KzSpace.s18),
                          KzButton(
                            label: l.welcomeCreateAccount,
                            trailingArrow: true,
                            onPressed: () => context.push(AppRoutes.register),
                          ),
                          const SizedBox(height: KzSpace.s10),
                          KzButton(
                            label: l.welcomeSignIn,
                            variant: KzButtonVariant.secondary,
                            onPressed: () => context.push(AppRoutes.signIn),
                          ),
                          const SizedBox(height: KzSpace.s18),
                          Center(
                            child: KzLink(
                              label: l.welcomeBrowse,
                              style: KzText.bodySm,
                              onPressed: () => context.go(AppRoutes.explore),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BrandChip extends StatelessWidget {
  const _BrandChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: KzSpace.s16,
        vertical: KzSpace.s9,
      ),
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.all(KzRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          KzIcon(KzIcons.trees, size: KzSize.iconSm, color: kz.forest),
          const SizedBox(width: KzSpace.s8),
          Text(label, style: KzText.title.copyWith(color: kz.forest)),
        ],
      ),
    );
  }
}

class _StatsChip extends StatelessWidget {
  const _StatsChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: KzSpace.s14,
        vertical: KzSpace.s9,
      ),
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.all(KzRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          KzIcon(KzIcons.starFilled, size: KzSize.iconXs, color: kz.star),
          const SizedBox(width: KzSpace.s6),
          Text(label, style: KzText.label.copyWith(color: kz.ink)),
        ],
      ),
    );
  }
}
