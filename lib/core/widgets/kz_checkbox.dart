import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';

/// Figma `Onay kutusu` (Seçili / Boş): yuvarlatılmış kare, seçili = forest.
class KzCheckbox extends StatelessWidget {
  const KzCheckbox({
    super.key,
    required this.value,
    this.size = KzSize.checkbox,
    this.circular = false,
  });

  final bool value;
  final double size;

  /// Kural listelerindeki yuvarlak işaret.
  final bool circular;

  static const double _checkRatio = 0.58;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return AnimatedContainer(
      duration: KzMotion.of(context, KzMotion.toggle),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: value ? kz.forest : kz.surface,
        borderRadius: KzRadii.all(circular ? KzRadii.pill : KzRadii.xs),
        border: value
            ? null
            : Border.all(color: kz.line, width: KzSize.borderCheckbox),
      ),
      alignment: Alignment.center,
      child: value
          ? KzIcon(KzIcons.check, size: size * _checkRatio, color: kz.onForest)
          : null,
    );
  }
}

/// Onay kutusu + metin; satırın tamamı dokunulabilir.
class KzCheckboxTile extends StatelessWidget {
  const KzCheckboxTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    required this.semanticLabel,
    this.size = KzSize.checkbox,
    this.gap = KzSpace.s10,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget label;
  final String semanticLabel;
  final double size;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      checked: value,
      child: KzPressable(
        onPressed: () => onChanged(!value),
        semanticLabel: semanticLabel,
        pressedScale: 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KzCheckbox(value: value, size: size),
            SizedBox(width: gap),
            Flexible(child: label),
          ],
        ),
      ),
    );
  }
}
