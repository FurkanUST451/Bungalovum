import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../l10n/l10n.dart';
import '../../data/listing_repository.dart';
import '../../domain/listing.dart';
import '../../domain/listing_detail.dart';

/// 20 · İlan Açıklaması (izin belge no burada).
Future<void> showDescriptionSheet(BuildContext context, ListingDetail d) {
  final l = context.l10n;
  return showKzSheet<void>(
    context: context,
    title: l.aboutListing,
    closeLabel: l.close,
    builder: (ctx) {
      final kz = ctx.kz;
      Widget para(String title, String body) => Padding(
        padding: const EdgeInsets.only(bottom: KzSpace.s18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: KzText.bodyStrong.copyWith(
                fontWeight: KzText.extraBold,
                color: kz.ink,
              ),
            ),
            const SizedBox(height: KzSpace.s6),
            Text(
              body,
              style: KzText.bodySm.copyWith(color: kz.ink, height: _leading),
            ),
          ],
        ),
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          para(l.descSpace, d.description.space),
          para(l.descGuestAccess, d.description.guestAccess),
          para(l.descOther, d.description.otherNotes),
          Text(
            l.listingNumbers(d.listingNo, d.permitNo),
            style: KzText.captionSemi.copyWith(color: kz.ink2),
          ),
        ],
      );
    },
  );
}

const double _leading = 1.55;

/// 28 · Paylaş
Future<void> showShareSheet(BuildContext context, Listing listing) {
  final l = context.l10n;
  return showKzSheet<void>(
    context: context,
    title: l.share,
    closeLabel: l.close,
    builder: (_) => _Share(listing: listing),
  );
}

class _Share extends ConsumerWidget {
  const _Share({required this.listing});

  final Listing listing;

  static const double _thumb = 64;
  static const double _target = 58;

  Future<void> _copy(BuildContext context, String link) async {
    await Clipboard.setData(ClipboardData(text: link));
    if (!context.mounted) return;
    final kz = context.kz;
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        content: Text(
          context.l10n.linkCopied,
          style: KzText.label.copyWith(color: kz.onForest),
        ),
        backgroundColor: kz.ink,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: KzRadii.all(KzRadii.md)),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final link = ref.read(listingRepositoryProvider).shareLink(listing.id);
    // Sistem paylaşım sayfası için share_plus paketi onayı bekleniyor;
    // şimdilik tüm hedefler bağlantıyı kopyalar.
    final targets = [
      (KzIcons.chat, l.shareWhatsapp, kz.forestSoft, kz.forest),
      (KzIcons.send, l.shareMessages, kz.poolSoft, kz.poolText),
      (KzIcons.mail, l.shareEmail, kz.sand, kz.ink),
      (KzIcons.users, l.shareOther, kz.apricotSoft, kz.apricotText),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(KzSpace.s10),
          decoration: BoxDecoration(
            color: kz.bg,
            borderRadius: KzRadii.all(KzRadii.field),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: KzRadii.all(KzRadii.tile),
                child: SizedBox.square(
                  dimension: _thumb,
                  child: KzPhoto(
                    url: listing.photoUrls.isEmpty
                        ? null
                        : listing.photoUrls.first,
                  ),
                ),
              ),
              const SizedBox(width: KzSpace.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listing.title,
                      style: KzText.titleSm.copyWith(color: kz.ink),
                    ),
                    const SizedBox(height: KzSpace.s3),
                    Row(
                      children: [
                        KzIcon(
                          KzIcons.starFilled,
                          size: KzSpace.s12,
                          color: kz.star,
                        ),
                        const SizedBox(width: KzSpace.s4),
                        Flexible(
                          child: Text(
                            l.ratingAndRegion(
                              KzFormat.rating(listing.rating ?? 0),
                              listing.region,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: KzText.captionBold.copyWith(color: kz.ink2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: KzSpace.s16),
        KzPressable(
          onPressed: () => _copy(context, link),
          semanticLabel: l.copyLink,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: KzSpace.s16,
              vertical: KzSpace.s14,
            ),
            decoration: BoxDecoration(
              color: kz.forestSoft,
              borderRadius: KzRadii.all(KzRadii.field),
            ),
            child: Row(
              children: [
                KzIcon(KzIcons.copy, size: KzSize.iconMd, color: kz.forest),
                const SizedBox(width: KzSpace.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.copyLink,
                        style: KzText.bodyStrongSm.copyWith(
                          fontWeight: KzText.extraBold,
                          color: kz.forest,
                        ),
                      ),
                      Text(
                        link,
                        style: KzText.caption.copyWith(color: kz.ink2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: KzSpace.s16),
        Row(
          children: [
            for (final (icon, label, bg, fg) in targets)
              Expanded(
                child: KzPressable(
                  onPressed: () => _copy(context, link),
                  semanticLabel: label,
                  child: Column(
                    children: [
                      Container(
                        width: _target,
                        height: _target,
                        decoration: BoxDecoration(
                          color: bg,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: KzIcon(icon, size: KzSize.iconLg, color: fg),
                        ),
                      ),
                      const SizedBox(height: KzSpace.s8),
                      Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: KzText.micro.copyWith(
                          color: kz.ink,
                          fontWeight: KzText.semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
