import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../../../../core/widgets/kz_switch.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/presentation/widgets/booking_parts.dart';
import '../../domain/listing_draft.dart';
import '../controllers/host_controllers.dart';
import '../host_labels.dart';
import 'wizard_steps_b.dart' show CheckRow;

/// Sihirbaz adımının düzenleme adresi (İlan Yönetimi ve Önizleme'den).
String hostEditRoute(WizardStep s) =>
    '${AppRoutes.hostWizard(s.number)}?$editQuery';

const editQuery = 'duzenle=1';

/// 82 · Ev Sahibi Ol.
class BecomeHostScreen extends ConsumerStatefulWidget {
  const BecomeHostScreen({super.key});

  /// Tanıtım görseli; CDN'e yüklenince adresi buraya gelir.
  static const String? heroPhotoUrl = null;

  @override
  ConsumerState<BecomeHostScreen> createState() => _BecomeHostScreenState();
}

class _BecomeHostScreenState extends ConsumerState<BecomeHostScreen> {
  bool _loading = false;

  static const double _heroAspect = 350 / 220;

  Future<void> _start() async {
    if (_loading) return;
    HapticFeedback.lightImpact();
    setState(() => _loading = true);
    try {
      final d = await ref.read(hostDraftProvider.notifier).start();
      if (!mounted) return;
      context.push(
        d.isLive || d.status == ListingStatus.inReview
            ? AppRoutes.hostListings
            : AppRoutes.hostWizard(d.resumeStep.number),
      );
    } on Object {
      if (mounted) showKzToast(context, context.l10n.errorNetwork);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final draft = ref.watch(hostDraftProvider).value;
    final steps = [
      (l.hostStep1, l.hostStep1Body),
      (l.hostStep2, l.hostStep2Body),
      (l.hostStep3, l.hostStep3Body),
    ];
    final prep = [l.hostPrep1, l.hostPrep2, l.hostPrep3, l.hostPrep4];
    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.close, close: true),
      ),
      bottomBar: KzBottomBar(
        child: KzButton(
          label: draft == null ? l.letsStart : l.continueWhereLeft,
          trailingArrow: true,
          loading: _loading,
          onPressed: _start,
        ),
      ),
      children: [
        ClipRRect(
          borderRadius: KzRadii.all(KzRadii.hero),
          child: AspectRatio(
            aspectRatio: _heroAspect,
            child: Stack(
              children: [
                const Positioned.fill(
                  child: KzPhoto(url: BecomeHostScreen.heroPhotoUrl),
                ),
                Positioned(
                  left: KzSpace.s14,
                  top: KzSpace.s14,
                  child: KzChip(
                    label: l.hostProgram,
                    icon: KzIcons.home,
                    variant: KzChipVariant.soft,
                    size: KzChipSize.small,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: KzSpace.s24),
        Semantics(
          header: true,
          child: Text(
            l.hostHeroTitle,
            style: KzText.h1.copyWith(color: kz.ink),
          ),
        ),
        const SizedBox(height: KzSpace.s12),
        Text(
          l.hostHeroBody,
          style: KzText.bodySm.copyWith(
            color: kz.ink2,
            height: KzText.body.height,
          ),
        ),
        const SizedBox(height: KzSpace.s20),
        Container(
          padding: const EdgeInsets.all(KzSpace.s16),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.card),
            border: Border.all(color: kz.line),
          ),
          child: Column(
            children: [
              for (final (i, (title, body)) in steps.indexed) ...[
                if (i > 0) const SizedBox(height: KzSpace.s16),
                Row(
                  children: [
                    Container(
                      width: KzSize.circleSm,
                      height: KzSize.circleSm,
                      decoration: BoxDecoration(
                        color: kz.forestSoft,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${i + 1}',
                        style: KzText.label.copyWith(color: kz.forest),
                      ),
                    ),
                    const SizedBox(width: KzSpace.s12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: KzText.bodyStrongSm.copyWith(color: kz.ink),
                          ),
                          const SizedBox(height: KzSpace.s2),
                          Text(
                            body,
                            style: KzText.caption.copyWith(color: kz.ink2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s16),
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
                l.hostPrepTitle,
                style: KzText.titleSm.copyWith(color: kz.ink),
              ),
              const SizedBox(height: KzSpace.s10),
              for (final p in prep)
                Padding(
                  padding: const EdgeInsets.only(bottom: KzSpace.s6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KzIcon(
                        KzIcons.check,
                        size: KzSize.iconSm,
                        color: kz.forest,
                      ),
                      const SizedBox(width: KzSpace.s8),
                      Expanded(
                        child: Text(
                          p,
                          style: KzText.bodySm.copyWith(color: kz.ink),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Önizleme ve yönetimde ilan özet kartı.
class _ListingSummaryCard extends StatelessWidget {
  const _ListingSummaryCard({required this.draft, this.trailing});

  final ListingDraft draft;
  final Widget? trailing;

  static const double _thumb = 64;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final d = draft;
    return Row(
      children: [
        SizedBox.square(
          dimension: _thumb,
          child: ClipRRect(
            borderRadius: KzRadii.all(KzRadii.tile),
            child: KzPhoto(url: d.cover?.url),
          ),
        ),
        const SizedBox(width: KzSpace.s12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                d.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: KzText.bodyStrongSm.copyWith(color: kz.ink),
              ),
              const SizedBox(height: KzSpace.s2),
              Text(
                [
                  d.district,
                  if (d.nightlyPrice != null)
                    l.perNightPrice(KzFormat.currency(d.nightlyPrice!)),
                ].join(' · '),
                style: KzText.caption.copyWith(color: kz.ink2),
              ),
              if (trailing != null) ...[
                const SizedBox(height: KzSpace.s6),
                trailing!,
              ],
            ],
          ),
        ),
      ],
    );
  }
}

KzChip _statusChip(AppLocalizations l, ListingStatus s) {
  final (label, variant, icon) = switch (s) {
    ListingStatus.published => (
      l.statusPublished,
      KzChipVariant.soft,
      KzIcons.check,
    ),
    ListingStatus.paused => (
      l.statusPaused,
      KzChipVariant.outline,
      KzIcons.clock,
    ),
    ListingStatus.inReview => (
      l.statusInReview,
      KzChipVariant.accent,
      KzIcons.clock,
    ),
    ListingStatus.rejected => (
      l.statusRejected,
      KzChipVariant.accent,
      KzIcons.alert,
    ),
    ListingStatus.draft => (l.statusDraft, KzChipVariant.outline, KzIcons.edit),
  };
  return KzChip(
    label: label,
    icon: icon,
    variant: variant,
    size: KzChipSize.small,
  );
}

/// 93 · İlan Önizleme ("Son bir kontrol").
class HostPreviewScreen extends ConsumerStatefulWidget {
  const HostPreviewScreen({super.key});

  @override
  ConsumerState<HostPreviewScreen> createState() => _HostPreviewScreenState();
}

class _HostPreviewScreenState extends ConsumerState<HostPreviewScreen> {
  bool _sending = false;

  static const double _coverAspect = 350 / 230;

  Future<void> _submit() async {
    if (_sending) return;
    HapticFeedback.lightImpact();
    setState(() => _sending = true);
    try {
      await ref.read(hostDraftProvider.notifier).submit();
      if (mounted) context.go(AppRoutes.hostInReview);
    } on Object {
      if (mounted) showKzToast(context, context.l10n.errorNetwork);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final d = ref.watch(hostDraftProvider).value;
    if (d == null) return const BookingLoading(cards: 2);
    final edit = ref.read(hostDraftProvider.notifier).edit;
    final missing = WizardStep.values
        .where((s) => !DraftValidator.isComplete(s, d))
        .length;

    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      bottomBar: KzBottomBar(
        child: KzButton(
          label: l.submitForReview,
          trailingArrow: true,
          loading: _sending,
          onPressed: DraftValidator.canSubmit(d) ? _submit : null,
        ),
      ),
      children: [
        KzPageTitle(title: l.previewTitle, subtitle: l.previewSubtitle),
        ClipRRect(
          borderRadius: KzRadii.all(KzRadii.lg),
          child: AspectRatio(
            aspectRatio: _coverAspect,
            child: Stack(
              children: [
                Positioned.fill(child: KzPhoto(url: d.cover?.url)),
                Positioned(
                  right: KzSpace.s12,
                  bottom: KzSpace.s12,
                  child: KzChip(
                    label: l.photoIndex(1, d.photoCount),
                    variant: KzChipVariant.soft,
                    size: KzChipSize.small,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: KzSpace.s14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(d.title, style: KzText.title.copyWith(color: kz.ink)),
            ),
            KzChip(
              label: l.badgeNew,
              icon: KzIcons.sparkles,
              variant: KzChipVariant.accent,
              size: KzChipSize.small,
            ),
          ],
        ),
        const SizedBox(height: KzSpace.s4),
        Text(
          [
            '${d.district}, ${d.city}',
            l.listingGuests(d.maxGuests),
            l.bedroomsCount(d.bedrooms),
          ].join(' · '),
          style: KzText.caption.copyWith(color: kz.ink2),
        ),
        if (d.nightlyPrice != null) ...[
          const SizedBox(height: KzSpace.s4),
          Text(
            l.perNightPrice(KzFormat.currency(d.nightlyPrice!)),
            style: KzText.bodyStrong.copyWith(color: kz.ink),
          ),
        ],
        const SizedBox(height: KzSpace.s10),
        Wrap(
          spacing: KzSpace.s8,
          runSpacing: KzSpace.s8,
          children: [
            for (final t in d.highlights)
              KzChip(
                label: t.label(l),
                icon: t.icon,
                variant: t == HighlightTag.heatedPool
                    ? KzChipVariant.pool
                    : KzChipVariant.soft,
                size: KzChipSize.small,
              ),
          ],
        ),
        const SizedBox(height: KzSpace.s20),
        Row(
          children: [
            Expanded(
              child: Text(
                l.completedSteps,
                style: KzText.title.copyWith(color: kz.ink),
              ),
            ),
            Text(
              missing == 0 ? l.allDone : l.missingSteps(missing),
              style: KzText.label.copyWith(
                color: missing == 0 ? kz.forest : kz.apricotText,
              ),
            ),
          ],
        ),
        const SizedBox(height: KzSpace.s10),
        KzGroup(
          rows: [
            for (final s in WizardStep.values)
              Builder(
                builder: (_) {
                  final ok = DraftValidator.isComplete(s, d);
                  return KzRow(
                    icon: ok ? KzIcons.check : KzIcons.alert,
                    tone: ok ? KzIconBoxTone.forest : KzIconBoxTone.apricot,
                    title: s.label(l),
                    subtitle: s.summary(l, d),
                    trailing: KzLink(
                      label: l.edit,
                      style: KzText.label,
                      onPressed: () => context.push(hostEditRoute(s)),
                    ),
                  );
                },
              ),
          ],
        ),
        const SizedBox(height: KzSpace.s20),
        Text(l.consents, style: KzText.title.copyWith(color: kz.ink)),
        const SizedBox(height: KzSpace.s10),
        KzGroup(
          inset: KzSpace.s16,
          rows: [
            CheckRow(
              title: l.consentAccuracy,
              value: d.accuracyConsent,
              onChanged: (v) => edit((d) => d.copyWith(accuracyConsent: v)),
            ),
            CheckRow(
              title: l.consentAgreement,
              value: d.agreementConsent,
              onChanged: (v) => edit((d) => d.copyWith(agreementConsent: v)),
            ),
            CheckRow(
              title: l.consentMinistry,
              value: d.ministryConsent,
              onChanged: (v) => edit((d) => d.copyWith(ministryConsent: v)),
            ),
          ],
        ),
      ],
    );
  }
}

/// 94 · İlan İncelemede.
class HostInReviewScreen extends ConsumerWidget {
  const HostInReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final d = ref.watch(hostDraftProvider).value;
    if (d == null) return const BookingLoading(cards: 2);
    final sent = d.submittedAt;
    final now = ref.watch(clockProvider)();
    final sentLabel = sent == null
        ? ''
        : DateUtils.isSameDay(sent, now)
        ? l.todayAt(KzFormat.time(sent))
        : KzFormat.dayMonthTime(sent);
    final steps = [
      (l.reviewSent, sentLabel, _TimelineState.done),
      (l.reviewChecking, l.reviewCheckingBody, _TimelineState.current),
      (l.reviewPublish, l.reviewPublishBody, _TimelineState.pending),
    ];
    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(
          semanticLabel: l.close,
          close: true,
          onPressed: () => context.go(AppRoutes.explore),
        ),
      ),
      bottomBar: KzBottomBar(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: KzButton(
                label: l.homePage,
                variant: KzButtonVariant.outline,
                onPressed: () => context.go(AppRoutes.explore),
              ),
            ),
            const SizedBox(width: KzSpace.s10),
            Expanded(
              flex: 3,
              child: KzButton(
                label: l.manageListing,
                trailingArrow: true,
                onPressed: () => context.go(AppRoutes.hostListings),
              ),
            ),
          ],
        ),
      ),
      children: [
        const Center(
          child: KzSpotIllustration(
            icon: KzIcons.doc,
            badgeIcon: KzIcons.clock,
            dot: KzSpotDot.pool,
            large: true,
          ),
        ),
        const SizedBox(height: KzSpace.s20),
        Semantics(
          header: true,
          child: Text(
            l.inReviewTitle,
            textAlign: TextAlign.center,
            style: KzText.h2.copyWith(color: kz.ink),
          ),
        ),
        const SizedBox(height: KzSpace.s12),
        Text(
          l.inReviewBody,
          textAlign: TextAlign.center,
          style: KzText.bodySm.copyWith(
            color: kz.ink2,
            height: KzText.body.height,
          ),
        ),
        const SizedBox(height: KzSpace.s20),
        Container(
          padding: const EdgeInsets.all(KzSpace.s16),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.card),
            border: Border.all(color: kz.line),
          ),
          child: Column(
            children: [
              for (final (i, (title, body, state)) in steps.indexed)
                _TimelineRow(
                  title: title,
                  body: body,
                  state: state,
                  last: i == steps.length - 1,
                ),
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s12),
        Container(
          padding: const EdgeInsets.all(KzSpace.s12),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.card),
            border: Border.all(color: kz.line),
          ),
          child: _ListingSummaryCard(
            draft: d,
            trailing: _statusChip(l, d.status),
          ),
        ),
        const SizedBox(height: KzSpace.s12),
        KzTip(
          icon: KzIcons.calendar,
          tone: KzTipTone.info,
          message: l.inReviewTip,
        ),
      ],
    );
  }
}

enum _TimelineState { done, current, pending }

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.title,
    required this.body,
    required this.state,
    required this.last,
  });

  final String title;
  final String body;
  final _TimelineState state;
  final bool last;

  static const double _dot = 26;
  static const double _line = 22;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final (bg, fg, icon) = switch (state) {
      _TimelineState.done => (kz.forest, kz.onForest, KzIcons.check),
      _TimelineState.current => (kz.apricotSoft, kz.apricotText, KzIcons.clock),
      _TimelineState.pending => (kz.sand, kz.ink2, KzIcons.home),
    };
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: _dot,
                height: _dot,
                decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                child: Center(
                  child: KzIcon(icon, size: KzSize.iconXs, color: fg),
                ),
              ),
              if (!last)
                Expanded(
                  child: Container(
                    width: KzSize.borderFocus,
                    constraints: const BoxConstraints(minHeight: _line),
                    color: state == _TimelineState.done ? kz.forest : kz.line,
                  ),
                ),
            ],
          ),
          const SizedBox(width: KzSpace.s12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: last ? 0 : KzSpace.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: KzText.bodyStrongSm.copyWith(
                      color: state == _TimelineState.pending ? kz.ink2 : kz.ink,
                    ),
                  ),
                  if (body.isNotEmpty) ...[
                    const SizedBox(height: KzSpace.s2),
                    Text(body, style: KzText.caption.copyWith(color: kz.ink2)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 95 · İlan Yönetimi.
class HostListingsScreen extends ConsumerWidget {
  const HostListingsScreen({super.key});

  Future<void> _confirmUnpublish(BuildContext context, WidgetRef ref) async {
    final l = context.l10n;
    final ok = await showKzSheet<bool>(
      context: context,
      title: l.unpublishTitle,
      closeLabel: l.close,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l.unpublishBody,
            style: KzText.bodySm.copyWith(color: ctx.kz.ink2),
          ),
          const SizedBox(height: KzSpace.s20),
          KzButton(
            label: l.unpublish,
            variant: KzButtonVariant.destructive,
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
          const SizedBox(height: KzSpace.s10),
          KzButton(
            label: l.cancel,
            variant: KzButtonVariant.secondary,
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(hostDraftProvider.notifier).unpublish();
    if (context.mounted) showKzToast(context, l.unpublished);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final async = ref.watch(hostDraftProvider);
    final d = async.value;
    if (d == null) {
      return async.isLoading
          ? const BookingLoading(cards: 2)
          : BookingError(onRetry: () => context.go(AppRoutes.becomeHost));
    }
    final n = ref.read(hostDraftProvider.notifier);

    KzRow row(WizardStep s, {String? title, String? subtitle, KzIcons? icon}) {
      final inReview = d.sectionsInReview.contains(s);
      return KzRow(
        icon: icon ?? s.icon,
        tone: inReview ? KzIconBoxTone.apricot : KzIconBoxTone.sand,
        title: title ?? s.label(l),
        subtitle: inReview ? l.sectionInReview : subtitle ?? s.summary(l, d),
        onPressed: () => context.push(hostEditRoute(s)),
      );
    }

    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      children: [
        KzPageTitle(title: l.manageTitle, subtitle: l.manageSubtitle),
        Container(
          padding: const EdgeInsets.all(KzSpace.s14),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.card),
            border: Border.all(color: kz.line),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ListingSummaryCard(draft: d, trailing: _statusChip(l, d.status)),
              if (d.isLive) ...[
                const SizedBox(height: KzSpace.s12),
                Container(height: KzSize.border, color: kz.line),
                const SizedBox(height: KzSpace.s12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.openForBooking,
                            style: KzText.bodyStrongSm.copyWith(color: kz.ink),
                          ),
                          Text(
                            l.openForBookingBody,
                            style: KzText.caption.copyWith(color: kz.ink2),
                          ),
                        ],
                      ),
                    ),
                    KzSwitch(
                      value: d.status == ListingStatus.published,
                      semanticLabel: l.openForBooking,
                      onChanged: (v) => n.setPaused(!v),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: KzSpace.s12),
              Row(
                children: [
                  Expanded(
                    child: KzButton(
                      label: l.previewListing,
                      icon: KzIcons.eye,
                      variant: KzButtonVariant.secondary,
                      size: KzButtonSize.compact,
                      onPressed: () => context.push(AppRoutes.hostPreview),
                    ),
                  ),
                  const SizedBox(width: KzSpace.s10),
                  Expanded(
                    child: KzButton(
                      label: l.calendar,
                      icon: KzIcons.calendar,
                      variant: KzButtonVariant.secondary,
                      size: KzButtonSize.compact,
                      // TODO(takvim): Ev sahibi takvim ekranı Figma'ya eklenince.
                      onPressed: () => showKzToast(context, l.calendarSoon),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s20),
        KzGroup(
          title: l.groupListingPage,
          rows: [
            row(WizardStep.photos),
            row(WizardStep.titleAndDescription),
            row(WizardStep.typeAndLocation),
            row(WizardStep.poolAndAmenities),
            row(WizardStep.safetyAndRules),
          ],
        ),
        const SizedBox(height: KzSpace.s20),
        KzGroup(title: l.groupPriceBooking, rows: [row(WizardStep.pricing)]),
        const SizedBox(height: KzSpace.s20),
        KzGroup(title: l.groupGuestExperience, rows: [row(WizardStep.checkIn)]),
        const SizedBox(height: KzSpace.s20),
        KzGroup(
          title: l.groupDocsAccount,
          rows: [
            row(WizardStep.legal),
            row(
              WizardStep.identityAndPayout,
              title: l.identityVerification,
              icon: KzIcons.user,
              subtitle: d.verifiedName != null ? l.verified : l.notVerified,
            ),
            row(
              WizardStep.identityAndPayout,
              title: l.payout,
              icon: KzIcons.card,
            ),
          ],
        ),
        const SizedBox(height: KzSpace.s16),
        KzTip(icon: KzIcons.info, message: l.manageReviewNote),
        if (d.isLive) ...[
          const SizedBox(height: KzSpace.s16),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: KzLink(
              label: l.unpublish,
              style: KzText.label.copyWith(color: kz.apricotText),
              onPressed: () => _confirmUnpublish(context, ref),
            ),
          ),
        ],
      ],
    );
  }
}
