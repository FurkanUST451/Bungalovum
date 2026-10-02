import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/clock.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/input_formatters.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_segmented.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../account/domain/account_models.dart' show LegalDoc;
import '../../../auth/domain/auth_validators.dart';
import '../../domain/booking.dart';
import '../controllers/stay_guests_controller.dart';
import '../widgets/booking_parts.dart';

/// 39 · Misafir Bilgileri: kimlik bildirimi (KBS) için tüm misafirlerin
/// bilgileri girişten önce toplanır.
class GuestDetailsScreen extends ConsumerWidget {
  const GuestDetailsScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(stayGuestsControllerProvider(bookingId));
    return switch (list) {
      AsyncData(:final value) => _Content(bookingId: bookingId, list: value),
      AsyncError() => BookingError(
        onRetry: () => ref.invalidate(stayGuestsControllerProvider(bookingId)),
      ),
      _ => const BookingLoading(cards: 2),
    };
  }
}

class _Content extends ConsumerStatefulWidget {
  const _Content({required this.bookingId, required this.list});

  final String bookingId;
  final StayGuestList list;

  @override
  ConsumerState<_Content> createState() => _ContentState();
}

class _ContentState extends ConsumerState<_Content> {
  final _name = TextEditingController();
  final _id = TextEditingController();
  final _birth = TextEditingController();
  Nationality _nationality = Nationality.turkish;
  bool _submitted = false;
  bool _saving = false;

  @override
  void dispose() {
    // KVKK: kimlik numarası ekrandan çıkınca bellekte kalmasın.
    for (final c in [_name, _id, _birth]) {
      c.clear();
      c.dispose();
    }
    super.dispose();
  }

  bool get _turkish => _nationality == Nationality.turkish;

  DateTime? get _birthDate => AuthValidators.parseBirthDate(_birth.text);

  bool get _nameOk => _name.text.trim().isNotEmpty;

  bool get _idOk => _turkish
      ? IdValidators.isTckn(_id.text)
      : IdValidators.isPassport(_id.text);

  bool get _birthOk {
    final b = _birthDate;
    return b != null && b.isBefore(ref.read(clockProvider)());
  }

  void _setNationality(Nationality n) {
    if (n == _nationality) return;
    setState(() {
      _nationality = n;
      _id.clear();
    });
  }

