part of 'listing_detail_screen.dart';

const double _sectionGap = KzSpace.s26;

class _Sections extends ConsumerWidget {
  const _Sections({required this.detail});

  final ListingDetail detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final listing = detail.listing;
    Widget divider() => Container(height: KzSize.border, color: kz.line);
    final children = <Widget>[
      Center(
        child: Container(
          width: KzSize.grabberWidth,
          height: KzSize.grabberHeight,
          decoration: BoxDecoration(
            color: kz.line,
            borderRadius: KzRadii.all(KzRadii.hairline),
          ),
        ),
      ),
      _TitleBlock(detail: detail),
      _Stats(detail: detail),
      _RatingStrip(detail: detail),
      _HostRow(detail: detail),
      if (detail.highlights.isNotEmpty) _Highlights(items: detail.highlights),
      if (detail.pool != null) _PoolCard(pool: detail.pool!),
      divider(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.description.summary,
            style: KzText.body.copyWith(color: kz.ink, height: _bodyLeading),
          ),
          const SizedBox(height: KzSpace.s10),
          KzLink(
            label: l.readMore,
            style: KzText.bodySm,
            onPressed: () => showDescriptionSheet(context, detail),
          ),
        ],
      ),
      _ReviewsPreview(detail: detail),
      divider(),
      _AmenitiesPreview(detail: detail),
      divider(),
      _LocationPreview(detail: detail),
      divider(),
      _AvailabilityStrip(listingId: listing.id),
      divider(),
      _ThingsToKnow(detail: detail),
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: KzPressable(
          onPressed: () => context.push(AppRoutes.listingReport(listing.id)),
          semanticLabel: l.reportListing,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              KzIcon(KzIcons.flag, size: KzSpace.s16, color: kz.ink2),
              const SizedBox(width: KzSpace.s8),
              Text(
                l.reportListing,
                style: KzText.labelSemi.copyWith(
                  color: kz.ink2,
                  decoration: TextDecoration.underline,
                  decorationColor: kz.ink2,
                ),
              ),
            ],
          ),
        ),
      ),
      if (detail.nearbyListingIds.isNotEmpty)
        _NearbyListings(ids: detail.nearbyListingIds),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (i, c) in children.indexed) ...[
          if (i > 0) const SizedBox(height: _sectionGap),
          c,
        ],
      ],
    );
  }

  static const double _bodyLeading = 1.55;
}

/// 21/800 bölüm başlığı (ilan detayında).
class _H extends StatelessWidget {
  const _H(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: Text(text, style: KzText.h4.copyWith(color: context.kz.ink)),
  );
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({required this.detail});

