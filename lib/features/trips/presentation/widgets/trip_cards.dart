import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/clock.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../l10n/l10n.dart';
import '../../../chat/presentation/controllers/chat_controllers.dart';
import '../../../booking/domain/booking.dart';
import '../../../booking/presentation/booking_labels.dart';
import '../../../listing/data/listing_repository.dart';
import '../../../listing/domain/listing.dart';

/// Kartın ilan bilgisi (ad + kapak). Yüklenene kadar iskelet.
class _WithListing extends ConsumerWidget {
  const _WithListing({required this.listingId, required this.builder});

  final String listingId;
  final Widget Function(Listing listing) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(listingDetailProvider(listingId)).value;
    if (d == null) {
      return KzSkeleton(
        height: KzSize.tabBar * 2,
        borderRadius: KzRadii.all(KzRadii.card),
      );
    }
    return builder(d.listing);
  }
}

/// Üstte fotoğraf + rozetler, altta içerik olan büyük kart.
class _PhotoCard extends StatelessWidget {
  const _PhotoCard({
    required this.listing,
    required this.aspectRatio,
    required this.children,
    this.leftChip,
    this.rightChip,
    this.muted = false,
    this.onPressed,
    this.semanticLabel,
  });

  final Listing listing;
  final double aspectRatio;
  final Widget? leftChip;
  final Widget? rightChip;
  final List<Widget> children;

  /// İptal edilenlerde soluk fotoğraf.
  final bool muted;
  final VoidCallback? onPressed;
  final String? semanticLabel;

  static const double _mutedOpacity = 0.55;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    Widget photo = KzPhoto(url: listing.photoUrls.firstOrNull);
    if (muted) {
      photo = Opacity(
        opacity: _mutedOpacity,
        // Doygunluğu sıfır bir renkle saturation karışımı = gri tonlama.
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(kz.surface, BlendMode.saturation),
          child: photo,
        ),
      );
    }
    final card = Container(
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.all(KzRadii.hero),
        border: Border.all(color: kz.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: aspectRatio,
            child: ClipRRect(
              borderRadius: KzRadii.all(KzRadii.hero),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  photo,
                  Positioned(
                    left: KzSpace.s14,
                    right: KzSpace.s14,
                    top: KzSpace.s14,
                    child: Row(
                      children: [
                        if (leftChip != null) Flexible(child: leftChip!),
                        const Spacer(),
                        if (rightChip != null) Flexible(child: rightChip!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              KzSpace.s18,
              KzSpace.s14,
              KzSpace.s18,
              KzSpace.s16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ],
      ),
    );
    if (onPressed == null) return card;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: semanticLabel,
      pressedScale: 1,
      child: card,
    );
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: KzText.titleLg.copyWith(color: kz.ink),
        ),
        const SizedBox(height: KzSpace.s4),
        Text(subtitle, style: KzText.labelMedium.copyWith(color: kz.ink2)),
      ],
    );
  }
}

/// 44 · Yaklaşan onaylı konaklama: kalan gün, yol tarifi, mesaj, giriş.
class UpcomingTripCard extends ConsumerWidget {
  const UpcomingTripCard({super.key, required this.booking});

  final Booking booking;

