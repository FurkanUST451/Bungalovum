import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../l10n/l10n.dart';
import '../../../search/data/search_repository.dart';
import '../../../search/domain/search_query.dart';

part 'date_picker_screen.calendar.dart';

class DatePickerArgs {
  const DatePickerArgs({this.initial, this.listingId, this.location = ''});

  final StayDates? initial;

  /// İlan bağlamında o ilanın müsaitliği; yoksa bölge geneli.
  final String? listingId;
  final String location;
}

/// Seçici kapanınca dönen sonuç; [dates] null = tarihler temizlendi.
class DatePickerResult {
  const DatePickerResult(this.dates);

  final StayDates? dates;
}

final _calendarProvider = FutureProvider.autoDispose
    .family<List<CalendarDay>, (DateTime, String?, String)>(
      (ref, key) => ref
          .watch(searchRepositoryProvider)
          .calendar(month: key.$1, listingId: key.$2, location: key.$3),
    );

/// 31 · Tarih Seç
class DatePickerScreen extends ConsumerStatefulWidget {
  const DatePickerScreen({super.key, required this.args, this.today});

  final DatePickerArgs args;

  /// Testte sabitlenir.
  final DateTime? today;

  @override
  ConsumerState<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends ConsumerState<DatePickerScreen> {
  late DateTime? _in = widget.args.initial?.checkIn;
  late DateTime? _out = widget.args.initial?.checkOut;
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    final now = widget.today ?? DateTime.now();
    final anchor = _in ?? now;
    _month = DateTime(anchor.year, anchor.month);
  }

  DateTime get _firstMonth {
    final now = widget.today ?? DateTime.now();
    return DateTime(now.year, now.month);
  }

  void _tap(CalendarDay day, List<CalendarDay> month) {
    final d = day.date;
    setState(() {
      if (_in == null || _out != null || !d.isAfter(_in!)) {
        _in = d;
        _out = null;
        return;
      }
      // Aradaki tüm geceler müsait olmalı (çıkış günü dolu olabilir).
      final blocked = month.any(
        (m) => !m.available && !m.date.isBefore(_in!) && m.date.isBefore(d),
      );
      if (blocked) {
        _in = d;
        _out = null;
      } else {
        _out = d;
      }
    });
  }

  void _clear() => setState(() {
    _in = null;
    _out = null;
  });

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final kz = context.kz;
    final complete = _in != null && _out != null;
    final cleared = _in == null && widget.args.initial != null;
    final days = ref.watch(
      _calendarProvider((_month, widget.args.listingId, widget.args.location)),
    );

    final summary = complete
        ? l.datesSummary(
            KzFormat.dateRange(_in!, _out!),
            _out!.difference(_in!).inDays,
          )
        : _in == null
        ? l.datesPickCheckIn
        : l.datesPickCheckOut;

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
                  summary,
                  style: KzText.bodyStrongSm.copyWith(
                    fontWeight: KzText.extraBold,
                    color: kz.ink,
                  ),
                ),
              ),
              if (_in != null) KzLink(label: l.datesClear, onPressed: _clear),
            ],
          ),
          action: KzButton(
            label: l.save,
            onPressed: complete || cleared
                ? () => context.pop(
                    DatePickerResult(
                      complete
                          ? StayDates(checkIn: _in!, checkOut: _out!)
                          : null,
                    ),
                  )
                : null,
          ),
        ),
      ),
      children: [
        KzPageTitle(title: l.datesTitle, subtitle: l.datesSubtitle),
        Container(
          padding: const EdgeInsets.all(KzSpace.s18),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.card),
            border: Border.all(color: kz.line),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  KzCircleButton(
                    icon: KzIcons.back,
                    iconSize: KzSpace.s16,
                    background: kz.sand,
                    semanticLabel: l.datesPrevMonth,
                    onPressed: _month.isAfter(_firstMonth)
                        ? () => setState(
                            () => _month = DateTime(
                              _month.year,
                              _month.month - 1,
                            ),
                          )
                        : null,
                  ),
                  Expanded(
                    child: Semantics(
                      header: true,
                      liveRegion: true,
                      child: Text(
                        KzFormat.monthYear(_month),
                        textAlign: TextAlign.center,
                        style: KzText.title.copyWith(color: kz.ink),
                      ),
                    ),
                  ),
                  KzCircleButton(
                    icon: KzIcons.chev,
                    iconSize: KzSpace.s16,
                    background: kz.sand,
                    semanticLabel: l.datesNextMonth,
                    onPressed: () => setState(
                      () => _month = DateTime(_month.year, _month.month + 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: KzSpace.s10),
              _WeekdayHeader(labels: l.weekdaysShort.split(',')),
              const SizedBox(height: KzSpace.s10),
              switch (days) {
                AsyncData(:final value) => _MonthGrid(
                  month: _month,
                  days: value,
                  checkIn: _in,
                  checkOut: _out,
                  onTap: (d) => _tap(d, value),
                ),
                _ => const _MonthSkeleton(),
              },
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s10),
        const _Legend(),
      ],
    );
  }
}
