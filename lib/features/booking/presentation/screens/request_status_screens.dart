import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../../../../l10n/l10n.dart';
import '../../../chat/presentation/controllers/chat_controllers.dart';
import '../../../listing/data/listing_repository.dart';
import '../../../listing/domain/listing_offer.dart';
import '../../../listing/presentation/listing_detail_labels.dart';
import '../../../search/domain/search_query.dart';
import '../../../search/presentation/controllers/search_controller.dart';
import '../../data/booking_repository.dart';
import '../../../status/presentation/screens/status_screens.dart';
import '../../domain/booking.dart';
import '../../domain/price_calculator.dart';
import '../booking_labels.dart';
import '../widgets/booking_parts.dart';
import 'booking_done_screen.dart';

/// Rezervasyonu yükler; durum bu ekrana uymuyorsa doğru ekrana geçer
/// (ör. talep bu arada onaylandıysa 42'ye).
class _BookingLoader extends ConsumerWidget {
  const _BookingLoader({
    required this.bookingId,
    required this.expected,
    required this.builder,
  });

  final String bookingId;
  final BookingStatus expected;
  final Widget Function(Booking booking) builder;

  static String? _routeFor(Booking b) => switch (b.status) {
    BookingStatus.pending => AppRoutes.requestSent(b.id),
    BookingStatus.confirmed => AppRoutes.requestApproved(b.id),
    BookingStatus.declined => AppRoutes.requestDeclined(b.id),
    _ => null,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingProvider(bookingId));
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go(AppRoutes.explore);
      },
      child: switch (booking) {
        AsyncData(:final value) when value.status == expected => builder(value),
        AsyncData(:final value) => Builder(
          builder: (context) {
            final route = _routeFor(value);
            if (route != null) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => context.go(route),
              );
            }
            return const BookingLoading(cards: 2);
          },
        ),
        AsyncError() => BookingError(
          onRetry: () => ref.invalidate(bookingProvider(bookingId)),
        ),
        _ => const BookingLoading(cards: 2),
      },
    );
  }
}

/// İllüstrasyon + başlık + açıklama (41 ve 43'ün üst bloğu).
class _StatusHeader extends StatelessWidget {
  const _StatusHeader({
    required this.illustration,
    required this.title,
    required this.body,
  });

