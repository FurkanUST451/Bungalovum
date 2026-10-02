import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/clock.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_group.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_switch.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/domain/auth_validators.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../auth/presentation/widgets/auth_parts.dart';
import '../../../booking/presentation/widgets/booking_parts.dart';
import '../../../chat/presentation/chat_labels.dart';
import '../../data/account_repository.dart';
import '../../domain/account_models.dart';
import '../controllers/account_controllers.dart';

/// 67 · Giriş ve Güvenlik.
class SecurityScreen extends ConsumerWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final security = ref.watch(securityProvider);
    return switch (security) {
      AsyncData(:final value) => _content(context, ref, value),
      AsyncError() => BookingError(
        onRetry: () => ref.invalidate(securityProvider),
      ),
      _ => const BookingLoading(cards: 2),
    };
  }

  Widget _content(BuildContext context, WidgetRef ref, SecuritySettings s) {
    final kz = context.kz;
    final l = context.l10n;
    final now = ref.watch(clockProvider)();
    final time = DateFormat('d MMM, HH:mm', kzLocale);
    final notifier = ref.read(securityProvider.notifier);

    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.close, close: true),
      ),
      children: [
        KzPageTitle(title: l.securityTitle),
        KzGroup(
          title: l.groupSignInMethods,
          rows: [
            KzRow(
              icon: KzIcons.fingerprint,
              tone: KzIconBoxTone.forest,
              title: l.biometricTitle,
              subtitle: l.biometricBody,
              trailing: KzSwitch(
                value: s.biometric,
                semanticLabel: l.biometricTitle,
                onChanged: notifier.setBiometric,
              ),
            ),
            KzRow(
              icon: KzIcons.lock,
              title: l.passwordRow,
              subtitle: l.passwordUpdatedAgo(
                notificationAgo(l, s.passwordUpdatedAt, now),
              ),
              trailing: KzLink(
                label: l.update,
                style: KzText.bodySm,
                onPressed: () => showKzSheet<void>(
                  context: context,
                  title: l.changePasswordTitle,
                  closeLabel: l.close,
                  builder: (_) => const _ChangePasswordForm(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: KzSpace.s20),
        KzGroup(
          title: l.groupDevices,
          rows: [
            for (final d in s.devices)
              KzRow(
                icon: KzIcons.phone,
                tone: KzIconBoxTone.pool,
                title: d.name,
                subtitle: l.deviceLine(d.city, time.format(d.lastActive)),
                trailing: d.current
                    ? KzChip(
                        label: l.thisDevice,
                        variant: KzChipVariant.accent,
                        size: KzChipSize.mini,
                      )
                    : KzLink(
                        label: l.signOutDevice,
                        style: KzText.label,
                        onPressed: () async {
                          await notifier.signOutDevice(d.id);
                          if (context.mounted) {
                            showKzToast(context, l.deviceSignedOut);
                          }
                        },
                      ),
              ),
          ],
        ),
        const SizedBox(height: KzSpace.s20),
        KzGroup(
          title: l.groupDanger,
          rows: [
            KzRow(
              icon: KzIcons.trash,
              tone: KzIconBoxTone.apricot,
              title: l.closeAccount,
              titleColor: kz.apricotText,
              subtitle: l.closeAccountSub,
              onPressed: () => context.push(AppRoutes.closeAccount),
            ),
          ],
        ),
      ],
    );
  }
}

class _ChangePasswordForm extends ConsumerStatefulWidget {
  const _ChangePasswordForm();

  @override
  ConsumerState<_ChangePasswordForm> createState() =>
      _ChangePasswordFormState();
}

class _ChangePasswordFormState extends ConsumerState<_ChangePasswordForm> {
  final _current = TextEditingController();
  final _next = TextEditingController();
  bool _submitted = false;
  bool _saving = false;
  String? _serverError;

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      _submitted = true;
      _serverError = null;
    });
    if (_current.text.isEmpty ||
        !AuthValidators.isValidNewPassword(_next.text)) {
      return;
    }
    setState(() => _saving = true);
    final l = context.l10n;
    try {
      await ref
          .read(securityProvider.notifier)
          .changePassword(_current.text, _next.text);
      if (!mounted) return;
      showKzToast(context, l.passwordUpdated);
      Navigator.of(context).pop();
    } on PasswordChangeRejected {
      if (mounted) setState(() => _serverError = l.errorWrongPassword);
    } on Object {
      if (mounted) setState(() => _serverError = l.errorNetwork);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: KzSpace.s12),
          KzInput(
            label: l.fieldCurrentPassword,
            icon: KzIcons.lock,
            controller: _current,
            obscure: true,
            toggleLabels: (l.showPassword, l.hidePassword),
            autofillHints: const [AutofillHints.password],
            errorText:
                _serverError ??
                (_submitted && _current.text.isEmpty ? l.errorName : null),
            textInputAction: TextInputAction.next,
            onChanged: (_) => setState(() => _serverError = null),
          ),
          const SizedBox(height: KzSpace.s12),
          KzInput(
            label: l.fieldNewPassword,
            icon: KzIcons.lock,
            controller: _next,
            obscure: true,
            toggleLabels: (l.showPassword, l.hidePassword),
            autofillHints: const [AutofillHints.newPassword],
            errorText:
                _submitted && !AuthValidators.isValidNewPassword(_next.text)
                ? l.errorPasswordRule
                : null,
            textInputAction: TextInputAction.done,
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: KzSpace.s8),
          PasswordStrengthMeter(password: _next.text),
          const SizedBox(height: KzSpace.s16),
          KzButton(label: l.save, loading: _saving, onPressed: _save),
        ],
      ),
    );
  }
}

