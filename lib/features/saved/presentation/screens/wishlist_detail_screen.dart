import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_circle_button.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_screen.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../core/widgets/kz_spot_illustration.dart';
import '../../../../core/widgets/kz_switch.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../booking/domain/price_calculator.dart';
import '../../../booking/presentation/screens/date_picker_screen.dart';
import '../../../booking/presentation/screens/guest_picker_screen.dart';
import '../../../explore/presentation/widgets/explore_message.dart';
import '../../../search/domain/search_query.dart';
import '../../../search/presentation/controllers/search_controller.dart';
import '../../../search/presentation/search_labels.dart';
import '../../data/wishlist_repository.dart';
import '../../domain/wishlist.dart';
import '../controllers/saved_listings_controller.dart';
import '../widgets/save_listing_button.dart';

/// 58 · Liste Detayı. Fiyatlar aktif aramanın tarih ve misafirlerine göre.
class WishlistDetailScreen extends ConsumerWidget {
  const WishlistDetailScreen({super.key, required this.listId});

  final String listId;

  Future<void> _pickDates(BuildContext context, WidgetRef ref) async {
    final q = ref.read(searchQueryControllerProvider);
    final r = await context.push<DatePickerResult>(
      AppRoutes.dates,
      extra: DatePickerArgs(initial: q.dates),
    );
    if (r != null) {
      ref.read(searchQueryControllerProvider.notifier).setDates(r.dates);
    }
  }

  Future<void> _pickGuests(BuildContext context, WidgetRef ref) async {
    final q = ref.read(searchQueryControllerProvider);
    final g = await context.push<GuestCount>(
      AppRoutes.guests,
      extra: GuestPickerArgs(initial: q.guests),
    );
    if (g != null) {
      ref.read(searchQueryControllerProvider.notifier).setGuests(g);
    }
  }

  Future<void> _share(BuildContext context, WidgetRef ref, Wishlist w) async {
    final l = context.l10n;
    if (!w.shareable) {
      showKzToast(context, l.listNotShareable);
      await showEditListSheet(context, w);
      return;
    }
    final link = ref.read(wishlistRepositoryProvider).shareLink(w.id);
    await Clipboard.setData(ClipboardData(text: link));
    if (context.mounted) showKzToast(context, l.listLinkCopied);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final list = ref
        .watch(wishlistsProvider)
        .value
        ?.where((w) => w.id == listId)
        .firstOrNull;
    final items = ref.watch(wishlistItemsProvider(listId));
    final q = ref.watch(searchQueryControllerProvider);
    final dates = q.dates;

    return KzScaffold(
      header: KzTopBar(
        leading: KzNavButton(semanticLabel: l.back),
        trailing: list == null
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  KzCircleButton(
                    icon: KzIcons.share,
                    diameter: KzSize.backButton,
                    iconSize: KzSize.iconMd,
                    shadow: KzShadows.card,
                    semanticLabel: l.shareList,
                    onPressed: () => _share(context, ref, list),
                  ),
                  const SizedBox(width: KzSpace.s10),
                  KzCircleButton(
                    icon: KzIcons.edit,
                    diameter: KzSize.backButton,
                    iconSize: KzSize.iconMd,
                    shadow: KzShadows.card,
                    semanticLabel: l.editList,
                    onPressed: () => showEditListSheet(context, list),
                  ),
                ],
              ),
      ),
      children: [
        if (list != null)
          KzPageTitle(
            title: list.name,
            subtitle: dates == null
                ? l.listSubtitle(list.listingIds.length)
                : l.listSubtitleDates(
                    list.listingIds.length,
                    KzFormat.dateRange(dates.checkIn, dates.checkOut),
                  ),
          ),
        Wrap(
          spacing: KzSpace.s8,
          runSpacing: KzSpace.s8,
          children: [
            KzChip(
              label: dates == null
                  ? l.addDates
                  : KzFormat.dateRange(dates.checkIn, dates.checkOut),
              icon: KzIcons.calendar,
              variant: dates == null
                  ? KzChipVariant.outline
                  : KzChipVariant.selected,
              onPressed: () => _pickDates(context, ref),
            ),
            KzChip(
              label: guestsLabel(l, q.guests),
              icon: KzIcons.users,
              variant: KzChipVariant.outline,
              onPressed: () => _pickGuests(context, ref),
            ),
          ],
        ),
        const SizedBox(height: KzSpace.s16),
        switch (items) {
          AsyncData(value: null) => ExploreMessage(
            title: l.loadErrorTitle,
            body: l.exploreErrorBody,
            actionLabel: l.back,
            onAction: () => context.pop(),
          ),
          AsyncData(value: final v?) when v.isEmpty => _EmptyList(
            onExplore: () => context.go(AppRoutes.explore),
          ),
          AsyncData(value: final v?) => Column(
            children: [
              for (final item in v) ...[
                _ItemCard(listId: listId, item: item, nights: q.nights),
                const SizedBox(height: KzSpace.s10),
              ],
            ],
          ),
          AsyncError() => ExploreMessage(
            title: l.loadErrorTitle,
            body: l.exploreErrorBody,
            actionLabel: l.retry,
            onAction: () => ref.invalidate(wishlistItemsProvider(listId)),
          ),
          _ => Column(
            children: [
              for (var i = 0; i < 3; i++) ...[
                KzSkeleton(
                  height: KzSize.tabBar * 2,
                  borderRadius: KzRadii.all(KzRadii.card),
                ),
                const SizedBox(height: KzSpace.s10),
              ],
            ],
          ),
        },
      ],
    );
  }
}

