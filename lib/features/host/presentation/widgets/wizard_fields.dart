import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_text_area.dart';
import '../../../../l10n/l10n.dart';

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

/// Sayı(lar) girme sheet'i: "Boyut" (en × boy), "Gecelik fiyat"…
/// Dönen liste [labels] sırasındadır; ondalık değerler virgülle girilir.
Future<List<num>?> showNumberSheet(
  BuildContext context, {
  required String title,
  required List<String> labels,
  required List<num?> initial,
  bool decimal = false,
  String? suffix,
}) => showKzSheet<List<num>>(
  context: context,
  title: title,
  closeLabel: context.l10n.close,
  builder: (_) => _NumberForm(
    labels: labels,
    initial: initial,
    decimal: decimal,
    suffix: suffix,
  ),
);

class _NumberForm extends StatefulWidget {
  const _NumberForm({
    required this.labels,
    required this.initial,
    required this.decimal,
    this.suffix,
  });

  final List<String> labels;
  final List<num?> initial;
  final bool decimal;
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

  num? _parse(String s) {
    final t = s.trim().replaceAll('.', '').replaceAll(',', '.');
    return widget.decimal ? double.tryParse(t) : int.tryParse(t);
  }

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
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: widget.decimal,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(widget.decimal ? r'[\d,]' : r'[\d.]'),
                      ),
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
