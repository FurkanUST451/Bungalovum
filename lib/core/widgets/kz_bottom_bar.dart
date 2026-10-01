import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../theme/tokens.dart';

/// Ekran altı sabit aksiyon barı: surface zemin, yalnızca üst köşeler 28,
/// yukarı doğru gölge. Alt güvenli alanın üstüne oturur; klavye açılınca
/// Scaffold ile birlikte yukarı çıkar.
class KzBottomBar extends StatelessWidget {
  const KzBottomBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final safe = MediaQuery.paddingOf(context).bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(
        KzSpace.screen,
        KzSpace.s14,
        KzSpace.screen,
        math.max(KzSpace.s30, safe + KzSpace.s14),
      ),
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.top(KzRadii.lg),
        boxShadow: KzShadows.bottomBar,
      ),
      child: child,
    );
  }
}

/// Sol: özet metin + link, sağ: birincil buton. (Tarih Seç, Misafirler...)
class KzBottomBarSummary extends StatelessWidget {
  const KzBottomBarSummary({
    super.key,
    required this.leading,
    required this.action,
  });

  final Widget leading;
  final Widget action;

  /// Butonun alabileceği en fazla genişlik oranı.
  static const double _actionFlex = 0.64;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) => Row(
        children: [
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              heightFactor: 1,
              child: leading,
            ),
          ),
          const SizedBox(width: KzSpace.s12),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: c.maxWidth * _actionFlex),
            child: action,
          ),
        ],
      ),
    );
  }
}
