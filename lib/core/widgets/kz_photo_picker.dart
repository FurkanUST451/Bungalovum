import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_dashed_border.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';

/// Seçilen fotoğrafların küçük önizlemeleri + kesikli "Ekle" kutusu
/// (Sorun Bildir, Değerlendirme Yaz, ilan sihirbazı).
class KzPhotoPicker extends StatelessWidget {
  const KzPhotoPicker({
    super.key,
    required this.paths,
    required this.onChanged,
    required this.addLabel,
    required this.removeLabel,
    this.max = 5,
    this.size = _tile,
  });

  /// Seçilen dosyaların yerel yolları.
  final List<String> paths;
  final ValueChanged<List<String>> onChanged;
  final String addLabel;

  /// Kaldır butonunun erişilebilirlik etiketi.
  final String removeLabel;
  final int max;
  final double size;

  static const double _tile = 72;
  static const double _remove = 24;

  /// Sunucuya gönderilmeden önce küçültülür.
  static const double maxDimension = 2048;
  static const int quality = 85;

  Future<void> _pick() async {
    final left = max - paths.length;
    if (left <= 0) return;
    final picked = await ImagePicker().pickMultiImage(
      limit: left > 1 ? left : null,
      maxWidth: maxDimension,
      maxHeight: maxDimension,
      imageQuality: quality,
    );
    if (picked.isEmpty) return;
    onChanged([...paths, ...picked.take(left).map((f) => f.path)]);
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final dpr = MediaQuery.devicePixelRatioOf(context);
    return Wrap(
      spacing: KzSpace.s10,
      runSpacing: KzSpace.s10,
      children: [
        for (final p in paths)
          SizedBox.square(
            dimension: size,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: KzRadii.all(KzRadii.tile),
                    child: Image.file(
                      File(p),
                      fit: BoxFit.cover,
                      cacheWidth: (size * dpr).round(),
                      errorBuilder: (_, _, _) => ColoredBox(color: kz.sand),
                    ),
                  ),
                ),
                Positioned(
                  right: -KzSpace.s6,
                  top: -KzSpace.s6,
                  child: KzPressable(
                    onPressed: () => onChanged([...paths]..remove(p)),
                    semanticLabel: removeLabel,
                    child: Container(
                      width: _remove,
                      height: _remove,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kz.ink,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: kz.surface,
                          width: KzSize.borderFocus,
                        ),
                      ),
                      child: KzIcon(
                        KzIcons.x,
                        size: KzSpace.s12,
                        color: kz.onForest,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (paths.length < max)
          KzPressable(
            onPressed: _pick,
            semanticLabel: addLabel,
            child: KzDashedBorder(
              radius: KzRadii.tile,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: kz.surface,
                  borderRadius: KzRadii.all(KzRadii.tile),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KzIcon(
                      KzIcons.camera,
                      size: KzSize.iconMd,
                      color: kz.forest,
                    ),
                    const SizedBox(height: KzSpace.s4),
                    Text(
                      addLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: KzText.microTight.copyWith(
                        color: kz.forest,
                        fontWeight: KzText.extraBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
