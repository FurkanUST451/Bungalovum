import 'package:flutter/widgets.dart';

import '../theme/tokens.dart';
import 'kz_pressable.dart';

/// Figma `Segment`: sand zemin hap, seçili parça beyaz + soft gölge.
class KzSegmented<T> extends StatelessWidget {
  const KzSegmented({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
  });

  final List<(T, String)> segments;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final duration = KzMotion.of(context, KzMotion.toggle);
    return Container(
      padding: const EdgeInsets.all(KzSpace.s5),
      decoration: BoxDecoration(
        color: kz.sand,
        borderRadius: KzRadii.all(KzRadii.pill),
      ),
      child: Row(
        children: [
          for (final (i, (value, label)) in segments.indexed) ...[
            if (i > 0) const SizedBox(width: KzSpace.s4),
            Expanded(
              child: KzPressable(
                onPressed: () => onChanged(value),
                semanticLabel: label,
                selected: value == selected,
                child: AnimatedContainer(
                  duration: duration,
                  curve: KzMotion.enter,
                  constraints: const BoxConstraints(minHeight: KzSize.segment),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: KzSpace.s8,
                    vertical: KzSpace.s4,
                  ),
                  decoration: BoxDecoration(
                    color: value == selected ? kz.surface : kz.sand,
                    borderRadius: KzRadii.all(KzRadii.pill),
                    boxShadow: value == selected ? KzShadows.soft : null,
                  ),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.bodySm.copyWith(
                      fontWeight: value == selected
                          ? KzText.extraBold
                          : KzText.semiBold,
                      color: value == selected ? kz.ink : kz.ink2,
                      height: KzText.tightLeading,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
