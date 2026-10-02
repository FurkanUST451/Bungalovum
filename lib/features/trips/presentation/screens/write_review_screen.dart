import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_bottom_bar.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_photo_picker.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_star_rating.dart';
import '../../../../core/widgets/kz_text_area.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/data/booking_repository.dart';
import '../../../booking/presentation/widgets/booking_parts.dart';
import '../../../listing/data/listing_repository.dart';
import '../../domain/trip_models.dart';
import '../controllers/trips_controller.dart';

extension ReviewCategoryUi on ReviewCategory {
  String label(AppLocalizations l) => switch (this) {
    ReviewCategory.cleanliness => l.reviewCleanliness,
    ReviewCategory.accuracy => l.reviewAccuracy,
    ReviewCategory.communication => l.reviewCommunication,
    ReviewCategory.location => l.reviewLocation,
    ReviewCategory.value => l.reviewValue,
  };
}

extension ReviewLikeUi on ReviewLike {
  String label(AppLocalizations l) => switch (this) {
    ReviewLike.pool => l.likePool,
    ReviewLike.view => l.likeView,
    ReviewLike.quiet => l.likeQuiet,
    ReviewLike.cleanliness => l.likeCleanliness,
    ReviewLike.host => l.likeHost,
    ReviewLike.location => l.likeLocation,
  };
}

String ratingWord(AppLocalizations l, int stars) => switch (stars) {
  1 => l.rating1,
  2 => l.rating2,
  3 => l.rating3,
  4 => l.rating4,
  _ => l.rating5,
};

/// 55 · Değerlendirme Yaz.
class WriteReviewScreen extends ConsumerStatefulWidget {
  const WriteReviewScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  ConsumerState<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends ConsumerState<WriteReviewScreen> {
  final _text = TextEditingController();
  int _overall = 0;
  final Map<ReviewCategory, int> _categories = {};
  final Set<ReviewLike> _likes = {};
  List<String> _photos = const [];
  bool _submitted = false;
  bool _sending = false;

  static const double _bigStar = 38;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  bool get _ratingsOk =>
      _overall > 0 && _categories.length == ReviewCategory.values.length;

  bool get _textOk => _text.text.trim().length >= ReviewPolicy.minLength;

  Future<void> _send() async {
    setState(() => _submitted = true);
    if (!_ratingsOk || !_textOk || _sending) return;
    HapticFeedback.lightImpact();
    setState(() => _sending = true);
    try {
      await ref
          .read(tripActionsProvider.notifier)
          .submitReview(
            widget.bookingId,
            ReviewInput(
              overall: _overall,
              categories: Map.of(_categories),
              likes: Set.of(_likes),
              text: _text.text.trim(),
              photoPaths: _photos,
            ),
          );
      if (!mounted) return;
      final l = context.l10n;
      showKzToast(context, l.reviewThanksBody, title: l.reviewThanksTitle);
      context.pop();
    } on Object {
      if (mounted) showKzToast(context, context.l10n.errorNetwork);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final booking = ref.watch(bookingProvider(widget.bookingId)).value;
    final title = booking == null
        ? null
        : ref
              .watch(listingDetailProvider(booking.listingId))
              .value
              ?.listing
              .title;
    String stars(int n) => l.starsOf(n);

    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.close, close: true),
      ),
      bottomBar: KzBottomBar(
        child: KzButton(
          label: l.submitReview,
          loading: _sending,
          onPressed: _overall == 0 ? null : _send,
        ),
      ),
      children: [
        KzPageTitle(
          title: l.reviewTitle,
          subtitle: booking == null
              ? null
              : [?title, KzFormat.monthYear(booking.dates.checkIn)].join(' · '),
        ),
        BookingCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.overallRating,
                style: KzText.titleSm.copyWith(color: kz.ink),
              ),
              const SizedBox(height: KzSpace.s8),
              KzStarRating(
                value: _overall,
                size: _bigStar,
                gap: KzSpace.s10,
                semanticLabel: l.overallRating,
                valueLabel: stars,
                onChanged: (v) => setState(() => _overall = v),
              ),
              if (_overall > 0) ...[
                const SizedBox(height: KzSpace.s4),
                Text(
                  ratingWord(l, _overall),
                  style: KzText.label.copyWith(color: kz.forest),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s16),
        BookingCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l.detailedRating,
                style: KzText.titleSm.copyWith(color: kz.ink),
              ),
              for (final c in ReviewCategory.values)
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        c.label(l),
                        style: KzText.bodySm.copyWith(
                          color: kz.ink,
                          fontWeight: KzText.bold,
                        ),
                      ),
                    ),
                    KzStarRating(
                      value: _categories[c] ?? 0,
                      semanticLabel: c.label(l),
                      valueLabel: stars,
                      onChanged: (v) => setState(() => _categories[c] = v),
                    ),
                  ],
                ),
            ],
          ),
        ),
        if (_submitted && !_ratingsOk) ...[
          const SizedBox(height: KzSpace.s10),
          KzTip(
            icon: KzIcons.alert,
            tone: KzTipTone.warning,
            message: l.errorRateAll,
          ),
        ],
        const SizedBox(height: KzSpace.s20),
        Text(l.whatYouLiked, style: KzText.titleSm.copyWith(color: kz.ink)),
        const SizedBox(height: KzSpace.s10),
        Wrap(
          spacing: KzSpace.s8,
          runSpacing: KzSpace.s8,
          children: [
            for (final like in ReviewLike.values)
              Semantics(
                checked: _likes.contains(like),
                child: KzChip(
                  label: like.label(l),
                  variant: _likes.contains(like)
                      ? KzChipVariant.filled
                      : KzChipVariant.outline,
                  onPressed: () => setState(
                    () => _likes.contains(like)
                        ? _likes.remove(like)
                        : _likes.add(like),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: KzSpace.s16),
        KzTextArea(
          label: l.yourReview,
          hint: l.reviewHint,
          controller: _text,
          minLines: 3,
          maxLength: ReviewPolicy.maxLength,
          errorText: _submitted && !_textOk
              ? l.errorReviewShort(ReviewPolicy.minLength)
              : null,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: KzSpace.s10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: KzPhotoPicker(
                paths: _photos,
                max: ReviewPolicy.maxPhotos,
                size: KzSize.tile,
                addLabel: l.photoAdd,
                removeLabel: l.photoRemove,
                onChanged: (p) => setState(() => _photos = p),
              ),
            ),
            Semantics(
              liveRegion: true,
              child: Text(
                l.charCount(_text.text.length, ReviewPolicy.maxLength),
                style: KzText.captionSemi.copyWith(color: kz.ink2),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
