import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/external_links.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_accordion.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_group.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_text_area.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/presentation/widgets/booking_parts.dart';
import '../../../chat/presentation/controllers/chat_controllers.dart';
import '../../data/account_repository.dart';
import '../../domain/account_models.dart';
import '../controllers/account_controllers.dart';

/// Yardım rehberinin web adresi.
final _helpCenterUri = Uri.https('kozalak.app', '/yardim');

/// 71 · Yardım.
class HelpScreen extends ConsumerStatefulWidget {
  const HelpScreen({super.key});

  @override
  ConsumerState<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends ConsumerState<HelpScreen> {
  final _query = TextEditingController();
  String? _open;

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  Future<void> _feedback() async {
    final l = context.l10n;
    final text = await showKzSheet<String>(
      context: context,
      title: l.feedbackTitle,
      closeLabel: l.close,
      builder: (_) => const _FeedbackForm(),
    );
    if (text == null || text.isEmpty) return;
    await ref.read(accountRepositoryProvider).sendFeedback(text);
    if (mounted) showKzToast(context, l.feedbackSent);
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final faq = ref.watch(faqProvider);
    final q = _query.text.trim().toLowerCase();
    final items = (faq.value ?? const <FaqItem>[])
        .where(
          (f) =>
              q.isEmpty ||
              f.question.toLowerCase().contains(q) ||
              f.answer.toLowerCase().contains(q),
        )
        .toList();

    final tiles = [
      (
        KzIcons.help,
        KzIconBoxTone.pool,
        l.helpCenter,
        l.helpCenterSub,
        () async {
          if (!await ExternalLinks.open(_helpCenterUri) && context.mounted) {
            showKzToast(context, l.cannotOpenLink);
          }
        },
      ),
      (
        KzIcons.shield,
        KzIconBoxTone.forest,
        l.safetySupport,
        l.safetySupportSub,
        () => openSupportChat(context, ref),
      ),
      (
        KzIcons.flag,
        KzIconBoxTone.apricot,
        l.reportProblem,
        l.reportProblemSub,
        () => openSupportChat(context, ref),
      ),
      (
        KzIcons.megaphone,
        KzIconBoxTone.sand,
        l.feedback,
        l.feedbackSub,
        _feedback,
      ),
    ];

    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      children: [
        KzPageTitle(title: l.helpTitle),
        KzInput(
          label: l.helpSearchLabel,
          icon: KzIcons.search,
          hint: l.helpSearchHint,
          controller: _query,
          textInputAction: TextInputAction.search,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: KzSpace.s16),
        LayoutBuilder(
          builder: (context, c) {
            final w = (c.maxWidth - KzSpace.s10) / 2;
            return Wrap(
              spacing: KzSpace.s10,
              runSpacing: KzSpace.s10,
              children: [
                for (final (icon, tone, title, sub, onTap) in tiles)
                  SizedBox(
                    width: w,
                    child: _HelpTile(
                      icon: icon,
                      tone: tone,
                      title: title,
                      subtitle: sub,
                      onPressed: onTap,
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: KzSpace.s24),
        switch (faq) {
          AsyncData() when items.isEmpty => Padding(
            padding: const EdgeInsets.symmetric(vertical: KzSpace.s16),
            child: Text(
              l.faqNoMatch,
              textAlign: TextAlign.center,
              style: KzText.bodySm.copyWith(color: kz.ink2),
            ),
          ),
          AsyncData() => KzGroup(
            title: l.faqTitle,
            rows: [
              for (final f in items)
                KzAccordionRow(
                  title: f.question,
                  body: f.answer,
                  open: _open == f.id || q.isNotEmpty,
                  onPressed: () =>
                      setState(() => _open = _open == f.id ? null : f.id),
                ),
            ],
          ),
          AsyncError() => const SizedBox.shrink(),
          _ => KzSkeleton(
            height: KzSize.tabBar * 2,
            borderRadius: KzRadii.all(KzRadii.card),
          ),
        },
      ],
    );
  }
}

class _HelpTile extends StatelessWidget {
  const _HelpTile({
    required this.icon,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  final KzIcons icon;
  final KzIconBoxTone tone;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  static const double _minHeight = 132;
  static const double _box = 44;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final (bg, fg) = switch (tone) {
      KzIconBoxTone.pool => (kz.poolSoft, kz.poolText),
      KzIconBoxTone.forest => (kz.forestSoft, kz.forest),
      KzIconBoxTone.apricot => (kz.apricotSoft, kz.apricotText),
      KzIconBoxTone.sand => (kz.sand, kz.ink),
    };
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: '$title, $subtitle',
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: _minHeight),
        padding: const EdgeInsets.all(KzSpace.s16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: KzRadii.all(KzRadii.card),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: _box,
              height: _box,
              decoration: BoxDecoration(
                color: kz.surface,
                borderRadius: KzRadii.all(KzRadii.icon),
              ),
              child: Center(
                child: KzIcon(icon, size: KzSize.iconMd, color: fg),
              ),
            ),
            const SizedBox(height: KzSpace.s20),
            Text(title, style: KzText.titleSm.copyWith(color: kz.ink)),
            const SizedBox(height: KzSpace.s2),
            Text(subtitle, style: KzText.caption.copyWith(color: kz.ink2)),
          ],
        ),
      ),
    );
  }
}

class _FeedbackForm extends StatefulWidget {
  const _FeedbackForm();

