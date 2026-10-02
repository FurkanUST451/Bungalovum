import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/responsive/adaptive_layout.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/external_links.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_avatar.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_group.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_map_backdrop.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../chat/presentation/controllers/chat_controllers.dart';
import '../../../booking/data/booking_repository.dart';
import '../../../booking/domain/booking.dart';
import '../../../booking/presentation/booking_labels.dart';
import '../../../booking/presentation/widgets/booking_parts.dart';
import '../../../listing/data/listing_repository.dart';
import '../../../listing/domain/listing_detail.dart';
import '../../../listing/presentation/listing_detail_labels.dart';
import '../../../listing/presentation/widgets/listing_sheets.dart';
import '../../domain/trip_models.dart';

/// "5 Kas 14:00" — erişim bilgilerinin açılacağı an.
String revealLabel(DateTime at) => KzFormat.dayMonthTimeDative(at);

/// 49 · Konaklama Detayı.
class TripDetailScreen extends ConsumerWidget {
  const TripDetailScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingProvider(bookingId));
    return switch (booking) {
      AsyncData(:final value) => _WithDetail(booking: value),
      AsyncError() => BookingError(
        onRetry: () => ref.invalidate(bookingProvider(bookingId)),
      ),
      _ => const BookingLoading(),
    };
  }
}

class _WithDetail extends ConsumerWidget {
  const _WithDetail({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(listingDetailProvider(booking.listingId));
    final access = ref.watch(tripAccessProvider(booking.id));
    return switch ((detail, access)) {
      (AsyncData(value: final d), AsyncData(value: final a)) => _Content(
        booking: booking,
        detail: d,
        access: a,
      ),
      (AsyncError(), _) || (_, AsyncError()) => BookingError(
        onRetry: () => ref
          ..invalidate(listingDetailProvider(booking.listingId))
          ..invalidate(tripAccessProvider(booking.id)),
      ),
      _ => const BookingLoading(),
    };
  }
}

class _Content extends ConsumerWidget {
  const _Content({
    required this.booking,
    required this.detail,
    required this.access,
  });

  final Booking booking;
  final ListingDetail detail;
  final TripAccess access;

  static const double _heroAspect = 390 / 280;

  /// İçerik hero'nun altına bu kadar biner.
  static const double _overlap = KzSpace.s30;

