import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';

/// Figma `Buton` (Tür = Birincil / İkincil / Koyu / Çerçeve).
enum KzButtonVariant { primary, secondary, dark, outline }

/// regular: 58 yükseklik, 16/800. social: 56, 15/800 (Google / Apple ile
/// devam et).
enum KzButtonSize { regular, social }

/// Yükseklik 58, pill, 16/800 metin. Basılıyken 0.97 ölçek; yüklenirken
/// genişlik sabit kalır ve spinner gösterilir; pasifken %40 opaklık.
class KzButton extends StatelessWidget {
  const KzButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = KzButtonVariant.primary,
    this.trailingArrow = false,
    this.loading = false,
    this.expand = true,
    this.size = KzButtonSize.regular,
    this.leading,
  });

  final String label;
  final VoidCallback? onPressed;
  final KzButtonVariant variant;
  final bool trailingArrow;
  final bool loading;

  /// true ise bulunduğu genişliği doldurur.
  final bool expand;
  final KzButtonSize size;

  /// Etiketin solundaki öğe (ör. sağlayıcı rozeti).
  final Widget? leading;

  static const double _disabledOpacity = 0.4;
  static const double _spinnerStroke = 2.5;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final (bg, fg, border, shadow) = switch (variant) {
      KzButtonVariant.primary => (kz.forest, kz.onForest, null, KzShadows.card),
      KzButtonVariant.secondary => (kz.sand, kz.ink, null, null),
      KzButtonVariant.dark => (kz.ink, kz.onForest, null, null),
      KzButtonVariant.outline => (kz.surface, kz.ink, kz.line, null),
    };
    final enabled = onPressed != null && !loading;
    final social = size == KzButtonSize.social;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: KzSpace.s10)],
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: (social ? KzText.bodyStrongSm : KzText.bodyStrong).copyWith(
              fontWeight: KzText.extraBold,
              color: fg,
            ),
          ),
        ),
        if (trailingArrow) ...[
          const SizedBox(width: KzSpace.s8),
          KzIcon(KzIcons.arrow, size: KzSize.iconSm, color: fg),
        ],
      ],
    );

    final body = AnimatedOpacity(
      opacity: onPressed == null ? _disabledOpacity : 1,
      duration: KzMotion.of(context, KzMotion.micro),
      child: Container(
        height: social ? KzSize.socialButton : KzSize.button,
        width: expand ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: KzSpace.s24),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: KzRadii.all(KzRadii.pill),
          border: border == null ? null : Border.all(color: border),
          boxShadow: shadow,
        ),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Yüklenirken metin görünmez ama yer kaplar: genişlik sabit kalır.
            Opacity(opacity: loading ? 0 : 1, child: content),
            if (loading)
              SizedBox.square(
                dimension: KzSize.iconMd,
                child: _Spinner(color: fg, stroke: _spinnerStroke),
              ),
          ],
        ),
      ),
    );

    return KzPressable(
      onPressed: enabled ? onPressed : null,
      semanticLabel: label,
      haptic: variant == KzButtonVariant.primary,
      child: body,
    );
  }
}

class _Spinner extends StatefulWidget {
  const _Spinner({required this.color, required this.stroke});

  final Color color;
  final double stroke;

  @override
  State<_Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<_Spinner>
    with SingleTickerProviderStateMixin {
  static const _period = Duration(milliseconds: 900);

  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: _period,
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _c,
      child: CustomPaint(painter: _ArcPainter(widget.color, widget.stroke)),
    );
  }
}

class _ArcPainter extends CustomPainter {
  _ArcPainter(this.color, this.stroke);

  final Color color;
  final double stroke;

  static const double _sweep = 4.2;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(Offset.zero & size, 0, _sweep, false, paint);
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.color != color || old.stroke != stroke;
}
