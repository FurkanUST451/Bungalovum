import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/adaptive_layout.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_group.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_tab_bar.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/account_models.dart';
import '../../../auth/presentation/screens/login_required_sheet.dart';
import '../../../host/domain/listing_draft.dart';
import '../../../host/presentation/controllers/host_controllers.dart';
import '../controllers/account_controllers.dart';

/// Profil avatarı: fotoğraf varsa o, yoksa forestSoft zeminde baş harf.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.profile, required this.size});

  final UserProfile profile;
  final double size;

  static const double _initialRatio = 0.4;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final url = profile.avatarUrl;
    Widget child;
    if (url != null && url.isNotEmpty) {
      child = url.contains('://')
          ? KzPhoto(url: url)
          : Image.file(
              File(url),
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => ColoredBox(color: kz.forestSoft),
            );
    } else {
      child = ColoredBox(
        color: kz.forestSoft,
        child: Center(
          child: Text(
            profile.firstName.characters.first.toUpperCaseTr(),
            style: KzText.h1.copyWith(
              color: kz.forest,
              fontSize: size * _initialRatio,
            ),
          ),
        ),
      );
    }
    return ExcludeSemantics(
      child: ClipOval(
        child: SizedBox.square(dimension: size, child: child),
      ),
    );
  }
}

