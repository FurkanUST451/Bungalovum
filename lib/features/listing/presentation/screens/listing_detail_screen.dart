import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_avatar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_map_backdrop.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/domain/price_calculator.dart';
import '../../../booking/presentation/controllers/booking_draft.dart';
import '../../../booking/presentation/screens/date_picker_screen.dart';
import '../../../explore/presentation/widgets/explore_message.dart';
import '../../../saved/data/wishlist_repository.dart';
import '../../../saved/presentation/widgets/save_listing_button.dart';
import '../../data/listing_repository.dart';
import '../../domain/listing.dart';
import '../../domain/listing_detail.dart';
import '../listing_detail_labels.dart';
import '../listing_labels.dart';
import '../widgets/listing_sheets.dart';
import '../widgets/rating_label.dart';

part 'listing_detail_sections.dart';

/// 19 · İlan Detayı
class ListingDetailScreen extends ConsumerStatefulWidget {
  const ListingDetailScreen({super.key, required this.id});

  final String id;

  /// Figma: kapak 500 yükseklik, içerik sayfası üstüne 36 biner.
  static const double heroMax = 500;
  static const double heroRatio = 0.59;
  static const double overlap = KzRadii.xl;

  /// Tablette yandaki rezervasyon kartının genişliği.
  static const double sideCardWidth = 360;

  @override
  ConsumerState<ListingDetailScreen> createState() =>
      _ListingDetailScreenState();
}

class _ListingDetailScreenState extends ConsumerState<ListingDetailScreen> {
  int _photo = 0;

  @override
  void initState() {
    super.initState();
    // Son baktıkların (60) listesine eklenir.
    ref.read(wishlistRepositoryProvider).markViewed(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final detail = ref.watch(listingDetailProvider(widget.id));
    final expanded = context.windowSize == KzWindowSize.expanded;

    return Scaffold(
      backgroundColor: kz.bg,
      body: switch (detail) {
        AsyncData(:final value) =>
          expanded
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _content(value, floatingBar: false)),
                    SafeArea(
                      left: false,
                      child: Padding(
                        padding: const EdgeInsets.all(KzSpace.s24),
                        child: SizedBox(
                          width: ListingDetailScreen.sideCardWidth,
                          child: _BookingBar(detail: value, docked: true),
                        ),
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    _content(value, floatingBar: true),
                    Positioned(
                      left: KzSpace.s16,
                      right: KzSpace.s16,
                      bottom:
                          KzSpace.s24 + MediaQuery.paddingOf(context).bottom,
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: KzBreakpoints.mediumContent,
                          ),
                          child: _BookingBar(detail: value, docked: false),
                        ),
                      ),
                    ),
                  ],
                ),
        AsyncError() => SafeArea(
          child: Padding(
            padding: EdgeInsets.all(context.screenGutter),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: KzNavButton(semanticLabel: l.back),
                ),
                ExploreMessage(
                  title: l.exploreErrorTitle,
                  body: l.exploreErrorBody,
                  actionLabel: l.retry,
                  onAction: () =>
                      ref.invalidate(listingDetailProvider(widget.id)),
                ),
              ],
            ),
          ),
        ),
        _ => const _DetailSkeleton(),
      },
    );
  }

  Widget _content(ListingDetail d, {required bool floatingBar}) {
    final kz = context.kz;
    final size = MediaQuery.sizeOf(context);
    final hero = (size.height * ListingDetailScreen.heroRatio).clamp(
      KzSize.input * 4,
      ListingDetailScreen.heroMax,
    );
    final gutter = context.screenGutter + KzSpace.s4;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: hero,
            child: _Hero(
              detail: d,
              page: _photo,
              onPage: (i) => setState(() => _photo = i),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Transform.translate(
            offset: const Offset(0, -ListingDetailScreen.overlap),
            child: Container(
              decoration: BoxDecoration(
                color: kz.bg,
                borderRadius: KzRadii.top(KzRadii.xl),
              ),
              padding: EdgeInsets.fromLTRB(gutter, KzSpace.s28, gutter, 0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: KzBreakpoints.formContent,
                  ),
                  child: _Sections(detail: d),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: floatingBar
                ? _BookingBar.reservedHeight +
                      MediaQuery.paddingOf(context).bottom
                : KzSpace.s32,
          ),
        ),
      ],
    );
  }
}

/// Kapak fotoğrafı + üst butonlar + "Fotoğraf turu" ve sayaç.
class _Hero extends StatelessWidget {
  const _Hero({required this.detail, required this.page, required this.onPage});

