import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_segmented.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/presentation/screens/date_picker_screen.dart';
import '../../../booking/presentation/screens/guest_picker_screen.dart';
import '../../domain/search_query.dart';
import '../controllers/search_controller.dart';
import '../search_labels.dart';

enum SearchMode { list, map }

/// 14 · Arama
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final SearchQuery _initial = ref.read(searchQueryControllerProvider);
  late final _location = TextEditingController(text: _initial.location);
  late StayDates? _dates = _initial.dates;
  late GuestCount _guests = _initial.guests;
  SearchMode _mode = SearchMode.list;

  @override
  void dispose() {
    _location.dispose();
    super.dispose();
  }

  Future<void> _pickDates() async {
    final r = await context.push<DatePickerResult>(
      AppRoutes.dates,
      extra: DatePickerArgs(initial: _dates, location: _location.text),
    );
    if (r != null) setState(() => _dates = r.dates);
  }

  Future<void> _pickGuests() async {
    final r = await context.push<GuestCount>(
      AppRoutes.guests,
      extra: GuestPickerArgs(initial: _guests),
    );
    if (r != null) setState(() => _guests = r);
  }

  void _clear() => setState(() {
    _location.clear();
    _dates = null;
    _guests = const GuestCount();
  });

  void _submit() {
    final c = ref.read(searchQueryControllerProvider.notifier);
    c.apply(
      ref
          .read(searchQueryControllerProvider)
          .copyWith(
            location: _location.text.trim(),
            dates: _dates,
            guests: _guests,
          ),
    );
    context.pushReplacement(
      _mode == SearchMode.map ? AppRoutes.map : AppRoutes.results,
    );
  }

  void _useRecent(RecentSearch r) => setState(() {
    _location.text = r.location;
    _dates = r.dates;
    _guests = r.guests;
  });

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final recents = ref.watch(recentSearchesProvider).value ?? const [];
    final routes = ref.watch(popularRoutesProvider).value ?? const [];

    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.close, close: true),
        trailing: SizedBox(
          width: _segmentWidth(context),
          child: KzSegmented<SearchMode>(
            segments: [
              (SearchMode.list, l.searchTabListings),
              (SearchMode.map, l.searchTabMap),
            ],
            selected: _mode,
            onChanged: (m) => setState(() => _mode = m),
          ),
        ),
      ),
      bottomBar: KzBottomBar(
        child: KzBottomBarSummary(
          leading: KzLink(label: l.clearAll, onPressed: _clear),
          action: KzButton(
            label: l.searchSubmit,
            trailingArrow: true,
            onPressed: _submit,
          ),
        ),
      ),
      children: [
        const SizedBox(height: KzSpace.s4),
        Container(
          padding: const EdgeInsets.all(KzSpace.s18),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.lg),
            boxShadow: KzShadows.card,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                header: true,
                child: Text(
                  l.searchWhereTitle,
                  style: KzText.h4.copyWith(color: kz.ink),
                ),
              ),
              const SizedBox(height: KzSpace.s14),
              KzInput(
                label: l.searchLocationLabel,
                controller: _location,
                icon: KzIcons.search,
                hint: l.searchLocationHint,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _submit(),
              ),
              if (recents.isNotEmpty) ...[
                const SizedBox(height: KzSpace.s14),
                KzOverline(l.searchRecent),
                const SizedBox(height: KzSpace.s4),
                for (final r in recents)
                  KzActionRow(
                    icon: KzIcons.clock,
                    tone: KzIconBoxTone.sand,
                    title: r.location,
                    subtitle: l.searchSummary(
                      datesLabel(l, r.dates),
                      guestsLabel(l, r.guests),
                    ),
                    card: false,
                    chevron: false,
                    onPressed: () => _useRecent(r),
                  ),
              ],
              if (routes.isNotEmpty) ...[
                const SizedBox(height: KzSpace.s14),
                KzOverline(l.searchPopularRoutes),
                const SizedBox(height: KzSpace.s14),
                Row(
                  children: [
                    for (final (i, name) in routes.indexed) ...[
                      if (i > 0) const SizedBox(width: KzSpace.s10),
                      Expanded(
                        child: _RouteTile(
                          name: name,
                          onPressed: () =>
                              setState(() => _location.text = name),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s14),
        _SummaryRow(
          icon: KzIcons.calendar,
          label: l.searchWhen,
          value: _dates == null ? l.searchAddDates : datesLabel(l, _dates),
          onPressed: _pickDates,
        ),
        const SizedBox(height: KzSpace.s8),
        _SummaryRow(
          icon: KzIcons.users,
          label: l.searchWho,
          value: guestsLabel(l, _guests),
          onPressed: _pickGuests,
        ),
      ],
    );
  }

  /// Segment, ekran genişliğine göre en fazla Figma'daki 228'e kadar.
  static double _segmentWidth(BuildContext context) {
    const figma = 228.0;
    final available =
        MediaQuery.sizeOf(context).width -
        KzSpace.screen * 2 -
        KzSize.backButton -
        KzSpace.s12;
    return available < figma ? available : figma;
  }
}

class _RouteTile extends StatelessWidget {
  const _RouteTile({required this.name, required this.onPressed});

  final String name;
  final VoidCallback onPressed;

  /// Figma: 98×84.
  static const double _aspect = 98 / 84;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: name,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: _aspect,
            child: ClipRRect(
              borderRadius: KzRadii.all(KzRadii.tile),
              child: const KzPhoto(url: null),
            ),
          ),
          const SizedBox(height: KzSpace.s6),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: KzText.label.copyWith(
              color: kz.ink,
              fontWeight: KzText.extraBold,
            ),
          ),
        ],
      ),
    );
  }
}

/// "Ne zaman?  6 – 8 Kas" satırı.
class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onPressed,
  });

  final KzIcons icon;
  final String label;
  final String value;
  final VoidCallback onPressed;

  static const double _height = 62;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: '$label $value',
      pressedScale: KzMotion.pressedScale,
      child: Container(
        constraints: const BoxConstraints(minHeight: _height),
        padding: const EdgeInsets.symmetric(
          horizontal: KzSpace.s18,
          vertical: KzSpace.s8,
        ),
        decoration: BoxDecoration(
          color: kz.surface,
          borderRadius: KzRadii.all(KzRadii.field),
          border: Border.all(color: kz.line),
        ),
        child: Row(
          children: [
            KzIcon(icon, size: KzSize.iconSm, color: kz.ink2),
            const SizedBox(width: KzSpace.s10),
            Expanded(
              child: Text(
                label,
                style: KzText.bodySm.copyWith(
                  fontWeight: KzText.semiBold,
                  color: kz.ink2,
                ),
              ),
            ),
            Text(
              value,
              maxLines: 1,
              textAlign: TextAlign.end,
              style: KzText.bodyStrongSm.copyWith(
                fontWeight: KzText.extraBold,
                color: kz.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
