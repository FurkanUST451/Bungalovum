import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_switch.dart';
import '../../../../l10n/l10n.dart';
import '../../data/search_repository.dart';
import '../../domain/search_query.dart';
import '../controllers/search_controller.dart';
import '../search_labels.dart';

/// 15 · Filtreler. Taslak üzerinde çalışır; "N bungalovu göster" ile
/// aktif aramaya uygulanır.
class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  late SearchFilters _f = ref.read(searchQueryControllerProvider).filters;

  static const _bedroomOptions = [1, 2, 3, 4];

  void _set(SearchFilters f) => setState(() => _f = f);

  void _toggle(SearchFeature feature) {
    final s = {..._f.features};
    s.contains(feature) ? s.remove(feature) : s.add(feature);
    _set(_f.copyWith(features: s));
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final base = ref.watch(searchQueryControllerProvider);
    final draft = base.copyWith(filters: _f);
    final count = ref.watch(searchCountProvider(draft)).value;
    final histogram = ref.watch(priceHistogramProvider(base)).value;

    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.close, close: true),
        title: l.filtersTitle,
        trailing: KzLink(
          label: l.clear,
          style: KzText.bodySm,
          onPressed: () => _set(const SearchFilters()),
        ),
      ),
      bottomBar: KzBottomBar(
        child: KzBottomBarSummary(
          leading: KzLink(
            label: l.clear,
            style: KzText.bodySm,
            onPressed: () => _set(const SearchFilters()),
          ),
          action: KzButton(
            label: count == null ? l.filtersTitle : l.filtersShow(count),
            onPressed: () {
              ref.read(searchQueryControllerProvider.notifier).setFilters(_f);
              context.pop();
            },
          ),
        ),
      ),
      children: [
        _Section(
          title: l.filtersPrice,
          children: [
            Text(
              l.filtersPriceNote,
              style: KzText.caption.copyWith(color: kz.ink2),
            ),
            if (histogram != null) ...[
              _PriceRange(
                histogram: histogram,
                min: _f.priceMin,
                max: _f.priceMax,
                onChanged: (lo, hi) => _set(
                  _f.copyWith(
                    priceMin: lo <= histogram.min ? null : lo,
                    priceMax: hi >= histogram.max ? null : hi,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _ValueBox(
                      label: l.filtersMin,
                      value: KzFormat.currency(_f.priceMin ?? histogram.min),
                    ),
                  ),
                  const SizedBox(width: KzSpace.s10),
                  Expanded(
                    child: _ValueBox(
                      label: l.filtersMax,
                      value: KzFormat.currency(_f.priceMax ?? histogram.max),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        _Section(
          title: l.filtersFeatures,
          children: [
            Wrap(
              spacing: KzSpace.s8,
              runSpacing: KzSpace.s8,
              children: [
                for (final f in SearchFeature.values)
                  Semantics(
                    selected: _f.features.contains(f),
                    child: KzChip(
                      label: f.label(l),
                      icon: f.icon,
                      variant: _f.features.contains(f)
                          ? KzChipVariant.filled
                          : KzChipVariant.outline,
                      onPressed: () => _toggle(f),
                    ),
                  ),
              ],
            ),
          ],
        ),
        _Section(
          title: l.filtersBedrooms,
          children: [
            Wrap(
              spacing: KzSpace.s8,
              runSpacing: KzSpace.s8,
              children: [
                _ChoiceBox(
                  label: l.filtersAnyBedrooms,
                  selected: _f.bedrooms == null,
                  onPressed: () => _set(_f.copyWith(bedrooms: null)),
                ),
                for (final n in _bedroomOptions)
                  _ChoiceBox(
                    label: n == _bedroomOptions.last
                        ? l.filtersBedroomsPlus(n)
                        : '$n',
                    selected: _f.bedrooms == n,
                    onPressed: () => _set(_f.copyWith(bedrooms: n)),
                  ),
              ],
            ),
          ],
        ),
        _Section(
          title: l.filtersBooking,
          gap: 0,
          children: [
            KzSwitchRow(
              title: l.filtersInstant,
              subtitle: l.filtersInstantNote,
              value: _f.instantBook,
              onChanged: (v) => _set(_f.copyWith(instantBook: v)),
            ),
            KzSwitchRow(
              title: l.filtersFreeCancel,
              subtitle: l.filtersFreeCancelNote,
              value: _f.freeCancellation,
              onChanged: (v) => _set(_f.copyWith(freeCancellation: v)),
            ),
            KzSwitchRow(
              title: l.filtersPets,
              subtitle: l.filtersPetsNote,
              value: _f.petsAllowed,
              onChanged: (v) => _set(_f.copyWith(petsAllowed: v)),
            ),
            KzSwitchRow(
              title: l.filtersAccessible,
              subtitle: l.filtersAccessibleNote,
              value: _f.accessible,
              onChanged: (v) => _set(_f.copyWith(accessible: v)),
            ),
          ],
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.children,
    this.gap = KzSpace.s12,
  });

  final String title;
  final List<Widget> children;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: KzSpace.s16, bottom: KzSpace.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          KzSectionTitle(title),
          for (final c in children) ...[SizedBox(height: gap), c],
        ],
      ),
    );
  }
}

/// "En az ₺2.000" kutusu (salt okunur; değer kaydırıcıdan gelir).
class _ValueBox extends StatelessWidget {
  const _ValueBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Semantics(
      label: '$label $value',
      child: ExcludeSemantics(
        child: Container(
          constraints: const BoxConstraints(minHeight: KzSize.input),
          padding: const EdgeInsets.symmetric(
            horizontal: KzSpace.s16,
            vertical: KzSpace.s8,
          ),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.field),
            border: Border.all(color: kz.line),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: KzText.captionSemi.copyWith(color: kz.ink2)),
              const SizedBox(height: KzSpace.s3),
              Text(value, style: KzText.bodyStrong.copyWith(color: kz.ink)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Yatak odası seçenek kutusu (46 yükseklik).
class _ChoiceBox extends StatelessWidget {
  const _ChoiceBox({
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  static const double _height = 46;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: label,
      selected: selected,
      child: AnimatedContainer(
        duration: KzMotion.of(context, KzMotion.micro),
        height: _height,
        constraints: const BoxConstraints(minWidth: _height),
        padding: const EdgeInsets.symmetric(horizontal: KzSpace.s16),
        decoration: BoxDecoration(
          color: selected ? kz.forest : kz.surface,
          borderRadius: KzRadii.all(KzRadii.tile),
          border: selected ? null : Border.all(color: kz.line),
        ),
        child: Center(
          widthFactor: 1,
          child: Text(
            label,
            style: KzText.bodySm.copyWith(
              fontWeight: KzText.extraBold,
              color: selected ? kz.onForest : kz.ink,
            ),
          ),
        ),
      ),
    );
  }
}

/// Histogram + iki uçlu kaydırıcı.
class _PriceRange extends StatelessWidget {
  const _PriceRange({
    required this.histogram,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final PriceHistogram histogram;
  final int? min;
  final int? max;
  final void Function(int lo, int hi) onChanged;

  static const double _barMaxHeight = 46;
  static const double _barMinHeight = 3;
  static const double _thumbRadius = 13;
  static const double _thumbStroke = 3;
  static const double _track = 4;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final lo = (min ?? histogram.min).toDouble();
    final hi = (max ?? histogram.max).toDouble();
    final peak = histogram.bins.reduce((a, b) => a > b ? a : b);
    return Column(
      children: [
        ExcludeSemantics(
          child: SizedBox(
            height: _barMaxHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final (i, v) in histogram.bins.indexed) ...[
                  if (i > 0) const SizedBox(width: KzSpace.s5),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final binStart = histogram.min + i * histogram.step;
                        final inside = binStart >= lo && binStart < hi;
                        return Container(
                          height: (_barMaxHeight * v / peak).clamp(
                            _barMinHeight,
                            _barMaxHeight,
                          ),
                          decoration: BoxDecoration(
                            color: inside ? kz.forest : kz.line,
                            borderRadius: KzRadii.all(KzSpace.xs),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: _track,
            activeTrackColor: kz.forest,
            inactiveTrackColor: kz.line,
            overlayColor: kz.forest.withValues(alpha: 0.08),
            rangeThumbShape: _RingThumb(
              radius: _thumbRadius,
              stroke: _thumbStroke,
              fill: kz.surface,
            ),
            rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
            showValueIndicator: ShowValueIndicator.never,
          ),
          child: RangeSlider(
            values: RangeValues(lo, hi),
            min: histogram.min.toDouble(),
            max: histogram.max.toDouble(),
            divisions: (histogram.max - histogram.min) ~/ 100,
            semanticFormatterCallback: (v) => KzFormat.currency(v.round()),
            labels: RangeLabels(l.filtersMin, l.filtersMax),
            onChanged: (r) => onChanged(r.start.round(), r.end.round()),
          ),
        ),
      ],
    );
  }
}

/// Beyaz dolgulu, forest halkalı kaydırıcı topuzu.
class _RingThumb extends RangeSliderThumbShape {
  const _RingThumb({
    required this.radius,
    required this.stroke,
    required this.fill,
  });

  final double radius;
  final double stroke;
  final Color fill;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(radius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final canvas = context.canvas;
    canvas.drawCircle(center, radius - stroke / 2, Paint()..color = fill);
    canvas.drawCircle(
      center,
      radius - stroke / 2,
      Paint()
        ..color = sliderTheme.activeTrackColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke,
    );
  }
}