/// 68 · Hesabı Kapat.
class CloseAccountScreen extends ConsumerStatefulWidget {
  const CloseAccountScreen({super.key});

  @override
  ConsumerState<CloseAccountScreen> createState() => _CloseAccountScreenState();
}

class _CloseAccountScreenState extends ConsumerState<CloseAccountScreen> {
  final _password = TextEditingController();
  bool _closing = false;
  String? _error;

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _close() async {
    if (_password.text.isEmpty || _closing) return;
    HapticFeedback.mediumImpact();
    final l = context.l10n;
    setState(() {
      _closing = true;
      _error = null;
    });
    try {
      await ref.read(accountRepositoryProvider).closeAccount(_password.text);
      ref.read(authSessionProvider.notifier).signOut();
      if (!mounted) return;
      showKzToast(context, l.accountClosed);
      context.go(AppRoutes.welcome);
    } on CloseAccountRejected catch (e) {
      if (mounted) {
        setState(
          () => _error = e.error == CloseAccountError.wrongPassword
              ? l.errorWrongPassword
              : l.closeUpcomingTitle,
        );
      }
    } on Object {
      if (mounted) setState(() => _error = l.errorNetwork);
    } finally {
      if (mounted) setState(() => _closing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final impact = ref.watch(closeAccountImpactProvider);
    final i = impact.value;
    if (i == null) {
      return impact.hasError
          ? BookingError(
              onRetry: () => ref.invalidate(closeAccountImpactProvider),
            )
          : const BookingLoading(cards: 2);
    }
    final blocked = i.upcomingBooking != null;

    Widget item(KzIcons icon, String title, String body) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KzIconBox(icon: icon, tone: KzIconBoxTone.apricot, size: KzSpace.s36),
        const SizedBox(width: KzSpace.s12),
        Expanded(
          child: MergeSemantics(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: KzText.bodySm.copyWith(
                    color: kz.ink,
                    fontWeight: KzText.extraBold,
                  ),
                ),
                const SizedBox(height: KzSpace.s2),
                Text(body, style: KzText.caption.copyWith(color: kz.ink2)),
              ],
            ),
          ),
        ),
      ],
    );

    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      bottomBar: KzBottomBar(
        child: Row(
          children: [
            Expanded(
              child: KzButton(
                label: l.keepRequest,
                variant: KzButtonVariant.secondary,
                onPressed: () => context.pop(),
              ),
            ),
            const SizedBox(width: KzSpace.s10),
            Expanded(
              child: KzButton(
                label: l.closeAccount,
                variant: KzButtonVariant.destructive,
                loading: _closing,
                onPressed: blocked || _password.text.isEmpty ? null : _close,
              ),
            ),
          ],
        ),
      ),
      children: [
        KzPageTitle(
          title: l.closeAccountTitle,
          subtitle: l.closeAccountSubtitle,
        ),
        BookingCard(
          child: Column(
            children: [
              if (blocked) ...[
                item(
                  KzIcons.calendar,
                  l.closeUpcomingTitle,
                  l.closeUpcomingBody(i.upcomingBooking!),
                ),
                const SizedBox(height: KzSpace.s16),
              ],
              item(
                KzIcons.heart,
                l.closeListsTitle,
                l.closeListsBody(i.lists, i.savedListings),
              ),
              const SizedBox(height: KzSpace.s16),
              item(KzIcons.star, l.closeReviewsTitle, l.closeReviewsBody),
              const SizedBox(height: KzSpace.s16),
              item(KzIcons.doc, l.closeLegalTitle, l.closeLegalBody),
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s16),
        if (blocked) ...[
          KzTip(
            icon: KzIcons.alert,
            tone: KzTipTone.warning,
            message: l.closeUpcomingBody(i.upcomingBooking!),
          ),
          const SizedBox(height: KzSpace.s10),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: KzLink(
              label: l.goToTrips,
              onPressed: () => context.go(AppRoutes.trips),
            ),
          ),
        ] else
          KzInput(
            label: l.confirmWithPassword,
            icon: KzIcons.lock,
            controller: _password,
            obscure: true,
            toggleLabels: (l.showPassword, l.hidePassword),
            autofillHints: const [AutofillHints.password],
            errorText: _error,
            textInputAction: TextInputAction.done,
            onChanged: (_) => setState(() => _error = null),
            onSubmitted: (_) => _close(),
          ),
      ],
    );
  }
}
