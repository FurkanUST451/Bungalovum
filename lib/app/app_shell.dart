import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../core/responsive/breakpoints.dart';
import '../core/theme/tokens.dart';
import '../core/widgets/kz_tab_bar.dart';
import '../l10n/l10n.dart';
import 'app_tabs.dart';

/// Sekmeli kabuk: telefonda yüzen tab bar, tablette (expanded) sol rail.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  void _go(int index) =>
      shell.goBranch(index, initialLocation: index == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    final items = appTabs(context.l10n);
    final kz = context.kz;

    if (context.windowSize == KzWindowSize.expanded) {
      return ColoredBox(
        color: kz.bg,
        child: Row(
          children: [
            SafeArea(
              right: false,
              child: Padding(
                padding: const EdgeInsets.all(KzSpace.s20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: KzNavRail(
                    items: items,
                    currentIndex: shell.currentIndex,
                    onSelected: _go,
                  ),
                ),
              ),
            ),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeLeft: true,
                child: shell,
              ),
            ),
          ],
        ),
      );
    }

    return KzTabBar.floating(
      context: context,
      child: shell,
      bar: KzTabBar(
        items: items,
        currentIndex: shell.currentIndex,
        onSelected: _go,
      ),
    );
  }
}

/// Henüz kodlanmamış sekmeler için boş zemin. İlgili Figma ekranları
/// (Kaydettiklerim 56, Seyahatler 44, Sohbetler 61, Hesabım 65) kodlandıkça
/// kaldırılır.
class PendingTabScreen extends StatelessWidget {
  const PendingTabScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      ColoredBox(color: context.kz.bg, child: const SizedBox.expand());
}
