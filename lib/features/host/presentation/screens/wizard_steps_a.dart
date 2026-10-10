import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/data/tr_districts.dart';
import '../../../../core/icons/kz_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/kz_action_row.dart';
import '../../../../core/widgets/kz_chip.dart';
import '../../../../core/widgets/kz_choice_card.dart';
import '../../../../core/widgets/kz_counter.dart';
import '../../../../core/widgets/kz_dashed_border.dart';
import '../../../../core/widgets/kz_group.dart';
import '../../../../core/widgets/kz_icon.dart';
import '../../../../core/widgets/kz_map_backdrop.dart';
import '../../../../core/widgets/kz_photo.dart';
import '../../../../core/widgets/kz_photo_picker.dart';
import '../../../../core/widgets/kz_pressable.dart';
import '../../../../core/widgets/kz_segmented.dart';
import '../../../../core/widgets/kz_sheet.dart';
import '../../../../core/widgets/kz_step_progress.dart';
import '../../../../core/widgets/kz_switch.dart';
import '../../../../core/widgets/kz_tip.dart';
import '../../../../core/widgets/kz_toast.dart';
import '../../../../l10n/l10n.dart';
import '../../../listing/domain/listing.dart';
import '../../../listing/domain/listing_detail.dart';
import '../../../listing/presentation/listing_detail_labels.dart';
import '../../../listing/presentation/listing_labels.dart';
import '../../domain/listing_draft.dart';
import '../controllers/host_controllers.dart';
import '../host_labels.dart';
import '../widgets/wizard_fields.dart';
import '../widgets/wizard_scaffold.dart';

typedef _Edit = void Function(ListingDraft Function(ListingDraft d) change);

_Edit _editor(WidgetRef ref) => ref.read(hostDraftProvider.notifier).edit;

/// 83 · İlan 1 — Tür ve Konum.
class TypeLocationStep extends ConsumerWidget {
  const TypeLocationStep({super.key, this.editing = false});

