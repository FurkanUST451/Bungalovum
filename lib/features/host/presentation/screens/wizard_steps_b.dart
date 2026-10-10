import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_checkbox.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_choice_card.dart';
import '../../../../core/widgets/kz_group.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_switch.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../listing/domain/listing_detail.dart';
import '../../../listing/presentation/listing_detail_labels.dart';
import '../../domain/listing_draft.dart';
import '../controllers/host_controllers.dart';
import '../host_labels.dart';
import '../widgets/wizard_fields.dart';
import '../widgets/wizard_scaffold.dart';

typedef _Edit = void Function(ListingDraft Function(ListingDraft d) change);

_Edit _editor(WidgetRef ref) => ref.read(hostDraftProvider.notifier).edit;

/// 87 · İlan 5 — Başlık ve Açıklama.
class TitleDescriptionStep extends ConsumerWidget {
  const TitleDescriptionStep({super.key, this.editing = false});

  final bool editing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final edit = _editor(ref);
    return WizardScaffold(
      step: WizardStep.titleAndDescription,
      editing: editing,
      title: l.wizTitleTitle,
      subtitle: l.wizTitleSubtitle,
      builder: (d) {
        final full = d.highlights.length >= ListingRules.maxHighlights;
        final titleLen = d.title.trim().length;
        final spaceLen = d.space.trim().length;
        return [
          WizardSection(l.wizListingTitle, top: false),
          DraftInput(
            label: l.wizTitleLabel,
            value: d.title,
            maxLength: ListingRules.maxTitle,
            capitalization: TextCapitalization.words,
            onChanged: (v) => edit((d) => d.copyWith(title: v)),
          ),
          const SizedBox(height: KzSpace.s8),
          Text(l.wizTitleHint, style: KzText.caption.copyWith(color: kz.ink2)),
          if (titleLen < ListingRules.minTitle) ...[
            const SizedBox(height: KzSpace.s6),
            KzFieldMessage(
              text: l.minCharsHint(titleLen, ListingRules.minTitle),
            ),
          ],
          WizardSection(
            l.wizHighlights(ListingRules.maxHighlights),
            trailing: l.countOf(
              d.highlights.length,
              ListingRules.maxHighlights,
            ),
          ),
          Wrap(
            spacing: KzSpace.s8,
            runSpacing: KzSpace.s8,
            children: [
              for (final t in HighlightTag.values)
                Builder(
                  builder: (_) {
                    final on = d.highlights.contains(t);
                    return KzChip(
                      label: t.label(l),
                      icon: on ? KzIcons.check : null,
                      variant: on
                          ? KzChipVariant.filled
                          : KzChipVariant.outline,
                      semanticLabel: t.label(l),
                      onPressed: !on && full
                          ? () => showKzToast(
                              context,
                              l.wizHighlightsFull(ListingRules.maxHighlights),
                            )
                          : () => edit(
                              (d) => d.copyWith(
                                highlights: on
                                    ? ({...d.highlights}..remove(t))
                                    : {...d.highlights, t},
                              ),
                            ),
                    );
                  },
                ),
            ],
          ),
          WizardSection(l.wizDescription),
          DraftTextArea(
            label: l.wizSpace,
            value: d.space,
            maxLength: ListingRules.maxDescription,
            minLines: 3,
            onChanged: (v) => edit((d) => d.copyWith(space: v)),
          ),
          if (spaceLen < ListingRules.minSpace) ...[
            const SizedBox(height: KzSpace.s7),
            KzFieldMessage(
              text: l.minCharsHint(spaceLen, ListingRules.minSpace),
            ),
          ],
          const SizedBox(height: KzSpace.s10),
          DraftTextArea(
            label: l.wizGuestAccess,
            value: d.guestAccess,
            maxLength: ListingRules.maxDescription,
            onChanged: (v) => edit((d) => d.copyWith(guestAccess: v)),
          ),
          const SizedBox(height: KzSpace.s10),
          DraftTextArea(
            label: l.wizOtherNotes,
            value: d.otherNotes,
            maxLength: ListingRules.maxDescription,
            onChanged: (v) => edit((d) => d.copyWith(otherNotes: v)),
          ),
        ];
      },
    );
  }
}

