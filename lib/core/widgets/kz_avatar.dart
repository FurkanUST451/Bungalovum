import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';
import 'kz_photo.dart';

/// Baş harfli ya da fotoğraflı yuvarlak avatar. Renk adın baş harfinden
/// türetilir (apricot / pool / forest).
class KzAvatar extends StatelessWidget {
  const KzAvatar({
    super.key,
    required this.name,
    this.photoUrl,
    this.size = KzSize.avatar,
    this.verified = false,
  });

  final String name;
  final String? photoUrl;
  final double size;

  /// Sağ altta doğrulanmış (kalkan) rozeti.
  final bool verified;

  static const double _initialRatio = 0.4;
  static const double _badgeRatio = 0.34;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final initial = name.isEmpty ? '' : name.characters.first.toUpperCase();
    final palette = [
      (kz.apricot, kz.ink),
      (kz.pool, kz.onForest),
      (kz.forest, kz.onForest),
    ];
    final (bg, fg) =
        palette[name.isEmpty ? 0 : name.codeUnitAt(0) % palette.length];
    final badge = size * _badgeRatio;
    return SizedBox.square(
      dimension: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipOval(
            child: Container(
              width: size,
              height: size,
              color: bg,
              alignment: Alignment.center,
              child: photoUrl == null
                  ? Text(
                      initial,
                      style: KzText.title.copyWith(
                        color: fg,
                        fontSize: size * _initialRatio,
                        height: 1,
                      ),
                    )
                  : KzPhoto(url: photoUrl),
            ),
          ),
          if (verified)
            Positioned(
              right: -KzSpace.s2,
              bottom: -KzSpace.s2,
              child: Container(
                width: badge,
                height: badge,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kz.forest,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kz.surface,
                    width: KzSize.badgeStroke,
                  ),
                ),
                child: KzIcon(
                  KzIcons.shield,
                  size: badge / 2,
                  color: kz.onForest,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// 5 yıldızlık puan satırı.
class KzStars extends StatelessWidget {
  const KzStars({super.key, required this.rating, this.size = KzSpace.s12});

  final double rating;
  final double size;

  static const int _max = 5;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final full = rating.round().clamp(0, _max);
    return ExcludeSemantics(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < _max; i++) ...[
            if (i > 0) const SizedBox(width: KzSpace.s2),
            KzIcon(
              i < full ? KzIcons.starFilled : KzIcons.star,
              size: size,
              color: i < full ? kz.star : kz.line,
            ),
          ],
        ],
      ),
    );
  }
}