/// Kayıt kartı: fotoğraf + kalp, puan, ad, öne çıkanlar, fiyat / dolu, not.
class _ItemCard extends ConsumerWidget {
  const _ItemCard({
    required this.listId,
    required this.item,
    required this.nights,
  });

  final String listId;
  final WishlistItem item;
  final int nights;

  static const Size _photo = Size(112, 124);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final listing = item.listing;
    final total = KzFormat.currency(PriceCalculator.total(item.price));
    return KzPressable(
      onPressed: () => context.push(AppRoutes.listing(listing.id)),
      semanticLabel: listing.title,
      pressedScale: 1,
      child: Container(
        padding: const EdgeInsets.all(KzSpace.s10),
        decoration: BoxDecoration(
          color: kz.surface,
          borderRadius: KzRadii.all(KzRadii.card),
          border: Border.all(color: kz.line),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox.fromSize(
              size: _photo,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: KzRadii.all(KzRadii.md),
                    child: KzPhoto(url: listing.photoUrls.firstOrNull),
                  ),
                  Positioned(
                    top: KzSpace.s8,
                    right: KzSpace.s8,
                    child: SaveListingButton(listingId: listing.id),
                  ),
                ],
              ),
            ),
            const SizedBox(width: KzSpace.s14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (listing.rating != null)
                    Row(
                      children: [
                        KzIcon(
                          KzIcons.starFilled,
                          size: KzSpace.s12,
                          color: kz.star,
                        ),
                        const SizedBox(width: KzSpace.s4),
                        Text(
                          KzFormat.rating(listing.rating!),
                          style: KzText.captionBold.copyWith(color: kz.ink),
                        ),
                      ],
                    ),
                  const SizedBox(height: KzSpace.s4),
                  Text(
                    listing.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.titleSm.copyWith(color: kz.ink),
                  ),
                  const SizedBox(height: KzSpace.s4),
                  Text(
                    listing.resultLine(l),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KzText.caption.copyWith(color: kz.ink2),
                  ),
                  const SizedBox(height: KzSpace.s4),
                  if (item.unavailable)
                    Text(
                      l.unavailableForDates,
                      style: KzText.label.copyWith(
                        color: kz.apricotText,
                        fontWeight: KzText.extraBold,
                      ),
                    )
                  else
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: total,
                            style: KzText.titleSm.copyWith(color: kz.forest),
                          ),
                          TextSpan(
                            text: ' ${l.listingNightsTotal(nights)}',
                            style: KzText.captionSemi.copyWith(color: kz.ink2),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: KzSpace.s6),
                  KzChip(
                    label: item.note == null
                        ? l.addNote
                        : l.noteChip(item.note!),
                    icon: KzIcons.edit,
                    iconColor: item.note == null ? kz.ink2 : null,
                    labelColor: item.note == null ? kz.ink2 : null,
                    variant: item.note == null
                        ? KzChipVariant.outline
                        : KzChipVariant.soft,
                    size: KzChipSize.mini,
                    onPressed: () =>
                        _editNote(context, ref, listing.id, item.note),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editNote(
    BuildContext context,
    WidgetRef ref,
    String listingId,
    String? current,
  ) async {
    final l = context.l10n;
    final note = await showKzSheet<String>(
      context: context,
      title: l.addNote,
      closeLabel: l.close,
      builder: (_) => _NoteForm(initial: current ?? ''),
    );
    if (note == null) return;
    await ref.read(wishlistsProvider.notifier).setNote(listId, listingId, note);
  }
}

class _NoteForm extends StatefulWidget {
  const _NoteForm({required this.initial});

  final String initial;

