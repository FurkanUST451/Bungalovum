import 'package:flutter/widgets.dart';

import '../icons/kz_icons.dart';
import '../responsive/breakpoints.dart';
import '../theme/tokens.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';

@immutable
class KzTabItem {
  const KzTabItem({required this.icon, required this.label, this.badge});

  final KzIcons icon;
  final String label;

  /// Okunmamış rozeti; null değilse ikonun köşesinde apricot nokta ve
  /// erişilebilirlik etiketine bu metin eklenir ("2 okunmamış mesaj").
  final String? badge;

  String get semanticLabel => badge == null ? label : '$label, $badge';
}

/// İkonun sağ üstünde apricot nokta (surface halkalı).
class _Badge extends StatelessWidget {
  const _Badge({required this.child, required this.show});

  final Widget child;
  final bool show;

  @override
  Widget build(BuildContext context) {
    if (!show) return child;
    final kz = context.kz;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: -KzSpace.s2,
          top: -KzSpace.s2,
          child: Container(
            width: KzSize.badgeDot,
            height: KzSize.badgeDot,
            decoration: BoxDecoration(
              color: kz.apricot,
              shape: BoxShape.circle,
              border: Border.all(color: kz.surface, width: KzSize.badgeStroke),
            ),
          ),
        ),
      ],
    );
  }
}

/// Yüzen alt tab bar (Figma `Tab bar`, Aktif=…).
///
/// Kenarlardan 20 içeride, alt güvenli alanın 28 üstünde durur; konumlamayı
/// [KzTabBar.floating] yapar. Seçili sekme forest hap içinde ikon + etiket,
/// diğerleri yalnızca ikon gösterir. Dar ekranda etiket sığmazsa seçili
/// sekme yalnızca ikonla kalır.
class KzTabBar extends StatelessWidget {
  const KzTabBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onSelected,
  });

  final List<KzTabItem> items;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  /// Tab bar'ın alt kenardan uzaklığı (güvenli alan hariç).
  static const double bottomOffset = KzSpace.s28;

  /// İçeriğin tab bar arkasında kalmaması için gereken alt boşluk.
  static double reservedHeight(BuildContext context) =>
      KzSize.tabBar + bottomOffset + MediaQuery.paddingOf(context).bottom;

  /// [child]'ın üstüne yüzen tab bar'ı yerleştirir.
  static Widget floating({
    required BuildContext context,
    required Widget child,
    required KzTabBar bar,
  }) {
    const gutter = KzSpace.screen;
    return Stack(
      children: [
        Positioned.fill(child: child),
        Positioned(
          left: gutter,
          right: gutter,
          bottom: bottomOffset + MediaQuery.paddingOf(context).bottom,
          // medium sınıfında içerikle aynı genişlikte ortalanır.
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: KzBreakpoints.mediumContent,
              ),
              child: bar,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Container(
      height: KzSize.tabBar,
      padding: const EdgeInsets.symmetric(horizontal: KzSpace.s12),
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.all(KzRadii.xl),
        boxShadow: KzShadows.floating,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final selectedLabel = items[currentIndex].label;
          final showLabel = _labelFits(
            context,
            constraints.maxWidth,
            selectedLabel,
          );
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < items.length; i++)
                _TabButton(
                  item: items[i],
                  selected: i == currentIndex,
                  showLabel: showLabel,
                  onPressed: () => onSelected(i),
                ),
            ],
          );
        },
      ),
    );
  }

  bool _labelFits(BuildContext context, double maxWidth, String label) {
    final painter = TextPainter(
      text: TextSpan(text: label, style: _TabButton.labelStyle),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    final pill = KzSpace.s18 * 2 + KzSize.iconMd + KzSpace.s8 + painter.width;
    painter.dispose();
    final others = (items.length - 1) * KzSize.tabItemNarrow;
    return pill + others <= maxWidth;
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.item,
    required this.selected,
    required this.showLabel,
    required this.onPressed,
  });

  final KzTabItem item;
  final bool selected;
  final bool showLabel;
  final VoidCallback onPressed;

  static final labelStyle = KzText.bodySm.copyWith(fontWeight: KzText.bold);

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final duration = KzMotion.of(context, KzMotion.transition);
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: item.semanticLabel,
      selected: selected,
      haptic: true,
      child: AnimatedContainer(
        duration: duration,
        curve: KzMotion.enter,
        height: KzSize.tabItem,
        constraints: const BoxConstraints(minWidth: KzSize.tabItemNarrow),
        padding: EdgeInsets.symmetric(
          horizontal: selected && showLabel ? KzSpace.s18 : KzSpace.s12,
        ),
        decoration: BoxDecoration(
          color: selected ? kz.forest : kz.surface,
          borderRadius: KzRadii.all(KzRadii.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Badge(
              show: item.badge != null && !selected,
              child: KzIcon(
                item.icon,
                size: selected ? KzSize.iconMd : KzSize.iconLg,
                color: selected ? kz.onForest : kz.ink2,
              ),
            ),
            if (selected && showLabel) ...[
              const SizedBox(width: KzSpace.s8),
              Text(
                item.label,
                maxLines: 1,
                style: labelStyle.copyWith(color: kz.onForest),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Tablet (expanded) sınıfında tab bar'ın yerini alan dikey yüzen rail.
/// Tab bar ile aynı görsel dil: surface kapsül, seçili öğe forest hap.
class KzNavRail extends StatelessWidget {
  const KzNavRail({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onSelected,
  });

  final List<KzTabItem> items;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Container(
      width: KzSize.navRail,
      padding: const EdgeInsets.symmetric(vertical: KzSpace.s12),
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.all(KzRadii.xl),
        boxShadow: KzShadows.floating,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(height: KzSpace.s8),
            _RailButton(
              item: items[i],
              selected: i == currentIndex,
              onPressed: () => onSelected(i),
            ),
          ],
        ],
      ),
    );
  }
}

class _RailButton extends StatelessWidget {
  const _RailButton({
    required this.item,
    required this.selected,
    required this.onPressed,
  });

  final KzTabItem item;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final duration = KzMotion.of(context, KzMotion.transition);
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: item.semanticLabel,
      selected: selected,
      haptic: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KzSpace.s8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: duration,
              curve: KzMotion.enter,
              width: KzSize.circleLg,
              height: KzSize.tabItem,
              decoration: BoxDecoration(
                color: selected ? kz.forest : kz.surface,
                borderRadius: KzRadii.all(KzRadii.pill),
              ),
              alignment: Alignment.center,
              child: _Badge(
                show: item.badge != null && !selected,
                child: KzIcon(
                  item.icon,
                  size: KzSize.iconLg,
                  color: selected ? kz.onForest : kz.ink2,
                ),
              ),
            ),
            const SizedBox(height: KzSpace.s4),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: (selected ? KzText.captionHeavy : KzText.captionSemi)
                  .copyWith(color: selected ? kz.ink : kz.ink2),
            ),
          ],
        ),
      ),
    );
  }
}
