import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/tokens.dart';

/// iPhone tarzı kaydırmalı seçici. Ortadaki seçim bandı sand zeminli haptır;
/// her adımda hafif titreşim verir. Banttaki değere dokununca klavyeyle
/// yazılabilir, banttaki diğer satırlara dokununca o satıra kayar.
///
/// Kontrollü bileşendir: [selected] dışarıdan değişirse tekerlek oraya kayar
/// (bu kayış sırasında [onChanged] çağrılmaz).
class KzWheelPicker extends StatefulWidget {
  const KzWheelPicker({
    super.key,
    required this.itemCount,
    required this.selected,
    required this.itemLabel,
    required this.onChanged,
    required this.semanticLabel,
    this.unit,
    this.parse,
    this.decimal = false,
  });

  final int itemCount;
  final int selected;
  final String Function(int index) itemLabel;
  final ValueChanged<int> onChanged;
  final String semanticLabel;

  /// Bandın sağında sabit duran birim ("m²", "°C").
  final String? unit;

  /// Yazılan metni sıraya çevirir; null ise elle yazma kapalıdır.
  final int? Function(String text)? parse;

  /// Klavyede ondalık ayırıcı (virgül) gösterilsin mi.
  final bool decimal;

  static const double _diameterRatio = 1.6;
  static const double _magnification = 1.08;
  static const double _sideOpacity = 0.4;

  @override
  State<KzWheelPicker> createState() => _KzWheelPickerState();
}

class _KzWheelPickerState extends State<KzWheelPicker> {
  late final _wheel = FixedExtentScrollController(initialItem: widget.selected);
  final _text = TextEditingController();
  final _focus = FocusNode();
  bool _editing = false;

  /// Programla kaydırılırken hedef sıra. Kayış sırasında geçilen ara satırlar
  /// bildirilmez; aksi halde kayış bitmeden "Kaydet"e basılınca ara değer
  /// kaydedilirdi.
  int? _target;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      if (mounted && !_focus.hasFocus && _editing) _commit();
    });
  }

  @override
  void didUpdateWidget(KzWheelPicker old) {
    super.didUpdateWidget(old);
    if (_editing || !_wheel.hasClients) return;
    if (widget.selected != (_target ?? _wheel.selectedItem)) {
      _moveTo(widget.selected, notify: false);
    }
  }

  @override
  void dispose() {
    _wheel.dispose();
    _text.dispose();
    _focus.dispose();
    super.dispose();
  }

  /// [index]'e kayar. [notify] ise hedef değer kayış başlamadan, tek seferde
  /// bildirilir.
  Future<void> _moveTo(int index, {required bool notify}) async {
    if (!_wheel.hasClients) return;
    if (notify && index != widget.selected) {
      HapticFeedback.selectionClick();
      widget.onChanged(index);
    }
    if (index == _wheel.selectedItem) return;
    final duration = KzMotion.of(context, KzMotion.transition);
    _target = index;
    if (duration == Duration.zero) {
      _wheel.jumpToItem(index);
    } else {
      // Kullanıcı kayış sırasında tekerleği tutarsa animasyon yarıda biter.
      await _wheel.animateToItem(
        index,
        duration: duration,
        curve: KzMotion.enter,
      );
    }
    if (mounted && _target == index) _target = null;
  }

  void _onWheel(int index) {
    // Parmakla tutunca animasyon kesilir ve [_target] temizlenir; sonraki
    // sürükleme normal bildirilir.
    if (_target != null) return;
    HapticFeedback.selectionClick();
    widget.onChanged(index);
  }

  void _onTapUp(TapUpDetails d, double height) {
    final rows = ((d.localPosition.dy - height / 2) / KzSize.wheelItem).round();
    if (rows == 0) {
      if (widget.parse != null) _startEditing();
      return;
    }
    final target = (_wheel.selectedItem + rows).clamp(0, widget.itemCount - 1);
    _moveTo(target, notify: true);
  }

  void _startEditing() {
    _text
      ..text = widget.itemLabel(widget.selected)
      ..selection = TextSelection(
        baseOffset: 0,
        extentOffset: _text.text.length,
      );
    setState(() => _editing = true);
    _focus.requestFocus();
  }

  /// Yazılan değer her tuşta bildirilir ki "Kaydet" her zaman son değeri
  /// alsın; tekerlek ise yazma bitince kayar.
  void _onTyped(String s) {
    final i = widget.parse!(s);
    if (i != null && i != widget.selected) widget.onChanged(i);
  }

  void _commit() {
    final i = widget.parse!(_text.text) ?? widget.selected;
    setState(() => _editing = false);
    _moveTo(i, notify: true);
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    const height = KzSize.wheelItem * KzSize.wheelVisibleItems;
    final style = KzText.h4.copyWith(
      color: kz.ink,
      height: KzText.tightLeading,
    );
    final unitStyle = KzText.label.copyWith(color: kz.ink2);
    final band = BoxDecoration(
      color: kz.sand,
      borderRadius: KzRadii.all(KzRadii.pill),
    );

    return Semantics(
      label: widget.semanticLabel,
      value: [widget.itemLabel(widget.selected), ?widget.unit].join(' '),
      increasedValue: widget.selected < widget.itemCount - 1
          ? widget.itemLabel(widget.selected + 1)
          : null,
      decreasedValue: widget.selected > 0
          ? widget.itemLabel(widget.selected - 1)
          : null,
      onIncrease: widget.selected < widget.itemCount - 1
          ? () => _moveTo(widget.selected + 1, notify: true)
          : null,
      onDecrease: widget.selected > 0
          ? () => _moveTo(widget.selected - 1, notify: true)
          : null,
      child: SizedBox(
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: KzSize.wheelItem, decoration: band),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: (d) => _onTapUp(d, height),
              child: ExcludeSemantics(
                child: ListWheelScrollView.useDelegate(
                  controller: _wheel,
                  itemExtent: KzSize.wheelItem,
                  diameterRatio: KzWheelPicker._diameterRatio,
                  useMagnifier: true,
                  magnification: KzWheelPicker._magnification,
                  overAndUnderCenterOpacity: KzWheelPicker._sideOpacity,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: _onWheel,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: widget.itemCount,
                    builder: (_, i) => Center(
                      child: Text(
                        widget.itemLabel(i),
                        maxLines: 1,
                        style: style,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_editing)
              Container(
                height: KzSize.wheelItem,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: KzSpace.s16),
                decoration: band.copyWith(
                  color: kz.surface,
                  border: Border.all(
                    color: kz.forest,
                    width: KzSize.borderFocus,
                  ),
                ),
                child: TextField(
                  controller: _text,
                  focusNode: _focus,
                  textAlign: TextAlign.center,
                  style: style,
                  cursorColor: kz.forest,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: widget.decimal,
                  ),
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(widget.decimal ? r'[\d,.]' : r'\d'),
                    ),
                  ],
                  onChanged: _onTyped,
                  onSubmitted: (_) => _focus.unfocus(),
                  onTapOutside: (_) => _focus.unfocus(),
                  decoration: const InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
            if (widget.unit != null && !_editing)
              Positioned(
                right: KzSpace.s16,
                child: IgnorePointer(
                  child: Text(widget.unit!, style: unitStyle),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
