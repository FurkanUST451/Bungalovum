import 'package:flutter/material.dart';

import '../theme/tokens.dart';
import 'kz_input.dart';

/// Çok satırlı metin alanı (`field` köşe, üstte küçük etiket). Odakta 2px
/// forest, hatada 2px apricotText kenarlık + altta hata satırı.
class KzTextArea extends StatefulWidget {
  const KzTextArea({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.errorText,
    this.minLines = 2,
    this.minHeight = 0,
    this.maxLength,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final String? errorText;
  final int minLines;
  final double minHeight;
  final int? maxLength;
  final ValueChanged<String>? onChanged;

  @override
  State<KzTextArea> createState() => _KzTextAreaState();
}

class _KzTextAreaState extends State<KzTextArea> {
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final hasError = widget.errorText != null;
    final accent = hasError
        ? kz.apricotText
        : _focus.hasFocus
        ? kz.forest
        : null;
    final box = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _focus.requestFocus,
      child: AnimatedContainer(
        duration: KzMotion.of(context, KzMotion.micro),
        constraints: BoxConstraints(minHeight: widget.minHeight),
        padding: const EdgeInsets.all(KzSpace.s16),
        decoration: BoxDecoration(
          color: kz.surface,
          borderRadius: KzRadii.all(KzRadii.field),
          border: Border.all(
            color: accent ?? kz.line,
            width: accent == null ? KzSize.border : KzSize.borderFocus,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: KzText.captionSemi.copyWith(
                color: accent ?? kz.ink2,
                height: KzText.tightLeading,
              ),
            ),
            const SizedBox(height: KzSpace.s6),
            TextField(
              controller: widget.controller,
              focusNode: _focus,
              maxLines: null,
              minLines: widget.minLines,
              maxLength: widget.maxLength,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              onChanged: widget.onChanged,
              cursorColor: kz.forest,
              style: KzText.body.copyWith(color: kz.ink),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                counterText: '',
                hintText: widget.hint,
                hintStyle: KzText.body.copyWith(color: kz.placeholder),
              ),
            ),
          ],
        ),
      ),
    );
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
