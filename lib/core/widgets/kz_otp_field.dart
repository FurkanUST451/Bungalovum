import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/tokens.dart';

/// 6 haneli doğrulama kodu girişi. Dolu haneler forestSoft, sıradaki hane
/// forest kenarlık + imleç, boşlar line kenarlık. Klavye girişi görünmez bir
/// TextField üzerinden alınır (SMS otomatik doldurma dahil).
class KzOtpField extends StatefulWidget {
  const KzOtpField({
    super.key,
    required this.controller,
    required this.semanticLabel,
    this.length = 6,
    this.hasError = false,
    this.onCompleted,
    this.autofocus = true,
  });

  final TextEditingController controller;
  final String semanticLabel;
  final int length;
  final bool hasError;
  final ValueChanged<String>? onCompleted;
  final bool autofocus;

  @override
  State<KzOtpField> createState() => _KzOtpFieldState();
}

class _KzOtpFieldState extends State<KzOtpField> {
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_changed);
    _focus.addListener(_changed);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_changed);
    _focus.dispose();
    super.dispose();
  }

  void _changed() {
    setState(() {});
    final text = widget.controller.text;
    if (text.length == widget.length) widget.onCompleted?.call(text);
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final code = widget.controller.text;
    return GestureDetector(
      onTap: _focus.requestFocus,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          // Görünmez gerçek giriş alanı.
          Positioned.fill(
            child: Opacity(
              opacity: 0,
              child: TextField(
                controller: widget.controller,
                focusNode: _focus,
                autofocus: widget.autofocus,
                keyboardType: TextInputType.number,
                autofillHints: const [AutofillHints.oneTimeCode],
                maxLength: widget.length,
                showCursor: false,
                enableInteractiveSelection: false,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Semantics(
            label: widget.semanticLabel,
            value: code,
            textField: true,
            child: ExcludeSemantics(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final gaps = KzSpace.s8 * (widget.length - 1);
                  final cell = math.min(
                    KzSize.otpCellWidth,
                    (constraints.maxWidth - gaps) / widget.length,
                  );
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 0; i < widget.length; i++)
                        _Cell(
                          width: cell,
                          digit: i < code.length ? code[i] : null,
                          active: _focus.hasFocus && i == code.length,
                          hasError: widget.hasError,
                          kz: kz,
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.width,
    required this.digit,
    required this.active,
    required this.hasError,
    required this.kz,
  });

  final double width;
  final String? digit;
  final bool active;
  final bool hasError;
  final KzColors kz;

  @override
  Widget build(BuildContext context) {
    final filled = digit != null;
    final Color? borderColor = hasError
        ? kz.apricotText
        : active
        ? kz.forest
        : filled
        ? null
        : kz.line;
    return AnimatedContainer(
      duration: KzMotion.of(context, KzMotion.micro),
      width: width,
      height: KzSize.otpCellHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: filled && !hasError ? kz.forestSoft : kz.surface,
        borderRadius: KzRadii.all(KzRadii.tile),
        border: borderColor == null
            ? null
            : Border.all(
                color: borderColor,
                width: active || hasError ? KzSize.borderFocus : KzSize.border,
              ),
      ),
      child: filled
          ? Text(
              digit!,
              style: KzText.digit.copyWith(
                color: hasError ? kz.apricotText : kz.forest,
              ),
            )
          : active
          ? Container(
              width: KzSize.caretWidth,
              height: KzSize.otpCaretHeight,
              decoration: BoxDecoration(
                color: kz.forest,
                borderRadius: KzRadii.all(KzSize.caretWidth / 2),
              ),
            )
          : null,
    );
  }
}