  final bool editing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final edit = _editor(ref);
    return WizardScaffold(
      step: WizardStep.typeAndLocation,
      editing: editing,
      title: l.wizTypeTitle,
      subtitle: l.wizTypeSubtitle,
      builder: (d) => [
        WizardSection(l.wizTypeSection, top: false),
        WizardGrid(
          children: [
            for (final t in PropertyType.values)
              KzChoiceCard(
                label: t.label(l),
                icon: t.icon,
                selected: d.propertyType == t,
                onPressed: () => edit((d) => d.copyWith(propertyType: t)),
              ),
          ],
        ),
        WizardSection(l.wizSettingSection),
        Wrap(
          spacing: KzSpace.s8,
          runSpacing: KzSpace.s8,
          children: [
            for (final s in ListingSetting.values)
              KzChip(
                label: s.label(l),
                icon: s.icon,
                variant: d.settings.contains(s)
                    ? KzChipVariant.filled
                    : KzChipVariant.outline,
                semanticLabel: s.label(l),
                onPressed: () => edit(
                  (d) => d.copyWith(
                    settings: d.settings.contains(s)
                        ? ({...d.settings}..remove(s))
                        : {...d.settings, s},
                  ),
                ),
              ),
          ],
        ),
        WizardSection(l.wizAddressSection),
        DraftInput(
          label: l.wizAddressLabel,
          icon: KzIcons.pin,
          value: d.address,
          capitalization: TextCapitalization.words,
          onChanged: (v) => edit((d) => d.copyWith(address: v)),
        ),
        const SizedBox(height: KzSpace.s10),
        Row(
          children: [
            Expanded(
              child: ValueBox(
                label: l.wizCity,
                value: d.city.isEmpty ? null : d.city,
                onPressed: () => _pickCity(context, ref),
              ),
            ),
            const SizedBox(width: KzSpace.s10),
            Expanded(
              child: ValueBox(
                label: l.wizDistrict,
                value: d.district.isEmpty ? null : d.district,
                onPressed: () => _pickDistrict(context, ref),
              ),
            ),
          ],
        ),
        const SizedBox(height: KzSpace.s10),
        ClipRRect(
          borderRadius: KzRadii.all(KzRadii.lg),
          child: AspectRatio(
            aspectRatio: _mapAspect,
            child: Stack(
              children: [
                const Positioned.fill(child: KzMapBackdrop()),
                Center(
                  child: Container(
                    width: KzSize.circleMd,
                    height: KzSize.circleMd,
                    decoration: BoxDecoration(
                      color: kz.forest,
                      shape: BoxShape.circle,
                      boxShadow: KzShadows.strong,
                    ),
                    child: Center(
                      child: KzIcon(
                        KzIcons.home,
                        size: KzSize.iconMd,
                        color: kz.onForest,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: KzSpace.s12,
                  bottom: KzSpace.s12,
                  child: KzChip(
                    label: l.wizPinHint,
                    variant: KzChipVariant.soft,
                    size: KzChipSize.small,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: KzSpace.s10),
        Text(
          l.wizAddressPrivacy,
          style: KzText.caption.copyWith(color: kz.ink2),
        ),
      ],
    );
  }

  static const double _mapAspect = 350 / 150;

  Future<void> _pickCity(BuildContext context, WidgetRef ref) async {
    final l = context.l10n;
    final d = ref.read(hostDraftProvider).value!;
    final city = await showSearchPickerSheet(
      context,
      title: l.wizCity,
      searchLabel: l.wizCitySearch,
      items: trDistricts.keys.toList(),
      selected: d.city,
    );
    if (city == null || city == d.city) return;
    // İl değişince eski ilçe yeni ile ait değilse temizlenir.
    _editor(ref)(
      (d) => d.copyWith(
        city: city,
        district: (trDistricts[city] ?? const []).contains(d.district)
            ? d.district
            : '',
      ),
    );
  }

  Future<void> _pickDistrict(BuildContext context, WidgetRef ref) async {
    final l = context.l10n;
    final d = ref.read(hostDraftProvider).value!;
    final districts = trDistricts[d.city];
    if (districts == null) {
      showKzToast(context, l.wizCityFirst);
      return;
    }
    final district = await showSearchPickerSheet(
      context,
      title: l.wizDistrict,
      searchLabel: l.wizDistrictSearch,
      items: districts,
      selected: d.district,
    );
    if (district != null) {
      _editor(ref)((d) => d.copyWith(district: district));
    }
  }
}

/// 84 · İlan 2 — Temel Bilgiler.
class BasicsStep extends ConsumerWidget {
  const BasicsStep({super.key, this.editing = false});

  final bool editing;

  Future<void> _editBeds(BuildContext context, WidgetRef ref) async {
    final l = context.l10n;
    await showKzSheet<void>(
      context: context,
      title: l.wizBedTypes,
      closeLabel: l.close,
      builder: (_) => Consumer(
        builder: (context, ref, _) {
          final d = ref.watch(hostDraftProvider).value;
          if (d == null) return const SizedBox.shrink();
          final edit = _editor(ref);
          int count(BedType t) =>
              d.bedTypes.where((b) => b.type == t).firstOrNull?.count ?? 0;
          return KzGroup(
            inset: KzSpace.s16,
            rows: [
              for (final t in BedType.values)
                KzRow(
                  title: t.label(l, count(t) == 0 ? 1 : count(t)),
                  constrainTrailing: false,
                  trailing: KzCounter(
                    value: count(t),
                    max: ListingRules.maxRooms,
                    decreaseLabel: l.decrease,
                    increaseLabel: l.increase,
                    onChanged: (n) => edit(
                      (d) => d.copyWith(
                        bedTypes: [
                          for (final b in d.bedTypes)
                            if (b.type != t) b,
                          if (n > 0) BedCount(type: t, count: n),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final edit = _editor(ref);
    KzRow counter(
      String title,
      String? subtitle,
      int value,
      int min,
      int max,
      ListingDraft Function(ListingDraft, int) set,
    ) => KzRow(
      title: title,
      subtitle: subtitle,
      constrainTrailing: false,
      trailing: KzCounter(
        value: value,
        min: min,
        max: max,
        decreaseLabel: l.decrease,
        increaseLabel: l.increase,
        onChanged: (n) => edit((d) => set(d, n)),
      ),
    );

    return WizardScaffold(
      step: WizardStep.basics,
      editing: editing,
      title: l.wizBasicsTitle,
      subtitle: l.wizBasicsSubtitle,
      builder: (d) => [
        KzGroup(
          inset: KzSpace.s16,
          rows: [
            counter(
              l.wizGuests,
              l.wizGuestsHint,
              d.maxGuests,
              1,
              ListingRules.maxGuests,
              (d, n) => d.copyWith(maxGuests: n),
            ),
            counter(
              l.wizBedrooms,
              null,
              d.bedrooms,
              0,
              ListingRules.maxRooms,
              (d, n) => d.copyWith(bedrooms: n),
            ),
            counter(
              l.wizBeds,
              null,
              d.beds,
              1,
              ListingRules.maxGuests,
              (d, n) => d.copyWith(beds: n),
            ),
            counter(
              l.wizBathrooms,
              null,
              d.bathrooms,
              1,
              ListingRules.maxRooms,
              (d, n) => d.copyWith(bathrooms: n),
            ),
          ],
        ),
        WizardSection(l.wizBedTypes),
        Wrap(
          spacing: KzSpace.s8,
          runSpacing: KzSpace.s8,
          children: [
            for (final b in d.bedTypes)
              KzChip(
                label: b.type.label(l, b.count),
                icon: KzIcons.bed,
                onPressed: () => _editBeds(context, ref),
              ),
            KzChip(
              label: l.wizAddBed,
              icon: KzIcons.plus,
              variant: KzChipVariant.outline,
              onPressed: () => _editBeds(context, ref),
            ),
          ],
        ),
        WizardSection(l.wizSize),
        Row(
          children: [
            Expanded(
              child: ValueBox(
                label: l.wizIndoorM2,
                value: d.indoorM2?.toString(),
                onPressed: () => _pickArea(context, ref, indoor: true),
              ),
            ),
            const SizedBox(width: KzSpace.s10),
            Expanded(
              child: ValueBox(
                label: l.wizGardenM2,
                value: d.gardenM2?.toString(),
                onPressed: () => _pickArea(context, ref, indoor: false),
              ),
            ),
          ],
        ),
        WizardSection(l.wizWholePlace),
        WizardGrid(
          children: [
            KzChoiceCard(
              label: l.wizWholePlaceYes,
              icon: KzIcons.home,
              selected: d.wholePlace,
              onPressed: () => edit((d) => d.copyWith(wholePlace: true)),
            ),
            KzChoiceCard(
              label: l.wizSharedGarden,
              icon: KzIcons.users,
              selected: !d.wholePlace,
              onPressed: () => edit((d) => d.copyWith(wholePlace: false)),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pickArea(
    BuildContext context,
    WidgetRef ref, {
    required bool indoor,
  }) async {
    final l = context.l10n;
    final d = ref.read(hostDraftProvider).value!;
    final label = indoor ? l.wizIndoorM2 : l.wizGardenM2;
    final r = await showWheelSheet(
      context,
      title: label,
      fields: [
        WheelField(
          label: label,
          range: indoor ? ListingRules.indoorM2 : ListingRules.gardenM2,
          value: indoor ? d.indoorM2 : d.gardenM2,
        ),
      ],
    );
    if (r == null) return;
    _editor(ref)(
      (d) => indoor
          ? d.copyWith(indoorM2: r.first.round())
          : d.copyWith(gardenM2: r.first.round()),
    );
  }
}

/// 85 · İlan 3 — Havuz ve Olanaklar.
class PoolAmenitiesStep extends ConsumerWidget {
  const PoolAmenitiesStep({super.key, this.editing = false});

  final bool editing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    final edit = _editor(ref);
    String meters(double v) => l.metersValue(KzFormat.decimal(v));

    Future<void> pick({
      required String title,
      required List<WheelField> fields,
      required ListingDraft Function(ListingDraft, List<double>) set,
      bool ordered = false,
    }) async {
      final r = await showWheelSheet(
        context,
        title: title,
        fields: fields,
        ordered: ordered,
      );
      if (r != null) edit((d) => set(d, r));
    }

    return WizardScaffold(
      step: WizardStep.poolAndAmenities,
      editing: editing,
      title: l.wizPoolTitle,
      subtitle: l.wizPoolSubtitle,
      builder: (d) {
        final selected = {...d.amenities, if (d.petsAllowed) AmenityKind.pets};
        return [
          Container(
            padding: const EdgeInsets.all(KzSpace.s16),
            decoration: BoxDecoration(
              color: kz.poolSoft,
              borderRadius: KzRadii.all(KzRadii.card),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SwitchLine(
                  icon: KzIcons.waves,
                  label: l.wizHasPool,
                  value: d.hasPool,
                  strong: true,
                  onChanged: (v) => edit((d) => d.copyWith(hasPool: v)),
                ),
                if (d.hasPool) ...[
                  const SizedBox(height: KzSpace.s12),
                  KzSegmented<bool>(
                    segments: [
                      (true, l.wizPoolPrivate),
                      (false, l.wizPoolShared),
                    ],
                    selected: d.poolPrivate,
                    onChanged: (v) => edit((d) => d.copyWith(poolPrivate: v)),
                  ),
                  const SizedBox(height: KzSpace.s12),
                  _SwitchLine(
                    label: l.wizHeated,
                    value: d.poolHeated,
                    onChanged: (v) => edit((d) => d.copyWith(poolHeated: v)),
                  ),
                  const SizedBox(height: KzSpace.s12),
                  WizardGrid(
                    children: [
                      if (d.poolHeated)
                        ValueBox(
                          label: l.wizPoolTemp,
                          value: d.poolTempC == null
                              ? null
                              : l.celsius(d.poolTempC!),
                          onPressed: () => pick(
                            title: l.wizPoolTemp,
                            fields: [
                              WheelField(
                                label: l.wizPoolTemp,
                                range: ListingRules.poolTempC,
                                value: d.poolTempC,
                                unit: l.wheelUnitCelsius,
                              ),
                            ],
                            set: (d, r) =>
                                d.copyWith(poolTempC: r.first.round()),
                          ),
                        ),
                      ValueBox(
                        label: l.wizPoolDepth,
                        value:
                            d.poolDepthMinM == null || d.poolDepthMaxM == null
                            ? null
                            : l.rangeValue(
                                KzFormat.decimal(d.poolDepthMinM!),
                                meters(d.poolDepthMaxM!),
                              ),
                        onPressed: () => pick(
                          title: l.wizPoolDepth,
                          ordered: true,
                          fields: [
                            WheelField(
                              label: l.wizMin,
                              range: ListingRules.poolDepthMinM,
                              value: d.poolDepthMinM,
                            ),
                            WheelField(
                              label: l.wizMax,
                              range: ListingRules.poolDepthMaxM,
                              value: d.poolDepthMaxM,
                            ),
                          ],
                          set: (d, r) => d.copyWith(
                            poolDepthMinM: r[0],
                            poolDepthMaxM: r[1],
                          ),
                        ),
                      ),
                      ValueBox(
                        label: l.wizPoolSize,
                        value: d.poolWidthM == null || d.poolLengthM == null
                            ? null
                            : l.sizeValue(
                                KzFormat.decimal(d.poolWidthM!),
                                meters(d.poolLengthM!),
                              ),
                        onPressed: () => pick(
                          title: l.wizPoolSize,
                          fields: [
                            WheelField(
                              label: l.wizWidth,
                              range: ListingRules.poolWidthM,
                              value: d.poolWidthM,
                            ),
                            WheelField(
                              label: l.wizLength,
                              range: ListingRules.poolLengthM,
                              value: d.poolLengthM,
                            ),
                          ],
                          set: (d, r) =>
                              d.copyWith(poolWidthM: r[0], poolLengthM: r[1]),
                        ),
                      ),
                      ValueBox(
                        label: l.wizPoolSeason,
                        value:
                            d.poolSeasonStart == null || d.poolSeasonEnd == null
                            ? null
                            : l.rangeValue(
                                KzFormat.monthShort(d.poolSeasonStart!),
                                KzFormat.monthShort(d.poolSeasonEnd!),
                              ),
                        onPressed: () async {
                          final r = await showMonthRangeSheet(
                            context,
                            title: l.wizPoolSeason,
                            start: d.poolSeasonStart,
                            end: d.poolSeasonEnd,
                          );
                          if (r != null) {
                            edit(
                              (d) => d.copyWith(
                                poolSeasonStart: r.$1,
                                poolSeasonEnd: r.$2,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          WizardSection(
            l.wizAmenities,
            trailing: l.selectedCount(selected.length),
          ),
          WizardGrid(
            columns: 3,
            children: [
              for (final a in wizardAmenities)
                KzChoiceCard(
                  label: a.label(l),
                  icon: a.icon,
                  vertical: true,
                  selected: selected.contains(a),
                  onPressed: () => edit((d) {
                    if (a == AmenityKind.pets) {
                      return d.copyWith(petsAllowed: !d.petsAllowed);
                    }
                    return d.copyWith(
                      amenities: d.amenities.contains(a)
                          ? ({...d.amenities}..remove(a))
                          : {...d.amenities, a},
                    );
                  }),
                ),
            ],
          ),
        ];
      },
    );
  }
}

/// Etiket + anahtar satırı (havuz kartı içinde).
class _SwitchLine extends StatelessWidget {
  const _SwitchLine({
    required this.label,
    required this.value,
    required this.onChanged,
    this.icon,
    this.strong = false,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final KzIcons? icon;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final kz = context.kz;
    return Row(
      children: [
        if (icon != null) ...[
          KzIcon(icon!, size: KzSize.iconMd, color: kz.poolText),
          const SizedBox(width: KzSpace.s10),
        ],
        Expanded(
          child: Text(
            label,
            style: (strong ? KzText.titleSm : KzText.bodyStrongSm).copyWith(
              color: kz.ink,
            ),
          ),
        ),
        KzSwitch(value: value, semanticLabel: label, onChanged: onChanged),
      ],
    );
  }
}

/// 86 · İlan 4 — Fotoğraflar.
class PhotosStep extends ConsumerWidget {
  const PhotosStep({super.key, this.editing = false});

  final bool editing;

  static const double _thumb = 76;
  static const double _coverAspect = 350 / 200;

  Future<void> _add(BuildContext context, WidgetRef ref, RoomKind room) async {
    final picked = await ImagePicker().pickMultiImage(
      maxWidth: KzPhotoPicker.maxDimension,
      maxHeight: KzPhotoPicker.maxDimension,
      imageQuality: KzPhotoPicker.quality,
    );
    if (picked.isEmpty) return;
    try {
      await ref.read(hostDraftProvider.notifier).addPhotos(room, [
        for (final f in picked) f.path,
      ]);
    } on Object {
      if (context.mounted) {
        showKzToast(context, context.l10n.errorPhotoUpload);
      }
    }
  }

  Future<void> _photoActions(
    BuildContext context,
    WidgetRef ref,
    DraftPhoto p,
  ) async {
    final l = context.l10n;
    final n = ref.read(hostDraftProvider.notifier);
    await showKzSheet<void>(
      context: context,
      title: l.photoActions,
      closeLabel: l.close,
      builder: (ctx) => KzGroup(
        inset: KzSpace.s16,
        rows: [
          KzRow(
            icon: KzIcons.star,
            title: l.makeCover,
            onPressed: () {
              n.setCover(p.id);
              Navigator.of(ctx).pop();
            },
          ),
          KzRow(
            icon: KzIcons.back,
            title: l.moveEarlier,
            onPressed: () {
              n.movePhoto(p.id, -1);
              Navigator.of(ctx).pop();
            },
          ),
          KzRow(
            icon: KzIcons.arrow,
            title: l.moveLater,
            onPressed: () {
              n.movePhoto(p.id, 1);
              Navigator.of(ctx).pop();
            },
          ),
          KzRow(
            icon: KzIcons.trash,
            tone: KzIconBoxTone.apricot,
            title: l.deletePhoto,
            titleColor: ctx.kz.apricotText,
            onPressed: () {
              n.removePhoto(p.id);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kz = context.kz;
    final l = context.l10n;
    return WizardScaffold(
      step: WizardStep.photos,
      editing: editing,
      title: l.wizPhotosTitle,
      subtitle: l.wizPhotosSubtitle,
      builder: (d) {
        final cover = d.cover;
        final rooms = [
          RoomKind.living,
          RoomKind.bedroom,
          RoomKind.bathroom,
          if (d.hasPool) RoomKind.pool,
          RoomKind.outdoor,
        ];
        return [
          Row(
            children: [
              Expanded(
                child: Text(
                  l.photoCount(d.photoCount),
                  style: KzText.titleSm.copyWith(color: kz.ink),
                ),
              ),
              const SizedBox(width: KzSpace.s8),
              Flexible(
                child: Text(
                  l.wizPhotosRule(
                    ListingRules.minPhotos,
                    ListingRules.recommendedPhotos,
                  ),
                  textAlign: TextAlign.end,
                  style: KzText.caption.copyWith(color: kz.ink2),
                ),
              ),
            ],
          ),
          const SizedBox(height: KzSpace.s8),
          KzStepProgress(
            value: d.photoCount / ListingRules.recommendedPhotos,
            semanticLabel: l.photoCount(d.photoCount),
          ),
          const SizedBox(height: KzSpace.s16),
          if (cover != null)
            ClipRRect(
              borderRadius: KzRadii.all(KzRadii.lg),
              child: AspectRatio(
                aspectRatio: _coverAspect,
                child: Stack(
                  children: [
                    Positioned.fill(child: KzPhoto(url: cover.url)),
                    Positioned(
                      left: KzSpace.s12,
                      top: KzSpace.s12,
                      child: KzChip(
                        label: l.coverPhoto,
                        icon: KzIcons.starFilled,
                        iconColor: kz.star,
                        variant: KzChipVariant.soft,
                        size: KzChipSize.small,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          for (final room in rooms) ...[
            const SizedBox(height: KzSpace.s16),
            Row(
              children: [
                KzIcon(room.icon, size: KzSize.iconSm, color: kz.ink),
                const SizedBox(width: KzSpace.s8),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: room.label(l)),
                        TextSpan(
                          text: '  ${d.photosIn(room).length}',
                          style: KzText.caption.copyWith(color: kz.ink2),
                        ),
                      ],
                    ),
                    style: KzText.bodyStrongSm.copyWith(color: kz.ink),
                  ),
                ),
              ],
            ),
            const SizedBox(height: KzSpace.s10),
            Wrap(
              spacing: KzSpace.s8,
              runSpacing: KzSpace.s8,
              children: [
                for (final p in d.photosIn(room))
                  KzPressable(
                    onPressed: () => _photoActions(context, ref, p),
                    semanticLabel: l.photoActions,
                    child: SizedBox.square(
                      dimension: _thumb,
                      child: ClipRRect(
                        borderRadius: KzRadii.all(KzRadii.tile),
                        child: KzPhoto(url: p.url),
                      ),
                    ),
                  ),
                KzPressable(
                  onPressed: () => _add(context, ref, room),
                  semanticLabel: l.addPhotoTo(room.label(l)),
                  child: KzDashedBorder(
                    radius: KzRadii.tile,
                    child: SizedBox.square(
                      dimension: _thumb,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          KzIcon(
                            KzIcons.plus,
                            size: KzSize.iconSm,
                            color: kz.forest,
                          ),
                          const SizedBox(height: KzSpace.s2),
                          Text(
                            l.add,
                            style: KzText.micro.copyWith(color: kz.forest),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: KzSpace.s20),
          KzTip(icon: KzIcons.sparkles, message: l.wizPhotosTip),
        ];
      },
    );
  }
}
