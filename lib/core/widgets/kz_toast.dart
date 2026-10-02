import 'package:flutter/material.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';

/// Kısa geri bildirim (ink zemin, yüzen, `md` köşe): "Bağlantı kopyalandı".
/// [title] verilirse kalın başlık + açıklama ve solda onay ikonu gösterilir
/// ("Değerlendirmen için teşekkürler!").
void showKzToast(BuildContext context, String message, {String? title}) {
  final kz = context.kz;
  final text = title == null
      ? Text(message, style: KzText.label.copyWith(color: kz.onForest))
      : Row(
          children: [
            Container(
              width: KzSize.minTouch - KzSpace.s12,
              height: KzSize.minTouch - KzSpace.s12,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kz.forest,
                shape: BoxShape.circle,
              ),
              child: KzIcon(
                KzIcons.check,
                size: KzSize.iconSm,
                color: kz.onForest,
              ),
            ),
            const SizedBox(width: KzSpace.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: KzText.bodySm.copyWith(
                      color: kz.onForest,
                      fontWeight: KzText.extraBold,
                    ),
                  ),
                  const SizedBox(height: KzSpace.s2),
                  Text(
                    message,
                    style: KzText.caption.copyWith(color: kz.forestSoft),
                  ),
                ],
              ),
            ),
          ],
        );
  ScaffoldMessenger.maybeOf(context)?.showSnackBar(
    SnackBar(
      content: Semantics(liveRegion: true, child: text),
      backgroundColor: kz.ink,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: KzRadii.all(KzRadii.md)),
    ),
  );
}
