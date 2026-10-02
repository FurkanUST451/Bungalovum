import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';

/// Daire zemini ve ikon rengi.
enum KzSpotTone { forest, apricot, pool, sand }

/// Köşe rozeti zemini.
enum KzSpotBadge { apricot, forest, forestSoft, warning }

/// Köşedeki küçük nokta.
enum KzSpotDot { none, pool, apricot, forest }

/// Kodla çizilen küçük illüstrasyon (boş durumlar, doğrulama ekranları):
/// yumuşak daire + beyaz kutu içinde ikon + köşede rozet (+ nokta).
class KzSpotIllustration extends StatelessWidget {
  const KzSpotIllustration({
    super.key,
    required this.icon,
    this.tone = KzSpotTone.forest,
    this.badgeIcon = KzIcons.sparklesFilled,
    this.badge = KzSpotBadge.apricot,
    this.dot = KzSpotDot.none,
    this.large = false,
  });

  final KzIcons icon;
  final KzSpotTone tone;
  final KzIcons badgeIcon;
  final KzSpotBadge badge;
  final KzSpotDot dot;

  /// Boş durum / Giriş Gerekli büyük boy (190×160).
  final bool large;

  // Figma ölçüleri (normal / büyük).
  static const _canvas = (Size(150, 120), Size(190, 160));
  static const _circle = (120.0, 150.0);
  static const _tile = (76.0, 92.0);
  static const _tileRadius = (KzRadii.card, KzRadii.hero);
  static const _icon = (34.0, 40.0);
  static const _badge = (32.0, 38.0);
  static const _badgeIcon = (14.0, 17.0);
  static const _dot = 14.0;

  /// Noktanın dairenin yüksekliğine göre dikey konumu.
  static const _dotTop = 0.8;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final (soft, ink) = switch (tone) {
      KzSpotTone.forest => (kz.forestSoft, kz.forest),
      KzSpotTone.apricot => (kz.apricotSoft, kz.apricotText),
      KzSpotTone.pool => (kz.poolSoft, kz.poolText),
      KzSpotTone.sand => (kz.sand, kz.forest),
    };
    final (badgeBg, badgeFg) = switch (badge) {
      KzSpotBadge.apricot => (kz.apricot, kz.onForest),
      KzSpotBadge.forest => (kz.forest, kz.onForest),
      KzSpotBadge.forestSoft => (kz.forestSoft, kz.forest),
      KzSpotBadge.warning => (kz.apricotText, kz.onForest),
    };
    T pick<T>((T, T) v) => large ? v.$2 : v.$1;
    final canvas = pick(_canvas);
    final circle = pick(_circle);
    final tile = pick(_tile);
    final badgeSize = pick(_badge);
    final circleLeft = (canvas.width - circle) / 2;

    return ExcludeSemantics(
      child: SizedBox.fromSize(
        size: canvas,
        child: Stack(
          children: [
            Positioned(
              left: circleLeft,
              top: 0,
              child: Container(
                width: circle,
                height: circle,
                decoration: BoxDecoration(color: soft, shape: BoxShape.circle),
              ),
            ),
            Positioned(
              left: (canvas.width - tile) / 2,
              top: (circle - tile) / 2,
              child: Container(
                width: tile,
                height: tile,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kz.surface,
                  borderRadius: KzRadii.all(pick(_tileRadius)),
                  boxShadow: KzShadows.raised,
                ),
                child: KzIcon(icon, size: pick(_icon), color: ink),
              ),
            ),
            Positioned(
              right: canvas.width - circleLeft - circle - badgeSize / 4,
              top: KzSpace.s6,
              child: Container(
                width: badgeSize,
                height: badgeSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: badgeBg,
                  shape: BoxShape.circle,
                ),
                child: KzIcon(
                  badgeIcon,
                  size: pick(_badgeIcon),
                  color: badgeFg,
                ),
              ),
            ),
            if (dot != KzSpotDot.none)
              Positioned(
                left: circleLeft + KzSpace.s6,
                top: circle * _dotTop,
                child: Container(
                  width: _dot,
                  height: _dot,
                  decoration: BoxDecoration(
                    color: switch (dot) {
                      KzSpotDot.pool => kz.pool,
                      KzSpotDot.forest => kz.forest,
                      _ => kz.apricot,
                    },
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Başarı ekranlarındaki büyük onay illüstrasyonu (Şifre Güncellendi,
/// Rezervasyon Tamam...).
class KzSuccessIllustration extends StatelessWidget {
  const KzSuccessIllustration({super.key, this.icon = KzIcons.check});

  final KzIcons icon;

  static const _canvas = Size(220, 200);
  static const _outer = 200.0;
  static const _inner = 140.0;
  static const _core = 84.0;
  static const _check = 40.0;
  static const _badge = 40.0;
  static const _dot = 16.0;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    Widget circle(
      double d,
      Color c, {
      List<BoxShadow>? shadow,
      Widget? child,
    }) => Container(
      width: d,
      height: d,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: c,
        shape: BoxShape.circle,
        boxShadow: shadow,
      ),
      child: child,
    );
    return ExcludeSemantics(
      child: SizedBox.fromSize(
        size: _canvas,
        child: Stack(
          alignment: Alignment.center,
          children: [
            circle(_outer, kz.forestSoft),
            circle(
              _inner,
              kz.surface,
              shadow: KzShadows.raised,
              child: circle(
                _core,
                kz.forest,
                child: KzIcon(icon, size: _check, color: kz.onForest),
              ),
            ),
            Positioned(
              right: 0,
              top: KzSpace.s14,
              child: circle(
                _badge,
                kz.apricot,
                child: KzIcon(
                  KzIcons.sparklesFilled,
                  size: KzSize.iconSm,
                  color: kz.onForest,
                ),
              ),
            ),
            Positioned(
              left: KzSpace.s18,
              bottom: KzSpace.s24,
              child: circle(_dot, kz.pool),
            ),
          ],
        ),
      ),
    );
  }
}

/// Boş durum: illüstrasyon + başlık + açıklama (+ aksiyonlar).
class KzEmptyState extends StatelessWidget {
  const KzEmptyState({
    super.key,
    required this.illustration,
    required this.title,
    this.body,
    this.actions = const [],
  });

  final Widget illustration;
  final String title;
  final String? body;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KzSpace.s16,
        vertical: KzSpace.s24,
      ),
      child: Column(
        children: [
          illustration,
          const SizedBox(height: KzSpace.s14),
          Semantics(
            header: true,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: KzText.h4.copyWith(color: kz.ink),
            ),
          ),
          if (body != null) ...[
            const SizedBox(height: KzSpace.s14),
            Text(
              body!,
              textAlign: TextAlign.center,
              style: KzText.bodySm.copyWith(
                color: kz.ink2,
                height: KzText.body.height,
              ),
            ),
          ],
          for (final a in actions) ...[const SizedBox(height: KzSpace.s14), a],
        ],
      ),
    );
  }
}
