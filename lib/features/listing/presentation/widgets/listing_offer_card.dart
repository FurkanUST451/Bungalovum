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
import '../../../booking/domain/price_calculator.dart';
import '../../../saved/presentation/widgets/save_listing_button.dart';
import '../../domain/listing.dart';
import '../../domain/listing_offer.dart';
import 'rating_label.dart';

enum PhotoIndicator { counter, dots }

/// Geniş ilan kartı: kaydırılabilir fotoğraf + başlık, alt satır, toplam
/// fiyat (indirim varsa indirimsiz fiyat üstü çizili). Keşfet, Arama
/// Sonuçları ve listelerde kullanılır.
class ListingOfferCard extends StatefulWidget {
  const ListingOfferCard({
    super.key,
    required this.offer,
    required this.subtitle,
    required this.onOpen,
    required this.heroPrefix,
    this.photoAspect = weekendAspect,
    this.indicator = PhotoIndicator.counter,
  });

  final ListingOffer offer;
  final String subtitle;
  final VoidCallback onOpen;

  /// Aynı ilan birden çok listede olabilir; Hero etiketi buna göre ayrışır.
  final String heroPrefix;
  final double photoAspect;
  final PhotoIndicator indicator;

  /// Figma: Keşfet 350×300, Arama Sonuçları 350×280.
  static const double weekendAspect = 350 / 300;
  static const double resultAspect = 350 / 280;

  static String heroTag(String prefix, String id) => '$prefix/$id';

  @override
  State<ListingOfferCard> createState() => _ListingOfferCardState();
}

class _ListingOfferCardState extends State<ListingOfferCard> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final listing = widget.offer.listing;
    final price = widget.offer.price;
    final total = KzFormat.currency(PriceCalculator.total(price));
    final original = KzFormat.currency(PriceCalculator.subtotal(price));
    final discounted = PriceCalculator.hasDiscount(price);
    final photos = listing.photoUrls;
    final nightsLeft = widget.offer.nightsLeft;
    final badge = nightsLeft != null
        ? l.badgeNightsLeft(nightsLeft)
        : listing.badge == ListingBadge.rareFind
        ? l.badgeRareFind
        : null;
    const touchOffset = (KzSize.minTouch - KzSize.circleSm) / 2;

    return KzPressable(
      onPressed: widget.onOpen,
      excludeChildSemantics: false,
      semanticLabel: [
        listing.title,
        widget.subtitle,
        discounted
            ? l.listingDiscountSemantics(price.nights, total, original)
            : l.listingTotalSemantics(price.nights, total),
        if (listing.rating != null)
          l.listingRating(KzFormat.rating(listing.rating!)),
      ].join(', '),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: widget.photoAspect,
            child: ClipRRect(
              borderRadius: KzRadii.all(KzRadii.hero),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: ListingOfferCard.heroTag(
                      widget.heroPrefix,
                      listing.id,
                    ),
                    child: photos.length > 1
                        ? PageView.builder(
                            itemCount: photos.length,
                            onPageChanged: (i) => setState(() => _page = i),
                            itemBuilder: (_, i) => KzPhoto(url: photos[i]),
                          )
                        : KzPhoto(url: photos.isEmpty ? null : photos.first),
                  ),
                  if (badge != null)
                    PositionedDirectional(
                      top: KzSpace.s14,
                      start: KzSpace.s14,
                      end: KzSize.circleSm + KzSpace.s14 * 2,
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: KzChip(
                          label: badge,
                          variant: KzChipVariant.highlight,
                          size: KzChipSize.small,
                          icon: KzIcons.sparklesFilled,
                          iconColor: kz.onForest,
                        ),
                      ),
                    ),
                  PositionedDirectional(
                    top: KzSpace.s14 - touchOffset,
                    end: KzSpace.s14 - touchOffset,
                    child: SaveListingButton(listingId: listing.id),
                  ),
                  if (widget.indicator == PhotoIndicator.counter)
                    PositionedDirectional(
                      end: KzSpace.s14,
                      bottom: KzSpace.s12,
                      child: Semantics(
                        label: l.photoOf(_page + 1, listing.photoCount),
                        child: ExcludeSemantics(
                          child: KzChip(
                            label: l.photoCounter(
                              _page + 1,
                              listing.photoCount,
                            ),
                            variant: KzChipVariant.dark,
                            size: KzChipSize.mini,
                          ),
                        ),
                      ),
                    )
                  else
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: KzSpace.s18,
                      child: Center(
                        child: KzPageDots(
                          count: listing.photoCount,
                          index: _page,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: KzSpace.s12),
          ExcludeSemantics(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: KzSpace.s6),
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
                  const SizedBox(height: KzSpace.s5),
                  Text(
                    widget.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.labelMedium.copyWith(color: kz.ink2),
                  ),
                  const SizedBox(height: KzSpace.s5),
                  PriceTotalLine(price: price),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "₺14.964 ₺10.800 · 2 gece toplam"
class PriceTotalLine extends StatelessWidget {
  const PriceTotalLine({super.key, required this.price});

  final PriceBreakdown price;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return Text.rich(
      TextSpan(
        children: [
          if (PriceCalculator.hasDiscount(price)) ...[
            TextSpan(
              text: KzFormat.currency(PriceCalculator.subtotal(price)),
              style: KzText.bodySm.copyWith(
                fontWeight: KzText.semiBold,
                color: kz.ink2,
                decoration: TextDecoration.lineThrough,
                decorationColor: kz.ink2,
              ),
            ),
            const TextSpan(text: '  '),
          ],
          TextSpan(
            text: KzFormat.currency(PriceCalculator.total(price)),
            style: KzText.bodyStrong.copyWith(
              fontWeight: KzText.extraBold,
              color: kz.forest,
            ),
          ),
          const TextSpan(text: '  '),
          TextSpan(
            text: l.listingNightsTotal(price.nights),
            style: KzText.labelMedium.copyWith(color: kz.ink2),
          ),
        ],
      ),
    );
  }
}

/// Geniş kartın yüklenme iskeleti.
class ListingOfferCardSkeleton extends StatelessWidget {
  const ListingOfferCardSkeleton({
    super.key,
    this.photoAspect = ListingOfferCard.weekendAspect,
  });

  final double photoAspect;

  static const double _titleWidthFactor = 0.6;
  static const double _lineWidthFactor = 0.45;

  @override
  Widget build(BuildContext context) {
    final r = KzRadii.all(KzRadii.xs);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: photoAspect,
          child: KzSkeleton(borderRadius: KzRadii.all(KzRadii.hero)),
        ),
        const SizedBox(height: KzSpace.s12),
        FractionallySizedBox(
          widthFactor: _titleWidthFactor,
          child: KzSkeleton(height: KzSpace.s18, borderRadius: r),
        ),
        const SizedBox(height: KzSpace.s8),
        FractionallySizedBox(
          widthFactor: _lineWidthFactor,
          child: KzSkeleton(height: KzSpace.s14, borderRadius: r),
        ),
      ],
    );
  }
}