  Future<void> _copy(BuildContext context, String text, String toast) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) showKzToast(context, toast);
  }

  Future<void> _open(BuildContext context, Future<bool> launch) async {
    if (!await launch && context.mounted) {
      showKzToast(context, context.l10n.cannotOpenLink);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final b = booking;
    final listing = detail.listing;
    final gutter = context.screenGutter;
    final confirmed = b.status == BookingStatus.confirmed;
    final cancelled =
        b.status == BookingStatus.cancelled ||
        b.status == BookingStatus.declined;
    final topInset = MediaQuery.paddingOf(context).top;

    final (statusLabel, statusIcon, statusVariant) = switch (b.status) {
      BookingStatus.confirmed => (
        l.statusConfirmed,
        KzIcons.check,
        KzChipVariant.selected,
      ),
      BookingStatus.pending => (
        l.statusPending,
        KzIcons.clock,
        KzChipVariant.soft,
      ),
      BookingStatus.completed => (l.tabPast, KzIcons.check, KzChipVariant.soft),
      BookingStatus.declined => (
        l.statusDeclined,
        KzIcons.x,
        KzChipVariant.accent,
      ),
      BookingStatus.cancelled => (
        l.statusCancelled,
        KzIcons.x,
        KzChipVariant.accent,
      ),
    };

    final dayFormat = DateFormat('EEE, d MMM', kzLocale);

    Widget dateCard(String label, DateTime day, String time) => Expanded(
      child: Container(
        padding: const EdgeInsets.all(KzSpace.s16),
        decoration: BoxDecoration(
          color: kz.surface,
          borderRadius: KzRadii.all(KzRadii.field),
          border: Border.all(color: kz.line),
        ),
        child: MergeSemantics(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: KzText.captionSemi.copyWith(color: kz.ink2)),
              const SizedBox(height: KzSpace.s4),
              Text(
                dayFormat.format(day),
                style: KzText.titleSm.copyWith(color: kz.ink),
              ),
              const SizedBox(height: KzSpace.s4),
              Text(time, style: KzText.label.copyWith(color: kz.forest)),
            ],
          ),
        ),
      ),
    );

    final manageRows = <Widget>[
      if (confirmed)
        KzRow(
          icon: KzIcons.alert,
          tone: KzIconBoxTone.apricot,
          title: l.reportStayIssue,
          onPressed: () => context.push(AppRoutes.reportIssue(b.id)),
        ),
      if (confirmed)
        KzRow(
          icon: KzIcons.chat,
          tone: KzIconBoxTone.sand,
          title: l.askHostChange,
          subtitle: l.askHostChangeNote,
          onPressed: () => openBookingChat(context, ref, b.id),
        ),
      if (confirmed)
        KzRow(
          icon: KzIcons.idcard,
          tone: KzIconBoxTone.forest,
          title: l.guestInfoTitle,
          onPressed: () => context.push(AppRoutes.guestDetails(b.id)),
        ),
      if (b.status == BookingStatus.completed && b.myRating == null)
        KzRow(
          icon: KzIcons.star,
          tone: KzIconBoxTone.apricot,
          title: l.rateStay,
          onPressed: () => context.push(AppRoutes.writeReview(b.id)),
        ),
      if (b.paidAt != null || b.status == BookingStatus.completed)
        KzRow(
          icon: KzIcons.receipt,
          tone: KzIconBoxTone.pool,
          title: l.receiptAndInvoice,
          onPressed: () => context.push(AppRoutes.receipt(b.id)),
        ),
      if (confirmed)
        KzRow(
          icon: KzIcons.calx,
          tone: KzIconBoxTone.apricot,
          title: l.cancelBooking,
          titleColor: kz.apricotText,
          onPressed: () => context.push(AppRoutes.cancelBooking(b.id)),
        ),
    ];

    return Scaffold(
      backgroundColor: kz.bg,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: KzSpace.s40 + MediaQuery.paddingOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero fotoğraf + geri / paylaş.
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: _heroAspect,
                  child: KzPhoto(url: listing.photoUrls.firstOrNull),
                ),
                Positioned(
                  left: gutter,
                  right: gutter,
                  top: topInset + KzSpace.s8,
                  child: Row(
                    children: [
                      KzCircleButton(
                        icon: KzIcons.back,
                        diameter: KzSize.backButton,
                        iconSize: KzSize.iconMd,
                        shadow: KzShadows.raised,
                        semanticLabel: l.back,
                        onPressed: () => context.pop(),
                      ),
                      const Spacer(),
                      KzCircleButton(
                        icon: KzIcons.share,
                        diameter: KzSize.backButton,
                        iconSize: KzSize.iconMd,
                        shadow: KzShadows.raised,
                        semanticLabel: l.share,
                        onPressed: () => showShareSheet(context, listing),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: const Offset(0, -_overlap),
              child: Container(
                decoration: BoxDecoration(
                  color: kz.bg,
                  borderRadius: KzRadii.top(KzRadii.hero),
                ),
                padding: EdgeInsets.fromLTRB(gutter, KzSpace.s24, gutter, 0),
                child: KzMaxWidth(
                  maxWidth: KzBreakpoints.mediumContent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Wrap(
                        spacing: KzSpace.s8,
                        runSpacing: KzSpace.s8,
                        children: [
                          KzChip(
                            label: statusLabel,
                            icon: statusIcon,
                            variant: statusVariant,
                            size: KzChipSize.small,
                          ),
                          KzChip(
                            label: b.code,
                            icon: KzIcons.copy,
                            variant: KzChipVariant.soft,
                            size: KzChipSize.small,
                            semanticLabel: '${l.copy}, ${l.bookingCode}',
                            onPressed: () =>
                                _copy(context, b.code, l.codeCopied),
                          ),
                        ],
                      ),
                      const SizedBox(height: KzSpace.s16),
                      Semantics(
                        header: true,
                        child: Text(
                          listing.title,
                          style: KzText.h3.copyWith(color: kz.ink),
                        ),
                      ),
                      const SizedBox(height: KzSpace.s16),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            dateCard(
                              l.checkInLabel,
                              b.dates.checkIn,
                              l.fromTime(access.checkInFrom),
                            ),
                            const SizedBox(width: KzSpace.s10),
                            dateCard(
                              l.checkOutLabel,
                              b.dates.checkOut,
                              l.untilTime(
                                KzFormat.timeDative(access.checkOutBy),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (cancelled && b.refundAmount != null) ...[
                        const SizedBox(height: KzSpace.s16),
                        KzTip(
                          icon: KzIcons.check,
                          tone: KzTipTone.success,
                          message: b.refundAmount! > 0
                              ? l.refundedTo(
                                  KzFormat.currency(b.refundAmount!),
                                  l.cardMasked(
                                    b.cardBrand.label(l),
                                    b.cardLast4 ?? '',
                                  ),
                                )
                              : l.provisionReleased(
                                  l.cardMasked(
                                    b.cardBrand.label(l),
                                    b.cardLast4 ?? '',
                                  ),
                                ),
                        ),
                      ],
                      if (confirmed) ...[
                        const SizedBox(height: KzSpace.s16),
                        _AddressCard(
                          access: access,
                          onDirections: () => _open(
                            context,
                            ExternalLinks.directions(
                              access.latitude,
                              access.longitude,
                            ),
                          ),
                          onCopy: () => _copy(
                            context,
                            access.addressText,
                            l.addressCopied,
                          ),
                        ),
                        const SizedBox(height: KzSpace.s16),
                        _GuideCard(
                          access: access,
                          onPressed: () =>
                              context.push(AppRoutes.houseGuide(b.id)),
                        ),
                        const SizedBox(height: KzSpace.s16),
                        _HostCard(
                          detail: detail,
                          phone: access.hostPhone,
                          onMessage: () => openBookingChat(context, ref, b.id),
                          onCall: (p) => _open(context, ExternalLinks.call(p)),
                        ),
                      ],
                      if (manageRows.isNotEmpty) ...[
                        const SizedBox(height: KzSpace.s24),
                        KzGroup(title: l.manageBooking, rows: manageRows),
                      ],
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

/// Adres + harita + yol tarifi / kopyala. Açılmadan önce yaklaşık bölge.
class _AddressCard extends StatelessWidget {
  const _AddressCard({
    required this.access,
    required this.onDirections,
    required this.onCopy,
  });

  final TripAccess access;
  final VoidCallback onDirections;
  final VoidCallback onCopy;

  static const double _mapHeight = 130;
  static const double _pin = 40;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final open = access.revealed;
    return BookingCard(
      padding: const EdgeInsets.all(KzSpace.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.addressLabel,
            style: KzText.labelSemi.copyWith(color: kz.ink2),
          ),
          const SizedBox(height: KzSpace.s12),
          Text(
            open ? access.addressText : access.areaLabel,
            style: KzText.titleSm.copyWith(
              color: kz.ink,
              height: KzText.bodyStrong.height,
            ),
          ),
          const SizedBox(height: KzSpace.s12),
          ClipRRect(
            borderRadius: KzRadii.all(KzRadii.md),
            child: SizedBox(
              height: _mapHeight,
              width: double.infinity,
              child: Stack(
                children: [
                  const Positioned.fill(child: KzMapBackdrop()),
                  Center(
                    child: Container(
                      width: _pin,
                      height: _pin,
                      decoration: BoxDecoration(
                        color: kz.forest,
                        shape: BoxShape.circle,
                        boxShadow: KzShadows.strong,
                      ),
                      child: Center(
                        child: KzIcon(
                          KzIcons.home,
                          size: KzSize.iconSm,
                          color: kz.onForest,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: KzSpace.s12),
          if (open)
            Wrap(
              spacing: KzSpace.s8,
              runSpacing: KzSpace.s8,
              children: [
                KzChip(
                  label: l.getDirections,
                  icon: KzIcons.nav,
                  onPressed: onDirections,
                ),
                KzChip(
                  label: l.copyAddress,
                  icon: KzIcons.copy,
                  variant: KzChipVariant.soft,
                  onPressed: onCopy,
                ),
              ],
            )
          else
            KzTip(
              icon: KzIcons.lock,
              tone: KzTipTone.info,
              message: l.addressLocked(revealLabel(access.revealAt)),
            ),
        ],
      ),
    );
  }
}

/// apricotSoft kutu: ev kılavuzu ve giriş bilgileri.
class _GuideCard extends StatelessWidget {
  const _GuideCard({required this.access, required this.onPressed});

  final TripAccess access;
  final VoidCallback onPressed;

  static const double _box = 46;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final note = access.revealed
        ? l.guideOpenNote
        : l.guideLockedNote(revealLabel(access.revealAt));
    return KzPressable(
      onPressed: onPressed,
      semanticLabel: '${l.guideAndAccess}, $note',
      child: Container(
        padding: const EdgeInsets.all(KzSpace.s16),
        decoration: BoxDecoration(
          color: kz.apricotSoft,
          borderRadius: KzRadii.all(KzRadii.card),
        ),
        child: Row(
          children: [
            Container(
              width: _box,
              height: _box,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kz.surface,
                borderRadius: KzRadii.all(KzRadii.icon),
              ),
              child: KzIcon(
                access.revealed ? KzIcons.key : KzIcons.lock,
                size: KzSize.iconLg,
                color: kz.apricotText,
              ),
            ),
            const SizedBox(width: KzSpace.s14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.guideAndAccess,
                    style: KzText.titleSm.copyWith(color: kz.ink),
                  ),
                  const SizedBox(height: KzSpace.s3),
                  Text(
                    note,
                    style: KzText.labelMedium.copyWith(color: kz.ink2),
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

/// Ev sahibi: avatar + ad + yanıt süresi + mesaj / ara.
class _HostCard extends StatelessWidget {
  const _HostCard({
    required this.detail,
    required this.phone,
    required this.onCall,
    required this.onMessage,
  });

  final ListingDetail detail;
  final String? phone;
  final ValueChanged<String> onCall;
  final VoidCallback onMessage;

  static const double _avatar = 50;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final host = detail.host;
    return BookingCard(
      padding: const EdgeInsets.all(KzSpace.s16),
      child: Row(
        children: [
          KzAvatar(name: host.name, photoUrl: host.avatarUrl, size: _avatar),
          const SizedBox(width: KzSpace.s14),
          Expanded(
            child: MergeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    host.name,
                    style: KzText.titleSm.copyWith(color: kz.ink),
                  ),
                  const SizedBox(height: KzSpace.s2),
                  Text(
                    l.respondsWithin(host.responseTimeLabel(l)),
                    style: KzText.caption.copyWith(color: kz.ink2),
                  ),
                ],
              ),
            ),
          ),
          KzCircleButton(
            icon: KzIcons.chat,
            diameter: KzSize.minTouch,
            iconSize: KzSize.iconSm,
            background: kz.forestSoft,
            iconColor: kz.forest,
            semanticLabel: l.messageHostShort,
            onPressed: onMessage,
          ),
          if (phone != null) ...[
            const SizedBox(width: KzSpace.s8),
            KzCircleButton(
              icon: KzIcons.phone,
              diameter: KzSize.minTouch,
              iconSize: KzSize.iconSm,
              background: kz.sand,
              semanticLabel: l.callHost,
              onPressed: () => onCall(phone!),
            ),
          ],
        ],
      ),
    );
  }
}