  @override
  State<_FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<_FeedbackForm> {
  final _c = TextEditingController();

  static const int _max = 1000;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
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
          KzTextArea(
            label: l.feedbackLabel,
            hint: l.feedbackHint,
            controller: _c,
            minLines: 4,
            maxLength: _max,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: KzSpace.s16),
          KzButton(
            label: l.send,
            onPressed: _c.text.trim().isEmpty
                ? null
                : () => Navigator.of(context).pop(_c.text.trim()),
          ),
        ],
      ),
    );
  }
}

extension LegalDocUi on LegalDoc {
  String label(AppLocalizations l) => switch (this) {
    LegalDoc.terms => l.docTerms,
    LegalDoc.kvkk => l.docKvkk,
    LegalDoc.privacy => l.docPrivacy,
    LegalDoc.cookies => l.docCookies,
    LegalDoc.distanceSales => l.docDistanceSales,
    LegalDoc.cancellation => l.docCancellation,
  };

  KzIcons get icon => switch (this) {
    LegalDoc.terms => KzIcons.doc,
    LegalDoc.kvkk => KzIcons.shield,
    LegalDoc.privacy => KzIcons.eye,
    LegalDoc.cookies => KzIcons.info,
    LegalDoc.distanceSales => KzIcons.receipt,
    LegalDoc.cancellation => KzIcons.calx,
  };
}

/// Hukuki metinlerin son güncellenme ayı (backend sürümüyle aynı tutulur).
final _legalUpdated = DateTime(2026, 10);

/// 72 · Hukuki Bilgiler.
class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      children: [
        KzPageTitle(title: l.legalTitle),
        KzGroup(
          rows: [
            for (final d in LegalDoc.values)
              KzRow(
                icon: d.icon,
                title: d.label(l),
                onPressed: () => context.push(AppRoutes.legalDoc(d.name)),
              ),
          ],
        ),
        const SizedBox(height: KzSpace.s20),
        Container(
          padding: const EdgeInsets.all(KzSpace.s16),
          decoration: BoxDecoration(
            color: kz.sand,
            borderRadius: KzRadii.all(KzRadii.md),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppInfo.companyName,
                style: KzText.bodySm.copyWith(
                  color: kz.ink,
                  fontWeight: KzText.extraBold,
                ),
              ),
              const SizedBox(height: KzSpace.s2),
              Text(
                l.legalFooter(
                  AppInfo.version,
                  KzFormat.monthYear(_legalUpdated),
                ),
                style: KzText.caption.copyWith(color: kz.ink2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Hukuki belge görüntüleme (72 alt sayfası; 39 ve 70'teki bağlantılar).
class LegalDocScreen extends ConsumerWidget {
  const LegalDocScreen({super.key, required this.doc});

  final LegalDoc doc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final d = ref.watch(legalDocumentProvider(doc));
    final date = DateFormat('d MMMM y', kzLocale);
    return switch (d) {
      AsyncData(:final value) => KzScaffold(
        header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
        children: [
          KzPageTitle(
            title: doc.label(l),
            subtitle: l.updatedOn(date.format(value.updatedAt)),
          ),
          for (final p in value.paragraphs)
            p.startsWith('## ')
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: KzSpace.s16,
                      bottom: KzSpace.s6,
                    ),
                    child: Semantics(
                      header: true,
                      child: Text(
                        p.substring(3),
                        style: KzText.titleSm.copyWith(color: kz.ink),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: KzSpace.s8),
                    child: Text(p, style: KzText.body.copyWith(color: kz.ink)),
                  ),
        ],
      ),
      AsyncError() => BookingError(
        onRetry: () => ref.invalidate(legalDocumentProvider(doc)),
      ),
      _ => const BookingLoading(cards: 2),
    };
  }
}