  final ListingDetail detail;
  final int page;
  final ValueChanged<int> onPage;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final listing = detail.listing;
    final top = MediaQuery.paddingOf(context).top + KzSpace.s8;
    final gutter = context.screenGutter;
    final photos = listing.photoUrls;
    final count = photos.isEmpty ? 1 : photos.length;
    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: 'listing/${listing.id}',
          child: PageView.builder(
            itemCount: count,
            onPageChanged: onPage,
            itemBuilder: (context, i) => KzPressable(
              onPressed: () =>
                  context.push(AppRoutes.listingPhoto(listing.id, i)),
              semanticLabel: l.photoOf(i + 1, listing.photoCount),
              pressedScale: 1,
              child: KzPhoto(url: photos.isEmpty ? null : photos[i]),
            ),
          ),
        ),
        Positioned(
          top: top,
          left: gutter,
          right: gutter,
          child: Row(
            children: [
              KzNavButton(semanticLabel: l.back),
              const Spacer(),
              KzCircleButton(
                icon: KzIcons.share,
                diameter: KzSize.backButton,
                iconSize: KzSize.iconMd,
                shadow: KzShadows.raised,
                semanticLabel: l.share,
                onPressed: () => showShareSheet(context, listing),
              ),
              const SizedBox(width: KzSpace.s10),
              SaveListingButton(listingId: listing.id),
            ],
          ),
        ),
        Positioned(
          left: gutter,
          right: gutter,
          bottom: ListingDetailScreen.overlap + KzSpace.s18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: KzChip(
                  label: l.photoTour,
                  variant: KzChipVariant.onImage,
                  icon: KzIcons.grid,
                  onPressed: () =>
                      context.push(AppRoutes.listingPhotos(listing.id)),
                ),
              ),
              const SizedBox(width: KzSpace.s8),
              KzChip(
                label: l.photoCounter(page + 1, listing.photoCount),
                variant: KzChipVariant.dark,
                size: KzChipSize.small,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Alttaki rezervasyon barı (telefon) ya da yandaki sabit kart (tablet).
class _BookingBar extends ConsumerWidget {
  const _BookingBar({required this.detail, required this.docked});

  final ListingDetail detail;
  final bool docked;

  /// Bar yüksekliği + alt boşluk (içerik bunun altında kalmasın).
  static const double reservedHeight = 190;

  Future<void> _pickDates(BuildContext context, WidgetRef ref) async {
    final draft = ref.read(bookingDraftControllerProvider(detail.listing.id));
    final r = await context.push<DatePickerResult>(
      AppRoutes.dates,
      extra: DatePickerArgs(initial: draft.dates, listingId: detail.listing.id),
    );
    if (r != null) {
      ref
          .read(bookingDraftControllerProvider(detail.listing.id).notifier)
          .setDates(r.dates);
    }
  }

  Future<void> _book(BuildContext context, WidgetRef ref) async {
    final id = detail.listing.id;
    if (ref.read(bookingDraftControllerProvider(id)).dates == null) {
      await _pickDates(context, ref);
      if (!context.mounted) return;
      if (ref.read(bookingDraftControllerProvider(id)).dates == null) return;
    }
    if (!context.mounted) return;
    context.push(
      detail.listing.instantBook
          ? AppRoutes.bookingConfirm(id)
          : AppRoutes.bookingRequest(id),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final listing = detail.listing;
    final draft = ref.watch(bookingDraftControllerProvider(listing.id));
    final quote = ref.watch(bookingQuoteProvider(listing.id)).value;
    final dates = draft.dates;

    return Container(
      padding: const EdgeInsets.all(KzSpace.s10),
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.all(KzRadii.hero),
        boxShadow: KzShadows.strong,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (listing.badge == ListingBadge.rareFind) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: KzSpace.s12,
                vertical: KzSpace.s8,
              ),
              decoration: BoxDecoration(
                color: kz.apricotSoft,
                borderRadius: KzRadii.all(KzRadii.md),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KzIcon(
                    KzIcons.sparklesFilled,
                    size: KzSize.iconXs,
                    color: kz.apricot,
                  ),
                  const SizedBox(width: KzSpace.s8),
                  Flexible(
                    child: Text(
                      l.rareFindBanner,
                      style: KzText.captionBold.copyWith(color: kz.apricotText),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: KzSpace.s10),
          ],
          Row(
            children: [
              const SizedBox(width: KzSpace.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (quote == null)
                      KzSkeleton(
                        width: KzSize.tile * 2,
                        height: KzSpace.s20,
                        borderRadius: KzRadii.all(KzRadii.xs),
                      )
                    else
                      Text.rich(
                        TextSpan(
                          children: [
                            if (PriceCalculator.hasDiscount(quote)) ...[
                              TextSpan(
                                text: KzFormat.currency(
                                  PriceCalculator.subtotal(quote),
                                ),
                                style: KzText.labelSemi.copyWith(
                                  color: kz.ink2,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: kz.ink2,
                                ),
                              ),
                              const TextSpan(text: '  '),
                            ],
                            TextSpan(
                              text: KzFormat.currency(
                                PriceCalculator.total(quote),
                              ),
                              style: KzText.h4.copyWith(
                                color: kz.ink,
                                fontSize: KzSpace.s20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    KzLink(
                      label: dates == null
                          ? l.addDatesForPrice
                          : l.nightsAndDates(
                              dates.nights,
                              KzFormat.dateRange(dates.checkIn, dates.checkOut),
                            ),
                      style: KzText.captionSemi.copyWith(color: kz.ink2),
                      onPressed: () => _pickDates(context, ref),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: KzButton(
                  label: listing.instantBook ? l.bookNow : l.requestToBook,
                  trailingArrow: true,
                  expand: false,
                  onPressed: () => _book(context, ref),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailSkeleton extends StatelessWidget {
  const _DetailSkeleton();

  @override
  Widget build(BuildContext context) {
    final gutter = context.screenGutter;
    final r = KzRadii.all(KzRadii.xs);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(flex: 5, child: KzSkeleton()),
        Padding(
          padding: EdgeInsets.all(gutter),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KzSkeleton(
                width: KzSize.tile * 3,
                height: KzSpace.s24,
                borderRadius: r,
              ),
              const SizedBox(height: KzSpace.s12),
              KzSkeleton(
                width: KzSize.tile * 4,
                height: KzSpace.s32,
                borderRadius: r,
              ),
              const SizedBox(height: KzSpace.s12),
              KzSkeleton(
                width: KzSize.tile * 2,
                height: KzSpace.s16,
                borderRadius: r,
              ),
            ],
          ),
        ),
        const Spacer(flex: 4),
      ],
    );
  }
}
