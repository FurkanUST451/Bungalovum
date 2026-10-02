import '../core/icons/kz_icons.dart';
import '../core/widgets/kz_tab_bar.dart';
import '../l10n/l10n.dart';

/// Ana sekmeler; sıra `StatefulShellRoute` dallarıyla aynıdır.
/// [unreadChats] > 0 ise Sohbetler sekmesinde rozet gösterilir.
List<KzTabItem> appTabs(AppLocalizations l, {int unreadChats = 0}) => [
  KzTabItem(icon: KzIcons.compass, label: l.tabExplore),
  KzTabItem(icon: KzIcons.heart, label: l.tabSaved),
  KzTabItem(icon: KzIcons.calendar, label: l.tabTrips),
  KzTabItem(
    icon: KzIcons.chat,
    label: l.tabChats,
    badge: unreadChats > 0 ? l.unreadCount(unreadChats) : null,
  ),
  KzTabItem(icon: KzIcons.user, label: l.tabAccount),
];
