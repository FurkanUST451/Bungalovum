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

  /// "Kodun: 482 913" ya da "482913" gibi kopyalanan metinden kodu çıkarır.
  /// Yalnızca tam [KzOtpField.length] haneli tek bir rakam dizisi kabul edilir
  /// (rastgele pano içeriği koda dönüşmesin diye).
  @visibleForTesting
  static String? codeFromText(String? text, int length) {
    if (text == null) return null;
    final plain = text.replaceAll(String.fromCharCode(0xa0), ' ');
    // Rakam grupları ("482 913", "482-913") tek kod sayılır.
    final candidates = RegExp('[0-9]+([ -][0-9]+)*')
        .allMatches(plain)
        .map((m) => m.group(0)!.replaceAll(RegExp('[^0-9]'), ''))
        .where((digits) => digits.length == length)
        .toList();
    return candidates.length == 1 ? candidates.single : null;
  }
}

class _KzOtpFieldState extends State<KzOtpField>
    with WidgetsBindingObserver {
  final _focus = FocusNode();

  /// Son bildirilen tam kod; odak ya da imleç değişince aynı kod tekrar
  /// gönderilmesin diye tutulur.
  String? _completed;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.controller.addListener(_changed);
    _focus.addListener(_refresh);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.controller.removeListener(_changed);
    _focus.removeListener(_refresh);
    _focus.dispose();
    super.dispose();
  }

  /// Uygulama arka plandan dönünce:
  /// - Android klavyeyi kapatmış olur ama kutu hâlâ odaklı sayılır; klavyeyi
  ///   yeniden aç.
  /// - Kullanıcı kodu mailden kopyalayıp dönmüştür; panoda 6 haneli kod varsa
  ///   kutuyu doldur (basılı tutup yapıştırmak her cihazda çalışmıyor).
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    if (_focus.hasFocus) _showKeyboard();
    _fillFromClipboard();
  }

  Future<void> _fillFromClipboard() async {
    if (widget.controller.text.isNotEmpty) return;
    // Android, uygulama öne gelir gelmez panoyu okutmayabilir; kısa bekle.
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (!mounted || widget.controller.text.isNotEmpty) return;
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final code = KzOtpField.codeFromText(data?.text, widget.length);
    if (code == null || !mounted || widget.controller.text.isNotEmpty) return;
    widget.controller.text = code;
  }

  void _showKeyboard() {
    _focus.requestFocus();
    SystemChannels.textInput.invokeMethod<void>('TextInput.show');
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  void _changed() {
    if (!mounted) return;
    setState(() {});
    final text = widget.controller.text;
    if (text.length == widget.length) {
      if (text == _completed) return;
      _completed = text;
      widget.onCompleted?.call(text);
    } else {
      _completed = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final code = widget.controller.text;
    return Stack(
      children: [
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
        // Görünmez gerçek giriş alanı kutucukların ÜSTÜNDE durur: kutunun
        // neresine dokunulursa dokunulsun dokunma doğrudan bu alana gider ve
        // klavye her seferinde açılır (altta kalınca yalnızca kutucuk
        // aralarına dokunmak işe yarıyordu).
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
              // Basılı tutunca "Yapıştır" menüsü açılır (kod mailden kopyalanır).
              enableInteractiveSelection: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
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
