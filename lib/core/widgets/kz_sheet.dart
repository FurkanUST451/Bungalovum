import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../icons/kz_icons.dart';
import '../responsive/breakpoints.dart';
import '../theme/tokens.dart';
import 'kz_circle_button.dart';
import 'kz_icon.dart';
import 'kz_pressable.dart';

/// Bungalovum alt sayfası: surface zemin, üst köşeler 30, tutamak, isteğe bağlı
/// başlık + kapat. Tablette 560 genişlikte ortalanır.
Future<T?> showKzSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  String? title,
  String? closeLabel,
}) {
  // Sheet sekme çubuğunun da üstünde açılsın diye uygulamanın kök
  // navigator'ına itilir. `useRootNavigator` yerine GoRouter'ın kökü
  // kullanılır: uygulama başka bir uygulamanın içine gömülüyse (ör. golden
  // testleri) en dıştaki navigator bizim tema ve yerelleştirmemizi taşımaz.
  final root = GoRouter.maybeOf(context)?.routerDelegate.navigatorKey;
  final host = root?.currentContext ?? context;
  return showModalBottomSheet<T>(
    context: host,
    isScrollControlled: true,
    useRootNavigator: root?.currentContext == null,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    barrierColor: context.kz.scrim,
    constraints: const BoxConstraints(maxWidth: KzBreakpoints.mediumContent),
    sheetAnimationStyle: AnimationStyle(
      duration: KzMotion.of(context, KzMotion.sheet),
      curve: KzMotion.enter,
      reverseCurve: KzMotion.exit,
    ),
    builder: (ctx) =>
        KzSheet(title: title, closeLabel: closeLabel, child: builder(ctx)),
  );
}

class KzSheet extends StatelessWidget {
  const KzSheet({super.key, required this.child, this.title, this.closeLabel});

  final Widget child;
  final String? title;
  final String? closeLabel;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Container(
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.top(KzRadii.hero),
      ),
      padding: EdgeInsets.fromLTRB(
        context.screenGutter,
        KzSpace.s14,
        context.screenGutter,
        KzSpace.s24 + MediaQuery.paddingOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: KzSize.grabberWidth,
                height: KzSize.grabberHeight,
                decoration: BoxDecoration(
                  color: kz.line,
                  borderRadius: KzRadii.all(KzRadii.hairline),
                ),
              ),
            ),
            if (title != null) ...[
              const SizedBox(height: KzSpace.s12),
              Row(
                children: [
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        title!,
                        style: KzText.h4.copyWith(color: kz.ink),
                      ),
                    ),
                  ),
                  if (closeLabel != null)
                    KzCircleButton(
                      icon: KzIcons.x,
                      iconSize: KzSpace.s16,
                      background: kz.sand,
                      semanticLabel: closeLabel!,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                ],
              ),
            ],
            const SizedBox(height: KzSpace.s16),
            child,
          ],
        ),
      ),
    );
  }
}

/// Tek seçimli satır (sıralama vb.).
class KzOptionRow extends StatelessWidget {
  const KzOptionRow({
    super.key,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: label,
      selected: selected,
      pressedScale: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: KzSpace.s14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: KzText.bodyStrongSm.copyWith(
                  color: kz.ink,
                  fontWeight: selected ? KzText.extraBold : KzText.semiBold,
                ),
              ),
            ),
            if (selected)
              KzIcon(KzIcons.check, size: KzSize.iconMd, color: kz.forest),
          ],
        ),
      ),
    );
  }
}