  @override
  State<_NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<_NoteForm> {
  late final _c = TextEditingController(text: widget.initial);

  static const int _max = 80;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: KzSpace.s16),
          KzInput(
            label: l.noteLabel,
            hint: l.noteHint,
            controller: _c,
            textCapitalization: TextCapitalization.sentences,
            inputFormatters: [LengthLimitingTextInputFormatter(_max)],
            onSubmitted: (v) => Navigator.of(context).pop(v),
          ),
          const SizedBox(height: KzSpace.s16),
          KzButton(
            label: l.save,
            onPressed: () => Navigator.of(context).pop(_c.text),
          ),
          if (widget.initial.isNotEmpty) ...[
            const SizedBox(height: KzSpace.s8),
            KzButton(
              label: l.removeNote,
              variant: KzButtonVariant.danger,
              onPressed: () => Navigator.of(context).pop(''),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: KzSpace.s24),
      child: Column(
        children: [
          const KzSpotIllustration(
            icon: KzIcons.heart,
            tone: KzSpotTone.apricot,
            dot: KzSpotDot.forest,
          ),
          const SizedBox(height: KzSpace.s16),
          Text(
            l.listEmptyTitle,
            textAlign: TextAlign.center,
            style: KzText.title.copyWith(color: kz.ink),
          ),
          const SizedBox(height: KzSpace.s8),
          Text(
            l.listEmptyBody,
            textAlign: TextAlign.center,
            style: KzText.bodySm.copyWith(color: kz.ink2),
          ),
          const SizedBox(height: KzSpace.s20),
          KzButton(
            label: l.startExploring,
            trailingArrow: true,
            expand: false,
            onPressed: onExplore,
          ),
        ],
      ),
    );
  }
}

/// 59 · Listeyi Düzenle (alt sayfa). Silinirse Kaydettiklerim'e döner.
Future<void> showEditListSheet(BuildContext context, Wishlist list) {
  final l = context.l10n;
  return showKzSheet<void>(
    context: context,
    title: l.editList,
    closeLabel: l.close,
    builder: (_) => _EditListForm(list: list),
  );
}

class _EditListForm extends ConsumerStatefulWidget {
  const _EditListForm({required this.list});

  final Wishlist list;

  @override
  ConsumerState<_EditListForm> createState() => _EditListFormState();
}

class _EditListFormState extends ConsumerState<_EditListForm> {
  late final _name = TextEditingController(text: widget.list.name);
  late bool _shareable = widget.list.shareable;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) return;
    setState(() => _saving = true);
    await ref
        .read(wishlistsProvider.notifier)
        .updateDetails(
          widget.list.id,
          name: _name.text.trim(),
          shareable: _shareable,
        );
    if (!mounted) return;
    showKzToast(context, context.l10n.listSaved);
    Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    final l = context.l10n;
    final router = GoRouter.of(context);
    final ok = await showKzSheet<bool>(
      context: context,
      title: l.deleteListTitle,
      closeLabel: l.close,
      builder: (ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: KzSpace.s10),
          Text(
            l.deleteListBody(widget.list.name, widget.list.listingIds.length),
            style: KzText.bodySm.copyWith(color: ctx.kz.ink2),
          ),
          const SizedBox(height: KzSpace.s20),
          KzButton(
            label: l.deleteConfirm,
            variant: KzButtonVariant.destructive,
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
          const SizedBox(height: KzSpace.s10),
          KzButton(
            label: l.keepRequest,
            variant: KzButtonVariant.secondary,
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    await ref.read(wishlistsProvider.notifier).delete(widget.list.id);
    if (!mounted) return;
    showKzToast(context, l.listDeleted);
    Navigator.of(context).pop();
    router.go(AppRoutes.saved);
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: KzSpace.s16),
          KzInput(
            label: l.listName,
            controller: _name,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.done,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: KzSpace.s16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.shareableTitle,
                      style: KzText.bodyStrongSm.copyWith(color: kz.ink),
                    ),
                    const SizedBox(height: KzSpace.s2),
                    Text(
                      l.shareableBody,
                      style: KzText.caption.copyWith(color: kz.ink2),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: KzSpace.s12),
              KzSwitch(
                value: _shareable,
                semanticLabel: l.shareableTitle,
                onChanged: (v) => setState(() => _shareable = v),
              ),
            ],
          ),
          const SizedBox(height: KzSpace.s20),
          KzButton(
            label: l.save,
            loading: _saving,
            onPressed: _name.text.trim().isEmpty ? null : _save,
          ),
          const SizedBox(height: KzSpace.s8),
          KzPressable(
            onPressed: _delete,
            semanticLabel: l.deleteList,
            child: SizedBox(
              height: KzSize.socialButton,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KzIcon(
                    KzIcons.trash,
                    size: KzSize.iconSm,
                    color: kz.apricotText,
                  ),
                  const SizedBox(width: KzSpace.s8),
                  Text(
                    l.deleteList,
                    style: KzText.titleSm.copyWith(color: kz.apricotText),
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
