import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/input_formatters.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_choice_card.dart';
import '../../../../core/widgets/kz_dashed_border.dart';
import '../../../../core/widgets/kz_group.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_photo_picker.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_segmented.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_switch.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/domain/auth_validators.dart';
import '../../../listing/domain/listing_detail.dart';
import '../../domain/listing_draft.dart';
import '../controllers/host_controllers.dart';
import '../host_labels.dart';
import '../widgets/wizard_fields.dart';
import '../widgets/wizard_scaffold.dart';
import 'wizard_steps_b.dart' show CheckRow;

typedef _Edit = void Function(ListingDraft Function(ListingDraft d) change);

_Edit _editor(WidgetRef ref) => ref.read(hostDraftProvider.notifier).edit;

/// 90 · İlan 8 — Giriş ve Ev Kılavuzu. Bu bilgiler yalnızca onaylı misafire,
/// girişten bir gün önce gösterilir (§10).
class CheckInStep extends ConsumerWidget {
  const CheckInStep({super.key, this.editing = false});

  final bool editing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final edit = _editor(ref);
    return WizardScaffold(
      step: WizardStep.checkIn,
      editing: editing,
      title: l.wizCheckInTitle,
      subtitle: l.wizCheckInSubtitle,
      builder: (d) => [
        WizardSection(l.wizCheckInMethod, top: false),
        WizardGrid(
          children: [
            for (final m in const [
              SelfCheckIn.keybox,
              SelfCheckIn.smartLock,
              SelfCheckIn.none,
            ])
              KzChoiceCard(
                label: m.label(l),
                icon: m.icon,
                selected: d.checkInMethod == m,
                onPressed: () => edit((d) => d.copyWith(checkInMethod: m)),
              ),
          ],
        ),
        WizardSection(l.wizCheckInInfo),
        if (d.checkInMethod != SelfCheckIn.none) ...[
          DraftInput(
            label: d.checkInMethod == SelfCheckIn.keybox
                ? l.lockboxCode
                : l.smartLockCode,
            icon: KzIcons.lock,
            value: d.lockboxCode,
            keyboardType: TextInputType.visiblePassword,
            capitalization: TextCapitalization.none,
            onChanged: (v) => edit((d) => d.copyWith(lockboxCode: v)),
          ),
          const SizedBox(height: KzSpace.s10),
          DraftInput(
            label: l.lockboxPlace,
            icon: KzIcons.pin,
            value: d.lockboxHint,
            onChanged: (v) => edit((d) => d.copyWith(lockboxHint: v)),
          ),
          const SizedBox(height: KzSpace.s10),
        ],
        Row(
          children: [
            Expanded(
              child: DraftInput(
                label: l.wifiName,
                value: d.wifiName,
                capitalization: TextCapitalization.none,
                onChanged: (v) => edit((d) => d.copyWith(wifiName: v)),
              ),
            ),
            const SizedBox(width: KzSpace.s10),
            Expanded(
              child: DraftInput(
                label: l.wifiPassword,
                value: d.wifiPassword,
                capitalization: TextCapitalization.none,
                onChanged: (v) => edit((d) => d.copyWith(wifiPassword: v)),
              ),
            ),
          ],
        ),
        WizardSection(l.wizInstructions),
        DraftTextArea(
          label: l.wizPoolInstructions,
          value: d.poolInstructions,
          onChanged: (v) => edit((d) => d.copyWith(poolInstructions: v)),
        ),
        const SizedBox(height: KzSpace.s10),
        DraftTextArea(
          label: l.wizHouseInstructions,
          value: d.houseInstructions,
          onChanged: (v) => edit((d) => d.copyWith(houseInstructions: v)),
        ),
        WizardSection(l.wizCheckoutList),
        for (final (i, task) in d.checkoutTasks.indexed) ...[
          Container(
            padding: const EdgeInsets.only(left: KzSpace.s16),
            decoration: BoxDecoration(
              color: kz.surface,
              borderRadius: KzRadii.all(KzRadii.tile),
              border: Border.all(color: kz.line),
            ),
            child: Row(
              children: [
                KzIcon(KzIcons.grid, size: KzSize.iconSm, color: kz.ink2),
                const SizedBox(width: KzSpace.s10),
                Expanded(
                  child: Text(
                    task,
                    style: KzText.bodySm.copyWith(color: kz.ink),
                  ),
                ),
                KzPressable(
                  onPressed: () => edit(
                    (d) => d.copyWith(
                      checkoutTasks: [...d.checkoutTasks]..removeAt(i),
                    ),
                  ),
                  semanticLabel: l.removeItem(task),
                  child: Padding(
                    padding: const EdgeInsets.all(KzSpace.s12),
                    child: KzIcon(
                      KzIcons.x,
                      size: KzSize.iconSm,
                      color: kz.ink2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: KzSpace.s8),
        ],
        KzPressable(
          onPressed: () async {
            final t = await showTextSheet(
              context,
              title: l.addItem,
              label: l.wizCheckoutItem,
            );
            if (t != null) {
              edit((d) => d.copyWith(checkoutTasks: [...d.checkoutTasks, t]));
            }
          },
          semanticLabel: l.addItem,
          child: KzDashedBorder(
            radius: KzRadii.tile,
            child: SizedBox(
              height: KzSize.socialButton - KzSpace.s8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KzIcon(KzIcons.plus, size: KzSize.iconSm, color: kz.forest),
                  const SizedBox(width: KzSpace.s6),
                  Text(
                    l.addItem,
                    style: KzText.label.copyWith(color: kz.forest),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Belgeyi seçip yükler. KVKK: dosya yüklendikten sonra cihazda tutulmaz.
Future<void> _uploadDoc(
  BuildContext context,
  WidgetRef ref,
  HostDocKind kind,
) async {
  final f = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxWidth: KzPhotoPicker.maxDimension,
    maxHeight: KzPhotoPicker.maxDimension,
    imageQuality: KzPhotoPicker.quality,
  );
  if (f == null) return;
  try {
    await ref.read(hostDraftProvider.notifier).uploadDocument(kind, f.path);
    if (context.mounted) showKzToast(context, context.l10n.docUploaded);
  } on Object {
    if (context.mounted) showKzToast(context, context.l10n.errorDocUpload);
  }
}

/// 91 · İlan 9 — Yasal Belgeler. İzin belge numarası olmayan ilan yayına
/// alınmaz (§10).
class LegalStep extends ConsumerWidget {
  const LegalStep({super.key, this.editing = false});

  final bool editing;

  Future<void> _conditionalDoc(
    BuildContext context,
    WidgetRef ref,
    HostDocKind kind,
  ) async {
    final l = context.l10n;
    await showKzSheet<void>(
      context: context,
      title: kind.label(l),
      closeLabel: l.close,
      builder: (_) => Consumer(
        builder: (ctx, ref, _) {
          final d = ref.watch(hostDraftProvider).value;
          if (d == null) return const SizedBox.shrink();
          final applies = kind == HostDocKind.condoDecision
              ? d.multiUnitParcel
              : d.onBehalfOfOwner;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              KzGroup(
                inset: KzSpace.s16,
                rows: [
                  KzRow(
                    title: kind.detail(l),
                    trailing: KzSwitch(
                      value: applies,
                      semanticLabel: kind.detail(l),
                      onChanged: (v) => _editor(ref)(
                        (d) => kind == HostDocKind.condoDecision
                            ? d.copyWith(multiUnitParcel: v)
                            : d.copyWith(onBehalfOfOwner: v),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: KzSpace.s16),
              KzButton(
                label: d.documents.containsKey(kind)
                    ? l.docReplace
                    : l.docUpload,
                variant: KzButtonVariant.secondary,
                onPressed: applies ? () => _uploadDoc(ctx, ref, kind) : null,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final edit = _editor(ref);

    Widget docStatus(ListingDraft d, HostDocKind k) {
      if (d.documents.containsKey(k)) {
        return KzChip(
          label: l.docUploadedShort,
          icon: KzIcons.check,
          variant: KzChipVariant.soft,
          size: KzChipSize.small,
          labelColor: kz.forest,
        );
      }
      final required =
          !k.conditional ||
          (k == HostDocKind.condoDecision && d.multiUnitParcel) ||
          (k == HostDocKind.powerOfAttorney && d.onBehalfOfOwner);
      return KzChip(
        label: required ? l.docUpload : l.ifNeeded,
        variant: required ? KzChipVariant.outline : KzChipVariant.soft,
        size: KzChipSize.small,
      );
    }

    return WizardScaffold(
      step: WizardStep.legal,
      editing: editing,
      title: l.wizLegalTitle,
      subtitle: l.wizLegalSubtitle,
      builder: (d) => [
        KzTip(
          icon: KzIcons.alert,
          tone: KzTipTone.warning,
          message: l.wizLegalLaw,
        ),
        WizardSection(l.wizPermitType),
        for (final t in PermitType.values) ...[
          KzRadioCard(
            title: t.label(l),
            subtitle: t.detail(l),
            selected: d.permitType == t,
            onPressed: () => edit((d) => d.copyWith(permitType: t)),
          ),
          const SizedBox(height: KzSpace.s10),
        ],
        WizardSection(l.wizPermitInfo, top: false),
        DraftInput(
          label: l.permitNoLabel,
          icon: KzIcons.doc,
          value: d.permitNo,
          capitalization: TextCapitalization.characters,
          onChanged: (v) => edit((d) => d.copyWith(permitNo: v.trim())),
        ),
        const SizedBox(height: KzSpace.s8),
        Text(l.permitNoHint, style: KzText.caption.copyWith(color: kz.ink2)),
        const SizedBox(height: KzSpace.s8),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: KzLink(
            label: l.noPermitHow,
            style: KzText.label,
            onPressed: () => context.push(AppRoutes.help),
          ),
        ),
        WizardSection(l.wizDocuments),
        KzGroup(
          rows: [
            for (final k in const [
              HostDocKind.permit,
              HostDocKind.deed,
              HostDocKind.condoDecision,
              HostDocKind.powerOfAttorney,
            ])
              KzRow(
                icon: k.icon,
                tone: d.documents.containsKey(k)
                    ? KzIconBoxTone.forest
                    : KzIconBoxTone.sand,
                title: k.label(l),
                subtitle: k.detail(l),
                trailing: docStatus(d, k),
                onPressed: () => k.conditional
                    ? _conditionalDoc(context, ref, k)
                    : _uploadDoc(context, ref, k),
              ),
          ],
        ),
        WizardSection(l.wizEntrancePlate),
        KzGroup(
          rows: [
            KzRow(
              icon: HostDocKind.entrancePlate.icon,
              tone: d.documents.containsKey(HostDocKind.entrancePlate)
                  ? KzIconBoxTone.forest
                  : KzIconBoxTone.apricot,
              title: HostDocKind.entrancePlate.label(l),
              subtitle: HostDocKind.entrancePlate.detail(l),
              trailing: docStatus(d, HostDocKind.entrancePlate),
              onPressed: () =>
                  _uploadDoc(context, ref, HostDocKind.entrancePlate),
            ),
          ],
        ),
        WizardSection(l.wizResponsibilities),
        KzGroup(
          inset: KzSpace.s16,
          rows: [
            CheckRow(
              title: l.declKbs,
              subtitle: l.declKbsBody,
              value: d.kbsDeclaration,
              onChanged: (v) => edit((d) => d.copyWith(kbsDeclaration: v)),
            ),
            CheckRow(
              title: l.declPermitHolder,
              subtitle: l.declPermitHolderBody,
              value: d.permitHolderDeclaration,
              onChanged: (v) =>
                  edit((d) => d.copyWith(permitHolderDeclaration: v)),
            ),
            CheckRow(
              title: l.declUpdate,
              value: d.updateDeclaration,
              onChanged: (v) => edit((d) => d.copyWith(updateDeclaration: v)),
            ),
          ],
        ),
        WizardSection(l.wizTaxInfo),
        KzSegmented<TaxType>(
          segments: [
            (TaxType.individual, l.taxIndividual),
            (TaxType.company, l.taxCompany),
          ],
          selected: d.taxType,
          onChanged: (t) => edit((d) => d.copyWith(taxType: t, taxId: '')),
        ),
        const SizedBox(height: KzSpace.s10),
        DraftInput(
          key: ValueKey(d.taxType),
          label: d.taxType == TaxType.individual ? l.tcknLabel : l.taxNoLabel,
          icon: KzIcons.user,
          value: d.taxId,
          obscure: d.taxType == TaxType.individual,
          toggleLabels: (l.show, l.hide),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(
              d.taxType == TaxType.individual ? 11 : 10,
            ),
          ],
          onChanged: (v) => edit((d) => d.copyWith(taxId: v)),
        ),
        const SizedBox(height: KzSpace.s10),
        DraftInput(
          label: l.taxOffice,
          icon: KzIcons.receipt,
          value: d.taxOffice,
          capitalization: TextCapitalization.words,
          onChanged: (v) => edit((d) => d.copyWith(taxOffice: v)),
        ),
        const SizedBox(height: KzSpace.s12),
        KzTip(icon: KzIcons.info, tone: KzTipTone.info, message: l.taxNote),
      ],
    );
  }
}

/// 92 · İlan 10 — Kimlik ve Ödeme. Hesap sahibi doğrulanmış kimlikteki
/// adla eşleşmeli; IBAN TR biçimi + mod-97 ile doğrulanır (§10).
class IdentityPayoutStep extends ConsumerWidget {
  const IdentityPayoutStep({super.key, this.editing = false});

  final bool editing;

  Future<void> _verify(
    BuildContext context,
    WidgetRef ref,
    IdentityStep step,
  ) async {
    final f = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: step == IdentityStep.selfie
          ? CameraDevice.front
          : CameraDevice.rear,
      maxWidth: KzPhotoPicker.maxDimension,
      maxHeight: KzPhotoPicker.maxDimension,
      imageQuality: KzPhotoPicker.quality,
    );
    if (f == null) return;
    try {
      await ref.read(hostDraftProvider.notifier).verifyIdentity(step, f.path);
    } on Object {
      if (context.mounted) showKzToast(context, context.l10n.errorIdentity);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final edit = _editor(ref);
    return WizardScaffold(
      step: WizardStep.identityAndPayout,
      editing: editing,
      continueLabel: l.goToPreview,
      title: l.wizIdentityTitle,
      subtitle: l.wizIdentitySubtitle,
      builder: (d) {
        final ibanFilled =
            d.iban.replaceAll(' ', '').length >= IbanValidator.trLength;
        final ibanError = ibanFilled && !IbanValidator.isValidTr(d.iban)
            ? l.errorIban
            : null;
        final holderError =
            d.verifiedName != null &&
                d.accountHolder.trim().isNotEmpty &&
                !NameMatcher.same(d.accountHolder, d.verifiedName!)
            ? l.errorIbanHolder
            : null;
        return [
          WizardSection(
            l.wizIdentity,
            trailing: l.countOf(
              d.identityDone.length,
              IdentityStep.values.length,
            ),
            top: false,
          ),
          KzGroup(
            rows: [
              for (final s in IdentityStep.values)
                Builder(
                  builder: (_) {
                    final done = d.identityDone.contains(s);
                    return KzRow(
                      icon: done ? KzIcons.check : KzIcons.camera,
                      tone: done ? KzIconBoxTone.forest : KzIconBoxTone.sand,
                      title: s.label(l),
                      subtitle: s.detail(l),
                      trailing: done
                          ? Text(
                              l.done,
                              style: KzText.label.copyWith(color: kz.forest),
                            )
                          : KzButton(
                              label: l.start,
                              icon: KzIcons.camera,
                              size: KzButtonSize.compact,
                              expand: false,
                              onPressed: () => _verify(context, ref, s),
                            ),
                    );
                  },
                ),
            ],
          ),
          WizardSection(l.wizPayout),
          DraftInput(
            label: l.accountHolder,
            icon: KzIcons.user,
            value: d.accountHolder,
            errorText: holderError,
            capitalization: TextCapitalization.words,
            onChanged: (v) => edit((d) => d.copyWith(accountHolder: v)),
          ),
          const SizedBox(height: KzSpace.s10),
          DraftInput(
            label: l.ibanLabel,
            icon: KzIcons.card,
            value: d.iban,
            errorText: ibanError,
            hint: l.ibanHint,
            capitalization: TextCapitalization.characters,
            inputFormatters: [IbanInputFormatter()],
            onChanged: (v) => edit((d) => d.copyWith(iban: v)),
          ),
          const SizedBox(height: KzSpace.s8),
          Text(l.ibanNote, style: KzText.caption.copyWith(color: kz.ink2)),
          WizardSection(l.wizBillingContact),
          DraftInput(
            label: l.billingAddress,
            icon: KzIcons.pin,
            value: d.billingAddress,
            capitalization: TextCapitalization.words,
            onChanged: (v) => edit((d) => d.copyWith(billingAddress: v)),
          ),
          const SizedBox(height: KzSpace.s10),
          DraftInput(
            label: l.emergencyPhone,
            icon: KzIcons.phone,
            value: d.emergencyPhone,
            keyboardType: TextInputType.phone,
            inputFormatters: [TrPhoneInputFormatter()],
            errorText:
                d.emergencyPhone.isNotEmpty &&
                    !AuthValidators.isTrMobile(d.emergencyPhone)
                ? l.errorPhone
                : null,
            onChanged: (v) => edit(
              (d) =>
                  d.copyWith(emergencyPhone: v.replaceAll(RegExp(r'\D'), '')),
            ),
          ),
          const SizedBox(height: KzSpace.s10),
          KzGroup(
            inset: KzSpace.s16,
            rows: [
              KzRow(
                title: l.reachableTitle,
                subtitle: l.reachableBody,
                trailing: KzSwitch(
                  value: d.reachableDuringStay,
                  semanticLabel: l.reachableTitle,
                  onChanged: (v) =>
                      edit((d) => d.copyWith(reachableDuringStay: v)),
                ),
              ),
            ],
          ),
          const SizedBox(height: KzSpace.s12),
          KzTip(icon: KzIcons.lock, message: l.kvkkNote),
        ];
      },
    );
  }
}
