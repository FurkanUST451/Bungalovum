import 'package:flutter/material.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';

/// Açılır-kapanır satır (SSS); [KzGroup] içinde kullanılır.
class KzAccordionRow extends StatelessWidget {
  const KzAccordionRow({
    super.key,
    required this.title,
    required this.body,
    required this.open,
    required this.onPressed,
  });

  final String title;
  final String body;
  final bool open;
  final VoidCallback onPressed;

  /// Sağ ok aşağı (kapalı) / yukarı (açık) bakar.
  static const double _closedTurns = 0.25;
  static const double _openTurns = 0.75;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final duration = KzMotion.of(context, KzMotion.toggle);
    return Semantics(
      expanded: open,
      child: KzPressable(
        onPressed: onPressed,
        semanticLabel: title,
        pressedScale: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KzSpace.s16,
            vertical: KzSpace.s14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: KzText.bodyStrongSm.copyWith(color: kz.ink),
                    ),
                  ),
                  const SizedBox(width: KzSpace.s8),
                  AnimatedRotation(
                    turns: open ? _openTurns : _closedTurns,
                    duration: duration,
                    child: KzIcon(
                      KzIcons.chev,
                      size: KzSize.iconSm,
                      color: kz.ink2,
                    ),
                  ),
                ],
              ),
              AnimatedSize(
                duration: duration,
                curve: KzMotion.enter,
                alignment: Alignment.topCenter,
                child: open
                    ? Padding(
                        padding: const EdgeInsets.only(top: KzSpace.s8),
                        child: Text(
                          body,
                          style: KzText.bodySm.copyWith(color: kz.ink2),
                        ),
                      )
                    : const SizedBox(width: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
