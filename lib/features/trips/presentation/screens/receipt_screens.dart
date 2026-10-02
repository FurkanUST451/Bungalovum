import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/external_links.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_link.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_segmented.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/data/booking_repository.dart';
import '../../../booking/domain/booking.dart';
import '../../../booking/presentation/booking_labels.dart';
import '../../../booking/presentation/screens/booking_confirm_screen.dart'
    show PriceRows;
import '../../../booking/presentation/widgets/booking_parts.dart';
import '../../../listing/data/listing_repository.dart';
import '../../domain/trip_models.dart';

/// 52 · Makbuz.
class ReceiptScreen extends ConsumerStatefulWidget {
  const ReceiptScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  ConsumerState<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends ConsumerState<ReceiptScreen> {
  bool _emailing = false;
  bool _downloading = false;

  BookingRepository get _repo => ref.read(bookingRepositoryProvider);

  Future<void> _email() async {
    setState(() => _emailing = true);
    try {
      final to = await _repo.emailReceipt(widget.bookingId);
      if (mounted) showKzToast(context, context.l10n.receiptEmailed(to));
    } on Object {
      if (mounted) showKzToast(context, context.l10n.errorNetwork);
    } finally {
      if (mounted) setState(() => _emailing = false);
    }
  }

  Future<void> _download() async {
    setState(() => _downloading = true);
    try {
      final uri = await _repo.receiptPdf(widget.bookingId);
      final ok = await ExternalLinks.open(uri);
      if (!ok && mounted) showKzToast(context, context.l10n.cannotOpenLink);
    } on Object {
      if (mounted) showKzToast(context, context.l10n.errorNetwork);
    } finally {
      if (mounted) setState(() => _downloading = false);
    }
  }

  Future<void> _share() async {
    try {
      final uri = await _repo.receiptPdf(widget.bookingId);
      await Clipboard.setData(ClipboardData(text: uri.toString()));
      if (mounted) showKzToast(context, context.l10n.receiptLinkCopied);
    } on Object {
      if (mounted) showKzToast(context, context.l10n.errorNetwork);
    }
  }

  @override
  Widget build(BuildContext context) {
    final booking = ref.watch(bookingProvider(widget.bookingId));
    return switch (booking) {
      AsyncData(:final value) => _content(value),
      AsyncError() => BookingError(
        onRetry: () => ref.invalidate(bookingProvider(widget.bookingId)),
      ),
      _ => const BookingLoading(cards: 2),
    };
  }

  Widget _content(Booking b) {
    final kz = context.kz;
    final l = context.l10n;
    final title = ref
        .watch(listingDetailProvider(b.listingId))
        .value
        ?.listing
        .title;
    final billing = ref.watch(billingInfoProvider).value;
    final refunded = (b.refundAmount ?? 0) > 0;
    final paidDate = DateFormat('d MMM y', kzLocale);
    final card = b.cardLast4 == null
        ? null
        : l.cardMasked(b.cardBrand.label(l), b.cardLast4!);

    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.back),
        trailing: KzCircleButton(
          icon: KzIcons.share,
          diameter: KzSize.backButton,
          iconSize: KzSize.iconMd,
          shadow: KzShadows.card,
          semanticLabel: l.share,
          onPressed: _share,
        ),
      ),
      bottomBar: KzBottomBar(
        child: Row(
          children: [
            Expanded(
              child: KzButton(
                label: l.emailReceipt,
                variant: KzButtonVariant.secondary,
                loading: _emailing,
                onPressed: _email,
              ),
            ),
            const SizedBox(width: KzSpace.s10),
            Expanded(
              child: KzButton(
                label: l.downloadPdf,
                loading: _downloading,
                onPressed: _download,
              ),
            ),
          ],
        ),
      ),
      children: [
        KzPageTitle(title: l.receiptTitle),
        BookingCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  KzIcon(KzIcons.trees, size: KzSize.iconMd, color: kz.forest),
                  const SizedBox(width: KzSpace.s8),
                  Expanded(
                    child: Text(
                      l.welcomeBrand,
                      style: KzText.titleLg.copyWith(color: kz.forest),
                    ),
                  ),
                  KzChip(
                    label: refunded ? l.refundedChip : l.paidChip,
                    icon: KzIcons.check,
                    variant: KzChipVariant.selected,
                    size: KzChipSize.mini,
                  ),
                ],
              ),
              const SizedBox(height: KzSpace.s12),
              MergeSemantics(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.bookingCode,
                      style: KzText.captionSemi.copyWith(color: kz.ink2),
                    ),
                    const SizedBox(height: KzSpace.s2),
                    SelectableText(
                      b.code,
                      style: KzText.code.copyWith(color: kz.ink),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: KzSpace.s12),
              const BookingDivider(),
              const SizedBox(height: KzSpace.s12),
              if (title != null) ...[
                BookingValueRow(label: l.rowStay, value: title),
                const SizedBox(height: KzSpace.s12),
              ],
              BookingValueRow(
                label: l.tripDates,
                value: l.datesWithYear(
                  KzFormat.dateRange(b.dates.checkIn, b.dates.checkOut),
                  b.dates.checkIn.year,
                  b.dates.nights,
                ),
              ),
              const SizedBox(height: KzSpace.s12),
              BookingValueRow(
                label: l.tripGuests,
                value: guestBreakdown(l, b.guests),
              ),
              const SizedBox(height: KzSpace.s12),
              const BookingDivider(),
              const SizedBox(height: KzSpace.s12),
              if (b.price != null)
                PriceRows(quote: b.price!, totalLabel: l.totalLabel)
              else
                BookingValueRow(
                  label: l.totalLabel,
                  value: KzFormat.currency(b.amountPaid),
                  valueWeight: KzText.extraBold,
                ),
              if (card != null) ...[
                const SizedBox(height: KzSpace.s12),
                BookingValueRow(
                  label: l.paymentLabel,
                  value: b.paidAt == null
                      ? card
                      : l.dotJoin2(card, paidDate.format(b.paidAt!)),
                ),
              ],
              if (refunded) ...[
                const SizedBox(height: KzSpace.s12),
                BookingValueRow(
                  label: l.refundLabel,
                  value: KzFormat.currency(b.refundAmount!),
                  valueColor: kz.forest,
                ),
              ],
              const SizedBox(height: KzSpace.s12),
              BookingValueRow(label: l.taxesLabel, value: l.vatIncluded),
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s16),
        Container(
          padding: const EdgeInsets.all(KzSpace.s16),
          decoration: BoxDecoration(
            color: kz.sand,
            borderRadius: KzRadii.all(KzRadii.field),
          ),
          child: Row(
            children: [
              KzIcon(KzIcons.receipt, size: KzSize.iconMd, color: kz.ink),
              const SizedBox(width: KzSpace.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.billingInfo,
                      style: KzText.bodySm.copyWith(
                        color: kz.ink,
                        fontWeight: KzText.extraBold,
                      ),
                    ),
                    if (billing != null) ...[
                      const SizedBox(height: KzSpace.s2),
                      Text(
                        billing.type == BillingType.individual
                            ? l.billingIndividualLine(billing.fullName)
                            : l.billingCorporateLine(billing.companyName),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: KzText.caption.copyWith(color: kz.ink2),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: KzSpace.s8),
              Semantics(
                label: l.editItem(l.billingInfo),
                button: true,
                excludeSemantics: true,
                child: KzLink(
                  label: l.edit,
                  onPressed: () => context.push(AppRoutes.billing(b.id)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 53 · Fatura Bilgileri.
class BillingScreen extends ConsumerWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(billingInfoProvider);
    return switch (info) {
      AsyncData(:final value) => _BillingForm(initial: value),
      AsyncError() => BookingError(
        onRetry: () => ref.invalidate(billingInfoProvider),
      ),
      _ => const BookingLoading(cards: 2),
    };
  }
}

class _BillingForm extends ConsumerStatefulWidget {
  const _BillingForm({required this.initial});

  final BillingInfo initial;

  @override
  ConsumerState<_BillingForm> createState() => _BillingFormState();
}

class _BillingFormState extends ConsumerState<_BillingForm> {
  late BillingType _type = widget.initial.type;
  late final _name = TextEditingController(text: widget.initial.fullName);
  final _tckn = TextEditingController();
  late final _address = TextEditingController(text: widget.initial.address);
  late final _email = TextEditingController(text: widget.initial.email);
  late final _company = TextEditingController(text: widget.initial.companyName);
  late final _taxOffice = TextEditingController(text: widget.initial.taxOffice);
  late final _taxNo = TextEditingController(text: widget.initial.taxNumber);
  bool _submitted = false;
  bool _saving = false;

  static const int _taxNoLength = 10;
  static final _emailRe = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  List<TextEditingController> get _all => [
    _name,
    _tckn,
    _address,
    _email,
    _company,
    _taxOffice,
    _taxNo,
  ];

  @override
  void dispose() {
    for (final c in _all) {
      c.dispose();
    }
    super.dispose();
  }

  bool get _corporate => _type == BillingType.corporate;

  String? _required(TextEditingController c) =>
      _submitted && c.text.trim().isEmpty ? context.l10n.errorName : null;

  String? get _tcknError =>
      _submitted && _tckn.text.isNotEmpty && !IdValidators.isTckn(_tckn.text)
      ? context.l10n.errorTckn
      : null;

  String? get _emailError =>
      _submitted && !_emailRe.hasMatch(_email.text.trim())
      ? context.l10n.errorEmail
      : null;

  String? get _taxNoError => _submitted && _taxNo.text.length != _taxNoLength
      ? context.l10n.errorTaxNumber
      : null;

  bool get _valid {
    final base =
        _address.text.trim().isNotEmpty &&
        _emailRe.hasMatch(_email.text.trim());
    if (_corporate) {
      return base &&
          _company.text.trim().isNotEmpty &&
          _taxOffice.text.trim().isNotEmpty &&
          _taxNo.text.length == _taxNoLength;
    }
    return base &&
        _name.text.trim().isNotEmpty &&
        (_tckn.text.isEmpty || IdValidators.isTckn(_tckn.text));
  }

  Future<void> _save() async {
    setState(() => _submitted = true);
    if (!_valid || _saving) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(bookingRepositoryProvider)
          .saveBillingInfo(
            BillingInput(
              info: widget.initial.copyWith(
                type: _type,
                fullName: _name.text.trim(),
                address: _address.text.trim(),
                email: _email.text.trim(),
                companyName: _company.text.trim(),
                taxOffice: _taxOffice.text.trim(),
                taxNumber: _taxNo.text,
              ),
              tckn: _tckn.text.isEmpty ? null : _tckn.text,
            ),
          );
      _tckn.clear();
      ref.invalidate(billingInfoProvider);
      if (!mounted) return;
      showKzToast(context, context.l10n.billingSaved);
      context.pop();
    } on Object {
      if (mounted) showKzToast(context, context.l10n.errorNetwork);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    void changed(String _) => setState(() {});
    const gap = SizedBox(height: KzSpace.s12);
    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      bottomBar: KzBottomBar(
        child: KzButton(label: l.save, loading: _saving, onPressed: _save),
      ),
      children: [
        KzPageTitle(title: l.billingTitle, subtitle: l.billingSubtitle),
        KzSegmented<BillingType>(
          segments: [
            (BillingType.individual, l.billingIndividual),
            (BillingType.corporate, l.billingCorporate),
          ],
          selected: _type,
          onChanged: (t) => setState(() => _type = t),
        ),
        const SizedBox(height: KzSpace.s14),
        if (_corporate) ...[
          KzInput(
            label: l.fieldCompanyName,
            icon: KzIcons.home,
            controller: _company,
            errorText: _required(_company),
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onChanged: changed,
          ),
          gap,
          KzInput(
            label: l.fieldTaxOffice,
            icon: KzIcons.doc,
            controller: _taxOffice,
            errorText: _required(_taxOffice),
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onChanged: changed,
          ),
          gap,
          KzInput(
            label: l.fieldTaxNumber,
            icon: KzIcons.doc,
            controller: _taxNo,
            hint: l.hintTaxNumber,
            errorText: _taxNoError,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(_taxNoLength),
            ],
            onChanged: changed,
          ),
        ] else ...[
          KzInput(
            label: l.fieldFullName,
            icon: KzIcons.user,
            controller: _name,
            errorText: _required(_name),
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.name],
            onChanged: changed,
          ),
          gap,
          KzInput(
            label: l.fieldTcknOptional,
            icon: KzIcons.idcard,
            controller: _tckn,
            hint: widget.initial.tcknLast2 == null
                ? l.hintTckn
                : l.idMaskedTr(widget.initial.tcknLast2!),
            errorText: _tcknError,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            onChanged: changed,
          ),
        ],
        gap,
        KzInput(
          label: l.fieldAddress,
          icon: KzIcons.pin,
          controller: _address,
          errorText: _required(_address),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.fullStreetAddress],
          onChanged: changed,
        ),
        gap,
        KzInput(
          label: l.fieldBillingEmail,
          icon: KzIcons.mail,
          controller: _email,
          errorText: _emailError,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.email],
          onChanged: changed,
        ),
        if (!_corporate) ...[
          const SizedBox(height: KzSpace.s14),
          KzTip(icon: KzIcons.info, message: l.billingCorporateNote),
        ],
      ],
    );
  }
}
