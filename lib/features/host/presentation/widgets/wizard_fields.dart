import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/tr_search.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_text_area.dart';
import '../../../../core/widgets/kz_wheel_picker.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/listing_draft.dart';

/// Taslak alanına bağlı metin kutusu: ilk değeri taslaktan alır, her
/// değişikliği [onChanged] ile taslağa yazar.
class DraftInput extends StatefulWidget {
  const DraftInput({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.icon,
    this.hint,
    this.errorText,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.obscure = false,
    this.toggleLabels,
    this.capitalization = TextCapitalization.sentences,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final KzIcons? icon;
  final String? hint;
  final String? errorText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool obscure;
  final (String, String)? toggleLabels;
  final TextCapitalization capitalization;

  @override
  State<DraftInput> createState() => _DraftInputState();
}

class _DraftInputState extends State<DraftInput> {
  late final _c = TextEditingController(text: widget.value);

  @override
  void dispose() {
    // KVKK: TCKN/IBAN gibi değerler bellekte kalmasın.
    _c
      ..clear()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KzInput(
    label: widget.label,
    controller: _c,
    icon: widget.icon,
    hint: widget.hint,
    errorText: widget.errorText,
    keyboardType: widget.keyboardType,
    inputFormatters: widget.inputFormatters,
    maxLength: widget.maxLength,
    obscure: widget.obscure,
    toggleLabels: widget.toggleLabels,
    textCapitalization: widget.capitalization,
    textInputAction: TextInputAction.next,
    onChanged: widget.onChanged,
  );
}

class DraftTextArea extends StatefulWidget {
  const DraftTextArea({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.hint,
    this.maxLength,
    this.minLines = 2,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final String? hint;
  final int? maxLength;
  final int minLines;

  @override
  State<DraftTextArea> createState() => _DraftTextAreaState();
}

class _DraftTextAreaState extends State<DraftTextArea> {
  late final _c = TextEditingController(text: widget.value);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KzTextArea(
    label: widget.label,
    controller: _c,
    hint: widget.hint,
    maxLength: widget.maxLength,
    minLines: widget.minLines,
    onChanged: widget.onChanged,
  );
}

/// Dokununca seçici açan değer kutusu ("Sıcaklık 28°C").
class ValueBox extends StatelessWidget {
  const ValueBox({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final String? value;
  final VoidCallback onPressed;
  final KzIcons? icon;

  @override
  Widget build(BuildContext context) => _ValueBoxField(
    key: ValueKey(value),
    label: label,
    value: value,
    icon: icon,
    onPressed: onPressed,
  );
}

class _ValueBoxField extends StatefulWidget {
  const _ValueBoxField({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final String? value;
  final VoidCallback onPressed;
  final KzIcons? icon;

  @override
  State<_ValueBoxField> createState() => _ValueBoxFieldState();
}

class _ValueBoxFieldState extends State<_ValueBoxField> {
  late final _c = TextEditingController(text: widget.value ?? '');

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    child: KzInput(
      label: widget.label,
      controller: _c,
      icon: widget.icon,
      hint: context.l10n.tapToSet,
      onTap: widget.onPressed,
    ),
  );
}

/// Aranabilir liste sheet'i (il, ilçe). Tüm seçenekler görünür; yazdıkça
/// Türkçe kurallarla süzülür ("i" → İstanbul, Iğdır…). Seçileni döner.
Future<String?> showSearchPickerSheet(
  BuildContext context, {
  required String title,
  required String searchLabel,
  required List<String> items,
  String? selected,
}) => showKzSheet<String>(
  context: context,
  title: title,
  closeLabel: context.l10n.close,
  builder: (_) =>
      _SearchPicker(searchLabel: searchLabel, items: items, selected: selected),
);

class _SearchPicker extends StatefulWidget {
  const _SearchPicker({
    required this.searchLabel,
    required this.items,
    this.selected,
  });

  final String searchLabel;
  final List<String> items;
  final String? selected;

  /// Liste, klavye dışında kalan yüksekliğin bu kadarını kaplar.
  static const double _listFraction = 0.5;

  @override
  State<_SearchPicker> createState() => _SearchPickerState();
}

class _SearchPickerState extends State<_SearchPicker> {
  final _query = TextEditingController();

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final mq = MediaQuery.of(context);
    final inset = mq.viewInsets.bottom;
    final results = TrSearch.filter(widget.items, _query.text);
    return Padding(
      padding: EdgeInsets.only(bottom: inset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          KzInput(
            label: widget.searchLabel,
            controller: _query,
            icon: KzIcons.search,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            onChanged: (_) => setState(() {}),
            // Tek sonuç kaldıysa klavyedeki "Bitti" onu seçer.
            onSubmitted: (_) {
              if (results.length == 1) Navigator.of(context).pop(results.first);
            },
          ),
          const SizedBox(height: KzSpace.s8),
          SizedBox(
            height: (mq.size.height - inset) * _SearchPicker._listFraction,
            child: results.isEmpty
                ? Center(
                    child: Text(
                      l.pickerNoMatch,
                      style: KzText.bodySm.copyWith(color: kz.ink2),
                    ),
                  )
                : ListView.separated(
                    itemCount: results.length,
                    separatorBuilder: (_, _) =>
                        Container(height: KzSize.border, color: kz.line),
                    itemBuilder: (_, i) => KzOptionRow(
                      label: results[i],
                      selected: results[i] == widget.selected,
                      onPressed: () => Navigator.of(context).pop(results[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Kaydırmalı seçicideki tek bir sayı alanı.
class WheelField {
  const WheelField({
    required this.label,
    required this.range,
    this.value,
    this.unit,
  });

  final String label;
  final NumberRange range;

  /// Taslaktaki değer; null ise seçici [NumberRange.start]'tan açılır.
  final num? value;
  final String? unit;
}

/// iPhone tarzı kaydırmalı sayı sheet'i: "Kapalı alan", "Derinlik" (en az ×
/// en çok)… Dönen liste [fields] sırasındadır. [ordered] ise ilk değer
/// ikinciyi geçemez; biri öbürünü aşarsa diğeri onu izler.
Future<List<double>?> showWheelSheet(
  BuildContext context, {
  required String title,
  required List<WheelField> fields,
  bool ordered = false,
}) => showKzSheet<List<double>>(
  context: context,
  title: title,
  closeLabel: context.l10n.close,
  builder: (_) => _WheelForm(fields: fields, ordered: ordered),
);

class _WheelForm extends StatefulWidget {
  const _WheelForm({required this.fields, required this.ordered});

  final List<WheelField> fields;
  final bool ordered;

  @override
  State<_WheelForm> createState() => _WheelFormState();
}

class _WheelFormState extends State<_WheelForm> {
  late final _index = [
    for (final f in widget.fields) f.range.indexOf(f.value ?? f.range.start),
  ];

  double _value(int i) => widget.fields[i].range.valueAt(_index[i]);

  void _set(int i, int index) => setState(() {
    _index[i] = index;
    if (!widget.ordered || _index.length != 2) return;
    final (low, high) = (_value(0), _value(1));
    if (low <= high) return;
    final other = 1 - i;
    _index[other] = widget.fields[other].range.indexOf(_value(i));
  });

  int? _parse(NumberRange r, String s) {
    final v = double.tryParse(s.trim().replaceAll(',', '.'));
    return v == null ? null : r.indexOf(v);
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final (i, f) in widget.fields.indexed) ...[
                if (i > 0) const SizedBox(width: KzSpace.s10),
                Expanded(
                  child: Column(
                    children: [
                      if (widget.fields.length > 1) ...[
                        Text(
                          f.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: KzText.captionSemi.copyWith(color: kz.ink2),
                        ),
                        const SizedBox(height: KzSpace.s8),
                      ],
                      KzWheelPicker(
                        itemCount: f.range.count,
                        selected: _index[i],
                        itemLabel: (n) => KzFormat.fixed(
                          f.range.valueAt(n),
                          f.range.decimals,
                        ),
                        unit: f.unit,
                        semanticLabel: f.label,
                        decimal: f.range.decimals > 0,
                        parse: (s) => _parse(f.range, s),
                        onChanged: (n) => _set(i, n),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: KzSpace.s12),
          Text(
            l.wheelHint,
            textAlign: TextAlign.center,
            style: KzText.caption.copyWith(color: kz.ink2),
          ),
          const SizedBox(height: KzSpace.s16),
          KzButton(
            label: l.save,
            onPressed: () => Navigator.of(
              context,
            ).pop([for (var i = 0; i < _index.length; i++) _value(i)]),
          ),
        ],
      ),
    );
  }
}

/// Tutar girme sheet'i ("Gecelik fiyat"): klavyeyle tam lira girilir.
/// Dönen liste [labels] sırasındadır.
Future<List<num>?> showNumberSheet(
  BuildContext context, {
  required String title,
  required List<String> labels,
  required List<num?> initial,
  String? suffix,
}) => showKzSheet<List<num>>(
  context: context,
  title: title,
  closeLabel: context.l10n.close,
  builder: (_) => _NumberForm(labels: labels, initial: initial, suffix: suffix),
);

class _NumberForm extends StatefulWidget {
  const _NumberForm({required this.labels, required this.initial, this.suffix});

  final List<String> labels;
  final List<num?> initial;
  final String? suffix;

  @override
  State<_NumberForm> createState() => _NumberFormState();
}

class _NumberFormState extends State<_NumberForm> {
  late final _cs = [
    for (final v in widget.initial)
      TextEditingController(
        text: v == null ? '' : KzFormat.decimal(v.toDouble()),
      ),
  ];

  @override
  void dispose() {
    for (final c in _cs) {
      c.dispose();
    }
    super.dispose();
  }

  num? _parse(String s) => int.tryParse(s.trim().replaceAll('.', ''));

  List<num>? get _values {
    final out = <num>[];
    for (final c in _cs) {
      final v = _parse(c.text);
      if (v == null || v < 0) return null;
      out.add(v);
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final values = _values;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: KzSpace.s12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final (i, label) in widget.labels.indexed) ...[
                if (i > 0) const SizedBox(width: KzSpace.s10),
                Expanded(
                  child: KzInput(
                    label: label,
                    controller: _cs[i],
                    hint: widget.suffix,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                    ],
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: KzSpace.s16),
          KzButton(
            label: l.save,
            onPressed: values == null
                ? null
                : () => Navigator.of(context).pop(values),
          ),
        ],
      ),
    );
  }
}

/// Saat seçimi (30 dakikalık aralıklar). "14:00" döner.
Future<String?> showTimeSheet(
  BuildContext context, {
  required String title,
  required String selected,
}) => showKzSheet<String>(
  context: context,
  title: title,
  closeLabel: context.l10n.close,
  builder: (ctx) => Padding(
    padding: const EdgeInsets.only(top: KzSpace.s12),
    child: Wrap(
      spacing: KzSpace.s8,
      runSpacing: KzSpace.s8,
      children: [
        for (var m = 0; m < Duration.minutesPerDay; m += _timeStep)
          Builder(
            builder: (_) {
              final t = _hhmm(m);
              return KzChip(
                label: t,
                variant: t == selected
                    ? KzChipVariant.filled
                    : KzChipVariant.outline,
                onPressed: () => Navigator.of(ctx).pop(t),
              );
            },
          ),
      ],
    ),
  ),
);

const _timeStep = 30;

String _hhmm(int minutes) =>
    '${(minutes ~/ 60).toString().padLeft(2, '0')}:'
    '${(minutes % 60).toString().padLeft(2, '0')}';

/// Ay aralığı seçimi (havuzun açık olduğu aylar). (başlangıç, bitiş) döner.
Future<(int, int)?> showMonthRangeSheet(
  BuildContext context, {
  required String title,
  int? start,
  int? end,
}) => showKzSheet<(int, int)>(
  context: context,
  title: title,
  closeLabel: context.l10n.close,
  builder: (_) => _MonthRangeForm(start: start, end: end),
);

class _MonthRangeForm extends StatefulWidget {
  const _MonthRangeForm({this.start, this.end});

  final int? start;
  final int? end;

  @override
  State<_MonthRangeForm> createState() => _MonthRangeFormState();
}

class _MonthRangeFormState extends State<_MonthRangeForm> {
  late int? _start = widget.start;
  late int? _end = widget.end;

  Widget _months(String label, int? value, ValueChanged<int> onPick) {
    final kz = context.kz;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: KzText.label.copyWith(color: kz.ink)),
        const SizedBox(height: KzSpace.s8),
        Wrap(
          spacing: KzSpace.s6,
          runSpacing: KzSpace.s6,
          children: [
            for (var m = 1; m <= DateTime.monthsPerYear; m++)
              KzChip(
                label: KzFormat.monthShort(m),
                variant: m == value
                    ? KzChipVariant.filled
                    : KzChipVariant.outline,
                onPressed: () => setState(() => onPick(m)),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: KzSpace.s12),
        _months(l.monthFrom, _start, (m) => _start = m),
        const SizedBox(height: KzSpace.s16),
        _months(l.monthTo, _end, (m) => _end = m),
        const SizedBox(height: KzSpace.s20),
        KzButton(
          label: l.save,
          onPressed: _start == null || _end == null
              ? null
              : () => Navigator.of(context).pop((_start!, _end!)),
        ),
      ],
    );
  }
}

/// Tek satırlık metin isteyen sheet ("Madde ekle").
Future<String?> showTextSheet(
  BuildContext context, {
  required String title,
  required String label,
}) => showKzSheet<String>(
  context: context,
  title: title,
  closeLabel: context.l10n.close,
  builder: (_) => _TextForm(label: label),
);

class _TextForm extends StatefulWidget {
  const _TextForm({required this.label});

  final String label;

  @override
  State<_TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<_TextForm> {
  final _c = TextEditingController();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: KzSpace.s12),
        KzInput(
          label: widget.label,
          controller: _c,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (_) => setState(() {}),
          onSubmitted: (v) {
            if (v.trim().isNotEmpty) Navigator.of(context).pop(v.trim());
          },
        ),
        const SizedBox(height: KzSpace.s16),
        KzButton(
          label: context.l10n.add,
          onPressed: _c.text.trim().isEmpty
              ? null
              : () => Navigator.of(context).pop(_c.text.trim()),
        ),
      ],
    ),
  );
}