  final ListingDetail detail;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final listing = detail.listing;
    final pool = detail.pool;
    final subtitle = [
      if (listing.settings.isNotEmpty) listing.settings.first.label(l),
      if (pool != null) pool.heated ? l.amenityHeatedPool : l.amenityPool,
    ].join(' · ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: KzSpace.s8,
          runSpacing: KzSpace.s8,
          children: [
            KzChip(
              label: listing.propertyType.label(l),
              variant: KzChipVariant.selected,
              size: KzChipSize.small,
              icon: KzIcons.home,
            ),
            KzChip(
              label: detail.locationLabel.split(', ').first,
              variant: KzChipVariant.soft,
              size: KzChipSize.small,
              icon: KzIcons.pin,
              iconColor: kz.apricotText,
            ),
          ],
        ),
        const SizedBox(height: KzSpace.s10),
        Semantics(
          header: true,
          child: Text(listing.title, style: KzText.h1.copyWith(color: kz.ink)),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: KzSpace.s10),
          Text(subtitle, style: KzText.body.copyWith(color: kz.ink2)),
        ],
      ],
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({required this.detail});

  final ListingDetail detail;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final items = [
      (KzIcons.users, l.statGuests(detail.listing.maxGuests)),
      (KzIcons.home, l.statRooms(detail.listing.bedrooms)),
      (KzIcons.bed, l.statBeds(detail.beds)),
      (KzIcons.bath, l.statBaths(detail.bathrooms)),
    ];
    return Row(
      children: [
        for (final (i, (icon, label)) in items.indexed) ...[
          if (i > 0) const SizedBox(width: KzSpace.s8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: KzSpace.s6,
                vertical: KzSpace.s12,
              ),
              decoration: BoxDecoration(
                color: kz.surface,
                borderRadius: KzRadii.all(KzRadii.md),
                border: Border.all(color: kz.line),
              ),
              child: Column(
                children: [
                  KzIcon(icon, size: KzSize.iconMd, color: kz.ink),
                  const SizedBox(height: KzSpace.s6),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.micro.copyWith(color: kz.ink),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _RatingStrip extends StatelessWidget {
  const _RatingStrip({required this.detail});

  final ListingDetail detail;

  static const double _height = 96;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final listing = detail.listing;
    void open() => context.push(AppRoutes.listingReviews(listing.id));
    Widget box({required Widget child, Color? bg, int flex = 100}) => Expanded(
      flex: flex,
      child: KzPressable(
        onPressed: open,
        semanticLabel: l.reviewsTitle,
        child: Container(
          constraints: const BoxConstraints(minHeight: _height),
          padding: const EdgeInsets.all(KzSpace.s8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bg ?? kz.surface,
            borderRadius: KzRadii.all(KzRadii.card),
            border: bg == null ? Border.all(color: kz.line) : null,
          ),
          child: child,
        ),
      ),
    );
    final big = KzText.h4.copyWith(color: kz.ink);
    return Row(
      children: [
        box(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(KzFormat.rating(listing.rating ?? 0), style: big),
              const SizedBox(height: KzSpace.s4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: KzStars(rating: listing.rating ?? 0, size: KzSpace.s12 - 1),
              ),
            ],
          ),
        ),
        if (listing.badge == ListingBadge.guestFavorite) ...[
          const SizedBox(width: KzSpace.s10),
          box(
            flex: 122,
            bg: kz.forest,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                KzIcon(KzIcons.award, size: KzSize.iconLg, color: kz.onForest),
                const SizedBox(height: KzSpace.s4),
                Text(
                  l.guestFavoriteTwoLine,
                  textAlign: TextAlign.center,
                  style: KzText.titleSm.copyWith(color: kz.onForest),
                ),
                if (detail.topPercent != null)
                  Text(
                    l.topPercent(detail.topPercent!),
                    style: KzText.micro.copyWith(
                      color: kz.onForest,
                      fontWeight: KzText.semiBold,
                    ),
                  ),
              ],
            ),
          ),
        ],
        const SizedBox(width: KzSpace.s10),
        box(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${detail.reviewCount}', style: big),
              const SizedBox(height: KzSpace.s4),
              Text(
                l.reviewsLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: KzText.micro.copyWith(
                  color: kz.ink2,
                  fontWeight: KzText.semiBold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HostRow extends StatelessWidget {
  const _HostRow({required this.detail});

  final ListingDetail detail;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final host = detail.host;
    return KzPressable(
      onPressed: () =>
          context.push(AppRoutes.host(host.id, listingId: detail.listing.id)),
      excludeChildSemantics: false,
      semanticLabel: l.hostLine(host.name),
      pressedScale: KzMotion.pressedScale,
      child: Container(
        padding: const EdgeInsets.all(KzSpace.s16),
        decoration: BoxDecoration(
          color: kz.surface,
          borderRadius: KzRadii.all(KzRadii.card),
          border: Border.all(color: kz.line),
        ),
        child: Row(
          children: [
            KzAvatar(
              name: host.name,
              photoUrl: host.avatarUrl,
              verified: host.identityVerified,
            ),
            const SizedBox(width: KzSpace.s14),
            Expanded(
              child: ExcludeSemantics(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.hostLine(host.name),
                      style: KzText.bodyStrongSm.copyWith(color: kz.ink),
                    ),
                    const SizedBox(height: KzSpace.s3),
                    Text(
                      l.hostSubline(
                        host.levelLabel(l),
                        l.hostYears(host.yearsHosting),
                      ),
                      style: KzText.labelMedium.copyWith(color: kz.ink2),
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
              semanticLabel: l.messageHost,
              onPressed: () => context.push(AppRoutes.chat('host-${host.id}')),
            ),
          ],
        ),
      ),
    );
  }
}

class _Highlights extends StatelessWidget {
  const _Highlights({required this.items});

  final List<ListingHighlight> items;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Column(
      children: [
        for (final (i, h) in items.indexed) ...[
          if (i > 0) const SizedBox(height: KzSpace.s18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KzIconBox(
                icon: h.kind.icon,
                tone: h.kind.tone,
                size: KzSize.circleMd,
                iconSize: KzSize.iconLg,
              ),
              const SizedBox(width: KzSpace.s14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      h.title,
                      style: KzText.bodyStrongSm.copyWith(color: kz.ink),
                    ),
                    const SizedBox(height: KzSpace.s3),
                    Text(
                      h.body,
                      style: KzText.labelMedium.copyWith(color: kz.ink2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _PoolCard extends StatelessWidget {
  const _PoolCard({required this.pool});

  final PoolInfo pool;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final months = [
      for (var m = 1; m <= 12; m++) KzFormat.monthName(DateTime(2026, m)),
    ];
    final tiles = [
      (
        KzIcons.thermo,
        l.poolTemperature,
        pool.heated && pool.temperatureC != null
            ? l.poolHeated(pool.temperatureC!)
            : l.poolUnheated,
      ),
      (
        KzIcons.expand,
        l.poolSize,
        l.poolSizeValue(decimal(pool.widthM), decimal(pool.lengthM)),
      ),
      (
        KzIcons.waves,
        l.poolDepth,
        l.poolDepthValue(decimal(pool.depthMinM), decimal(pool.depthMaxM)),
      ),
      (
        KzIcons.calendar,
        l.poolSeason,
        '${months[pool.seasonStartMonth - 1]} – ${months[pool.seasonEndMonth - 1]}',
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(KzSpace.s18),
      decoration: BoxDecoration(
        color: kz.poolSoft,
        borderRadius: KzRadii.all(KzRadii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: KzSize.circleMd,
                height: KzSize.circleMd,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kz.surface,
                  borderRadius: KzRadii.all(KzRadii.icon),
                ),
                child: KzIcon(
                  KzIcons.waves,
                  size: KzSize.iconXl,
                  color: kz.poolText,
                ),
              ),
              const SizedBox(width: KzSpace.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.poolTitle,
                      style: KzText.titleLg.copyWith(color: kz.ink),
                    ),
                    Text(
                      pool.private ? l.poolPrivate : l.poolShared,
                      style: KzText.captionSemi.copyWith(color: kz.poolText),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: KzSpace.s14),
          LayoutBuilder(
            builder: (context, c) {
              final w = (c.maxWidth - KzSpace.s10) / 2;
              return Wrap(
                spacing: KzSpace.s10,
                runSpacing: KzSpace.s10,
                children: [
                  for (final (icon, label, value) in tiles)
                    Container(
                      width: w,
                      padding: const EdgeInsets.all(KzSpace.s14),
                      decoration: BoxDecoration(
                        color: kz.surface,
                        borderRadius: KzRadii.all(KzRadii.md),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              KzIcon(
                                icon,
                                size: KzSpace.s14 + 1,
                                color: kz.poolText,
                              ),
                              const SizedBox(width: KzSpace.s6),
                              Flexible(
                                child: Text(
                                  label,
                                  style: KzText.captionSemi.copyWith(
                                    color: kz.ink2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: KzSpace.s6),
                          Text(
                            value,
                            style: KzText.bodyStrong.copyWith(
                              fontWeight: KzText.extraBold,
                              color: kz.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
          if (pool.note.isNotEmpty) ...[
            const SizedBox(height: KzSpace.s14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KzIcon(
                  KzIcons.sparkles,
                  size: KzSize.iconXs,
                  color: kz.poolText,
                ),
                const SizedBox(width: KzSpace.s8),
                Expanded(
                  child: Text(
                    pool.note,
                    style: KzText.caption.copyWith(color: kz.ink),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ReviewsPreview extends StatelessWidget {
  const _ReviewsPreview({required this.detail});

  final ListingDetail detail;

  static const double _cardWidth = 280;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final id = detail.listing.id;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _H(l.guestsLoved),
        const SizedBox(height: KzSpace.s14),
        Wrap(
          spacing: KzSpace.s8,
          runSpacing: KzSpace.s8,
          children: [
            for (final t in detail.reviewTopics)
              KzChip(
                label: l.topicCount(t.topic.label(l), t.count),
                icon: t.topic.icon,
                variant: switch (t.topic.tone) {
                  KzIconBoxTone.pool => KzChipVariant.pool,
                  KzIconBoxTone.apricot => KzChipVariant.accent,
                  _ => KzChipVariant.selected,
                },
                size: KzChipSize.small,
                onPressed: () => context.push(
                  '${AppRoutes.listingReviews(id)}?konu=${t.topic.name}',
                ),
              ),
          ],
        ),
        const SizedBox(height: KzSpace.s14),
        SizedBox(
          height: ReviewCard.previewHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: detail.reviews.length,
            separatorBuilder: (_, _) => const SizedBox(width: KzSpace.s12),
            itemBuilder: (_, i) => SizedBox(
              width: _cardWidth,
              child: ReviewCard(review: detail.reviews[i], clamp: true),
            ),
          ),
        ),
        const SizedBox(height: KzSpace.s14),
        KzButton(
          label: l.allReviews(detail.reviewCount),
          variant: KzButtonVariant.secondary,
          onPressed: () => context.push(AppRoutes.listingReviews(id)),
        ),
      ],
    );
  }
}

/// Değerlendirme kartı (19 önizleme ve 23 liste).
class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review, this.clamp = false});

  final Review review;

  /// Önizlemede metin 3 satırla sınırlanır.
  final bool clamp;

  /// Yatay önizleme şeridinin yüksekliği (1.3 yazı ölçeğine pay bırakır).
  static const double previewHeight = 214;
  static const int _clampLines = 3;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return Container(
      padding: const EdgeInsets.all(KzSpace.s18),
      decoration: BoxDecoration(
        color: kz.surface,
        borderRadius: KzRadii.all(KzRadii.card),
        border: Border.all(color: kz.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              KzAvatar(name: review.author, size: KzSize.avatarSm),
              const SizedBox(width: KzSpace.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.author,
                      style: KzText.bodySm.copyWith(
                        fontWeight: KzText.extraBold,
                        color: kz.ink,
                      ),
                    ),
                    Text(
                      review.city,
                      style: KzText.caption.copyWith(color: kz.ink2),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: KzSpace.s10),
          Semantics(
            label: l.starsLabel(review.rating),
            child: Row(
              children: [
                KzStars(rating: review.rating.toDouble()),
                const SizedBox(width: KzSpace.s6),
                Flexible(
                  child: Text(
                    '· ${relativeDate(l, review.date, DateTime.now())}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.caption.copyWith(color: kz.ink2),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: KzSpace.s10),
          Text(
            review.text,
            maxLines: clamp ? _clampLines : null,
            overflow: clamp ? TextOverflow.ellipsis : null,
            style: KzText.bodySm.copyWith(
              color: kz.ink,
              height: KzText.body.height,
            ),
          ),
        ],
      ),
    );
  }
}

class _AmenitiesPreview extends StatelessWidget {
  const _AmenitiesPreview({required this.detail});

  final ListingDetail detail;

  static const int _preview = 6;
  static const double _box = 36;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final included = detail.amenityItems
        .where((a) => a.group != AmenityGroup.notIncluded)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _H(l.whatOffers),
        const SizedBox(height: KzSpace.s14),
        LayoutBuilder(
          builder: (context, c) {
            final w = (c.maxWidth - KzSpace.s10) / 2;
            return Wrap(
              spacing: KzSpace.s10,
              runSpacing: KzSpace.s10,
              children: [
                for (final a in included.take(_preview))
                  Container(
                    width: w,
                    padding: const EdgeInsets.all(KzSpace.s14),
                    decoration: BoxDecoration(
                      color: kz.surface,
                      borderRadius: KzRadii.all(KzRadii.md),
                      border: Border.all(color: kz.line),
                    ),
                    child: Row(
                      children: [
                        KzIconBox(
                          icon: a.kind.icon,
                          tone: a.kind.previewTone,
                          size: _box,
                        ),
                        const SizedBox(width: KzSpace.s10),
                        Expanded(
                          child: Text(
                            a.kind.label(l),
                            style: KzText.label.copyWith(color: kz.ink),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: KzSpace.s14),
        KzButton(
          label: l.allAmenities(detail.amenityItems.length),
          variant: KzButtonVariant.secondary,
          onPressed: () =>
              context.push(AppRoutes.listingAmenities(detail.listing.id)),
        ),
      ],
    );
  }
}

class _LocationPreview extends StatelessWidget {
  const _LocationPreview({required this.detail});

  final ListingDetail detail;

  static const double _mapHeight = 230;
  static const double _area = 110;
  static const double _pin = 52;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final lake = detail.nearby
        .where((n) => n.kind == NearbyKind.lake)
        .firstOrNull;
    void open() => context.push(AppRoutes.listingLocation(detail.listing.id));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _H(l.whereYouWillBe),
        const SizedBox(height: KzSpace.s12),
        Text(
          detail.locationLabel,
          style: KzText.bodySm.copyWith(color: kz.ink2),
        ),
        const SizedBox(height: KzSpace.s12),
        KzPressable(
          onPressed: open,
          semanticLabel: l.expandMap,
          excludeChildSemantics: false,
          pressedScale: 1,
          child: ClipRRect(
            borderRadius: KzRadii.all(KzRadii.lg),
            child: SizedBox(
              height: _mapHeight,
              child: Stack(
                children: [
                  const Positioned.fill(child: KzMapBackdrop()),
                  Center(
                    child: Container(
                      width: _area,
                      height: _area,
                      decoration: BoxDecoration(
                        color: kz.forest.withValues(alpha: 0.12),
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
                            size: KzSize.iconLg,
                            color: kz.onForest,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (lake != null)
                    Positioned(
                      left: KzSpace.s12,
                      top: KzSpace.s14,
                      child: KzChip(
                        label: l.nearbyMinutes(lake.name, lake.minutes),
                        variant: KzChipVariant.onImage,
                        size: KzChipSize.small,
                        icon: KzIcons.waves,
                        iconColor: kz.poolText,
                      ),
                    ),
                  Positioned(
                    right:
                        KzSpace.s12 - (KzSize.minTouch - KzSize.circleSm) / 2,
                    top: KzSpace.s12 - (KzSize.minTouch - KzSize.circleSm) / 2,
                    child: KzCircleButton(
                      icon: KzIcons.expand,
                      shadow: KzShadows.card,
                      iconSize: KzSize.iconSm - 1,
                      semanticLabel: l.expandMap,
                      onPressed: open,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: KzSpace.s12),
        Text(
          l.locationAfterBooking,
          style: KzText.labelMedium.copyWith(color: kz.ink2),
        ),
      ],
    );
  }
}

class _AvailabilityStrip extends ConsumerWidget {
  const _AvailabilityStrip({required this.listingId});

  final String listingId;

  static const double _cellHeight = 64;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final draft = ref.watch(bookingDraftControllerProvider(listingId));
    final dates = draft.dates;
    final anchor = dates?.checkIn ?? DateTime.now();
    final monday = DateTime(
      anchor.year,
      anchor.month,
      anchor.day,
    ).subtract(Duration(days: anchor.weekday - 1));
    final weekdays = l.weekdaysShort.split(',');

    Future<void> pick() async {
      final r = await context.push<DatePickerResult>(
        AppRoutes.dates,
        extra: DatePickerArgs(initial: dates, listingId: listingId),
      );
      if (r != null) {
        ref
            .read(bookingDraftControllerProvider(listingId).notifier)
            .setDates(r.dates);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _H(l.availability),
                  const SizedBox(height: KzSpace.s3),
                  Text(
                    dates == null
                        ? l.addDatesForPrice
                        : l.datesSummary(
                            KzFormat.dateRange(dates.checkIn, dates.checkOut),
                            dates.nights,
                          ),
                    style: KzText.bodySm.copyWith(color: kz.ink2),
                  ),
                ],
              ),
            ),
            KzCircleButton(
              icon: KzIcons.calendar,
              diameter: KzSize.minTouch,
              iconSize: KzSize.iconSm + 1,
              background: kz.sand,
              semanticLabel: l.changeDates,
              onPressed: pick,
            ),
          ],
        ),
        const SizedBox(height: KzSpace.s14),
        Row(
          children: [
            for (var i = 0; i < DateTime.daysPerWeek; i++) ...[
              if (i > 0) const SizedBox(width: KzSpace.s6),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final d = monday.add(Duration(days: i));
                    final edge =
                        dates != null &&
                        (d == dates.checkIn || d == dates.checkOut);
                    final mid =
                        dates != null &&
                        d.isAfter(dates.checkIn) &&
                        d.isBefore(dates.checkOut);
                    final fg = edge ? kz.onForest : kz.ink;
                    return KzPressable(
                      onPressed: pick,
                      semanticLabel: KzFormat.dayLong(d),
                      selected: edge || mid,
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: _cellHeight,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: edge
                              ? kz.forest
                              : mid
                              ? kz.forestSoft
                              : kz.surface,
                          borderRadius: KzRadii.all(KzRadii.tile),
                          border: edge || mid
                              ? null
                              : Border.all(color: kz.line),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              weekdays[i],
                              style: KzText.micro.copyWith(
                                color: edge ? kz.onForest : kz.ink2,
                                fontWeight: KzText.semiBold,
                              ),
                            ),
                            Text(
                              '${d.day}',
                              style: KzText.title.copyWith(color: fg),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _ThingsToKnow extends StatelessWidget {
  const _ThingsToKnow({required this.detail});

  final ListingDetail detail;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final id = detail.listing.id;
    final r = detail.rules;
    final rows = [
      (
        KzIcons.calx,
        l.cancellationPolicy,
        l.cancellationSummary(detail.freeCancelHours),
        1,
      ),
      (
        KzIcons.key,
        l.houseRules,
        l.houseRulesSummary(
          r.checkInFrom,
          r.checkOutBy,
          detail.listing.maxGuests,
        ),
        0,
      ),
      (
        KzIcons.shield,
        l.safetyTitle,
        detail.safety.take(2).map((s) => s.kind.label(l)).join(' · '),
        2,
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _H(l.thingsToKnow),
        for (final (icon, title, sub, tab) in rows) ...[
          const SizedBox(height: KzSpace.s10),
          KzActionRow(
            icon: icon,
            tone: KzIconBoxTone.sand,
            title: title,
            subtitle: sub,
            onPressed: () =>
                context.push('${AppRoutes.listingRules(id)}?sekme=$tab'),
          ),
        ],
      ],
    );
  }
}

class _NearbyListings extends ConsumerWidget {
  const _NearbyListings({required this.ids});

  final List<String> ids;

  static const double _width = 230;
  static const double _photo = 270;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final listings = ref.watch(listingsByIdsProvider(ids)).value ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _H(l.nearbyListings),
        const SizedBox(height: KzSpace.s14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final (i, item) in listings.indexed) ...[
                if (i > 0) const SizedBox(width: KzSpace.s12),
                SizedBox(
                  width: _width,
                  child: KzPressable(
                    onPressed: () => context.push(AppRoutes.listing(item.id)),
                    excludeChildSemantics: false,
                    semanticLabel: item.title,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: KzRadii.all(KzRadii.lg),
                          child: SizedBox(
                            height: _photo,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                KzPhoto(
                                  url: item.photoUrls.isEmpty
                                      ? null
                                      : item.photoUrls.first,
                                ),
                                Positioned(
                                  top:
                                      KzSpace.s12 -
                                      (KzSize.minTouch - KzSize.circleSm) / 2,
                                  right:
                                      KzSpace.s12 -
                                      (KzSize.minTouch - KzSize.circleSm) / 2,
                                  child: SaveListingButton(listingId: item.id),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: KzSpace.s10),
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
                                style: KzText.titleSm.copyWith(color: kz.ink),
                              ),
                              const SizedBox(height: KzSpace.s3),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      l.perNightPrice(
                                        KzFormat.currency(item.nightlyPrice),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: KzText.label.copyWith(
                                        color: kz.forest,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: KzSpace.s6),
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
