import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';

enum KzTipTone {
  /// Sand zemin, apricot ikon, ink2 metin — ipucu.
  neutral,

  /// apricotSoft zemin, apricotText ikon, ink kalın metin — hata/uyarı bandı.
  warning,

  /// poolSoft zemin, poolText ikon, ink yarı kalın metin — bilgi kutusu.
  info,

  /// forestSoft zemin, forest ikon, ink metin — onay/güvence.
  success,
}

/// İpucu kutusu / uyarı bandı (md radius, yumuşak zemin, ikon + metin).
class KzTip extends StatelessWidget {
  const KzTip({
    super.key,
    required this.message,
    required this.icon,
    this.tone = KzTipTone.neutral,
    this.title,
  });

  final String message;
  final KzIcons icon;
  final KzTipTone tone;

  /// İsteğe bağlı kalın başlık satırı.
  final String? title;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final (bg, iconColor, textStyle, iconSize, gap) = switch (tone) {
      KzTipTone.neutral => (
        kz.sand,
        kz.apricot,
        KzText.labelMedium.copyWith(color: kz.ink2),
        KzSpace.s16,
        KzSpace.s10,
      ),
      KzTipTone.warning => (
        kz.apricotSoft,
        kz.apricotText,
        KzText.label.copyWith(color: kz.ink),
        KzSize.iconMd,
        KzSpace.s12,
      ),
      KzTipTone.info => (
        kz.poolSoft,
        kz.poolText,
        KzText.labelSemi.copyWith(color: kz.ink),
        KzSize.iconMd,
        KzSpace.s12,
      ),
      KzTipTone.success => (
        kz.forestSoft,
        kz.forest,
        KzText.labelSemi.copyWith(color: kz.ink),
        KzSize.iconMd,
        KzSpace.s12,
      ),
    };
    final neutral = tone == KzTipTone.neutral;
    final multiline = neutral || title != null;
    return Semantics(
      liveRegion: tone == KzTipTone.warning,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(neutral ? KzSpace.s14 : KzSpace.s16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: KzRadii.all(neutral ? KzRadii.md : KzRadii.field),
        ),
        child: Row(
          crossAxisAlignment: multiline
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            KzIcon(icon, size: iconSize, color: iconColor),
            SizedBox(width: gap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) ...[
                    Text(
                      title!,
                      style: KzText.label.copyWith(
                        color: kz.ink,
                        fontWeight: KzText.extraBold,
                      ),
                    ),
                    const SizedBox(height: KzSpace.s2),
                  ],
                  Text(
                    message,
                    style: textStyle.copyWith(height: KzText.caption.height),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
