import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';

/// 1–5 yıldız seçimi. Dokunarak ya da parmağı kaydırarak seçilir; ekran
/// okuyucuda ayarlanabilir değer (artır / azalt) olarak okunur. Görsel
/// yıldız küçük olsa da her hücre en az 44 yüksekliğindedir.
class KzStarRating extends StatelessWidget {
  const KzStarRating({
    super.key,
    required this.value,
    required this.onChanged,
    required this.semanticLabel,
    required this.valueLabel,
    this.size = KzSize.iconSm,
    this.gap = KzSpace.s4,
  });

  /// 0 = henüz puanlanmadı.
  final int value;
  final ValueChanged<int> onChanged;

  /// "Temizlik"
  final String semanticLabel;

  /// Değerin okunuşu: "4 / 5 yıldız".
  final String Function(int stars) valueLabel;
  final double size;
  final double gap;

  static const int max = 5;

  int _starAt(double dx) => (dx / (size + gap)).floor().clamp(0, max - 1) + 1;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Semantics(
      label: semanticLabel,
      value: valueLabel(value),
      increasedValue: value < max ? valueLabel(value + 1) : null,
      decreasedValue: value > 1 ? valueLabel(value - 1) : null,
      onIncrease: value < max ? () => onChanged(value + 1) : null,
      onDecrease: value > 1 ? () => onChanged(value - 1) : null,
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) => onChanged(_starAt(d.localPosition.dx)),
          onHorizontalDragUpdate: (d) {
            final s = _starAt(d.localPosition.dx);
            if (s != value) onChanged(s);
          },
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: KzSize.minTouch),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 1; i <= max; i++) ...[
                  if (i > 1) SizedBox(width: gap),
                  KzIcon(
                    KzIcons.starFilled,
                    size: size,
                    color: i <= value ? kz.star : kz.line,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
