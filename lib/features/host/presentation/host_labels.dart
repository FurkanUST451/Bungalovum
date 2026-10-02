import '../../../core/icons/kz_icons.dart';
import '../../../core/utils/formatters.dart';
import '../../../l10n/l10n.dart';
import '../../listing/domain/listing.dart';
import '../../listing/domain/listing_detail.dart';
import '../../listing/presentation/listing_labels.dart';
import '../domain/listing_draft.dart';

extension PropertyTypeIcon on PropertyType {
  KzIcons get icon => switch (this) {
    PropertyType.bungalow || PropertyType.stoneHouse => KzIcons.home,
    PropertyType.aFrame => KzIcons.mountain,
    PropertyType.treeHouse => KzIcons.trees,
    PropertyType.glampingTent => KzIcons.sun,
    PropertyType.tinyHouse => KzIcons.grid,
    PropertyType.cabin => KzIcons.door,
  };
}

extension ListingSettingIcon on ListingSetting {
  KzIcons get icon => switch (this) {
    ListingSetting.lakeside || ListingSetting.lakeView => KzIcons.waves,
    ListingSetting.forest => KzIcons.trees,
    ListingSetting.mountainView => KzIcons.mountain,
    ListingSetting.nearSea => KzIcons.sun,
  };
}

extension BedTypeUi on BedType {
  /// "1 çift kişilik"
  String label(AppLocalizations l, int n) => switch (this) {
    BedType.double => l.bedDouble(n),
    BedType.single => l.bedSingle(n),
    BedType.sofaBed => l.bedSofa(n),
    BedType.bunk => l.bedBunk(n),
  };
}

extension HighlightTagUi on HighlightTag {
  String label(AppLocalizations l) => switch (this) {
    HighlightTag.lakeView => l.tagLakeView,
    HighlightTag.heatedPool => l.tagHeatedPool,
    HighlightTag.selfCheckIn => l.tagSelfCheckIn,
    HighlightTag.inForest => l.tagInForest,
    HighlightTag.sunsetTerrace => l.tagSunsetTerrace,
    HighlightTag.quietArea => l.tagQuietArea,
  };

  KzIcons get icon => switch (this) {
    HighlightTag.lakeView || HighlightTag.heatedPool => KzIcons.waves,
    HighlightTag.selfCheckIn => KzIcons.key,
    HighlightTag.inForest => KzIcons.trees,
    HighlightTag.sunsetTerrace => KzIcons.sun,
    HighlightTag.quietArea => KzIcons.moon,
  };
}

extension CancellationPolicyUi on CancellationPolicy {
  String label(AppLocalizations l) => switch (this) {
    CancellationPolicy.flexible => l.policyFlexible,
    CancellationPolicy.moderate => l.policyModerate,
    CancellationPolicy.strict => l.policyStrict,
  };

  String detail(AppLocalizations l) => switch (this) {
    CancellationPolicy.flexible => l.policyFlexibleBody,
    CancellationPolicy.moderate => l.policyModerateBody,
    CancellationPolicy.strict => l.policyStrictBody,
  };
}

extension PermitTypeUi on PermitType {
  String label(AppLocalizations l) => switch (this) {
    PermitType.tourismRental => l.permitTourismRental,
    PermitType.tourismOperation => l.permitTourismOperation,
    PermitType.municipalLicense => l.permitMunicipal,
  };

  String detail(AppLocalizations l) => switch (this) {
    PermitType.tourismRental => l.permitTourismRentalBody,
    PermitType.tourismOperation => l.permitTourismOperationBody,
    PermitType.municipalLicense => l.permitMunicipalBody,
  };
}

extension HostDocKindUi on HostDocKind {
  String label(AppLocalizations l) => switch (this) {
    HostDocKind.permit => l.docPermit,
    HostDocKind.deed => l.docDeed,
    HostDocKind.condoDecision => l.docCondo,
    HostDocKind.powerOfAttorney => l.docAttorney,
    HostDocKind.entrancePlate => l.docPlate,
  };

  String detail(AppLocalizations l) => switch (this) {
    HostDocKind.permit => l.docPermitBody,
    HostDocKind.deed => l.docDeedBody,
    HostDocKind.condoDecision => l.docCondoBody,
    HostDocKind.powerOfAttorney => l.docAttorneyBody,
    HostDocKind.entrancePlate => l.docPlateBody,
  };

  KzIcons get icon => switch (this) {
    HostDocKind.permit || HostDocKind.powerOfAttorney => KzIcons.doc,
    HostDocKind.deed => KzIcons.home,
    HostDocKind.condoDecision => KzIcons.users,
    HostDocKind.entrancePlate => KzIcons.image,
  };
}

extension IdentityStepUi on IdentityStep {
  String label(AppLocalizations l) => switch (this) {
    IdentityStep.idFront => l.idFront,
    IdentityStep.idBack => l.idBack,
    IdentityStep.selfie => l.idSelfie,
  };

