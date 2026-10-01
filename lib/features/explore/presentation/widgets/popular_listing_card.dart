import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_page_dots.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../l10n/l10n.dart';
import '../../../listing/domain/listing.dart';
import '../../../listing/presentation/listing_labels.dart';
import '../../../saved/presentation/widgets/save_listing_button.dart';
import '../../../listing/presentation/widgets/rating_label.dart';

/// "En sevilenler" yatay karuseli.
class PopularCarousel extends StatelessWidget {
  const PopularCarousel({
    super.key,
    required this.listings,
    required this.inset,
    required this.onOpen,
  });

  /// null iken iskelet kartlar gösterilir.
  final List<Listing>? listings;
  final double inset;
  final ValueChanged<Listing> onOpen;

  /// Figma kartı 300×420.
  static const double maxCardWidth = 300;
  static const double cardAspect = 300 / 420;

  /// Telefonda bir sonraki kartın kenarı görünsün diye kart, içerik
  /// genişliğinin bu oranını aşmaz.
  static const double _peekRatio = 0.86;
  static const int _skeletonCount = 3;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final content = constraints.maxWidth - inset * 2;
        final width = math.min(maxCardWidth, content * _peekRatio);
        final height = width / cardAspect;
        final items = listings;
        return SizedBox(
          height: height + KzSpace.s10,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            padding: EdgeInsets.only(
              left: inset,
              right: inset,
              bottom: KzSpace.s10,
            ),
            itemCount: items?.length ?? _skeletonCount,
            separatorBuilder: (_, _) => const SizedBox(width: KzSpace.s14),
            itemBuilder: (context, i) => SizedBox(
              width: width,
              child: items == null
                  ? KzSkeleton(borderRadius: KzRadii.all(KzRadii.hero))
                  : PopularListingCard(
                      listing: items[i],
                      onOpen: () => onOpen(items[i]),
                    ),
            ),
          ),
        );
      },
    );
  }
}

/// Tam fotoğraflı dikey kart; bilgiler alttaki beyaz panelde.
class PopularListingCard extends StatelessWidget {
  const PopularListingCard({
    super.key,
    required this.listing,
    required this.onOpen,
  });

  final Listing listing;
  final VoidCallback onOpen;

  static String heroTag(String id) => 'popular/$id';

  /// Sayfa noktalarının bilgi panelinin üstündeki mesafesi.
  static const double _dotsGap = 34;
  static const int _maxAmenityChips = 2;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final photo = listing.photoUrls.isEmpty ? null : listing.photoUrls.first;

    return KzPressable(
      onPressed: onOpen,
      excludeChildSemantics: false,
      semanticLabel: [
        listing.title,
        listing.summary(l),
        l.listingNightlySemantics(KzFormat.currency(listing.nightlyPrice)),
        if (listing.rating != null)
          l.listingRating(KzFormat.rating(listing.rating!)),
      ].join(', '),
      child: ClipRRect(
        borderRadius: KzRadii.all(KzRadii.hero),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: heroTag(listing.id),
              child: KzPhoto(url: photo),
            ),
            PositionedDirectional(
              top: KzSpace.s14,
              start: KzSpace.s14,
              end: KzSize.circleSm + KzSpace.s14 * 2,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: listing.badge == ListingBadge.guestFavorite
                    ? KzChip(
                        label: l.badgeGuestFavorite,
                        variant: KzChipVariant.onImage,
                        size: KzChipSize.small,
                        icon: KzIcons.award,
                        iconColor: kz.apricotText,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            PositionedDirectional(
              // Görsel buton 40, dokunma alanı 44: farkın yarısı kadar dışa.
              top: KzSpace.s14 - (KzSize.minTouch - KzSize.circleSm) / 2,
              end: KzSpace.s14 - (KzSize.minTouch - KzSize.circleSm) / 2,
              child: SaveListingButton(listingId: listing.id),
            ),
            Positioned(
              left: KzSpace.s12,
              right: KzSpace.s12,
              bottom: KzSpace.s12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  KzPageDots(count: listing.photoCount, index: 0),
                  const SizedBox(height: _dotsGap),
                  _InfoPanel(listing: listing, maxChips: _maxAmenityChips),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  const _InfoPanel({required this.listing, required this.maxChips});

  final Listing listing;
  final int maxChips;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return ExcludeSemantics(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          KzSpace.s16,
          KzSpace.s14,
          KzSpace.s16,
          KzSpace.s16,
        ),
        decoration: BoxDecoration(
          color: kz.surface,
          borderRadius: KzRadii.all(KzRadii.card),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    listing.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.title.copyWith(color: kz.ink),
                  ),
                ),
                if (listing.rating != null) ...[
                  const SizedBox(width: KzSpace.s8),
                  RatingLabel(rating: listing.rating!),
                ],
              ],
            ),
            const SizedBox(height: KzSpace.s8),
            Text(
              listing.summary(l),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: KzText.caption.copyWith(color: kz.ink2),
            ),
            const SizedBox(height: KzSpace.s8),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: KzSpace.s8,
              runSpacing: KzSpace.s6,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: KzFormat.currency(listing.nightlyPrice),
                        style: KzText.title.copyWith(color: kz.forest),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: l.listingPerNight,
                        style: KzText.captionSemi.copyWith(color: kz.ink2),
                      ),
                    ],
                  ),
                ),
                Wrap(
                  spacing: KzSpace.s4,
                  runSpacing: KzSpace.s4,
                  children: [
                    for (final a
                        in listing.amenities
                            .where((a) => a.isFeatured)
                            .take(maxChips))
                      KzChip(
                        label: a.label(l),
                        variant: a.chipVariant,
                        size: KzChipSize.mini,
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
