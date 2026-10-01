import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_avatar.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_segmented.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/presentation/controllers/booking_draft.dart';
import '../../data/listing_repository.dart';
import '../../domain/listing_detail.dart';
import '../listing_detail_labels.dart';
import 'listing_detail_screen.dart' show ReviewCard;

/// Ortak iskelet: geri butonu + büyük başlık + içerik.
class _InfoPage extends StatelessWidget {
  const _InfoPage({required this.title, this.subtitle, required this.children});

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return KzScaffold(
      header: KzTopBar(leading: KzNavButton(semanticLabel: l.back)),
      children: [
        KzPageTitle(title: title, subtitle: subtitle),
        ...children,
      ],
    );
  }
}

/// Yüklenirken iskelet.
class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) => _InfoPage(
    title: '',
    children: [
      for (var i = 0; i < 3; i++) ...[
        KzSkeleton(
          height: KzSize.tabBar * 2,
          borderRadius: KzRadii.all(KzRadii.card),
        ),
        const SizedBox(height: KzSpace.s10),
      ],
    ],
  );
}

/// Kart içinde ikon kutulu satırlar (24 ve 25).
class _IconCard extends StatelessWidget {
  const _IconCard({required this.rows});

  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Container(
      padding: const EdgeInsets.all(KzSpace.s16),
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.all(KzRadii.card),
        border: Border.all(color: kz.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, r) in rows.indexed) ...[
            if (i > 0) const SizedBox(height: KzSpace.s14),
            r,
          ],
        ],
      ),
    );
  }
}

class _IconLine extends StatelessWidget {
  const _IconLine({
    required this.icon,
    required this.title,
    this.subtitle,
    this.tone = KzIconBoxTone.sand,
    this.struck = false,
  });

  final KzIcons icon;
  final String title;
  final String? subtitle;
  final KzIconBoxTone tone;