  static const double _aspect = 350 / 210;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final b = booking;
    final today = DateUtils.dateOnly(ref.watch(clockProvider)());
    final days = DateUtils.dateOnly(b.dates.checkIn).difference(today).inDays;
    return _WithListing(
      listingId: b.listingId,
      builder: (listing) => _PhotoCard(
        listing: listing,
        aspectRatio: _aspect,
        onPressed: () => context.push(AppRoutes.trip(b.id)),
        semanticLabel: listing.title,
        leftChip: days >= 0
            ? KzChip(
                label: l.daysLeft(days),
                icon: KzIcons.clock,
                variant: KzChipVariant.highlight,
                size: KzChipSize.small,
              )
            : null,
        rightChip: KzChip(
          label: l.statusConfirmed,
          icon: KzIcons.check,
          iconColor: kz.forest,
          labelColor: kz.forest,
          variant: KzChipVariant.onImage,
          size: KzChipSize.small,
        ),
        children: [
          _TitleBlock(
            title: listing.title,
            subtitle: l.dotJoin2(
              KzFormat.dateRangeWithWeekday(b.dates.checkIn, b.dates.checkOut),
              guestBreakdown(l, b.guests),
            ),
          ),
          const SizedBox(height: KzSpace.s14),
          Row(
            children: [
              for (final (i, (icon, label, onTap)) in [
                (
                  KzIcons.nav,
                  l.actionDirections,
                  () => context.push(AppRoutes.trip(b.id)),
                ),
                (
                  KzIcons.chat,
                  l.actionMessage,
                  () => openBookingChat(context, ref, b.id),
                ),
                (
                  KzIcons.key,
                  l.actionCheckIn,
                  () => context.push(AppRoutes.houseGuide(b.id)),
                ),
              ].indexed) ...[
                if (i > 0) const SizedBox(width: KzSpace.s8),
                Expanded(
                  child: _ActionTile(
                    icon: icon,
                    label: label,
                    onPressed: onTap,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final KzIcons icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: label,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: KzSpace.s4,
          vertical: KzSpace.s12,
        ),
        decoration: BoxDecoration(
          color: kz.sand,
          borderRadius: KzRadii.all(KzRadii.md),
        ),
        child: Column(
          children: [
            KzIcon(icon, size: KzSize.iconMd, color: kz.ink),
            const SizedBox(height: KzSpace.s6),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: KzText.captionBold.copyWith(color: kz.ink),
            ),
          ],
        ),
      ),
    );
  }
}

/// 45 · Onay bekleyen talep: kalan yanıt süresi, mesaj, geri çek.
class PendingTripCard extends ConsumerWidget {
  const PendingTripCard({
    super.key,
    required this.booking,
    required this.onWithdraw,
  });

  final Booking booking;
  final VoidCallback onWithdraw;

  static const double _aspect = 350 / 160;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final b = booking;
    final now = ref.watch(clockProvider)();
    final left = b.respondBy?.difference(now);
    return _WithListing(
      listingId: b.listingId,
      builder: (listing) => _PhotoCard(
        listing: listing,
        aspectRatio: _aspect,
        onPressed: () => context.push(AppRoutes.requestSent(b.id)),
        semanticLabel: '${listing.title}, ${l.statusPending}',
        leftChip: KzChip(
          label: l.statusPending,
          icon: KzIcons.clock,
          variant: KzChipVariant.onImage,
          size: KzChipSize.small,
        ),
        children: [
          _TitleBlock(
            title: listing.title,
            subtitle: l.dotJoin3(
              KzFormat.dateRange(b.dates.checkIn, b.dates.checkOut),
              guestBreakdown(l, b.guests),
              KzFormat.currency(b.amountPaid),
            ),
          ),
          if (left != null && !left.isNegative) ...[
            const SizedBox(height: KzSpace.s12),
            KzTip(
              icon: KzIcons.clock,
              tone: KzTipTone.warning,
              message: left.inHours >= 1
                  ? l.hostResponseHoursLeft(left.inHours)
                  : l.hostResponseMinutesLeft(left.inMinutes),
            ),
          ],
          const SizedBox(height: KzSpace.s12),
          Row(
            children: [
              Expanded(
                child: KzButton(
                  label: l.sendMessage,
                  icon: KzIcons.chat,
                  size: KzButtonSize.compact,
                  variant: KzButtonVariant.secondary,
                  onPressed: () => openBookingChat(context, ref, b.id),
                ),
              ),
              const SizedBox(width: KzSpace.s8),
              Expanded(
                child: KzButton(
                  label: l.withdrawRequest,
                  icon: KzIcons.x,
                  size: KzButtonSize.compact,
                  variant: KzButtonVariant.danger,
                  onPressed: onWithdraw,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 46 · Geçmiş konaklama: değerlendirme rozeti, makbuz / değerlendir,
/// tekrar rezerve et.
class PastTripCard extends StatelessWidget {
  const PastTripCard({super.key, required this.booking});

  final Booking booking;

  static const double _aspect = 350 / 150;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final b = booking;
    final rated = b.myRating != null;
    return _WithListing(
      listingId: b.listingId,
      builder: (listing) => _PhotoCard(
        listing: listing,
        aspectRatio: _aspect,
        onPressed: () => context.push(AppRoutes.trip(b.id)),
        semanticLabel: listing.title,
        leftChip: rated
            ? KzChip(
                label: l.youRated(KzFormat.rating(b.myRating!)),
                icon: KzIcons.starFilled,
                iconColor: kz.star,
                variant: KzChipVariant.onImage,
                size: KzChipSize.small,
              )
            : null,
        children: [
          _TitleBlock(
            title: listing.title,
            subtitle: l.dotJoin3(
              KzFormat.monthYear(b.dates.checkIn),
              l.nightsCount(b.dates.nights),
              guestBreakdown(l, b.guests),
            ),
          ),
          const SizedBox(height: KzSpace.s12),
          Row(
            children: [
              Expanded(
                child: rated
                    ? KzButton(
                        label: l.receipt,
                        icon: KzIcons.receipt,
                        size: KzButtonSize.compact,
                        variant: KzButtonVariant.secondary,
                        onPressed: () => context.push(AppRoutes.receipt(b.id)),
                      )
                    : KzButton(
                        label: l.rateStay,
                        icon: KzIcons.star,
                        size: KzButtonSize.compact,
                        variant: KzButtonVariant.accent,
                        onPressed: () =>
                            context.push(AppRoutes.writeReview(b.id)),
                      ),
              ),
              const SizedBox(width: KzSpace.s8),
              Expanded(
                child: KzButton(
                  label: l.bookAgain,
                  icon: KzIcons.refresh,
                  size: KzButtonSize.compact,
                  onPressed: () => context.push(AppRoutes.listing(b.listingId)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 47 · İptal edilen / reddedilen: soluk fotoğraf, iade bilgisi.
class CancelledTripCard extends StatelessWidget {
  const CancelledTripCard({super.key, required this.booking});

  final Booking booking;

  static const double _aspect = 350 / 130;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final b = booking;
    final declined = b.status == BookingStatus.declined;
    final dates = KzFormat.dateRange(b.dates.checkIn, b.dates.checkOut);
    final who = declined
        ? l.declinedByHost
        : b.cancelledByGuest
        ? l.cancelledByYou(KzFormat.dayMonth(b.cancelledAt ?? b.dates.checkIn))
        : l.cancelledByHost(
            KzFormat.dayMonth(b.cancelledAt ?? b.dates.checkIn),
          );
    final card = b.cardLast4 == null
        ? null
        : l.cardMasked(b.cardBrand.label(l), b.cardLast4!);
    final refund = b.refundAmount ?? 0;
    final String? refundText = card == null
        ? null
        : refund > 0
        ? l.refundedTo(KzFormat.currency(refund), card)
        : (b.isRequest || declined)
        ? l.provisionReleased(card)
        : null;
    return _WithListing(
      listingId: b.listingId,
      builder: (listing) => _PhotoCard(
        listing: listing,
        aspectRatio: _aspect,
        muted: true,
        leftChip: KzChip(
          label: declined ? l.statusDeclined : l.statusCancelled,
          icon: KzIcons.x,
          iconColor: kz.apricotText,
          labelColor: kz.apricotText,
          variant: KzChipVariant.onImage,
          size: KzChipSize.small,
        ),
        children: [
          _TitleBlock(title: listing.title, subtitle: l.dotJoin2(dates, who)),
          if (refundText != null) ...[
            const SizedBox(height: KzSpace.s12),
            KzTip(
              icon: KzIcons.check,
              tone: KzTipTone.success,
              message: refundText,
            ),
          ],
        ],
      ),
    );
  }
}

/// Kompakt satır: küçük fotoğraf + ad + alt satır + sağda rozet/ok.
class TripRow extends StatelessWidget {
  const TripRow({
    super.key,
    required this.booking,
    required this.subtitle,
    this.subtitleColor,
    this.trailing,
    required this.onPressed,
  });

  final Booking booking;
  final String subtitle;
  final Color? subtitleColor;
  final Widget? trailing;
  final VoidCallback onPressed;

  static const double _photo = 64;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return _WithListing(
      listingId: booking.listingId,
      builder: (listing) => KzPressable(
        onPressed: onPressed,
        semanticLabel: '${listing.title}, $subtitle',
        child: Container(
          padding: const EdgeInsets.all(KzSpace.s12),
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
              const SizedBox(width: KzSpace.s14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listing.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: KzText.titleSm.copyWith(color: kz.ink),
                    ),
                    const SizedBox(height: KzSpace.s3),
                    Text(
                      subtitle,
                      style: KzText.caption.copyWith(
                        color: subtitleColor ?? kz.ink2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: KzSpace.s8),
              trailing ??
                  KzIcon(KzIcons.chev, size: KzSize.iconSm, color: kz.ink2),
            ],
          ),
        ),
      ),
    );
  }
}
