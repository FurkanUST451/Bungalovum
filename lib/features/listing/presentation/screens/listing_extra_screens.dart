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
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_checkbox.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_map_backdrop.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_text_area.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../data/listing_repository.dart';
import '../../domain/listing_detail.dart';
import '../listing_detail_labels.dart';
import '../widgets/rating_label.dart';

/// 26 · Konum (yaklaşık konum + yakındaki yerler).
class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key, required this.id});

  final String id;

  static const double _area = 170;
  static const double _pin = 56;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final d = ref.watch(listingDetailProvider(id)).value;
    final gutter = context.screenGutter;
    final lake = d?.nearby.where((n) => n.kind == NearbyKind.lake).firstOrNull;
    final market = d?.nearby
        .where((n) => n.kind == NearbyKind.market)
        .firstOrNull;
    return Scaffold(
      backgroundColor: kz.bg,
      body: Stack(
        children: [
          Positioned.fill(
            child: KzMapBackdrop(
              lakeLabel: d == null ? null : l.lakeName(d.listing.region),
            ),
          ),
          Center(
            child: Container(
              width: _area,
              height: _area,
              decoration: BoxDecoration(
                color: kz.forest.withValues(alpha: KzOpacity.muted / 4),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
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
                    size: KzSize.iconXl,
                    color: kz.onForest,
                  ),
                ),
              ),
            ),
          ),
          if (lake != null)
            Align(
              alignment: const Alignment(-0.7, -0.38),
              child: KzChip(
                label: l.nearbyMinutes(lake.name, lake.minutes),
                variant: KzChipVariant.onImage,
                size: KzChipSize.small,
                icon: lake.kind.icon,
              ),
            ),
          if (market != null)
            Align(
              alignment: const Alignment(0.6, 0.12),
              child: KzChip(
                label: l.nearbyMinutes(market.name, market.minutes),
                variant: KzChipVariant.onImage,
                size: KzChipSize.small,
                icon: market.kind.icon,
              ),
            ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                gutter,
                KzSpace.s8,
                gutter,
                KzSpace.s24,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      KzNavButton(semanticLabel: l.back),
                      const SizedBox(width: KzSpace.s10),
                      if (d != null)
                        Flexible(
                          child: KzChip(
                            label: l.approxLocation(d.areaLabel),
                            variant: KzChipVariant.onImage,
                            icon: KzIcons.pin,
                          ),
                        ),
                    ],
                  ),
                  if (d != null)
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: KzBreakpoints.mediumContent,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(KzSpace.s18),
                              decoration: BoxDecoration(
                                color: kz.surface,
                                borderRadius: KzRadii.all(KzRadii.lg),
                                boxShadow: KzShadows.strong,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  KzSectionTitle(l.whatsNearby),
                                  for (final p in d.nearby) ...[
                                    const SizedBox(height: KzSpace.s12),
                                    Row(
                                      children: [
                                        KzIconBox(
                                          icon: p.kind.icon,
                                          size: KzSpace.s36,
                                          iconSize: KzSpace.s16 + 1,
                                        ),
                                        const SizedBox(width: KzSpace.s12),
                                        Expanded(
                                          child: Text(
                                            p.name,
                                            style: KzText.bodySm.copyWith(
                                              fontWeight: KzText.bold,
                                              color: kz.ink,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: KzSpace.s8),
                                        Flexible(
                                          child: Text(
                                            nearbyLine(l, p),
                                            textAlign: TextAlign.end,
                                            style: KzText.labelSemi.copyWith(
                                              color: kz.ink2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  const SizedBox(height: KzSpace.s12),
                                  Text(
                                    l.addressAfterBooking,
                                    style: KzText.caption.copyWith(
                                      color: kz.ink2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 27 · Ev Sahibi Profili
class HostProfileScreen extends ConsumerWidget {
  const HostProfileScreen({
    super.key,
    required this.hostId,
    required this.listingId,
  });

  final String hostId;

  /// Profilin açıldığı ilan (ev sahibi verisi ilan detayından gelir).
  final String listingId;

  static const double _cardW = 200;
  static const double _cardH = 150;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final d = ref.watch(listingDetailProvider(listingId)).value;
    if (d == null) {
      return Scaffold(
        backgroundColor: kz.bg,
        body: const SafeArea(child: KzSkeleton()),
      );
    }
    final h = d.host;
    final listings =
        ref.watch(listingsByIdsProvider(h.listingIds)).value ?? const [];
    final big = KzText.h4.copyWith(color: kz.ink, fontSize: KzSpace.s20);
    final small = KzText.micro.copyWith(
      color: kz.ink2,
      fontWeight: KzText.semiBold,
    );
    final infoRows = [
      (l.hostResponseRate, l.percentValue(h.responseRate), false),
      (l.hostResponseTime, h.responseTimeLabel(l), false),
      (l.hostLanguages, h.languages.join(', '), false),
      (
        l.hostIdentity,
        h.identityVerified ? l.hostVerified : l.hostNotVerified,
        h.identityVerified,
      ),
    ];

    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      bottomBar: KzBottomBar(
        child: KzButton(
          label: l.messageHost,
          onPressed: () => context.push(AppRoutes.chat('host-${h.id}')),
        ),
      ),
      children: [
        KzPageTitle(title: l.yourHost),
        Container(
          padding: const EdgeInsets.all(KzSpace.s22),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.hero),
            border: Border.all(color: kz.line),
            boxShadow: KzShadows.soft,
          ),
          child: Column(
            children: [
              KzAvatar(
                name: h.name,
                photoUrl: h.avatarUrl,
                size: KzSize.avatarLg,
                verified: h.identityVerified,
              ),
              const SizedBox(height: KzSpace.s14),
              Text(h.name, style: KzText.h4.copyWith(color: kz.ink)),
              const SizedBox(height: KzSpace.s14),
              KzChip(
                label: h.levelLabel(l),
                variant: KzChipVariant.selected,
                size: KzChipSize.small,
                icon: KzIcons.award,
              ),
              const SizedBox(height: KzSpace.s14),
              Row(
                children: [
                  for (final (v, label) in [
                    ('${h.reviewCount}', l.reviewsLabel),
                    (KzFormat.rating(h.rating), l.ratingLabel),
                    (l.hostYears(h.yearsHosting), l.hostStandard),
                  ])
                    Expanded(
                      child: Semantics(
                        label: '$v $label',
                        child: ExcludeSemantics(
                          child: Column(
                            children: [
                              Text(v, style: big),
                              Text(
                                label,
                                style: small,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s16),
        Container(
          padding: const EdgeInsets.all(KzSpace.s18),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.card),
            border: Border.all(color: kz.line),
          ),
          child: Column(
            children: [
              for (final (i, (k, v, ok)) in infoRows.indexed) ...[
                if (i > 0) const SizedBox(height: KzSpace.s12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        k,
                        style: KzText.bodySm.copyWith(color: kz.ink2),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        v,
                        textAlign: TextAlign.end,
                        style: KzText.bodySm.copyWith(
                          fontWeight: KzText.bold,
                          color: ok ? kz.forest : kz.ink,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s24),
        KzSectionTitle(l.about),
        const SizedBox(height: KzSpace.s8),
        Text(
          h.about,
          style: KzText.bodySm.copyWith(
            color: kz.ink,
            height: KzText.body.height,
          ),
        ),
        const SizedBox(height: KzSpace.s24),
        KzSectionTitle(l.hostListings(h.name)),
        const SizedBox(height: KzSpace.s12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final (i, item) in listings.indexed) ...[
                if (i > 0) const SizedBox(width: KzSpace.s12),
                KzPressable(
                  onPressed: () => context.push(AppRoutes.listing(item.id)),
                  semanticLabel: item.title,
                  child: SizedBox(
                    width: _cardW,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: KzRadii.all(KzRadii.card),
                          child: SizedBox(
                            height: _cardH,
                            child: KzPhoto(
                              url: item.photoUrls.isEmpty
                                  ? null
                                  : item.photoUrls.first,
                            ),
                          ),
                        ),
                        const SizedBox(height: KzSpace.s8),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: KzSpace.s4,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: KzText.bodySm.copyWith(
                                  fontWeight: KzText.extraBold,
                                  color: kz.ink,
                                ),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      l.perNightPrice(
                                        KzFormat.currency(item.nightlyPrice),
                                      ),
                                      style: KzText.captionBold.copyWith(
                                        color: kz.forest,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: KzSpace.s5),
                                  if (item.rating != null)
                                    RatingLabel(rating: item.rating!),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// 29 · İlanı Bildir
class ReportListingScreen extends ConsumerStatefulWidget {
  const ReportListingScreen({super.key, required this.id});

  final String id;

  @override
  ConsumerState<ReportListingScreen> createState() =>
      _ReportListingScreenState();
}

class _ReportListingScreenState extends ConsumerState<ReportListingScreen> {
  ReportReason? _reason;
  final _details = TextEditingController();
  bool _sending = false;

  static const double _detailsMin = 120;

  @override
  void dispose() {
    _details.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    setState(() => _sending = true);
    await ref
        .read(listingRepositoryProvider)
        .report(widget.id, _reason!, _details.text.trim());
    if (!mounted) return;
    showKzToast(context, context.l10n.reportSent);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final reasons = [
      (ReportReason.inaccurate, l.reportInaccurate),
      (ReportReason.fraud, l.reportFraud),
      (ReportReason.offPlatformPayment, l.reportOffPlatform),
      (ReportReason.safety, l.reportSafety),
      (ReportReason.other, l.reportOther),
    ];
    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.close, close: true),
      ),
      bottomBar: KzBottomBar(
        child: KzButton(
          label: l.reportSubmit,
          loading: _sending,
          onPressed: _reason == null ? null : _send,
        ),
      ),
      children: [
        KzPageTitle(title: l.reportTitle, subtitle: l.reportSubtitle),
        Container(
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.card),
            border: Border.all(color: kz.line),
          ),
          child: Column(
            children: [
              for (final (reason, label) in reasons)
                Semantics(
                  inMutuallyExclusiveGroup: true,
                  checked: _reason == reason,
                  child: KzPressable(
                    onPressed: () => setState(() => _reason = reason),
                    semanticLabel: label,
                    pressedScale: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: KzSpace.s16,
                        vertical: KzSpace.s14,
                      ),
                      child: Row(
                        children: [
                          KzRadio(value: _reason == reason),
                          const SizedBox(width: KzSpace.s12),
                          Expanded(
                            child: Text(
                              label,
                              style: KzText.bodyStrongSm.copyWith(
                                color: kz.ink,
                                fontWeight: _reason == reason
                                    ? KzText.extraBold
                                    : KzText.medium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s14),
        KzTextArea(
          label: l.reportDetails,
          hint: l.reportDetailsHint,
          controller: _details,
          minHeight: _detailsMin,
        ),
        const SizedBox(height: KzSpace.s14),
        KzTip(
          icon: KzIcons.alert,
          tone: KzTipTone.warning,
          message: l.reportEmergency,
        ),
      ],
    );
  }
}
