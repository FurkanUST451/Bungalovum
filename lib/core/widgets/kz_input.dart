import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';

/// Figma `Input` (Durum = Varsayılan / Odak / Hata).
///
/// Üstte küçük etiket (12/600) + değer (16/700). Odakta 2px forest, hatada
/// 2px apricotText kenarlık ve altta hata satırı. [obscure] verilirse göz
/// ikonu ile göster/gizle yapılır.
class KzInput extends StatefulWidget {
  const KzInput({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    this.icon,
    this.prefix,
    this.hint,
    this.prefixText,
    this.errorText,
    this.obscure = false,
    this.toggleLabels,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final KzIcons? icon;

  /// İkon yerine ya da ikondan önce gösterilen öğe (ör. "+90" ülke kodu).
  final Widget? prefix;
  final String? hint;

  /// Değerin önüne eklenen sabit metin (ör. "+90 ").
  final String? prefixText;

  /// null değilse hata durumu; boş metin yalnızca kenarlığı kırmızı yapar.
  final String? errorText;
  final bool obscure;

  /// Göz butonunun erişilebilirlik etiketleri: (göster, gizle).
  final (String, String)? toggleLabels;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// Gizli şifrede noktalar arası boşluk (Figma: %12).
  static const double _obscuredSpacing = 0.12;

  @override
  State<KzInput> createState() => _KzInputState();
}

class _KzInputState extends State<KzInput> {
  late FocusNode _focus = widget.focusNode ?? FocusNode();
  bool _hidden = true;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocus);
  }

  @override
  void didUpdateWidget(KzInput old) {
    super.didUpdateWidget(old);
    if (old.focusNode != widget.focusNode) {
      _focus.removeListener(_onFocus);
      if (old.focusNode == null) _focus.dispose();
      _focus = widget.focusNode ?? FocusNode();
      _focus.addListener(_onFocus);
    }
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocus);
    if (widget.focusNode == null) _focus.dispose();
    super.dispose();
  }

  void _onFocus() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final hasError = widget.errorText != null;
    final focused = _focus.hasFocus;
    final accent = hasError
        ? kz.apricotText
        : focused
        ? kz.forest
        : null;
    final obscured = widget.obscure && _hidden;
    final valueStyle = KzText.bodyStrong.copyWith(
      color: kz.ink,
      height: KzText.tightLeading,
      letterSpacing: obscured
          ? KzText.bodyStrong.fontSize! * KzInput._obscuredSpacing
          : null,
    );

    final box = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _focus.requestFocus,
      child: AnimatedContainer(
        duration: KzMotion.of(context, KzMotion.micro),
        constraints: const BoxConstraints(minHeight: KzSize.input),
        padding: const EdgeInsets.symmetric(
          horizontal: KzSpace.s16,
          vertical: KzSpace.s8,
        ),
        decoration: BoxDecoration(
          color: kz.surface,
          borderRadius: KzRadii.all(KzRadii.field),
          border: Border.all(
            color: accent ?? kz.line,
            width: accent == null ? KzSize.border : KzSize.borderFocus,
          ),
        ),
        child: Row(
          children: [
            if (widget.prefix != null) ...[
              widget.prefix!,
              const SizedBox(width: KzSpace.s12),
            ],
            if (widget.icon != null) ...[
              KzIcon(
                widget.icon!,
                size: KzSize.iconMd,
                color: hasError
                    ? kz.apricotText
                    : focused
                    ? kz.ink
                    : kz.ink2,
              ),
              const SizedBox(width: KzSpace.s12),
            ],
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.captionSemi.copyWith(
                      color: accent ?? kz.ink2,
                      height: KzText.tightLeading,
                    ),
                  ),
                  const SizedBox(height: KzSpace.s3),
                  TextField(
                    controller: widget.controller,
                    focusNode: _focus,
                    obscureText: obscured,
                    obscuringCharacter: '•',
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    inputFormatters: widget.inputFormatters,
                    autofillHints: widget.autofillHints,
                    textCapitalization: widget.textCapitalization,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    style: valueStyle,
                    cursorColor: kz.forest,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      prefixText: widget.prefixText,
                      prefixStyle: valueStyle,
                      hintText: widget.hint,
                      hintStyle: KzText.bodyStrong.copyWith(
                        fontWeight: KzText.medium,
                        color: kz.placeholder,
                        height: KzText.tightLeading,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.obscure)
              KzPressable(
                onPressed: () => setState(() => _hidden = !_hidden),
                semanticLabel: _hidden
                    ? widget.toggleLabels?.$1
                    : widget.toggleLabels?.$2,
                child: KzIcon(
                  _hidden ? KzIcons.eye : KzIcons.eyeoff,
                  size: KzSize.iconMd,
                  color: kz.ink2,
                ),
              ),
          ],
        ),
      ),
    );

    // Boş hata metni: yalnızca kırmızı kenarlık (ör. sunucu hatası bandı varken).
    if (!hasError || widget.errorText!.isEmpty) return box;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        box,
        const SizedBox(height: KzSpace.s7),
        KzFieldMessage(text: widget.errorText!, isError: true),
      ],
    );
  }
}

/// Alan altı yardım / hata satırı.
class KzFieldMessage extends StatelessWidget {
  const KzFieldMessage({super.key, required this.text, this.isError = false});

  final String text;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final color = isError ? kz.apricotText : kz.ink2;
    return Semantics(
      liveRegion: isError,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KzSpace.s6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isError) ...[
              Padding(
                padding: const EdgeInsets.only(top: KzSpace.s2),
                child: KzIcon(KzIcons.info, size: KzSize.iconXs, color: color),
              ),
              const SizedBox(width: KzSpace.s6),
            ],
            Expanded(
              child: Text(
                text,
                style: KzText.captionSemi.copyWith(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