  String detail(AppLocalizations l) => switch (this) {
    IdentityStep.idFront => l.idFrontBody,
    IdentityStep.idBack => l.idBackBody,
    IdentityStep.selfie => l.idSelfieBody,
  };
}

extension SelfCheckInUi on SelfCheckIn {
  String label(AppLocalizations l) => switch (this) {
    SelfCheckIn.keybox => l.checkInKeybox,
    SelfCheckIn.smartLock => l.checkInSmartLock,
    SelfCheckIn.none => l.checkInInPerson,
  };

  KzIcons get icon => switch (this) {
    SelfCheckIn.keybox => KzIcons.key,
    SelfCheckIn.smartLock => KzIcons.lock,
    SelfCheckIn.none => KzIcons.user,
  };
}

extension WizardStepUi on WizardStep {
  String label(AppLocalizations l) => switch (this) {
    WizardStep.typeAndLocation => l.stepTypeLocation,
    WizardStep.basics => l.stepBasics,
    WizardStep.poolAndAmenities => l.stepPoolAmenities,
    WizardStep.photos => l.stepPhotos,
    WizardStep.titleAndDescription => l.stepTitleDescription,
    WizardStep.safetyAndRules => l.stepSafetyRules,
    WizardStep.pricing => l.stepPricing,
    WizardStep.checkIn => l.stepCheckIn,
    WizardStep.legal => l.stepLegal,
    WizardStep.identityAndPayout => l.stepIdentityPayout,
  };

  KzIcons get icon => switch (this) {
    WizardStep.typeAndLocation || WizardStep.basics => KzIcons.home,
    WizardStep.poolAndAmenities => KzIcons.waves,
    WizardStep.photos => KzIcons.camera,
    WizardStep.titleAndDescription => KzIcons.edit,
    WizardStep.safetyAndRules => KzIcons.shield,
    WizardStep.pricing => KzIcons.wallet,
    WizardStep.checkIn => KzIcons.key,
    WizardStep.legal => KzIcons.doc,
    WizardStep.identityAndPayout => KzIcons.idcard,
  };

  /// Önizleme (93) ve İlan Yönetimi (95) satır özeti.
  String summary(AppLocalizations l, ListingDraft d) => switch (this) {
    WizardStep.typeAndLocation => [
      ?d.propertyType?.label(l),
      if (d.district.isNotEmpty) d.district,
      l.listingGuests(d.maxGuests),
    ].join(' · '),
    WizardStep.basics => [
      l.listingGuests(d.maxGuests),
      l.bedroomsCount(d.bedrooms),
      if (d.indoorM2 != null) l.squareMeters(d.indoorM2!),
    ].join(' · '),
    WizardStep.poolAndAmenities => [
      if (d.hasPool) poolSummary(l, d),
      l.amenitiesCount(d.amenities.length),
    ].join(' · '),
    WizardStep.photos => l.photosSummary(
      d.photoCount,
      RoomKind.values.where((r) => d.photosIn(r).isNotEmpty).length,
    ),
    WizardStep.titleAndDescription => d.title.isEmpty ? l.notAdded : d.title,
    WizardStep.safetyAndRules => l.safetySummary(
      d.safety.length,
      d.checkInFrom,
      d.checkOutBy,
    ),
    WizardStep.pricing => [
      if (d.nightlyPrice != null)
        l.perNightPrice(KzFormat.currency(d.nightlyPrice!)),
      d.instantBook ? l.instantBookShort : l.requestBookShort,
      d.cancellation.label(l),
    ].join(' · '),
    WizardStep.checkIn => [
      d.checkInMethod.label(l),
      if (d.wifiName.isNotEmpty) l.wifiShort,
      if (d.checkoutTasks.isNotEmpty) l.checkoutListShort,
    ].join(' · '),
    WizardStep.legal =>
      d.permitNo.isEmpty ? l.notAdded : l.permitNoShort(d.permitNo),
    WizardStep.identityAndPayout =>
      d.iban.isEmpty ? l.notAdded : l.ibanShort(IbanValidator.masked(d.iban)),
  };
}

/// "Özel havuz · Isıtmalı"
String poolSummary(AppLocalizations l, ListingDraft d) => [
  d.poolPrivate ? l.wizPoolPrivate : l.wizPoolShared,
  if (d.poolHeated) l.poolHeatedShort,
].join(' · ');

/// Olanak ızgarasında gösterilenler. Özel havuz havuz bölümünden, evcil
/// hayvan ise ev kurallarından ([ListingDraft.petsAllowed]) türetilir.
const wizardAmenities = [
  AmenityKind.jacuzzi,
  AmenityKind.fireplace,
  AmenityKind.kitchen,
  AmenityKind.wifi,
  AmenityKind.parking,
  AmenityKind.airConditioning,
  AmenityKind.barbecue,
  AmenityKind.pets,
  AmenityKind.stepFreeEntry,
];
