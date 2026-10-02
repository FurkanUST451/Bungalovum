import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_checkbox.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_text_area.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../l10n/l10n.dart';
import '../../../listing/data/listing_repository.dart';
import '../../../listing/domain/listing_detail.dart';
import '../../../listing/presentation/listing_labels.dart';
import '../../../search/domain/search_query.dart';
import '../../domain/booking.dart';
import '../../domain/price_calculator.dart';
import '../booking_labels.dart';
import '../controllers/booking_draft.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/booking_parts.dart';
import 'date_picker_screen.dart';
import 'guest_picker_screen.dart';

/// 33 · Rezervasyonu Onayla (anında onay) ve 40 · Rezervasyon Talebi (ev
/// sahibi onaylı). Hangisi olduğu ilanın `instantBook` alanından gelir.
class BookingConfirmScreen extends ConsumerStatefulWidget {
  const BookingConfirmScreen({super.key, required this.listingId});

  final String listingId;

  @override
  ConsumerState<BookingConfirmScreen> createState() =>
      _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends ConsumerState<BookingConfirmScreen> {
  static const int _maxMessage = 1000;

  bool _accepted = false;
  bool _submitted = false;
  final _message = TextEditingController();

  late final _rulesTap = TapGestureRecognizer()..onTap = () => _openRules(0);
  late final _policyTap = TapGestureRecognizer()..onTap = () => _openRules(1);

  @override
  void dispose() {
    _rulesTap.dispose();
    _policyTap.dispose();
    _message.dispose();
    super.dispose();
  }

  void _openRules(int tab) =>
      context.push('${AppRoutes.listingRules(widget.listingId)}?sekme=$tab');

  Future<void> _editDates() async {
    final draft = ref.read(bookingDraftControllerProvider(widget.listingId));
    final r = await context.push<DatePickerResult>(
      AppRoutes.dates,
      extra: DatePickerArgs(initial: draft.dates, listingId: widget.listingId),
    );
    if (r?.dates != null) {
      ref
          .read(bookingDraftControllerProvider(widget.listingId).notifier)
          .setDates(r!.dates);
    }
  }

  Future<void> _editGuests(ListingDetail d) async {
    final draft = ref.read(bookingDraftControllerProvider(widget.listingId));
    final g = await context.push<GuestCount>(
      AppRoutes.guests,
      extra: GuestPickerArgs(
        initial: draft.guests,
        maxGuests: d.listing.maxGuests,
        petsAllowed: d.listing.petsAllowed,
      ),
    );
    if (g != null) {
      ref
          .read(bookingDraftControllerProvider(widget.listingId).notifier)
          .setGuests(g);
    }
  }

  bool get _messageOk =>
      _message.text.trim().length >= BookingPolicy.minIntroLength;

  void _continue({required bool request}) {
    if (request && !_messageOk) {
      setState(() => _submitted = true);
      return;
    }
    HapticFeedback.lightImpact();
    ref
        .read(checkoutControllerProvider.notifier)
        .begin(
          widget.listingId,
          messageToHost: request ? _message.text.trim() : null,
        );
    context.push(AppRoutes.payment);
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(listingDetailProvider(widget.listingId));
    return switch (detail) {
      AsyncData(:final value) => _content(value),
      AsyncError() => BookingError(
        onRetry: () => ref.invalidate(listingDetailProvider(widget.listingId)),
      ),
      _ => const BookingLoading(),
    };
  }

  Widget _content(ListingDetail d) {
    final kz = context.kz;
    final l = context.l10n;
    final draft = ref.watch(bookingDraftControllerProvider(widget.listingId));
    final quote = ref.watch(bookingQuoteProvider(widget.listingId)).value;
    final dates = draft.dates;
    final total = quote == null ? null : PriceCalculator.total(quote);
    final request = !d.listing.instantBook;

    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      bottomBar: KzBottomBar(
        child: KzBottomBarSummary(
          leading: total == null
              ? KzSkeleton(
                  width: KzSize.tile * 2,
                  height: KzSpace.s24,
                  borderRadius: KzRadii.all(KzRadii.xs),
                )
              : BookingTotalSummary(
                  amount: KzFormat.currency(total),
                  note: request
                      ? l.notChargedNow
                      : l.nightsTotalShort(draft.nights),
                  noteColor: request ? kz.forest : null,
                  semanticLabel: l.listingTotalSemantics(
                    draft.nights,
                    KzFormat.currency(total),
                  ),
                ),
          action: KzButton(
            label: request ? l.sendRequest : l.goToPayment,
            trailingArrow: true,
            expand: false,
            onPressed: _accepted && dates != null && quote != null
                ? () => _continue(request: request)
                : null,
          ),
        ),
      ),
      children: [
        KzPageTitle(title: request ? l.requestTitle : l.bookingConfirmTitle),
        _ListingSummary(detail: d),
        const SizedBox(height: KzSpace.s16),
        if (request) ...[
          const _RequestSteps(),
          const SizedBox(height: KzSpace.s16),
        ],
        BookingCard(
          title: l.yourTrip,
          child: Column(
            children: [
              _TripRow(
                icon: KzIcons.calendar,
                label: l.tripDates,
                value: dates == null
                    ? l.searchAnyDate
                    : l.datesSummary(
                        KzFormat.dateRange(dates.checkIn, dates.checkOut),
                        dates.nights,
                      ),
                onEdit: _editDates,
              ),
              const SizedBox(height: KzSpace.s14),
              _TripRow(
                icon: KzIcons.users,
                label: l.tripGuests,
                value: guestBreakdown(l, draft.guests),
                onEdit: () => _editGuests(d),
              ),
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s16),
        if (quote == null)
          KzSkeleton(
            height: KzSize.tabBar * 3,
            borderRadius: KzRadii.all(KzRadii.card),
          )
        else
          PriceDetailsCard(quote: quote),
        if (dates != null) ...[
          const SizedBox(height: KzSpace.s16),
          KzTip(
            icon: KzIcons.calx,
            tone: KzTipTone.success,
            title: l.freeCancelUntil(
              KzFormat.dayMonthTimeDative(d.freeCancelDeadline(dates.checkIn)),
            ),
            message: l.noRefundAfter,
          ),
        ],
        if (request) ...[
          const SizedBox(height: KzSpace.s16),
          KzTextArea(
            label: l.introduceYourself,
            hint: l.introduceHint(d.host.name),
            controller: _message,
            minLines: 3,
            maxLength: _maxMessage,
            errorText: _submitted && !_messageOk
                ? l.errorIntroShort(BookingPolicy.minIntroLength)
                : null,
            onChanged: (_) => setState(() {}),
          ),
        ],
        const SizedBox(height: KzSpace.s18),
        KzCheckboxTile(
          value: _accepted,
          size: KzSize.checkboxLg,
          gap: KzSpace.s12,
          semanticLabel: l.acceptSemantics,
          onChanged: (v) => setState(() => _accepted = v),
          label: Text.rich(
            TextSpan(
              style: KzText.labelMedium.copyWith(
                color: kz.ink,
                height: KzText.body.height,
              ),
              children: [
                TextSpan(
                  text: l.acceptRulesLink,
                  recognizer: _rulesTap,
                  style: TextStyle(
                    fontWeight: KzText.extraBold,
                    color: kz.forest,
                  ),
                ),
                TextSpan(text: l.acceptMiddle),
                TextSpan(
                  text: l.acceptPolicyLink,
                  recognizer: _policyTap,
                  style: TextStyle(
                    fontWeight: KzText.extraBold,
                    color: kz.forest,
                  ),
                ),
                TextSpan(text: l.acceptEnd),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Kapak fotoğrafı + ad + tür/bölge + puan + "Anında onay".
class _ListingSummary extends StatelessWidget {
  const _ListingSummary({required this.detail});

  final ListingDetail detail;

  static const double _photo = 92;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final listing = detail.listing;
    return BookingCard(
      padding: const EdgeInsets.all(KzSpace.s12),
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: KzText.bodyStrong.copyWith(
                    color: kz.ink,
                    fontWeight: KzText.extraBold,
                    height: KzText.tightLeading,
                  ),
                ),
                const SizedBox(height: KzSpace.s4),
                Text(
                  l.listingTypeRegion(
                    listing.propertyType.label(l),
                    listing.region,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: KzText.labelMedium.copyWith(color: kz.ink2),
                ),
                if (listing.rating != null) ...[
                  const SizedBox(height: KzSpace.s4),
                  Row(
                    children: [
                      KzIcon(
                        KzIcons.starFilled,
                        size: KzSpace.s13,
                        color: kz.star,
                      ),
                      const SizedBox(width: KzSpace.s6),
                      Flexible(
                        child: Text(
                          l.ratingWithCount(
                            KzFormat.rating(listing.rating!),
                            detail.reviewCount,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: KzText.captionBold.copyWith(color: kz.ink),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: KzSpace.s4),
                listing.instantBook
                    ? KzChip(
                        label: l.instantBookChip,
                        icon: KzIcons.sparkles,
                        variant: KzChipVariant.selected,
                        size: KzChipSize.mini,
                      )
                    : KzChip(
                        label: l.hostApprovalChip,
                        icon: KzIcons.clock,
                        iconColor: kz.ink,
                        variant: KzChipVariant.soft,
                        size: KzChipSize.mini,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 40 · "Nasıl işliyor?" — talep, yanıt, ödeme adımları.
class _RequestSteps extends StatelessWidget {
  const _RequestSteps();

  static const double _badge = 28;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final steps = [
      (l.requestStep1Title, l.requestStep1Body),
      (
        l.requestStep2Title(BookingPolicy.requestResponseHours),
        l.requestStep2Body,
      ),
      (l.requestStep3Title, l.requestStep3Body),
    ];
    return BookingCard(
      title: l.howItWorks,
      child: Column(
        children: [
          for (final (i, (title, body)) in steps.indexed) ...[
            if (i > 0) const SizedBox(height: KzSpace.s14),
            MergeSemantics(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: _badge,
                    height: _badge,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: i == 0 ? kz.forest : kz.sand,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${i + 1}',
                      style: KzText.label.copyWith(
                        fontWeight: KzText.extraBold,
                        color: i == 0 ? kz.onForest : kz.ink,
                      ),
                    ),
                  ),
                  const SizedBox(width: KzSpace.s12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: KzText.bodySm.copyWith(
                            color: kz.ink,
                            fontWeight: KzText.extraBold,
                            height: KzText.tightLeading,
                          ),
                        ),
                        const SizedBox(height: KzSpace.s2),
                        Text(
                          body,
                          style: KzText.caption.copyWith(color: kz.ink2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// İkon kutusu + etiket/değer + "Düzenle".
class _TripRow extends StatelessWidget {
  const _TripRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onEdit,
  });

  final KzIcons icon;
  final String label;
  final String value;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return Row(
      children: [
        KzIconBox(icon: icon),
        const SizedBox(width: KzSpace.s14),
        Expanded(
          child: MergeSemantics(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: KzText.captionSemi.copyWith(
                    color: kz.ink2,
                    height: KzText.tightLeading,
                  ),
                ),
                const SizedBox(height: KzSpace.s2),
                Text(value, style: KzText.titleSm.copyWith(color: kz.ink)),
              ],
            ),
          ),
        ),
        const SizedBox(width: KzSpace.s8),
        Semantics(
          label: l.editItem(label),
          excludeSemantics: true,
          button: true,
          child: KzLink(
            label: l.edit,
            style: KzText.bodySm.copyWith(fontWeight: KzText.extraBold),
            onPressed: onEdit,
          ),
        ),
      ],
    );
  }
}

/// Fiyat ayrıntısı kartı: gecelik × gece, temizlik, hizmet, indirim, toplam.
/// Tutarların hepsi [PriceCalculator]'dan gelir.
class PriceDetailsCard extends StatelessWidget {
  const PriceDetailsCard({super.key, required this.quote});

  final PriceBreakdown quote;

  @override
  Widget build(BuildContext context) => BookingCard(
    title: context.l10n.priceDetails,
    child: PriceRows(quote: quote, totalLabel: context.l10n.priceTotalTry),
  );
}

/// Fiyat kalemleri + ayırıcı + toplam (33, 40, 52).
class PriceRows extends StatelessWidget {
  const PriceRows({super.key, required this.quote, required this.totalLabel});

  final PriceBreakdown quote;
  final String totalLabel;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final q = quote;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BookingValueRow(
          label: l.priceNightsLine(KzFormat.currency(q.nightlyRate), q.nights),
          value: KzFormat.currency(PriceCalculator.stay(q)),
        ),
        if (q.cleaningFee > 0) ...[
          const SizedBox(height: KzSpace.s14),
          BookingValueRow(
            label: l.priceCleaning,
            value: KzFormat.currency(q.cleaningFee),
          ),
        ],
        if (q.serviceFee > 0) ...[
          const SizedBox(height: KzSpace.s14),
          BookingValueRow(
            label: l.priceService,
            value: KzFormat.currency(q.serviceFee),
          ),
        ],
        if (PriceCalculator.hasDiscount(q)) ...[
          const SizedBox(height: KzSpace.s14),
          BookingValueRow(
            label: q.discountKind.label(l),
            value: l.minusAmount(KzFormat.currency(q.discount)),
            valueColor: kz.apricotText,
          ),
        ],
        const SizedBox(height: KzSpace.s14),
        const BookingDivider(),
        const SizedBox(height: KzSpace.s14),
        MergeSemantics(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  totalLabel,
                  style: KzText.bodyStrong.copyWith(
                    color: kz.ink,
                    fontWeight: KzText.extraBold,
                  ),
                ),
              ),
              Text(
                KzFormat.currency(PriceCalculator.total(q)),
                style: KzText.titleLg.copyWith(color: kz.ink),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