  /// Dahil olmayan olanak: üstü çizili, soluk.
  final bool struck;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Row(
      children: [
        Opacity(
          opacity: struck ? KzOpacity.muted : 1,
          child: KzIconBox(icon: icon, tone: tone, iconSize: KzSize.iconSm + 1),
        ),
        const SizedBox(width: KzSpace.s14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: KzText.bodyStrongSm.copyWith(
                  color: struck ? kz.placeholder : kz.ink,
                  decoration: struck ? TextDecoration.lineThrough : null,
                  decorationColor: kz.placeholder,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: KzSpace.s2),
                Text(subtitle!, style: KzText.caption.copyWith(color: kz.ink2)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// 23 · Değerlendirmeler
class ReviewsScreen extends ConsumerStatefulWidget {
  const ReviewsScreen({super.key, required this.id, this.topic});

  final String id;
  final ReviewTopic? topic;

  @override
  ConsumerState<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends ConsumerState<ReviewsScreen> {
  late ReviewTopic? _topic = widget.topic;

  static const double _barWidth = 56;
  static const double _labelWidth = 64;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final d = ref.watch(listingDetailProvider(widget.id)).value;
    if (d == null) return const _Loading();
    final rating = d.listing.rating ?? 0;
    final bars = [
      (l.ratingCleanliness, d.ratings.cleanliness),
      (l.ratingAccuracy, d.ratings.accuracy),
      (l.ratingCommunication, d.ratings.communication),
      (l.ratingLocation, d.ratings.location),
    ];
    final reviews = _topic == null
        ? d.reviews
        : d.reviews.where((r) => r.topics.contains(_topic)).toList();

    return _InfoPage(
      title: l.reviewsTitle,
      children: [
        Container(
          padding: const EdgeInsets.all(KzSpace.s18),
          decoration: BoxDecoration(
            color: kz.surface,
            borderRadius: KzRadii.all(KzRadii.lg),
            border: Border.all(color: kz.line),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: KzSpace.s16,
            runSpacing: KzSpace.s16,
            children: [
              Semantics(
                label:
                    '${KzFormat.rating(rating)}, ${l.reviewsCount(d.reviewCount)}',
                child: ExcludeSemantics(
                  child: Column(
                    children: [
                      Text(
                        KzFormat.rating(rating),
                        style: KzText.display.copyWith(color: kz.ink),
                      ),
                      const SizedBox(height: KzSpace.s4),
                      KzStars(rating: rating, size: KzSpace.s13),
                      const SizedBox(height: KzSpace.s4),
                      Text(
                        l.reviewsCount(d.reviewCount),
                        style: KzText.captionSemi.copyWith(color: kz.ink2),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final (label, value) in bars)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: KzSpace.s4),
                      child: Semantics(
                        label: '$label ${KzFormat.rating(value)}',
                        child: ExcludeSemantics(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: _labelWidth,
                                child: Text(
                                  label,
                                  style: KzText.micro.copyWith(
                                    color: kz.ink2,
                                    fontWeight: KzText.semiBold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: KzSpace.s8),
                              ClipRRect(
                                borderRadius: KzRadii.all(KzRadii.hairline),
                                child: SizedBox(
                                  width: _barWidth,
                                  height: KzSize.strengthBar,
                                  child: LinearProgressIndicator(
                                    value: value / 5,
                                    backgroundColor: kz.line,
                                    color: kz.forest,
                                  ),
                                ),
                              ),
                              const SizedBox(width: KzSpace.s8),
                              Text(
                                KzFormat.rating(value),
                                style: KzText.micro.copyWith(color: kz.ink),
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
        const SizedBox(height: KzSpace.s14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: [
              Semantics(
                selected: _topic == null,
                child: KzChip(
                  label: l.all,
                  variant: _topic == null
                      ? KzChipVariant.filled
                      : KzChipVariant.outline,
                  onPressed: () => setState(() => _topic = null),
                ),
              ),
              for (final t in d.reviewTopics) ...[
                const SizedBox(width: KzSpace.s8),
                Semantics(
                  selected: _topic == t.topic,
                  child: KzChip(
                    label: l.topicCount(t.topic.label(l), t.count),
                    variant: _topic == t.topic
                        ? KzChipVariant.filled
                        : KzChipVariant.outline,
                    onPressed: () => setState(() => _topic = t.topic),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s12),
        for (final r in reviews) ...[
          ReviewCard(review: r),
          const SizedBox(height: KzSpace.s10),
        ],
      ],
    );
  }
}

/// 24 · Olanaklar
class AmenitiesScreen extends ConsumerWidget {
  const AmenitiesScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final d = ref.watch(listingDetailProvider(id)).value;
    if (d == null) return const _Loading();
    return _InfoPage(
      title: l.whatOffers,
      subtitle: l.amenityCount(d.amenityItems.length),
      children: [
        for (final group in AmenityGroup.values)
          if (d.amenityItems.any((a) => a.group == group)) ...[
            const SizedBox(height: KzSpace.s10),
            KzOverline(group.label(l)),
            const SizedBox(height: KzSpace.s10),
            _IconCard(
              rows: [
                for (final a in d.amenityItems.where((a) => a.group == group))
                  _IconLine(
                    icon: a.kind.icon,
                    title: a.kind.label(l),
                    subtitle: a.note,
                    tone: group == AmenityGroup.notIncluded
                        ? KzIconBoxTone.sand
                        : KzIconBoxTone.forest,
                    struck: group == AmenityGroup.notIncluded,
                  ),
              ],
            ),
          ],
      ],
    );
  }
}

/// 25 · Kurallar ve İptal (Ev kuralları / İptal / Güvenlik sekmeleri).
class RulesScreen extends ConsumerStatefulWidget {
  const RulesScreen({super.key, required this.id, this.initialTab = 0});

  final String id;
  final int initialTab;

  @override
  ConsumerState<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends ConsumerState<RulesScreen> {
  late int _tab = widget.initialTab;

  static const double _dot = 16;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final d = ref.watch(listingDetailProvider(widget.id)).value;
    if (d == null) return const _Loading();
    final r = d.rules;
    final dates = ref.watch(bookingDraftControllerProvider(widget.id)).dates;

    Widget section(String title, List<Widget> rows) => Padding(
      padding: const EdgeInsets.only(top: KzSpace.s14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          KzOverline(title),
          const SizedBox(height: KzSpace.s10),
          _IconCard(rows: rows),
        ],
      ),
    );

    final house = [
      section(l.rulesCheckInOut, [
        _IconLine(
          icon: KzIcons.clock,
          title: l.ruleCheckIn(r.checkInFrom, r.checkInTo),
        ),
        _IconLine(icon: KzIcons.clock, title: l.ruleCheckOut(r.checkOutBy)),
        _IconLine(
          icon: KzIcons.key,
          title: switch (r.selfCheckIn) {
            SelfCheckIn.keybox => l.ruleKeybox,
            SelfCheckIn.smartLock => l.ruleSmartLock,
            SelfCheckIn.none => l.ruleHostCheckIn,
          },
        ),
      ]),
      section(l.rulesDuringStay, [
        _IconLine(
          icon: KzIcons.users,
          title: l.ruleMaxGuests(d.listing.maxGuests),
        ),
        _IconLine(
          icon: KzIcons.paw,
          title: d.listing.petsAllowed ? l.rulePetsYes : l.rulePetsNo,
        ),
        _IconLine(
          icon: KzIcons.moon,
          title: l.ruleQuiet(r.quietFrom, r.quietTo),
        ),
        if (!r.smokingAllowed)
          _IconLine(icon: KzIcons.flame, title: l.ruleNoSmoking),
      ]),
    ];

    Widget cancel() {
      if (dates == null) {
        return Padding(
          padding: const EdgeInsets.only(top: KzSpace.s14),
          child: Text(
            l.cancelPickDates,
            style: KzText.bodySm.copyWith(color: kz.ink2),
          ),
        );
      }
      final [inH, inM] = r.checkInFrom.split(':').map(int.parse).toList();
      final deadline = DateTime(
        dates.checkIn.year,
        dates.checkIn.month,
        dates.checkIn.day,
        inH,
        inM,
      ).subtract(Duration(hours: d.freeCancelHours));
      final when = KzFormat.dayMonthTime(deadline);
      Widget step(Color c, String title, String body) => Semantics(
        container: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: _dot,
              height: _dot,
              margin: const EdgeInsets.only(top: KzSpace.s2),
              decoration: BoxDecoration(color: c, shape: BoxShape.circle),
            ),
            const SizedBox(width: KzSpace.s14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: KzText.bodySm.copyWith(
                      fontWeight: KzText.extraBold,
                      color: kz.ink,
                    ),
                  ),
                  const SizedBox(height: KzSpace.s2),
                  Text(body, style: KzText.caption.copyWith(color: kz.ink2)),
                ],
              ),
            ),
          ],
        ),
      );
      return section(_tab == 0 ? l.rulesCancelPreview : l.cancellationPolicy, [
        step(kz.forest, l.cancelUntil(when), l.cancelFullRefund),
        step(kz.apricot, l.cancelAfter(when), l.cancelNoRefund),
      ]);
    }

    final safety = section(l.safetyTitle, [
      for (final s in d.safety)
        _IconLine(icon: s.kind.icon, title: s.kind.label(l), subtitle: s.note),
    ]);

    return _InfoPage(
      title: l.thingsToKnow,
      children: [
        KzSegmented<int>(
          segments: [
            (0, l.rulesTabHouse),
            (1, l.rulesTabCancel),
            (2, l.rulesTabSafety),
          ],
          selected: _tab,
          onChanged: (t) => setState(() => _tab = t),
        ),
        ...switch (_tab) {
          0 => [...house, cancel()],
          1 => [cancel()],
          _ => [safety],
        },
      ],
    );
  }
}
