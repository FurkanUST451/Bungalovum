import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/adaptive_layout.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/clock.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../../../../core/widgets/kz_tab_bar.dart';
import '../../../../l10n/l10n.dart';
import '../../../explore/presentation/widgets/explore_message.dart';
import '../../../saved/presentation/controllers/saved_listings_controller.dart';
import '../../domain/chat_models.dart';
import '../chat_labels.dart';
import '../controllers/chat_controllers.dart';

enum _Filter { all, stay, support }

/// 61 · Sohbetler (boş) ve 62 · Sohbetler (dolu).
class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  _Filter _filter = _Filter.all;
  bool _searching = false;
  final _query = TextEditingController();

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  bool _matches(Conversation c) {
    final f = switch (_filter) {
      _Filter.all => true,
      _Filter.stay => !c.isSupport,
      _Filter.support => c.isSupport,
    };
    final q = _query.text.trim().toLowerCase();
    return f && (q.isEmpty || c.title.toLowerCase().contains(q));
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final conversations = ref.watch(conversationsProvider);
    final now = ref.watch(clockProvider)();
    final size = context.windowSize;
    final bottomSpace = size == KzWindowSize.expanded
        ? KzSpace.xl
        : KzTabBar.reservedHeight(context) + KzSpace.s20;
    final all = conversations.value;
    final shown = all?.where(_matches).toList();

    return ColoredBox(
      color: kz.bg,
      child: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: kz.forest,
          backgroundColor: kz.surface,
          onRefresh: () => ref.read(conversationsProvider.notifier).refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              context.screenGutter,
              KzSpace.s14,
              context.screenGutter,
              bottomSpace,
            ),
            child: KzMaxWidth(
              maxWidth: KzBreakpoints.mediumContent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Semantics(
                          header: true,
                          child: Text(
                            l.chatsTitle,
                            style: KzText.h1.copyWith(color: kz.ink),
                          ),
                        ),
                      ),
                      KzCircleButton(
                        icon: _searching ? KzIcons.x : KzIcons.search,
                        diameter: KzSize.backButton,
                        iconSize: KzSize.iconMd,
                        shadow: KzShadows.card,
                        semanticLabel: _searching ? l.close : l.searchChats,
                        onPressed: () => setState(() {
                          _searching = !_searching;
                          if (!_searching) _query.clear();
                        }),
                      ),
                    ],
                  ),
                  if (_searching) ...[
                    const SizedBox(height: KzSpace.s14),
                    KzInput(
                      label: l.searchChats,
                      icon: KzIcons.search,
                      hint: l.searchChatsHint,
                      controller: _query,
                      textInputAction: TextInputAction.search,
                      onChanged: (_) => setState(() {}),
                    ),
                  ],
                  const SizedBox(height: KzSpace.s14),
                  Wrap(
                    spacing: KzSpace.s8,
                    runSpacing: KzSpace.s8,
                    children: [
                      for (final (f, label) in [
                        (_Filter.all, l.chatFilterAll),
                        (_Filter.stay, l.chatFilterStay),
                        (_Filter.support, l.chatFilterSupport),
                      ])
                        Semantics(
                          inMutuallyExclusiveGroup: true,
                          checked: f == _filter,
                          child: KzChip(
                            label: label,
                            variant: f == _filter
                                ? KzChipVariant.filled
                                : KzChipVariant.outline,
                            onPressed: () => setState(() => _filter = f),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: KzSpace.s12),
                  switch (conversations) {
                    AsyncData() when all!.isEmpty => _Empty(
                      onExplore: () => context.go(AppRoutes.explore),
                    ),
                    AsyncData() when shown!.isEmpty => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: KzSpace.s32,
                      ),
                      child: Text(
                        l.chatsNoMatch,
                        textAlign: TextAlign.center,
                        style: KzText.bodySm.copyWith(color: kz.ink2),
                      ),
                    ),
                    AsyncData() => Column(
                      children: [
                        for (final c in shown!) ...[
                          _ConversationTile(conversation: c, now: now),
                          const SizedBox(height: KzSpace.s6),
                        ],
                      ],
                    ),
                    AsyncError() => ExploreMessage(
                      title: l.loadErrorTitle,
                      body: l.exploreErrorBody,
                      actionLabel: l.retry,
                      onAction: () => ref.invalidate(conversationsProvider),
                    ),
                    _ => Column(
                      children: [
                        for (var i = 0; i < 3; i++) ...[
                          KzSkeleton(
                            height: KzSize.tile + KzSpace.s20,
                            borderRadius: KzRadii.all(KzRadii.card),
                          ),
                          const SizedBox(height: KzSpace.s6),
                        ],
                      ],
                    ),
                  },
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ConversationTile extends ConsumerWidget {
  const _ConversationTile({required this.conversation, required this.now});

  final Conversation conversation;
  final DateTime now;

  static const double _badge = 22;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final c = conversation;
    final unread = c.unread > 0;
    final listing = c.listingId == null
        ? null
        : ref.watch(listingSummaryProvider(c.listingId!)).value;
    final context0 = c.isSupport
        ? l.supportTicket(c.ticketNo ?? '')
        : listing == null
        ? ''
        : c.kind == ConversationKind.request
        ? l.chatContextRequest(listing.title)
        : listing.title;
    final preview = c.lastMessage.isEmpty
        ? ''
        : c.lastFromMe
        ? l.youPrefix(c.lastMessage)
        : c.lastMessage;
    final time = chatListTime(l, c.lastAt, now);

    return KzPressable(
      onPressed: () => context.push(AppRoutes.chat(c.id)),
      semanticLabel: [
        c.title,
        context0,
        preview,
        time,
        if (unread) l.unreadCount(c.unread),
      ].where((s) => s.isNotEmpty).join(', '),
      pressedScale: 1,
      child: Container(
        padding: const EdgeInsets.all(KzSpace.s14),
        decoration: BoxDecoration(
          color: unread ? kz.surface : null,
          borderRadius: KzRadii.all(KzRadii.card),
          border: unread ? Border.all(color: kz.line) : null,
        ),
        child: Row(
          children: [
            ChatAvatar(conversation: c),
            const SizedBox(width: KzSpace.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          c.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: KzText.titleSm.copyWith(color: kz.ink),
                        ),
                      ),
                      const SizedBox(width: KzSpace.s8),
                      Text(
                        time,
                        style: KzText.microTight.copyWith(
                          color: kz.ink2,
                          fontWeight: KzText.semiBold,
                        ),
                      ),
                    ],
                  ),
                  if (context0.isNotEmpty) ...[
                    const SizedBox(height: KzSpace.s2),
                    Text(
                      context0,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: KzText.captionSemi.copyWith(color: kz.forest),
                    ),
                  ],
                  if (preview.isNotEmpty) ...[
                    const SizedBox(height: KzSpace.s2),
                    Text(
                      preview,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: unread
                          ? KzText.label.copyWith(color: kz.ink)
                          : KzText.labelMedium.copyWith(color: kz.ink2),
                    ),
                  ],
                ],
              ),
            ),
            if (unread) ...[
              const SizedBox(width: KzSpace.s10),
              Container(
                width: _badge,
                height: _badge,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kz.forest,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${c.unread}',
                  style: KzText.microTight.copyWith(
                    color: kz.onForest,
                    fontWeight: KzText.extraBold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KzSpace.s16,
        vertical: KzSpace.s36,
      ),
      child: Column(
        children: [
          const KzSpotIllustration(
            icon: KzIcons.chat,
            dot: KzSpotDot.pool,
            large: true,
          ),
          const SizedBox(height: KzSpace.s16),
          Semantics(
            header: true,
            child: Text(
              l.chatsEmptyTitle,
              textAlign: TextAlign.center,
              style: KzText.h4.copyWith(color: kz.ink),
            ),
          ),
          const SizedBox(height: KzSpace.s10),
          Text(
            l.chatsEmptyBody,
            textAlign: TextAlign.center,
            style: KzText.bodySm.copyWith(
              color: kz.ink2,
              height: KzText.body.height,
            ),
          ),
          const SizedBox(height: KzSpace.s20),
          KzButton(
            label: l.exploreBungalows,
            trailingArrow: true,
            expand: false,
            onPressed: onExplore,
          ),
        ],
      ),
    );
  }
}
