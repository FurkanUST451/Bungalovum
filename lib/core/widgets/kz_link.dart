import 'package:flutter/widgets.dart';

import '../theme/tokens.dart';
import 'kz_pressable.dart';

/// Link: forest + 800 (+ alt çizgi).
class KzLink extends StatelessWidget {
  const KzLink({
    super.key,
    required this.label,
    required this.onPressed,
    this.style,
    this.underline = true,
  });

  final String label;
  final VoidCallback onPressed;

  /// Boyut için taban stil; renk ve kalınlık her zaman link stilidir.
  final TextStyle? style;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: label,
      child: Text(
        label,
        style: (style ?? KzText.label).copyWith(
          color: kz.forest,
          fontWeight: KzText.extraBold,
          decoration: underline ? TextDecoration.underline : null,
          decorationColor: kz.forest,
        ),
      ),
    );
  }
}

/// "Hesabın yok mu? Kayıt ol" satırı.
class KzPromptLink extends StatelessWidget {
  const KzPromptLink({
    super.key,
    required this.prompt,
    required this.action,
    required this.onPressed,
  });

  final String prompt;
  final String action;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: KzSpace.s4),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('$prompt ', style: KzText.bodySm.copyWith(color: kz.ink2)),
          KzLink(
            label: action,
            onPressed: onPressed,
            underline: false,
            style: KzText.bodySm,
          ),
        ],
      ),
    );
  }
}

/// Ortasında metin olan ince ayraç ("veya").
class KzDividerLabel extends StatelessWidget {
  const KzDividerLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final line = Expanded(
      child: Container(height: KzSize.border, color: kz.line),
    );
    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: KzSpace.s12),
          child: Text(label, style: KzText.labelSemi.copyWith(color: kz.ink2)),
        ),
        line,
      ],
    );
  }
}
