import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/responsive/breakpoints.dart';
import '../core/theme/tokens.dart';
import '../core/widgets/kz_tab_bar.dart';
import '../l10n/l10n.dart';
import '../features/chat/presentation/controllers/chat_controllers.dart';
import 'app_tabs.dart';

/// Sekmeli kabuk: telefonda yüzen tab bar, tablette (expanded) sol rail.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  void _go(int index) =>
      shell.goBranch(index, initialLocation: index == shell.currentIndex);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = appTabs(
      context.l10n,
      unreadChats: ref.watch(unreadChatsProvider),
    );
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