  Future<void> _save() async {
    setState(() => _submitted = true);
    if (!_nameOk || !_idOk || !_birthOk) return;
    HapticFeedback.lightImpact();
    setState(() => _saving = true);
    try {
      await ref
          .read(stayGuestsControllerProvider(widget.bookingId).notifier)
          .add(
            StayGuestInput(
              fullName: _name.text.trim(),
              nationality: _nationality,
              idNumber: _id.text.trim().toUpperCase(),
              birthDate: _birthDate!,
            ),
          );
      if (!mounted) return;
      for (final c in [_name, _id, _birth]) {
        c.clear();
      }
      setState(() {
        _submitted = false;
        _nationality = Nationality.turkish;
      });
      showKzToast(context, context.l10n.guestSaved);
    } on Object {
      if (mounted) showKzToast(context, context.l10n.errorNetwork);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final list = widget.list;
    final today = ref.watch(clockProvider)();
    final days = DateUtils.dateOnly(
      list.checkIn,
    ).difference(DateUtils.dateOnly(today)).inDays;

    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.back),
        trailing: KzChip(
          label: l.guestInfoProgress(list.guests.length, list.requiredCount),
          icon: KzIcons.check,
          variant: KzChipVariant.selected,
          size: KzChipSize.small,
        ),
      ),
      bottomBar: list.isComplete
          ? null
          : KzBottomBar(
              child: KzBottomBarSummary(
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l.daysToCheckIn(days < 0 ? 0 : days),
                      style: KzText.bodySm.copyWith(
                        color: kz.ink,
                        fontWeight: KzText.extraBold,
                        height: KzText.tightLeading,
                      ),
                    ),
                    const SizedBox(height: KzSpace.s2),
                    Text(
                      l.completeLater,
                      style: KzText.caption.copyWith(
                        color: kz.ink2,
                        height: KzText.tightLeading,
                      ),
                    ),
                  ],
                ),
                action: KzButton(
                  label: l.save,
                  expand: false,
                  loading: _saving,
                  onPressed: _save,
                ),
              ),
            ),
      children: [
        KzPageTitle(title: l.guestInfoTitle, subtitle: l.guestInfoSubtitle),
        for (final g in list.guests) ...[
          _SavedGuest(guest: g),
          const SizedBox(height: KzSpace.s16),
        ],
        if (list.isComplete)
          KzTip(
            icon: KzIcons.check,
            tone: KzTipTone.success,
            message: l.guestInfoComplete,
          )
        else ...[
          _form(list.guests.length + 1),
          const SizedBox(height: KzSpace.s16),
        ],
        const SizedBox(height: KzSpace.s16),
        KzTip(
          icon: KzIcons.shield,
          message: l.guestInfoKvkk,
          link: (
            l.privacyNoticeLink,
            () => context.push(AppRoutes.legalDoc(LegalDoc.kvkk.name)),
          ),
        ),
      ],
    );
  }

  Widget _form(int number) {
    final kz = context.kz;
    final l = context.l10n;
    void changed(String _) => setState(() {});
    return BookingCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(
                    l.guestNumber(number),
                    style: KzText.bodyStrong.copyWith(
                      color: kz.ink,
                      fontWeight: KzText.extraBold,
                    ),
                  ),
                ),
              ),
              Text(
                l.requiredField,
                style: KzText.captionHeavy.copyWith(color: kz.apricotText),
              ),
            ],
          ),
          const SizedBox(height: KzSpace.s12),
          KzSegmented<Nationality>(
            segments: [
              (Nationality.turkish, l.nationalityTurkish),
              (Nationality.foreign, l.nationalityForeign),
            ],
            selected: _nationality,
            onChanged: _setNationality,
          ),
          const SizedBox(height: KzSpace.s12),
          KzInput(
            label: l.fieldFullName,
            icon: KzIcons.user,
            controller: _name,
            errorText: _submitted && !_nameOk ? l.errorName : null,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onChanged: changed,
          ),
          const SizedBox(height: KzSpace.s12),
          KzInput(
            key: ValueKey(_nationality),
            label: _turkish ? l.fieldTckn : l.fieldPassport,
            icon: KzIcons.idcard,
            controller: _id,
            hint: _turkish ? l.hintTckn : l.hintPassport,
            errorText: _submitted && !_idOk
                ? (_turkish ? l.errorTckn : l.errorPassport)
                : null,
            keyboardType: _turkish ? TextInputType.number : TextInputType.text,
            textCapitalization: TextCapitalization.characters,
            textInputAction: TextInputAction.next,
            inputFormatters: _turkish
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ]
                : [
                    FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')),
                    LengthLimitingTextInputFormatter(9),
                  ],
            onChanged: changed,
          ),
          const SizedBox(height: KzSpace.s12),
          KzInput(
            label: l.fieldBirthDate,
            icon: KzIcons.calendar,
            controller: _birth,
            hint: l.hintBirthDate,
            errorText: _submitted && !_birthOk ? l.errorBirthDate : null,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: [BirthDateInputFormatter()],
            onChanged: changed,
          ),
        ],
      ),
    );
  }
}

/// Bilgisi kaydedilmiş misafir: baş harf + ad + maskeli kimlik + onay.
class _SavedGuest extends StatelessWidget {
  const _SavedGuest({required this.guest});

  final StayGuest guest;

  static const double _check = 32;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final name = guest.isYou ? l.guestYou(guest.fullName) : guest.fullName;
    final id = guest.nationality == Nationality.turkish
        ? l.idMaskedTr(guest.idLast2)
        : l.idMaskedPassport(guest.idLast2);
    return MergeSemantics(
      child: BookingCard(
        padding: const EdgeInsets.all(KzSpace.s16),
        child: Row(
          children: [
            Container(
              width: KzSize.minTouch,
              height: KzSize.minTouch,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kz.forestSoft,
                shape: BoxShape.circle,
              ),
              child: ExcludeSemantics(
                child: Text(
                  guest.fullName.characters.first.toUpperCaseTr(),
                  style: KzText.title.copyWith(color: kz.forest),
                ),
              ),
            ),
            const SizedBox(width: KzSpace.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.titleSm.copyWith(color: kz.ink),
                  ),
                  const SizedBox(height: KzSpace.s2),
                  Text(id, style: KzText.caption.copyWith(color: kz.ink2)),
                ],
              ),
            ),
            const SizedBox(width: KzSpace.s8),
            Container(
              width: _check,
              height: _check,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kz.forest,
                shape: BoxShape.circle,
              ),
              child: KzIcon(
                KzIcons.check,
                size: KzSpace.s16,
                color: kz.onForest,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