/// 65 · Hesabım.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  static const double _avatar = 76;
  static const double _stat = 86;

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final l = context.l10n;
    final router = GoRouter.of(context);
    final ok = await showKzSheet<bool>(
      context: context,
      title: l.signOutTitle,
      closeLabel: l.close,
      builder: (ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: KzSpace.s10),
          Text(
            l.signOutBody,
            style: KzText.bodySm.copyWith(color: ctx.kz.ink2),
          ),
          const SizedBox(height: KzSpace.s20),
          KzButton(
            label: l.signOut,
            variant: KzButtonVariant.destructive,
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
          const SizedBox(height: KzSpace.s10),
          KzButton(
            label: l.keepRequest,
            variant: KzButtonVariant.secondary,
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
        ],
      ),
    );
    if (ok != true) return;
    ref.read(authSessionProvider.notifier).signOut();
    router.go(AppRoutes.welcome);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final signedIn = ref.watch(authSessionProvider) != null;
    final profile = ref.watch(profileProvider).value;
    final stats = ref.watch(accountStatsProvider).value;
    final size = context.windowSize;
    final bottomSpace = size == KzWindowSize.expanded
        ? KzSpace.xl
        : KzTabBar.reservedHeight(context) + KzSpace.s20;

    Widget stat(int? value, String label) => Expanded(
      child: Container(
        height: _stat,
        decoration: BoxDecoration(
          color: kz.surface,
          borderRadius: KzRadii.all(KzRadii.field),
          border: Border.all(color: kz.line),
        ),
        child: MergeSemantics(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value?.toString() ?? '–',
                style: KzText.digit.copyWith(color: kz.ink),
              ),
              const SizedBox(height: KzSpace.s2),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: KzText.captionSemi.copyWith(color: kz.ink2),
              ),
            ],
          ),
        ),
      ),
    );

    return ColoredBox(
      color: kz.bg,
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            context.screenGutter,
            KzSpace.s14,
            context.screenGutter,
            bottomSpace,
          ),
          child: KzMaxWidth(
            maxWidth: KzBreakpoints.mediumContent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    l.accountTitle,
                    style: KzText.h1.copyWith(color: kz.ink),
                  ),
                ),
                const SizedBox(height: KzSpace.s16),
                if (!signedIn)
                  _GuestCard(
                    onSignIn: () => context.push(AppRoutes.signIn),
                    onRegister: () => context.push(AppRoutes.register),
                  )
                else ...[
                  // Profil kartı.
                  KzPressable(
                    onPressed: () => context.push(AppRoutes.personalInfo),
                    semanticLabel: profile?.fullName ?? l.viewProfile,
                    pressedScale: 1,
                    child: Container(
                      padding: const EdgeInsets.all(KzSpace.s18),
                      decoration: BoxDecoration(
                        color: kz.surface,
                        borderRadius: KzRadii.all(KzRadii.hero),
                        border: Border.all(color: kz.line),
                        boxShadow: KzShadows.soft,
                      ),
                      child: profile == null
                          ? KzSkeleton(
                              height: _avatar,
                              borderRadius: KzRadii.all(KzRadii.md),
                            )
                          : Row(
                              children: [
                                ProfileAvatar(profile: profile, size: _avatar),
                                const SizedBox(width: KzSpace.s16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        profile.fullName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: KzText.titleLg.copyWith(
                                          color: kz.ink,
                                        ),
                                      ),
                                      const SizedBox(height: KzSpace.s6),
                                      Text(
                                        l.memberSince(
                                          '${profile.memberSince.year}',
                                        ),
                                        style: KzText.labelMedium.copyWith(
                                          color: kz.ink2,
                                        ),
                                      ),
                                      const SizedBox(height: KzSpace.s6),
                                      KzChip(
                                        label: l.viewProfile,
                                        icon: KzIcons.arrow,
                                        variant: KzChipVariant.soft,
                                        size: KzChipSize.small,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: KzSpace.s16),
                  Row(
                    children: [
                      stat(stats?.stays, l.statStays),
                      const SizedBox(width: KzSpace.s10),
                      stat(stats?.reviews, l.statReviews),
                      const SizedBox(width: KzSpace.s10),
                      stat(stats?.saved, l.statSaved),
                    ],
                  ),
                ],
                const SizedBox(height: KzSpace.s18),
                _HostCta(
                  // İlan oluşturmak hesap gerektirir (12 · Giriş Gerekli).
                  onPressed: () async {
                    if (!signedIn && !await showLoginRequiredSheet(context)) {
                      return;
                    }
                    if (!context.mounted) return;
                    final draft = await ref.read(hostDraftProvider.future);
                    if (!context.mounted) return;
                    context.push(
                      draft != null &&
                              (draft.isLive ||
                                  draft.status == ListingStatus.inReview)
                          ? AppRoutes.hostListings
                          : AppRoutes.becomeHost,
                    );
                  },
                ),
                if (signedIn) ...[
                  const SizedBox(height: KzSpace.s24),
                  KzGroup(
                    title: l.groupAccount,
                    rows: [
                      KzRow(
                        icon: KzIcons.user,
                        tone: KzIconBoxTone.forest,
                        title: l.rowPersonalInfo,
                        subtitle: l.rowPersonalInfoSub,
                        onPressed: () => context.push(AppRoutes.personalInfo),
                      ),
                      KzRow(
                        icon: KzIcons.lock,
                        title: l.rowSecurity,
                        onPressed: () => context.push(AppRoutes.security),
                      ),
                      KzRow(
                        icon: KzIcons.bell,
                        title: l.rowNotificationPrefs,
                        onPressed: () =>
                            context.push(AppRoutes.notificationPrefs),
                      ),
                      KzRow(
                        icon: KzIcons.eyeoff,
                        title: l.rowPrivacy,
                        onPressed: () => context.push(AppRoutes.privacy),
                      ),
                      KzRow(
                        icon: KzIcons.wallet,
                        tone: KzIconBoxTone.apricot,
                        title: l.rowWallet,
                        subtitle: l.rowWalletSub,
                        onPressed: () => context.push(AppRoutes.wallet),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: KzSpace.s20),
                KzGroup(
                  title: l.groupSupport,
                  rows: [
                    KzRow(
                      icon: KzIcons.help,
                      tone: KzIconBoxTone.pool,
                      title: l.rowHelp,
                      onPressed: () => context.push(AppRoutes.help),
                    ),
                    KzRow(
                      icon: KzIcons.doc,
                      title: l.rowLegal,
                      onPressed: () => context.push(AppRoutes.legal),
                    ),
                  ],
                ),
                if (signedIn) ...[
                  const SizedBox(height: KzSpace.s20),
                  KzPressable(
                    onPressed: () => _signOut(context, ref),
                    semanticLabel: l.signOut,
                    child: Container(
                      height: KzSize.socialButton,
                      decoration: BoxDecoration(
                        color: kz.surface,
                        borderRadius: KzRadii.all(KzRadii.md),
                        border: Border.all(color: kz.line),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          KzIcon(
                            KzIcons.logout,
                            size: KzSize.iconSm,
                            color: kz.apricotText,
                          ),
                          const SizedBox(width: KzSpace.s8),
                          Text(
                            l.signOut,
                            style: KzText.titleSm.copyWith(
                              color: kz.apricotText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: KzSpace.s14),
                Text(
                  l.versionLine(AppInfo.version),
                  textAlign: TextAlign.center,
                  style: KzText.caption.copyWith(color: kz.ink2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Forest kart: "Bungalovunu kirala".
class _HostCta extends StatelessWidget {
  const _HostCta({required this.onPressed});

  final VoidCallback onPressed;

  static const double _box = 56;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: '${l.hostCtaTitle}, ${l.hostCtaBody}',
      child: Container(
        padding: const EdgeInsets.all(KzSpace.s18),
        decoration: BoxDecoration(
          color: kz.forest,
          borderRadius: KzRadii.all(KzRadii.lg),
        ),
        child: Row(
          children: [
            Container(
              width: _box,
              height: _box,
              decoration: BoxDecoration(
                color: kz.forestSoft,
                borderRadius: KzRadii.all(KzRadii.md),
              ),
              child: Center(
                child: KzIcon(
                  KzIcons.home,
                  size: KzSize.iconXl,
                  color: kz.forest,
                ),
              ),
            ),
            const SizedBox(width: KzSpace.s14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.hostCtaTitle,
                    style: KzText.title.copyWith(color: kz.onForest),
                  ),
                  const SizedBox(height: KzSpace.s4),
                  Text(
                    l.hostCtaBody,
                    style: KzText.caption.copyWith(color: kz.forestSoft),
                  ),
                ],
              ),
            ),
            const SizedBox(width: KzSpace.s10),
            Container(
              width: KzSize.circleSm,
              height: KzSize.circleSm,
              decoration: BoxDecoration(
                color: kz.surface,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: KzIcon(
                  KzIcons.arrow,
                  size: KzSize.iconSm,
                  color: kz.forest,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuestCard extends StatelessWidget {
  const _GuestCard({required this.onSignIn, required this.onRegister});

  final VoidCallback onSignIn;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return Container(
      padding: const EdgeInsets.all(KzSpace.s18),
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.all(KzRadii.hero),
        border: Border.all(color: kz.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l.guestAccountTitle,
            style: KzText.titleLg.copyWith(color: kz.ink),
          ),
          const SizedBox(height: KzSpace.s6),
          Text(
            l.guestAccountBody,
            style: KzText.bodySm.copyWith(color: kz.ink2),
          ),
          const SizedBox(height: KzSpace.s16),
          KzButton(label: l.signInSubmit, onPressed: onSignIn),
          const SizedBox(height: KzSpace.s10),
          KzButton(
            label: l.welcomeCreateAccount,
            variant: KzButtonVariant.secondary,
            onPressed: onRegister,
          ),
        ],
      ),
    );
  }
}