  final Widget illustration;
  final String title;
  final String? body;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: KzSpace.s40),
        Center(child: illustration),
        const SizedBox(height: KzSpace.s14),
        Semantics(
          header: true,
          liveRegion: true,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: KzText.h4.copyWith(color: kz.ink),
          ),
        ),
        if (body != null) ...[
          const SizedBox(height: KzSpace.s14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KzSpace.s16),
            child: Text(
              body!,
              textAlign: TextAlign.center,
              style: KzText.bodySm.copyWith(
                color: kz.ink2,
                height: KzText.body.height,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// 41 · Talep Gönderildi.
class RequestSentScreen extends StatelessWidget {
  const RequestSentScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context) => _BookingLoader(
    bookingId: bookingId,
    expected: BookingStatus.pending,
    builder: (b) => NotificationPromptTrigger(child: _RequestSent(booking: b)),
  );
}

class _RequestSent extends ConsumerWidget {
  const _RequestSent({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final b = booking;
    final detail = ref.watch(listingDetailProvider(b.listingId)).value;

    return KzScaffold(
      bottomBar: KzBottomBar(
        child: Row(
          children: [
            Expanded(
              child: KzButton(
                label: l.messageHost,
                variant: KzButtonVariant.secondary,
                onPressed: () => openBookingChat(context, ref, b.id),
              ),
            ),
            const SizedBox(width: KzSpace.s10),
            Expanded(
              child: KzButton(
                label: l.myTrips,
                trailingArrow: true,
                onPressed: () => context.go(AppRoutes.trips),
              ),
            ),
          ],
        ),
      ),
      children: [
        _StatusHeader(
          illustration: const KzSpotIllustration(
            icon: KzIcons.send,
            badgeIcon: KzIcons.clock,
            dot: KzSpotDot.pool,
            large: true,
          ),
          title: l.requestSentTitle,
          body: detail == null
              ? null
              : l.requestSentBody(
                  detail.host.name,
                  detail.host.responseTimeLabel(l),
                ),
        ),
        const SizedBox(height: KzSpace.s24),
        if (b.requestedAt != null && b.respondBy != null)
          _ResponseCountdown(from: b.requestedAt!, until: b.respondBy!),
        const SizedBox(height: KzSpace.s16),
        BookingCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BookingValueRow(
                label: l.rowListing,
                value: detail?.listing.title ?? '',
              ),
              const SizedBox(height: KzSpace.s12),
              BookingValueRow(
                label: l.tripDates,
                value: l.datesSummary(
                  KzFormat.dateRange(b.dates.checkIn, b.dates.checkOut),
                  b.dates.nights,
                ),
              ),
              const SizedBox(height: KzSpace.s12),
              BookingValueRow(
                label: l.rowProvision,
                value: b.cardLast4 == null
                    ? KzFormat.currency(b.amountPaid)
                    : l.amountWithCard(
                        KzFormat.currency(b.amountPaid),
                        l.cardMasked(b.cardBrand.label(l), b.cardLast4!),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Forest kart: "Yanıt için kalan süre · 23 sa 58 dk" + ilerleme çubuğu.
class _ResponseCountdown extends StatelessWidget {
  const _ResponseCountdown({required this.from, required this.until});

  final DateTime from;
  final DateTime until;

  static const double _bar = 8;
  static const double _trackAlpha = 0.2;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final total = until.difference(from);
    return CountdownBuilder(
      until: until,
      builder: (context, left) {
        final over = left == Duration.zero;
        final elapsed = 1 - left.inSeconds / total.inSeconds;
        final text = over
            ? l.responseTimeOver
            : l.hoursMinutes(left.inHours, left.inMinutes % 60);
        return Semantics(
          label: '${l.responseTimeLeft}, $text',
          excludeSemantics: true,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(KzSpace.s18),
            decoration: BoxDecoration(
              color: kz.forest,
              borderRadius: KzRadii.all(KzRadii.card),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.responseTimeLeft,
                  style: KzText.labelSemi.copyWith(color: kz.forestSoft),
                ),
                const SizedBox(height: KzSpace.s10),
                Text(
                  text,
                  style: (over ? KzText.titleSm : KzText.h1).copyWith(
                    color: kz.onForest,
                  ),
                ),
                const SizedBox(height: KzSpace.s10),
                ClipRRect(
                  borderRadius: KzRadii.all(_bar / 2),
                  child: SizedBox(
                    height: _bar,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ColoredBox(
                            color: kz.onForest.withValues(alpha: _trackAlpha),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: elapsed.clamp(0.0, 1.0),
                          heightFactor: 1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: kz.star,
                              borderRadius: KzRadii.all(_bar / 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// 42 · Talep Onaylandı — 38'in talep varyantı.
class RequestApprovedScreen extends StatelessWidget {
  const RequestApprovedScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context) => _BookingLoader(
    bookingId: bookingId,
    expected: BookingStatus.confirmed,
    builder: (b) => BookingDoneContent(booking: b),
  );
}

/// 43 · Talep Reddedildi.
class RequestDeclinedScreen extends StatelessWidget {
  const RequestDeclinedScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context) => _BookingLoader(
    bookingId: bookingId,
    expected: BookingStatus.declined,
    builder: (b) => _RequestDeclined(booking: b),
  );
}

class _RequestDeclined extends ConsumerWidget {
  const _RequestDeclined({required this.booking});

  final Booking booking;

  void _seeAll(BuildContext context, WidgetRef ref) {
    final listing = ref.read(listingDetailProvider(booking.listingId)).value;
    ref
        .read(searchQueryControllerProvider.notifier)
        .apply(
          SearchQuery(
            location: listing?.listing.region ?? '',
            dates: booking.dates,
            guests: booking.guests,
            filters: const SearchFilters(instantBook: true),
          ),
        );
    context.go(AppRoutes.results);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final similar = ref.watch(similarAvailableProvider(booking.id));

    return KzScaffold(
      bottomBar: KzBottomBar(
        child: KzButton(
          label: l.seeAllSimilar,
          trailingArrow: true,
          onPressed: () => _seeAll(context, ref),
        ),
      ),
      children: [
        _StatusHeader(
          illustration: const KzSpotIllustration(
            icon: KzIcons.calx,
            tone: KzSpotTone.sand,
            badge: KzSpotBadge.forest,
            badgeIcon: KzIcons.refresh,
            dot: KzSpotDot.apricot,
            large: true,
          ),
          title: l.requestDeclinedTitle,
          body: l.requestDeclinedBody(KzFormat.currency(booking.amountPaid)),
        ),
        const SizedBox(height: KzSpace.s20),
        Semantics(
          header: true,
          child: Text(
            l.similarTitle,
            style: KzText.title.copyWith(color: kz.ink),
          ),
        ),
        const SizedBox(height: KzSpace.s10),
        switch (similar) {
          AsyncData(:final value) => Column(
            children: [
              for (final offer in value) ...[
                _SimilarCard(offer: offer),
                const SizedBox(height: KzSpace.s10),
              ],
            ],
          ),
          AsyncError() => const SizedBox.shrink(),
          _ => Column(
            children: [
              for (var i = 0; i < 2; i++) ...[
                KzSkeleton(
                  height: KzSize.tile + KzSpace.s36,
                  borderRadius: KzRadii.all(KzRadii.card),
                ),
                const SizedBox(height: KzSpace.s10),
              ],
            ],
          ),
        },
      ],
    );
  }
}

/// Benzer ilan satırı: fotoğraf + "Anında onay" + ad + toplam fiyat + puan.
class _SimilarCard extends StatelessWidget {
  const _SimilarCard({required this.offer});

  final ListingOffer offer;

  static const double _photo = 76;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final listing = offer.listing;
    final price = l.priceForNights(
      KzFormat.currency(PriceCalculator.total(offer.price)),
      offer.price.nights,
    );
    return KzPressable(
      onPressed: () => context.push(AppRoutes.listing(listing.id)),
      semanticLabel: '${listing.title}, $price',
      child: Container(
        padding: const EdgeInsets.all(KzSpace.s10),
        decoration: BoxDecoration(
          color: kz.surface,
          borderRadius: KzRadii.all(KzRadii.card),
          border: Border.all(color: kz.line),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: KzRadii.all(KzRadii.tile),
              child: SizedBox.square(
                dimension: _photo,
                child: KzPhoto(url: listing.photoUrls.firstOrNull),
              ),
            ),
            const SizedBox(width: KzSpace.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (listing.instantBook) ...[
                    KzChip(
                      label: l.instantBookChip,
                      icon: KzIcons.sparkles,
                      variant: KzChipVariant.selected,
                      size: KzChipSize.mini,
                    ),
                    const SizedBox(height: KzSpace.s3),
                  ],
                  Text(
                    listing.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.titleSm.copyWith(color: kz.ink),
                  ),
                  const SizedBox(height: KzSpace.s3),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: KzSpace.s6,
                    children: [
                      Text(
                        price,
                        style: KzText.label.copyWith(
                          color: kz.forest,
                          fontWeight: KzText.extraBold,
                        ),
                      ),
                      if (listing.rating != null) ...[
                        KzIcon(
                          KzIcons.starFilled,
                          size: KzSpace.s12,
                          color: kz.star,
                        ),
                        Text(
                          KzFormat.rating(listing.rating!),
                          style: KzText.captionSemi.copyWith(color: kz.ink2),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: KzSpace.s8),
            KzIcon(KzIcons.chev, size: KzSize.iconSm, color: kz.ink2),
          ],
        ),
      ),
    );
  }
}