/// Grup içinde onay kutusu satırı (başlık + isteğe bağlı açıklama).
class CheckRow extends StatelessWidget {
  const CheckRow({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KzSpace.s16,
        vertical: KzSpace.s14,
      ),
      child: KzCheckboxTile(
        value: value,
        size: KzSize.checkboxLg,
        gap: KzSpace.s12,
        semanticLabel: title,
        onChanged: onChanged,
        label: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: KzSpace.s2),
              child: Text(
                title,
                style: KzText.bodyStrongSm.copyWith(color: kz.ink),
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: KzSpace.s3),
              Text(subtitle!, style: KzText.caption.copyWith(color: kz.ink2)),
            ],
          ],
        ),
      ),
    );
  }
}

/// 88 · İlan 6 — Güvenlik ve Ev Kuralları.
class SafetyRulesStep extends ConsumerWidget {
  const SafetyRulesStep({super.key, this.editing = false});

  final bool editing;

  static const _safetyOrder = [
    SafetyKind.smokeDetector,
    SafetyKind.coAlarm,
    SafetyKind.fireExtinguisher,
    SafetyKind.firstAidKit,
    SafetyKind.poolFence,
    SafetyKind.outdoorCamera,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final edit = _editor(ref);

    String? safetyNote(SafetyKind k) => switch (k) {
      SafetyKind.coAlarm => l.wizCoNote,
      SafetyKind.poolFence => l.wizPoolFenceNote,
      SafetyKind.outdoorCamera => l.wizCameraNote,
      _ => null,
    };

    Future<void> pickTime(String title, String current, bool checkIn) async {
      final t = await showTimeSheet(context, title: title, selected: current);
      if (t == null) return;
      edit(
        (d) => checkIn ? d.copyWith(checkInFrom: t) : d.copyWith(checkOutBy: t),
      );
    }

    KzRow switchRow(
      String title,
      bool value,
      ListingDraft Function(ListingDraft, bool) set, {
      String? subtitle,
    }) => KzRow(
      title: title,
      subtitle: subtitle,
      trailing: KzSwitch(
        value: value,
        semanticLabel: title,
        onChanged: (v) => edit((d) => set(d, v)),
      ),
    );

    return WizardScaffold(
      step: WizardStep.safetyAndRules,
      editing: editing,
      title: l.wizSafetyTitle,
      subtitle: l.wizSafetySubtitle,
      builder: (d) => [
        WizardSection(l.wizSafetyGear, top: false),
        KzGroup(
          inset: KzSpace.s16,
          rows: [
            for (final k in _safetyOrder)
              if (k != SafetyKind.poolFence || d.hasPool)
                CheckRow(
                  title: k.label(l),
                  subtitle: safetyNote(k),
                  value: d.safety.contains(k),
                  onChanged: (v) => edit(
                    (d) => d.copyWith(
                      safety: v ? {...d.safety, k} : ({...d.safety}..remove(k)),
                    ),
                  ),
                ),
          ],
        ),
        if (d.safety.contains(SafetyKind.outdoorCamera)) ...[
          const SizedBox(height: KzSpace.s10),
          DraftInput(
            label: l.wizCameraLocation,
            icon: KzIcons.camera,
            value: d.outdoorCameraNote,
            errorText: d.outdoorCameraNote.trim().isEmpty
                ? l.wizCameraLocationRequired
                : null,
            onChanged: (v) => edit((d) => d.copyWith(outdoorCameraNote: v)),
          ),
        ],
        if (d.hasPool) ...[
          WizardSection(l.wizPoolSafety),
          KzGroup(
            inset: KzSpace.s16,
            rows: [
              CheckRow(
                title: l.wizNoLifeguard,
                value: d.poolNoLifeguardAck,
                onChanged: (v) =>
                    edit((d) => d.copyWith(poolNoLifeguardAck: v)),
              ),
              CheckRow(
                title: l.wizDepthMarked,
                value: d.poolDepthMarked,
                onChanged: (v) => edit((d) => d.copyWith(poolDepthMarked: v)),
              ),
            ],
          ),
        ],
        WizardSection(l.wizHouseRules),
        Row(
          children: [
            Expanded(
              child: ValueBox(
                label: l.checkInTime,
                icon: KzIcons.clock,
                value: d.checkInFrom,
                onPressed: () => pickTime(l.checkInTime, d.checkInFrom, true),
              ),
            ),
            const SizedBox(width: KzSpace.s10),
            Expanded(
              child: ValueBox(
                label: l.checkOutTime,
                icon: KzIcons.clock,
                value: d.checkOutBy,
                onPressed: () => pickTime(l.checkOutTime, d.checkOutBy, false),
              ),
            ),
          ],
        ),
        const SizedBox(height: KzSpace.s10),
        KzGroup(
          inset: KzSpace.s16,
          rows: [
            switchRow(
              l.wizPets,
              d.petsAllowed,
              (d, v) => d.copyWith(petsAllowed: v),
            ),
            switchRow(
              l.wizSmoking,
              d.smokingAllowed,
              (d, v) => d.copyWith(smokingAllowed: v),
            ),
            switchRow(
              l.wizEvents,
              d.eventsAllowed,
              (d, v) => d.copyWith(eventsAllowed: v),
            ),
            switchRow(
              l.wizQuietHours,
              d.quietHours,
              (d, v) => d.copyWith(quietHours: v),
              subtitle: l.rangeValue(d.quietFrom, d.quietTo),
            ),
          ],
        ),
      ],
    );
  }
}

