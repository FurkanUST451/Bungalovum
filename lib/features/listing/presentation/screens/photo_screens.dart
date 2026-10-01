import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../l10n/l10n.dart';
import '../../../saved/presentation/widgets/save_listing_button.dart';
import '../../data/listing_repository.dart';
import '../../domain/listing_detail.dart';
import '../listing_detail_labels.dart';
import '../widgets/listing_sheets.dart';

/// Tüm odaların fotoğrafları sırayla (görüntüleyici indeksleri için).
List<(RoomKind, ListingPhoto)> _flatten(ListingDetail d) => [
  for (final r in d.photoRooms)
    for (final p in r.photos) (r.kind, p),
];

/// 21 · Fotoğraf Turu
class PhotoTourScreen extends ConsumerStatefulWidget {
  const PhotoTourScreen({super.key, required this.id});

  final String id;

  @override
  ConsumerState<PhotoTourScreen> createState() => _PhotoTourScreenState();
}

class _PhotoTourScreenState extends ConsumerState<PhotoTourScreen> {
  final _keys = <RoomKind, GlobalKey>{};
  RoomKind? _active;

  static const double _thumbW = 112;
  static const double _thumbH = 88;
  static const double _ring = 2.5;
  static const double _ringGap = 3;

  void _jump(RoomKind kind) {
    setState(() => _active = kind);
    final ctx = _keys[kind]?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: KzMotion.of(context, KzMotion.transition),
        curve: KzMotion.enter,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final detail = ref.watch(listingDetailProvider(widget.id)).value;
    final gutter = context.screenGutter;

    if (detail == null) {
      return Scaffold(
        backgroundColor: kz.bg,
        body: const SafeArea(child: KzSkeleton()),
      );
    }
    final listing = detail.listing;
    final flat = _flatten(detail);
    final active = _active ?? detail.photoRooms.first.kind;
    final firstIndex = flat.indexWhere((e) => e.$1 == active);

    return Scaffold(
      backgroundColor: kz.bg,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(gutter, KzSpace.s10, gutter, 0),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        KzNavButton(semanticLabel: l.back),
                        const SizedBox(width: KzSpace.s12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Semantics(
                                header: true,
                                child: Text(
                                  l.photoTour,
                                  style: KzText.titleLg.copyWith(color: kz.ink),
                                ),
                              ),
                              Text(
                                l.photoTourSubtitle(
                                  listing.title,
                                  listing.photoCount,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: KzText.caption.copyWith(color: kz.ink2),
                              ),
                            ],
                          ),
                        ),
                        KzCircleButton(
                          icon: KzIcons.share,
                          diameter: KzSize.backButton,
                          iconSize: KzSize.iconMd,
                          shadow: KzShadows.card,
                          semanticLabel: l.share,
                          onPressed: () => showShareSheet(context, listing),
                        ),
                        const SizedBox(width: KzSpace.s8),
                        SaveListingButton(listingId: listing.id),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.fromLTRB(
                      gutter,
                      KzSpace.s16,
                      gutter,
                      KzSpace.s8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final (i, room) in detail.photoRooms.indexed) ...[
                          if (i > 0) const SizedBox(width: KzSpace.s12),
                          _RoomTab(
                            room: room,
                            selected: room.kind == active,
                            onPressed: () => _jump(room.kind),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                for (final room in detail.photoRooms)
                  SliverPadding(
                    key: _keys.putIfAbsent(room.kind, GlobalKey.new),
                    padding: EdgeInsets.fromLTRB(
                      gutter,
                      KzSpace.s26,
                      gutter,
                      0,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: _RoomSection(
                        room: room,
                        onOpen: (p) => context.push(
                          AppRoutes.listingPhoto(
                            listing.id,
                            flat.indexWhere((e) => identical(e.$2, p)),
                          ),
                        ),
                      ),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height:
                        KzSize.button * 2 +
                        MediaQuery.paddingOf(context).bottom,
                  ),
                ),
              ],
            ),
            Positioned(
              left: gutter,
              right: gutter,
              bottom: KzSpace.s28 + MediaQuery.paddingOf(context).bottom,
              child: Center(
                child: Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    KzSpace.s18,
                    KzSpace.s8,
                    KzSpace.s8,
                    KzSpace.s8,
                  ),
                  decoration: BoxDecoration(
                    color: kz.ink,
                    borderRadius: KzRadii.all(KzRadii.pill),
                    boxShadow: KzShadows.strong,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              active.label(l),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: KzText.label.copyWith(color: kz.onForest),
                            ),
                            Text(
                              l.photoProgress(
                                firstIndex + 1,
                                listing.photoCount,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: KzText.micro.copyWith(
                                color: kz.forestSoft,
                                fontWeight: KzText.medium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: KzSpace.s14),
                      KzPressable(
                        onPressed: () => context.pop(),
                        semanticLabel: listing.instantBook
                            ? l.bookNow
                            : l.requestToBook,
                        child: Container(
                          height: KzSize.minTouch,
                          padding: const EdgeInsets.symmetric(
                            horizontal: KzSpace.s18,
                          ),
                          decoration: BoxDecoration(
                            color: kz.surface,
                            borderRadius: KzRadii.all(KzRadii.pill),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                listing.instantBook
                                    ? l.bookNow
                                    : l.requestToBook,
                                style: KzText.bodySm.copyWith(
                                  fontWeight: KzText.extraBold,
                                  color: kz.forest,
                                ),
                              ),
                              const SizedBox(width: KzSpace.s8),
                              KzIcon(
                                KzIcons.arrow,
                                size: KzSpace.s16,
                                color: kz.forest,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoomTab extends StatelessWidget {
  const _RoomTab({
    required this.room,
    required this.selected,
    required this.onPressed,
  });

  final PhotoRoom room;
  final bool selected;
  final VoidCallback onPressed;

  static const double _badge = 30;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return KzPressable(
      onPressed: onPressed,
      selected: selected,
      semanticLabel:
          '${room.kind.label(l)}, ${l.photoCountShort(room.photos.length)}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: KzMotion.of(context, KzMotion.micro),
            padding: const EdgeInsets.all(_PhotoTourScreenState._ringGap),
            decoration: BoxDecoration(
              borderRadius: KzRadii.all(KzRadii.card),
              border: Border.all(
                color: selected ? kz.forest : Colors.transparent,
                width: _PhotoTourScreenState._ring,
              ),
            ),
            child: ClipRRect(
              borderRadius: KzRadii.all(KzRadii.field),
              child: SizedBox(
                width: _PhotoTourScreenState._thumbW,
                height: _PhotoTourScreenState._thumbH,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    KzPhoto(url: room.photos.first.url),
                    Positioned(
                      left: KzSpace.s8,
                      bottom: KzSpace.s8,
                      child: Container(
                        width: _badge,
                        height: _badge,
                        decoration: BoxDecoration(
                          color: kz.surface,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: KzIcon(
                            room.kind.icon,
                            size: KzSpace.s16,
                            color: kz.ink,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: KzSpace.s8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KzSpace.s4),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: room.kind.label(l),
                    style: KzText.label.copyWith(
                      color: selected ? kz.ink : kz.ink2,
                      fontWeight: selected ? KzText.extraBold : KzText.semiBold,
                    ),
                  ),
                  TextSpan(
                    text: '  ${room.photos.length}',
                    style: KzText.captionSemi.copyWith(color: kz.ink2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomSection extends StatelessWidget {
  const _RoomSection({required this.room, required this.onOpen});

  final PhotoRoom room;
  final ValueChanged<ListingPhoto> onOpen;

  static const double _wide = 250;
  static const double _half = 170;
  static const double _tall = 348;

  Widget _photo(ListingPhoto p, double height) => SizedBox(
    height: height,
    child: Builder(
      builder: (context) => KzPressable(
        onPressed: () => onOpen(p),
        semanticLabel: p.caption,
        pressedScale: 1,
        child: ClipRRect(
          borderRadius: KzRadii.all(KzRadii.lg),
          child: KzPhoto(url: p.url),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final ps = room.photos;
    const gap = SizedBox.square(dimension: KzSpace.s8);
    // Figma düzenleri: geniş + iki yarım / uzun + iki küçük / iki uzun.
    final Widget grid = switch (ps.length) {
      1 => _photo(ps[0], _wide),
      2 => Row(
        children: [
          Expanded(child: _photo(ps[0], _wide)),
          gap,
          Expanded(child: _photo(ps[1], _wide)),
        ],
      ),
      _ when room.kind == RoomKind.bedroom || room.kind == RoomKind.outdoor =>
        Row(
          children: [
            Expanded(flex: 3, child: _photo(ps[0], _tall)),
            gap,
            Expanded(
              flex: 2,
              child: Column(
                children: [_photo(ps[1], _half), gap, _photo(ps[2], _half)],
              ),
            ),
          ],
        ),
      _ => Column(
        children: [
          _photo(ps[0], _wide),
          gap,
          Row(
            children: [
              Expanded(child: _photo(ps[1], _half)),
              gap,
              Expanded(child: _photo(ps[2], _half)),
            ],
          ),
        ],
      ),
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            KzIconBox(
              icon: room.kind.icon,
              tone: room.kind.tone,
              size: KzSpace.s36 + 2,
            ),
            const SizedBox(width: KzSpace.s10),
            Flexible(
              child: Semantics(
                header: true,
                child: Text(
                  room.kind.label(l),
                  style: KzText.h4.copyWith(color: kz.ink),
                ),
              ),
            ),
            const SizedBox(width: KzSpace.s10),
            KzChip(
              label: l.photoCountShort(ps.length),
              variant: KzChipVariant.soft,
              size: KzChipSize.mini,
            ),
          ],
        ),
        const SizedBox(height: KzSpace.s14),
        grid,
      ],
    );
  }
}

/// 22 · Fotoğraf Görüntüleyici
class PhotoViewerScreen extends ConsumerStatefulWidget {
  const PhotoViewerScreen({super.key, required this.id, required this.index});

  final String id;
  final int index;

  @override
  ConsumerState<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends ConsumerState<PhotoViewerScreen> {
  late final _pages = PageController(initialPage: widget.index);
  late int _index = widget.index;

  static const double _thumb = 56;
  static const double _glass = 0.14;
  static const double _photoRatio = 0.6;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final detail = ref.watch(listingDetailProvider(widget.id)).value;
    final gutter = context.screenGutter;
    final glass = kz.onForest.withValues(alpha: _glass);
    if (detail == null) {
      return Scaffold(backgroundColor: kz.ink);
    }
    final flat = _flatten(detail);
    final total = detail.listing.photoCount;
    final current = flat[_index.clamp(0, flat.length - 1)];

    return Scaffold(
      backgroundColor: kz.ink,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(gutter, KzSpace.s8, gutter, 0),
              child: Row(
                children: [
                  KzCircleButton(
                    icon: KzIcons.x,
                    diameter: KzSize.minTouch,
                    background: glass,
                    iconColor: kz.onForest,
                    semanticLabel: l.close,
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Semantics(
                      liveRegion: true,
                      child: Text(
                        l.photoCounter(_index + 1, total),
                        textAlign: TextAlign.center,
                        style: KzText.titleSm.copyWith(color: kz.onForest),
                      ),
                    ),
                  ),
                  KzCircleButton(
                    icon: KzIcons.share,
                    diameter: KzSize.minTouch,
                    background: glass,
                    iconColor: kz.onForest,
                    semanticLabel: l.share,
                    onPressed: () => showShareSheet(context, detail.listing),
                  ),
                  const SizedBox(width: KzSpace.s10),
                  SaveListingButton(
                    listingId: detail.listing.id,
                    background: glass,
                    shadow: const [],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: FractionallySizedBox(
                  heightFactor: _photoRatio / (1 - _photoRatio / 3),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      PageView.builder(
                        controller: _pages,
                        itemCount: flat.length,
                        onPageChanged: (i) => setState(() => _index = i),
                        itemBuilder: (_, i) => InteractiveViewer(
                          maxScale: 4,
                          child: KzPhoto(url: flat[i].$2.url),
                        ),
                      ),
                      Positioned(
                        bottom: KzSpace.s18,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ExcludeSemantics(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: KzSpace.s12,
                                vertical: KzSpace.s8,
                              ),
                              decoration: BoxDecoration(
                                color: kz.ink.withValues(alpha: _glass * 3),
                                borderRadius: KzRadii.all(KzRadii.pill),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  KzIcon(
                                    KzIcons.expand,
                                    size: KzSize.iconXs,
                                    color: kz.onForest,
                                  ),
                                  const SizedBox(width: KzSpace.s6),
                                  Flexible(
                                    child: Text(
                                      l.pinchToZoom,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: KzText.captionBold.copyWith(
                                        color: kz.onForest,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gutter),
              child: Semantics(
                liveRegion: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        current.$1.label(l),
                        style: KzText.title.copyWith(color: kz.onForest),
                      ),
                    ),
                    const SizedBox(height: KzSpace.s4),
                    Text(
                      current.$2.caption,
                      style: KzText.labelMedium.copyWith(color: kz.forestSoft),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: KzSpace.s14),
            SizedBox(
              height: _thumb,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: gutter),
                itemCount: flat.length,
                separatorBuilder: (_, _) => const SizedBox(width: KzSpace.s8),
                itemBuilder: (_, i) => KzPressable(
                  onPressed: () => _pages.animateToPage(
                    i,
                    duration: KzMotion.of(context, KzMotion.transition),
                    curve: KzMotion.enter,
                  ),
                  semanticLabel: l.photoOf(i + 1, total),
                  selected: i == _index,
                  minTouchSize: _thumb,
                  child: Container(
                    width: _thumb,
                    height: _thumb,
                    decoration: BoxDecoration(
                      borderRadius: KzRadii.all(KzRadii.md),
                      border: i == _index
                          ? Border.all(
                              color: kz.onForest,
                              width: KzSize.borderFocus,
                            )
                          : null,
                    ),
                    child: ClipRRect(
                      borderRadius: KzRadii.all(KzRadii.md),
                      child: KzPhoto(url: flat[i].$2.url),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: KzSpace.s16),
          ],
        ),
      ),
    );
  }
}
