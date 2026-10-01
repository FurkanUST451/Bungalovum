import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/kz_button.dart';
import '../../../../core/widgets/kz_checkbox.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_input.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_skeleton.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/wishlist.dart';
import '../controllers/saved_listings_controller.dart';

/// 30 · Listeye Ekle. İlan en az bir listeye kaydedilirse true döner.
Future<bool> showAddToListSheet(BuildContext context, String listingId) async {
  final l = context.l10n;
  final r = await showKzSheet<bool>(
    context: context,
    title: l.saveToList,
    closeLabel: l.close,
    builder: (_) => _AddToList(listingId: listingId),
  );
  return r ?? false;
}

/// Yeni liste adı sorar; oluşturulan listeyi döner.
Future<Wishlist?> showCreateListSheet(BuildContext context) {
  final l = context.l10n;
  return showKzSheet<Wishlist>(
    context: context,
    title: l.newList,
    closeLabel: l.close,
    builder: (_) => const _CreateList(),
  );
}

class _AddToList extends ConsumerStatefulWidget {
  const _AddToList({required this.listingId});

  final String listingId;

  @override
  ConsumerState<_AddToList> createState() => _AddToListState();
}

class _AddToListState extends ConsumerState<_AddToList> {
  Set<String>? _selected;
  bool _saving = false;

  static const double _thumb = 60;

  Set<String> _initial(List<Wishlist> lists) {
    final current = {
      for (final w in lists)
        if (w.listingIds.contains(widget.listingId)) w.id,
    };
    // Yeni kayıtta en son güncellenen liste önerilir.
    if (current.isEmpty && lists.isNotEmpty) return {lists.first.id};
    return current;
  }

  Future<void> _newList() async {
    final created = await showCreateListSheet(context);
    if (created != null) {
      setState(() => _selected = {...?_selected, created.id});
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    await ref
        .read(wishlistsProvider.notifier)
        .setMembership(widget.listingId, _selected ?? const {});
    if (mounted) Navigator.of(context).pop((_selected ?? const {}).isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    final l = context.l10n;
    final lists = ref.watch(wishlistsProvider).value;
    if (lists != null) _selected ??= _initial(lists);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KzPressable(
          onPressed: _newList,
          semanticLabel: l.newList,
          child: Container(
            padding: const EdgeInsets.all(KzSpace.s14),
            decoration: BoxDecoration(
              color: kz.forestSoft,
              borderRadius: KzRadii.all(KzRadii.field),
              border: Border.all(
                color: kz.forest,
                width: KzSize.borderCheckbox,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: KzSize.circleSm,
                  height: KzSize.circleSm,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kz.forest,
                    shape: BoxShape.circle,
                  ),
                  child: KzIcon(
                    KzIcons.plus,
                    size: KzSize.iconSm,
                    color: kz.onForest,
                  ),
                ),
                const SizedBox(width: KzSpace.s12),
                Expanded(
                  child: Text(
                    l.newList,
                    style: KzText.bodyStrongSm.copyWith(
                      fontWeight: KzText.extraBold,
                      color: kz.forest,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: KzSpace.s8),
        if (lists == null)
          for (var i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: KzSpace.s8),
              child: KzSkeleton(
                height: _thumb,
                borderRadius: KzRadii.all(KzRadii.tile),
              ),
            )
        else
          for (final w in lists)
            Semantics(
              checked: _selected!.contains(w.id),
              child: KzPressable(
                onPressed: () => setState(() {
                  _selected!.contains(w.id)
                      ? _selected!.remove(w.id)
                      : _selected!.add(w.id);
                }),
                semanticLabel: w.name,
                pressedScale: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: KzSpace.s8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: KzRadii.all(KzRadii.tile),
                        child: const SizedBox.square(
                          dimension: _thumb,
                          child: KzPhoto(url: null),
                        ),
                      ),
                      const SizedBox(width: KzSpace.s14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              w.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: KzText.bodyStrongSm.copyWith(
                                fontWeight: KzText.extraBold,
                                color: kz.ink,
                              ),
                            ),
                            const SizedBox(height: KzSpace.s2),
                            Text(
                              w.listingIds.isEmpty
                                  ? l.emptyList
                                  : l.listItems(w.listingIds.length),
                              style: KzText.caption.copyWith(color: kz.ink2),
                            ),
                          ],
                        ),
                      ),
                      KzCheckbox(
                        value: _selected!.contains(w.id),
                        size: KzSize.checkboxLg,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        const SizedBox(height: KzSpace.s16),
        KzButton(
          label: l.save,
          loading: _saving,
          onPressed: lists == null ? null : _save,
        ),
      ],
    );
  }
}

class _CreateList extends ConsumerStatefulWidget {
  const _CreateList();

  @override
  ConsumerState<_CreateList> createState() => _CreateListState();
}

class _CreateListState extends ConsumerState<_CreateList> {
  final _name = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    setState(() => _saving = true);
    final list = await ref
        .read(wishlistsProvider.notifier)
        .create(_name.text.trim());
    if (mounted) Navigator.of(context).pop(list);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          KzInput(
            label: l.listName,
            controller: _name,
            hint: l.listNameHint,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => _create(),
          ),
          const SizedBox(height: KzSpace.s16),
          KzButton(
            label: l.create,
            loading: _saving,
            onPressed: _name.text.trim().isEmpty ? null : _create,
          ),
        ],
      ),
    );
  }
}