/// 89 · İlan 7 — Fiyat ve Rezervasyon.
class PricingStep extends ConsumerWidget {
  const PricingStep({super.key, this.editing = false});

  final bool editing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final edit = _editor(ref);

    Future<void> pickInt(
      String title,
      int? current,
      ListingDraft Function(ListingDraft, int) set,
    ) async {
      final r = await showNumberSheet(
        context,
        title: title,
        labels: [title],
        initial: [current],
      );
      if (r != null) edit((d) => set(d, r.first.toInt()));
    }

    Future<void> pickWheel(
      String title,
      NumberRange range,
      int current,
      String unit,
      ListingDraft Function(ListingDraft, int) set,
    ) async {
      final r = await showWheelSheet(
        context,
        title: title,
        fields: [
          WheelField(label: title, range: range, value: current, unit: unit),
        ],
      );
      if (r != null) edit((d) => set(d, r.first.round()));
    }

    return WizardScaffold(
      step: WizardStep.pricing,
      editing: editing,
      title: l.wizPriceTitle,
      subtitle: l.wizPriceSubtitle,
      builder: (d) {
        final nightly = d.nightlyPrice;
        final earnings = nightly == null
            ? null
            : ref
                  .watch(
                    hostEarningsProvider(
                      nightly: nightly,
                      cleaningFee: d.cleaningFee,
                      city: d.district,
                    ),
                  )
                  .value;
        return [
          KzPressable(
            onPressed: () => pickInt(
              l.nightlyPrice,
              nightly,
              (d, v) => d.copyWith(nightlyPrice: v),
            ),
            semanticLabel: l.nightlyPrice,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(KzSpace.s20),
              decoration: BoxDecoration(
                color: kz.surface,
                borderRadius: KzRadii.all(KzRadii.card),
                border: Border.all(color: kz.forest, width: KzSize.borderFocus),
              ),
              child: Column(
                children: [
                  Text(
                    l.nightlyPrice,
                    style: KzText.label.copyWith(color: kz.forest),
                  ),
                  const SizedBox(height: KzSpace.s6),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      nightly == null ? l.tapToSet : KzFormat.currency(nightly),
                      style: KzText.display.copyWith(color: kz.ink),
                    ),
                  ),
                  if (earnings?.similarMin case final lo?
                      when earnings?.similarMax != null) ...[
                    const SizedBox(height: KzSpace.s6),
                    Text(
                      l.similarRange(
                        KzFormat.currency(lo),
                        KzFormat.currency(earnings!.similarMax!),
                      ),
                      textAlign: TextAlign.center,
                      style: KzText.caption.copyWith(color: kz.ink2),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: KzSpace.s10),
          WizardGrid(
            children: [
              ValueBox(
                label: l.weekendPrice,
                value: d.weekendPrice == null
                    ? null
                    : KzFormat.currency(d.weekendPrice!),
                onPressed: () => pickInt(
                  l.weekendPrice,
                  d.weekendPrice,
                  (d, v) => d.copyWith(weekendPrice: v),
                ),
              ),
              ValueBox(
                label: l.cleaningFee,
                value: KzFormat.currency(d.cleaningFee),
                onPressed: () => pickInt(
                  l.cleaningFee,
                  d.cleaningFee,
                  (d, v) => d.copyWith(cleaningFee: v),
                ),
              ),
              ValueBox(
                label: l.weeklyDiscount,
                value: l.percentValue(d.weeklyDiscountPercent),
                onPressed: () => pickWheel(
                  l.weeklyDiscount,
                  ListingRules.weeklyDiscount,
                  d.weeklyDiscountPercent,
                  l.wheelUnitPercent,
                  (d, v) => d.copyWith(weeklyDiscountPercent: v),
                ),
              ),
              ValueBox(
                label: l.minNights,
                value: l.nightsCount(d.minNights),
                onPressed: () => pickWheel(
                  l.minNights,
                  ListingRules.minNights,
                  d.minNights,
                  l.wheelUnitNights,
                  (d, v) => d.copyWith(minNights: v),
                ),
              ),
            ],
          ),
          if (earnings != null) ...[
            const SizedBox(height: KzSpace.s16),
            _EarningsCard(e: earnings),
          ],
          WizardSection(l.wizBookingType),
          KzRadioCard(
            title: l.instantBook,
            subtitle: l.instantBookBody,
            icon: KzIcons.sparkles,
            selected: d.instantBook,
            onPressed: () => edit((d) => d.copyWith(instantBook: true)),
          ),
          const SizedBox(height: KzSpace.s10),
          KzRadioCard(
            title: l.requestBook,
            subtitle: l.requestBookBody,
            icon: KzIcons.clock,
            selected: !d.instantBook,
            onPressed: () => edit((d) => d.copyWith(instantBook: false)),
          ),
          WizardSection(l.cancellationPolicy),
          KzGroup(
            inset: KzSpace.s16,
            rows: [
              for (final p in CancellationPolicy.values)
                _RadioRow(
                  title: p.label(l),
                  subtitle: p.detail(l),
                  selected: d.cancellation == p,
                  onPressed: () => edit((d) => d.copyWith(cancellation: p)),
                ),
            ],
          ),
          const SizedBox(height: KzSpace.s16),
          KzGroup(
            rows: [
              KzRow(
                icon: KzIcons.calendar,
                title: l.availabilityCalendar,
                subtitle: l.availabilityCalendarSub,
                // TODO(takvim): Ev sahibi takvim ekranı Figma'ya eklenince.
                onPressed: () => showKzToast(context, l.calendarSoon),
              ),
            ],
          ),
        ];
      },
    );
  }
}

class _EarningsCard extends StatelessWidget {
  const _EarningsCard({required this.e});

