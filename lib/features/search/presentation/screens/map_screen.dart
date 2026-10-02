import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../status/presentation/screens/status_screens.dart';
import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_map_backdrop.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/domain/price_calculator.dart';
import '../../../listing/domain/listing.dart';
import '../../../listing/domain/listing_offer.dart';
import '../../../listing/presentation/listing_labels.dart';
import '../../../saved/presentation/widgets/save_listing_button.dart';
import '../controllers/search_controller.dart';
import '../widgets/search_header.dart';
import 'results_screen.dart';

/// 17 · Harita Görünümü.
///
/// Harita SDK'sı (ör. google_maps_flutter) henüz eklenmedi — paket onayı
/// bekliyor. O zamana kadar [KzMapBackdrop] sade bir zemin çizer ve pinler
/// gerçek enlem/boylamdan bu zemine yansıtılır.
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  String? _selectedId;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final offers = ref.watch(searchResultsProvider).value ?? const [];
    final nights = ref.watch(searchQueryControllerProvider).nights;
    final selected =
        offers.where((o) => o.listing.id == _selectedId).firstOrNull ??
        offers.firstOrNull;
    final gutter = context.screenGutter;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: kz.bg,
      body: Stack(
        children: [
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, c) => _PinLayer(
                size: c.biggest,
                offers: offers,
                selectedId: selected?.listing.id,
                onSelect: (id) => setState(() => _selectedId = id),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: gutter),
              child: Column(
                children: [
                  const SearchHeader(),
                  KzChip(
                    label: l.mapPriceNote(nights),
                    variant: KzChipVariant.onImage,
                    size: KzChipSize.small,
                    icon: KzIcons.info,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: gutter,
            right: gutter,
            bottom: bottomInset + KzSpace.s24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: KzCircleButton(
                    icon: KzIcons.nav,
                    diameter: KzSize.circleMd,
                    iconSize: KzSize.iconMd,
                    shadow: KzShadows.raised,
                    semanticLabel: l.mapMyLocation,
                    // Konum alınınca harita ortalanır (harita SDK'sıyla).
                    onPressed: () => ensureLocationPermission(context, ref),
                  ),
                ),
                const SizedBox(height: KzSpace.s32),
                if (selected != null)
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: KzBreakpoints.mediumContent,
                      ),
                      child: _SelectedCard(offer: selected),
                    ),
                  ),
                const SizedBox(height: KzSpace.s32),
                Center(
                  child: FloatingPill(
                    icon: KzIcons.list,
                    label: l.resultsList,
                    onPressed: () => context.pushReplacement(AppRoutes.results),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PinLayer extends StatelessWidget {
  const _PinLayer({
    required this.size,
    required this.offers,
    required this.selectedId,
    required this.onSelect,
  });

  final Size size;
  final List<ListingOffer> offers;
  final String? selectedId;
  final ValueChanged<String> onSelect;

  /// Pinlerin kenarlardan ve üst/alt panellerden uzak durduğu alan.
  static const double _sidePad = 0.12;
  static const double _topPad = 0.28;
  static const double _bottomPad = 0.42;

  @override
  Widget build(BuildContext context) {
    final backdrop = KzMapBackdrop(
      lakeLabel: offers.isEmpty
          ? null
          : context.l10n.lakeName(offers.first.listing.region),
    );
    if (offers.isEmpty) return backdrop;

    final lats = offers.map((o) => o.listing.latitude);
    final lngs = offers.map((o) => o.listing.longitude);
    final minLat = lats.reduce(math.min), maxLat = lats.reduce(math.max);
    final minLng = lngs.reduce(math.min), maxLng = lngs.reduce(math.max);
    double nx(double v) =>
        maxLng == minLng ? 0.5 : (v - minLng) / (maxLng - minLng);
    double ny(double v) =>
        maxLat == minLat ? 0.5 : (maxLat - v) / (maxLat - minLat);

    final usableW = size.width * (1 - _sidePad * 2);
    final usableH = size.height * (1 - _topPad - _bottomPad);
    return Stack(
      children: [
        backdrop,
        for (final o in offers)
          Positioned(
            left: size.width * _sidePad + nx(o.listing.longitude) * usableW,
            top: size.height * _topPad + ny(o.listing.latitude) * usableH,
            child: FractionalTranslation(
              translation: const Offset(-0.5, -0.5),
              child: _PricePin(
                offer: o,
                selected: o.listing.id == selectedId,
                onPressed: () => onSelect(o.listing.id),
              ),
            ),
          ),
      ],
    );
  }
}

class _PricePin extends StatelessWidget {
  const _PricePin({
    required this.offer,
    required this.selected,
    required this.onPressed,
  });

  final ListingOffer offer;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final price = KzFormat.currency(PriceCalculator.total(offer.price));
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: '${offer.listing.title}, $price',
      selected: selected,
      child: AnimatedContainer(
        duration: KzMotion.of(context, KzMotion.micro),
        padding: const EdgeInsets.symmetric(
          horizontal: KzSpace.s12,
          vertical: KzSpace.s8,
        ),
        decoration: BoxDecoration(
          color: selected ? kz.forest : kz.surface,
          borderRadius: KzRadii.all(KzRadii.pill),
          boxShadow: KzShadows.strong,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              KzIcon(KzIcons.home, size: KzSize.iconXs, color: kz.onForest),
              const SizedBox(width: KzSpace.s6),
            ],
            Text(
              price,
              style: KzText.label.copyWith(
                fontWeight: KzText.extraBold,
                color: selected ? kz.onForest : kz.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedCard extends StatelessWidget {
  const _SelectedCard({required this.offer});

  final ListingOffer offer;

  static const double _photo = 110;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final listing = offer.listing;
    final setting = listing.settings.isEmpty
        ? ''
        : (listing.settings.first == ListingSetting.lakeView
              ? l.featureLakeView
              : listing.settings.first.label(l));
    return KzPressable(
      onPressed: () => context.push(AppRoutes.listing(listing.id)),
      excludeChildSemantics: false,
      semanticLabel: listing.title,
      pressedScale: KzMotion.pressedScale,
      child: Container(
        padding: const EdgeInsets.all(KzSpace.s10),
        decoration: BoxDecoration(
          color: kz.surface,
          borderRadius: KzRadii.all(KzRadii.lg),
          boxShadow: KzShadows.strong,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: KzRadii.all(KzRadii.md),
              child: SizedBox.square(
                dimension: _photo,
                child: KzPhoto(
                  url: listing.photoUrls.isEmpty
                      ? null
                      : listing.photoUrls.first,
                ),
              ),
            ),
            const SizedBox(width: KzSpace.s12),
            Expanded(
              child: ExcludeSemantics(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (listing.badge == ListingBadge.rareFind) ...[
                      KzChip(
                        label: l.badgeRareFind,
                        variant: KzChipVariant.accent,
                        size: KzChipSize.mini,
                        icon: KzIcons.sparkles,
                      ),
                      const SizedBox(height: KzSpace.s4),
                    ],
                    Text(
                      listing.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: KzText.titleSm.copyWith(color: kz.ink),
                    ),
                    const SizedBox(height: KzSpace.s4),
                    Row(
                      children: [
                        KzIcon(
                          KzIcons.starFilled,
                          size: KzSize.iconXs - KzSpace.s2,
                          color: kz.star,
                        ),
                        const SizedBox(width: KzSpace.s4),
                        Flexible(
                          child: Text(
                            l.mapListingLine(
                              KzFormat.rating(listing.rating ?? 0),
                              setting,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: KzText.captionBold.copyWith(color: kz.ink2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: KzSpace.s4),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: KzFormat.currency(
                              PriceCalculator.total(offer.price),
                            ),
                            style: KzText.bodyStrong.copyWith(
                              fontWeight: KzText.extraBold,
                              color: kz.forest,
                            ),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: l.nightsTotalShort(offer.price.nights),
                            style: KzText.captionSemi.copyWith(color: kz.ink2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SaveListingButton(
              listingId: listing.id,
              background: kz.sand,
              shadow: const [],
            ),
          ],
        ),
      ),
    );
  }
}
