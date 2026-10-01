import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_counter.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../l10n/l10n.dart';
import '../../../search/domain/search_query.dart';

class GuestPickerArgs {
  const GuestPickerArgs({
    this.initial = const GuestCount(),
    this.maxGuests,
    this.petsAllowed = true,
  });

  final GuestCount initial;

  /// İlan bağlamında kapasite; aramada sınır yok.
  final int? maxGuests;
  final bool petsAllowed;
}

/// 32 · Misafirler
class GuestPickerScreen extends StatefulWidget {
  const GuestPickerScreen({super.key, required this.args});

  final GuestPickerArgs args;

  /// Kapasite yokken bir rezervasyondaki en fazla misafir.
  static const int searchMaxGuests = 16;
  static const int maxInfants = 5;
  static const int maxPets = 3;

  @override
  State<GuestPickerScreen> createState() => _GuestPickerScreenState();
}

class _GuestPickerScreenState extends State<GuestPickerScreen> {
  late GuestCount _g = widget.args.initial;

  int get _cap => widget.args.maxGuests ?? GuestPickerScreen.searchMaxGuests;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final pets = widget.args.petsAllowed;

    Widget row({
      required String title,
      required String note,
      required int value,
      required int min,
      required int max,
      required ValueChanged<int> onChanged,
      bool enabled = true,
    }) => Padding(
      padding: const EdgeInsets.symmetric(vertical: KzSpace.s16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: KzText.bodyStrong.copyWith(
                    fontWeight: KzText.extraBold,
                    color: enabled ? kz.ink : kz.placeholder,
                  ),
                ),
                const SizedBox(height: KzSpace.s3),
                Text(note, style: KzText.labelMedium.copyWith(color: kz.ink2)),
              ],
            ),
          ),
          const SizedBox(width: KzSpace.s12),
          KzCounter(
            value: value,
            min: min,
            max: max,
            enabled: enabled,
            decreaseLabel: l.counterDecrease(title),
            increaseLabel: l.counterIncrease(title),
            onChanged: onChanged,
          ),
        ],
      ),
    );

    Widget divider() => Container(height: KzSize.border, color: kz.line);

    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.close, close: true),
      ),
      bottomBar: KzBottomBar(
        child: KzBottomBarSummary(
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Semantics(
                liveRegion: true,
                child: Text(
                  l.listingGuests(_g.total),
                  style: KzText.bodyStrongSm.copyWith(
                    fontWeight: KzText.extraBold,
                    color: kz.ink,
                  ),
                ),
              ),
              KzLink(
                label: l.reset,
                onPressed: () => setState(() => _g = const GuestCount()),
              ),
            ],
          ),
          action: KzButton(
            label: l.continueLabel,
            trailingArrow: true,
            onPressed: () => context.pop(_g),
          ),
        ),
      ),
      children: [
        KzPageTitle(title: l.guestsTitle, subtitle: l.guestsSubtitle),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: KzSpace.s18,
            vertical: KzSpace.s4,
          ),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.card),
            border: Border.all(color: kz.line),
          ),
          child: Column(
            children: [
              row(
                title: l.guestsAdults,
                note: l.guestsAdultsNote,
                value: _g.adults,
                min: 1,
                max: _cap - _g.children,
                onChanged: (v) => setState(() => _g = _g.copyWith(adults: v)),
              ),
              divider(),
              row(
                title: l.guestsChildren,
                note: l.guestsChildrenNote,
                value: _g.children,
                min: 0,
                max: _cap - _g.adults,
                onChanged: (v) => setState(() => _g = _g.copyWith(children: v)),
              ),
              divider(),
              row(
                title: l.guestsInfants,
                note: l.guestsInfantsNote,
                value: _g.infants,
                min: 0,
                max: GuestPickerScreen.maxInfants,
                onChanged: (v) => setState(() => _g = _g.copyWith(infants: v)),
              ),
              divider(),
              row(
                title: l.guestsPets,
                note: pets ? l.guestsPetsNote : l.guestsPetsNotAllowed,
                value: pets ? _g.pets : 0,
                min: 0,
                max: GuestPickerScreen.maxPets,
                enabled: pets,
                onChanged: (v) => setState(() => _g = _g.copyWith(pets: v)),
              ),
            ],
          ),
        ),
        if (widget.args.maxGuests != null) ...[
          const SizedBox(height: KzSpace.s14),
          KzTip(
            icon: KzIcons.info,
            tone: KzTipTone.info,
            message: l.guestsCapacity(widget.args.maxGuests!),
          ),
        ],
      ],
    );
  }
}