  final EarningsEstimate e;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    Widget line(
      String label,
      String value, {
      Color? color,
      bool bold = false,
    }) => Padding(
      padding: const EdgeInsets.symmetric(vertical: KzSpace.s4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: (bold ? KzText.bodyStrongSm : KzText.bodySm).copyWith(
                color: bold ? kz.ink : kz.ink2,
              ),
            ),
          ),
          const SizedBox(width: KzSpace.s8),
          Text(
            value,
            style: KzText.bodyStrongSm.copyWith(color: color ?? kz.ink),
          ),
        ],
      ),
    );
    return Container(
      padding: const EdgeInsets.all(KzSpace.s16),
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.all(KzRadii.card),
        border: Border.all(color: kz.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l.earningsTitle, style: KzText.titleSm.copyWith(color: kz.ink)),
          const SizedBox(height: KzSpace.s8),
          line(
            l.nightsTimesPrice(e.nights, KzFormat.currency(e.nightly)),
            KzFormat.currency(e.stayTotal),
          ),
          line(l.cleaningFee, KzFormat.currency(e.cleaningFee)),
          line(
            l.serviceFeeExample,
            l.minusAmount(KzFormat.currency(e.serviceFee)),
            color: kz.apricotText,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: KzSpace.s8),
            child: Container(height: KzSize.border, color: kz.line),
          ),
          line(
            l.youEarn,
            KzFormat.currency(e.hostEarns),
            color: kz.forest,
            bold: true,
          ),
          const SizedBox(height: KzSpace.s6),
          Text(l.earningsNote, style: KzText.caption.copyWith(color: kz.ink2)),
        ],
      ),
    );
  }
}

/// Grup içinde radyo satırı (iptal politikası, belge türü).
class _RadioRow extends StatelessWidget {
  const _RadioRow({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      child: KzPressable(
        onPressed: onPressed,
        semanticLabel: '$title, $subtitle',
        pressedScale: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KzSpace.s16,
            vertical: KzSpace.s14,
          ),
          child: Row(
            children: [
              KzRadio(value: selected),
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
                      subtitle,
                      style: KzText.caption.copyWith(color: kz.ink2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
