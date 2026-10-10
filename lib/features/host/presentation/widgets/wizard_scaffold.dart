import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_step_progress.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/presentation/widgets/booking_parts.dart';
import '../../domain/listing_draft.dart';
import '../controllers/host_controllers.dart';
import '../host_errors.dart';

/// Sihirbaz adımı iskeleti (83–92): "Adım n / 10", ilerleme, "Kaydet ve
/// çık", altta Geri + Devam. [editing] ise İlan Yönetimi'nden (95) açılmıştır:
/// ilerleme yerine tek "Kaydet" butonu gösterilir.
class WizardScaffold extends ConsumerStatefulWidget {
  const WizardScaffold({
    super.key,
    required this.step,
    required this.title,
    required this.builder,
    this.subtitle,
    this.editing = false,
    this.continueLabel,
  });

  final WizardStep step;
  final String title;
  final String? subtitle;
  final bool editing;
  final String? continueLabel;

  /// Taslak yüklendikten sonra adım içeriği.
  final List<Widget> Function(ListingDraft draft) builder;

  @override
  ConsumerState<WizardScaffold> createState() => _WizardScaffoldState();
}

class _WizardScaffoldState extends ConsumerState<WizardScaffold> {
  bool _saving = false;

  WizardStep get _step => widget.step;

  HostDraft get _notifier => ref.read(hostDraftProvider.notifier);

  @override
  void initState() {
    super.initState();
    // Doğrudan adrese gelindiyse taslağı oluştur.
    Future.microtask(() async {
      final d = await ref.read(hostDraftProvider.future);
      if (d == null && mounted) await _notifier.start();
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      await action();
    } on Object catch (e) {
      if (mounted) showKzToast(context, hostErrorMessage(context.l10n, e));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else if (_step.index > 0) {
      context.go(AppRoutes.hostWizard(_step.number - 1));
    } else {
      context.go(AppRoutes.becomeHost);
    }
  }

  Future<void> _continue() => _run(() async {
    HapticFeedback.lightImpact();
    final next = WizardStep.fromNumber(_step.number + 1);
    await _notifier.save(resumeAt: next ?? _step);
    if (!mounted) return;
    context.push(
      next == null ? AppRoutes.hostPreview : AppRoutes.hostWizard(next.number),
    );
  });

  Future<void> _saveAndExit() => _run(() async {
    await _notifier.save(resumeAt: _step);
    if (!mounted) return;
    showKzToast(context, context.l10n.draftSaved);
    context.go(AppRoutes.account);
  });

  Future<void> _saveEdit() => _run(() async {
    final l = context.l10n;
    final live = ref.read(hostDraftProvider).value?.isLive ?? false;
    await _notifier.save();
    if (!mounted) return;
    showKzToast(
      context,
      live && _step.needsReviewOnChange ? l.sectionSentToReview : l.saved,
    );
    context.pop();
  });

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final draft = ref.watch(hostDraftProvider).value;
    if (draft == null) return const BookingLoading(cards: 2);
    final complete = DraftValidator.isComplete(_step, draft);
    final total = WizardStep.values.length;

    return KzScaffold(
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          KzTopBar(
            leading: KzNavButton(semanticLabel: l.back, onPressed: _back),
            title: widget.editing ? null : l.wizardStepOf(_step.number, total),
            subtleTitle: true,
            trailing: widget.editing
                ? null
                : KzLink(
                    label: l.saveAndExit,
                    style: KzText.label,
                    onPressed: _saveAndExit,
                  ),
          ),
          if (!widget.editing) ...[
            const SizedBox(height: KzSpace.s12),
            KzStepProgress(
              value: _step.number / total,
              semanticLabel: l.wizardStepOf(_step.number, total),
            ),
          ],
        ],
      ),
      bottomBar: KzBottomBar(
        child: widget.editing
            ? KzButton(
                label: l.save,
                loading: _saving,
                onPressed: complete ? _saveEdit : null,
              )
            : KzBottomBarSummary(
                leading: KzLink(
                  label: l.back,
                  style: KzText.bodySm.copyWith(color: kz.ink),
                  onPressed: _back,
                ),
                action: KzButton(
                  label: widget.continueLabel ?? l.wizardContinue,
                  trailingArrow: true,
                  loading: _saving,
                  onPressed: complete ? _continue : null,
                ),
              ),
      ),
      children: [
        KzPageTitle(title: widget.title, subtitle: widget.subtitle),
        ...widget.builder(draft),
      ],
    );
  }
}

/// Adım içi bölüm başlığı ("Bungalov türü", "Çevresi"...).
class WizardSection extends StatelessWidget {
  const WizardSection(this.text, {super.key, this.trailing, this.top = true});

  final String text;
  final String? trailing;

  /// Üstte bölüm aralığı bırakılsın mı.
  final bool top;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Padding(
      padding: EdgeInsets.only(top: top ? KzSpace.s24 : 0, bottom: KzSpace.s12),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              header: true,
              child: Text(text, style: KzText.title.copyWith(color: kz.ink)),
            ),
          ),
          if (trailing != null)
            Text(trailing!, style: KzText.label.copyWith(color: kz.forest)),
        ],
      ),
    );
  }
}

/// İki kolonlu ızgara (seçim kartları, değer kutuları).
class WizardGrid extends StatelessWidget {
  const WizardGrid({
    super.key,
    required this.children,
    this.columns = 2,
    this.gap = KzSpace.s10,
  });

  final List<Widget> children;
  final int columns;
  final double gap;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, c) {
      final w = (c.maxWidth - gap * (columns - 1)) / columns;
      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: [
          for (final child in children) SizedBox(width: w, child: child),
        ],
      );
    },
  );
}
