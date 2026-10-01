part of 'date_picker_screen.dart';

const double _cellWidth = 40;
const double _cellHeight = 54;
const double _dealDot = 5;
const double _legendSwatch = 14;
const double _legendDot = 7;

class _WeekdayHeader extends StatelessWidget {
  const _WeekdayHeader({required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return ExcludeSemantics(
      child: Row(
        children: [
          for (final d in labels)
            Expanded(
              child: Text(
                d,
                textAlign: TextAlign.center,
                style: KzText.captionHeavy.copyWith(color: kz.ink2),
              ),
            ),
        ],
      ),
    );
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.days,
    required this.checkIn,
    required this.checkOut,
    required this.onTap,
  });

  final DateTime month;
  final List<CalendarDay> days;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final ValueChanged<CalendarDay> onTap;

  @override
  Widget build(BuildContext context) {
    // Pazartesi başlangıçlı hafta: ilk günün önündeki boş hücreler.
    final lead = DateTime(month.year, month.month).weekday - 1;
    final cells = <CalendarDay?>[
      ...List<CalendarDay?>.filled(lead, null),
      ...days,
    ];
    while (cells.length % DateTime.daysPerWeek != 0) {
      cells.add(null);
    }
    final weeks = cells.length ~/ DateTime.daysPerWeek;
    return Column(
      children: [
        for (var w = 0; w < weeks; w++)
          Padding(
            padding: const EdgeInsets.only(bottom: KzSpace.s4),
            child: Row(
              children: [
                for (var i = 0; i < DateTime.daysPerWeek; i++)
                  Expanded(
                    child: Center(
                      child: switch (cells[w * DateTime.daysPerWeek + i]) {
                        final day? => _DayCell(
                          day: day,
                          checkIn: checkIn,
                          checkOut: checkOut,
                          onTap: () => onTap(day),
                        ),
                        null => const SizedBox(
                          width: _cellWidth,
                          height: _cellHeight,
                        ),
                      },
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.checkIn,
    required this.checkOut,
    required this.onTap,
  });

  final CalendarDay day;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final d = day.date;
    final isEdge = d == checkIn || d == checkOut;
    final inRange =
        checkIn != null &&
        checkOut != null &&
        d.isAfter(checkIn!) &&
        d.isBefore(checkOut!);
    // Çıkış günü dolu olsa da seçilebilir (o gece kalınmaz).
    final selectable =
        day.available || (checkIn != null && d.isAfter(checkIn!));
    final bg = isEdge
        ? kz.forest
        : inRange
        ? kz.forestSoft
        : null;
    final numberColor = isEdge
        ? kz.onForest
        : day.available
        ? kz.ink
        : kz.placeholder;

    final priceText = day.price == null
        ? null
        : l.dayPriceShort(KzFormat.thousands(day.price!));
    final showPrice = day.price != null && (isEdge || inRange || !day.isDeal);

    return KzPressable(
      onPressed: selectable ? onTap : null,
      selected: isEdge || inRange,
      semanticLabel: day.available
          ? [
              KzFormat.dayLong(d),
              if (day.price != null) KzFormat.currency(day.price!),
            ].join(', ')
          : l.dayUnavailable(KzFormat.dayLong(d)),
      minTouchSize: _cellWidth,
      child: AnimatedContainer(
        duration: KzMotion.of(context, KzMotion.micro),
        width: _cellWidth,
        constraints: const BoxConstraints(minHeight: _cellHeight),
        padding: const EdgeInsets.symmetric(vertical: KzSpace.s4),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: KzRadii.all(KzRadii.icon),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${d.day}',
              style: KzText.bodyStrongSm.copyWith(
                color: numberColor,
                fontWeight: isEdge || inRange ? KzText.extraBold : KzText.bold,
                height: KzText.tightLeading,
                decoration: day.available ? null : TextDecoration.lineThrough,
                decorationColor: kz.placeholder,
              ),
            ),
            const SizedBox(height: KzSpace.s3),
            if (showPrice)
              Text(
                priceText!,
                maxLines: 1,
                style: KzText.nano.copyWith(
                  color: isEdge ? kz.forestSoft : kz.ink2,
                ),
              )
            else if (day.available && day.isDeal)
              Container(
                width: _dealDot,
                height: _dealDot,
                decoration: BoxDecoration(
                  color: kz.forest,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MonthSkeleton extends StatelessWidget {
  const _MonthSkeleton();

  static const int _weeks = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var w = 0; w < _weeks; w++)
          Padding(
            padding: const EdgeInsets.only(bottom: KzSpace.s4),
            child: Row(
              children: [
                for (var i = 0; i < DateTime.daysPerWeek; i++)
                  Expanded(
                    child: Center(
                      child: KzSkeleton(
                        width: _cellWidth,
                        height: _cellHeight,
                        borderRadius: KzRadii.all(KzRadii.icon),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final text = KzText.captionSemi.copyWith(color: kz.ink2);
    Widget swatch(Color c, String label) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: _legendSwatch,
          height: _legendSwatch,
          decoration: BoxDecoration(
            color: c,
            borderRadius: KzRadii.all(KzSpace.s5),
          ),
        ),
        const SizedBox(width: KzSpace.s6),
        Text(label, style: text),
      ],
    );
    return ExcludeSemantics(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KzSpace.s4),
        child: Wrap(
          spacing: KzSpace.s14,
          runSpacing: KzSpace.s6,
          children: [
            swatch(kz.forest, l.datesLegendSelected),
            swatch(kz.forestSoft, l.datesLegendStay),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: _legendDot,
                  height: _legendDot,
                  decoration: BoxDecoration(
                    color: kz.forest,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: KzSpace.s6),
                Text(l.datesLegendDeal, style: text),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '13',
                  style: text.copyWith(
                    color: kz.placeholder,
                    fontWeight: KzText.bold,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: KzSpace.s6),
                Text(l.datesLegendBooked, style: text),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
