import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../chat/presentation/controllers/chat_controllers.dart';
import '../../../listing/data/listing_repository.dart';
import '../../data/booking_repository.dart';
import '../../../status/presentation/screens/status_screens.dart';
import '../../domain/booking.dart';
import '../booking_labels.dart';
import '../widgets/booking_parts.dart';

/// 38 · Rezervasyon Tamam ve 42 · Talep Onaylandı (talepten gelen
/// onaylı rezervasyon).
class BookingDoneScreen extends ConsumerWidget {
  const BookingDoneScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingProvider(bookingId));
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go(AppRoutes.explore);
      },
      child: switch (booking) {
        AsyncData(:final value) => NotificationPromptTrigger(
          child: BookingDoneContent(booking: value),
        ),
        AsyncError() => BookingError(
          onRetry: () => ref.invalidate(bookingProvider(bookingId)),
        ),
        _ => const BookingLoading(cards: 2),
      },
    );
  }
}

/// 38 / 42 gövdesi.
class BookingDoneContent extends ConsumerWidget {
  const BookingDoneContent({super.key, required this.booking});

  final Booking booking;

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: booking.code));
    if (context.mounted) showKzToast(context, context.l10n.bookingCodeCopied);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final listing = ref.watch(listingDetailProvider(booking.listingId)).value;
    final b = booking;

    return KzScaffold(
      bottomBar: KzBottomBar(
        child: Row(
          children: [
            Expanded(
              child: KzButton(
                label: l.messageHost,
                variant: KzButtonVariant.secondary,
                onPressed: () => openBookingChat(context, ref, booking.id),
              ),
            ),
            const SizedBox(width: KzSpace.s10),
            Expanded(
              child: KzButton(
                label: l.goToTrip,
                trailingArrow: true,
                // Sekme kökü altında açılır; geri Seyahatler'e döner.
                onPressed: () => context
                  ..go(AppRoutes.trips)
                  ..push(AppRoutes.trip(booking.id)),
              ),
            ),
          ],
        ),
      ),
      children: [
        const SizedBox(height: KzSpace.s40),
        Center(
          child: _DoneIllustration(
            photoUrl: listing?.listing.photoUrls.firstOrNull,
          ),
        ),
        const SizedBox(height: KzSpace.s14),
        Semantics(
          header: true,
          liveRegion: true,
          child: Text(
            b.isRequest && listing != null
                ? l.requestApprovedTitle(listing.host.name)
                : l.bookingDoneTitle,
            textAlign: TextAlign.center,
            style: KzText.h3.copyWith(color: kz.ink),
          ),
        ),
        if (listing != null) ...[
          const SizedBox(height: KzSpace.s14),
          Text(
            (b.isRequest ? l.requestApprovedBody : l.bookingDoneBody)(
              listing.listing.title,
              KzFormat.dayMonthLocative(b.dates.checkIn),
            ),
            textAlign: TextAlign.center,
            style: KzText.bodySm.copyWith(
              color: kz.ink2,
              height: KzText.body.height,
            ),
          ),
        ],
        const SizedBox(height: KzSpace.s24),
        BookingCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BookingValueRow(
                label: l.tripDates,
                value: l.datesSummary(
                  KzFormat.dateRange(b.dates.checkIn, b.dates.checkOut),
                  b.dates.nights,
                ),
              ),
              const SizedBox(height: KzSpace.s14),
              BookingValueRow(
                label: l.tripGuests,
                value: guestBreakdown(l, b.guests),
              ),
              const SizedBox(height: KzSpace.s14),
              BookingValueRow(
                label: l.amountPaid,
                value: KzFormat.currency(b.amountPaid),
              ),
              const SizedBox(height: KzSpace.s14),
              const BookingDivider(),
              const SizedBox(height: KzSpace.s14),
              Row(
                children: [
                  Expanded(
                    child: MergeSemantics(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.bookingCode,
                            style: KzText.captionSemi.copyWith(
                              color: kz.ink2,
                              height: KzText.tightLeading,
                            ),
                          ),
                          const SizedBox(height: KzSpace.s2),
                          SelectableText(
                            b.code,
                            style: KzText.code.copyWith(color: kz.forest),
                          ),
                        ],
                      ),
                    ),
                  ),
                  KzChip(
                    label: l.copy,
                    icon: KzIcons.copy,
                    variant: KzChipVariant.soft,
                    size: KzChipSize.small,
                    semanticLabel: '${l.copy}, ${l.bookingCode}',
                    onPressed: () => _copy(context),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s16),
        KzTip(
          icon: KzIcons.key,
          tone: KzTipTone.info,
          message: l.bookingDoneAddress,
        ),
      ],
    );
  }
}

/// Yumuşak daire + ilan fotoğrafı + onay ve parıltı rozetleri.
class _DoneIllustration extends StatelessWidget {
  const _DoneIllustration({required this.photoUrl});

  final String? photoUrl;

  static const Size _canvas = Size(200, 170);
  static const double _circle = 170;
  static const double _photo = 110;
  static const double _check = 48;
  static const double _spark = 36;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final circleLeft = (_canvas.width - _circle) / 2;
    final photoOffset = (_circle - _photo) / 2;
    Widget badge(double d, Color bg, KzIcons icon, double iconSize) =>
        Container(
          width: d,
          height: d,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          child: KzIcon(icon, size: iconSize, color: kz.onForest),
        );
    return ExcludeSemantics(
      child: SizedBox.fromSize(
        size: _canvas,
        child: Stack(
          children: [
            Positioned(
              left: circleLeft,
              top: 0,
              child: Container(
                width: _circle,
                height: _circle,
                decoration: BoxDecoration(
                  color: kz.forestSoft,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: circleLeft + photoOffset,
              top: photoOffset,
              child: Container(
                width: _photo,
                height: _photo,
                decoration: BoxDecoration(
                  borderRadius: KzRadii.all(KzRadii.hero),
                  boxShadow: KzShadows.raised,
                ),
                child: ClipRRect(
                  borderRadius: KzRadii.all(KzRadii.hero),
                  child: KzPhoto(url: photoUrl),
                ),
              ),
            ),
            Positioned(
              left: circleLeft + photoOffset + _photo - _check / 2 - KzSpace.s4,
              top: photoOffset + _photo - _check / 2 - KzSpace.s4,
              child: badge(_check, kz.forest, KzIcons.check, KzSize.iconXl),
            ),
            Positioned(
              right: 0,
              top: KzSpace.s8,
              child: badge(
                _spark,
                kz.apricot,
                KzIcons.sparklesFilled,
                KzSpace.s16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
