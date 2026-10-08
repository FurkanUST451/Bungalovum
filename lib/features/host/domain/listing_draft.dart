import 'package:freezed_annotation/freezed_annotation.dart';

import '../../booking/domain/booking.dart';
import '../../listing/domain/listing.dart';
import '../../listing/domain/listing_detail.dart';

part 'listing_draft.freezed.dart';

/// İlanın yaşam döngüsü (§10): draft → in_review → published | rejected,
/// ayrıca paused (rezervasyona kapalı).
enum ListingStatus { draft, inReview, published, rejected, paused }

/// Sihirbaz adımları (83–92). Sıra Figma ile aynıdır.
enum WizardStep {
  typeAndLocation,
  basics,
  poolAndAmenities,
  photos,
  titleAndDescription,
  safetyAndRules,
  pricing,
  checkIn,
  legal,
  identityAndPayout;

  /// 1'den başlayan adım numarası.
  int get number => index + 1;

  static WizardStep? fromNumber(int n) =>
      n >= 1 && n <= values.length ? values[n - 1] : null;

  /// Değişince yalnızca o bölümün yeniden incelemeye girdiği adımlar (§10).
  bool get needsReviewOnChange => this == legal || this == identityAndPayout;
}

enum BedType { double, single, sofaBed, bunk }

@freezed
abstract class BedCount with _$BedCount {
  const factory BedCount({required BedType type, required int count}) =
      _BedCount;
}

/// Öne çıkan özellik etiketleri (87); en fazla [ListingRules.maxHighlights].
enum HighlightTag {
  lakeView,
  heatedPool,
  selfCheckIn,
  inForest,
  sunsetTerrace,
  quietArea,
}

enum CancellationPolicy {
  /// Girişten 24 saat öncesine kadar tam iade.
  flexible,

  /// Girişten 5 gün öncesine kadar tam iade.
  moderate,

  /// Girişten 7 gün öncesine kadar %50 iade.
  strict;

  /// Misafir tarafındaki [ListingDetail.freeCancelHours] karşılığı.
  int get freeCancelHours => switch (this) {
    flexible => 24,
    moderate => 5 * 24,
    strict => 0,
  };
}

enum PermitType { tourismRental, tourismOperation, municipalLicense }

/// Yasal belgeler (91). Kat malikleri kararı ve vekaletname koşulludur.
enum HostDocKind {
  permit,
  deed,
  condoDecision,
  powerOfAttorney,
  entrancePlate;

  bool get conditional => this == condoDecision || this == powerOfAttorney;
}

enum DocStatus { uploaded, approved, rejected }

/// Yüklenmiş belge: cihazda dosya tutulmaz, yalnızca sunucu kimliği (KVKK).
@freezed
abstract class HostDocument with _$HostDocument {
  const factory HostDocument({
    required String id,
    @Default(DocStatus.uploaded) DocStatus status,
  }) = _HostDocument;
}

enum TaxType { individual, company }

enum IdentityStep { idFront, idBack, selfie }

/// Kimlik ve ödeme hesabı incelemesi.
enum VerificationStatus { notStarted, pending, approved, rejected }

/// Backend'in sabit hata kodları (§14); ekranda ARB metnine çevrilir.
class HostFailure implements Exception {
  const HostFailure(this.code, [this.detail]);

  /// `listing_incomplete`, `invalid_iban`, `iban_name_mismatch`…
  final String code;

  /// Ör. `listing_incomplete` için eksik adımlar ("photos,legal").
  final String? detail;

  @override
  String toString() => 'HostFailure($code${detail == null ? '' : ': $detail'})';
}

/// İlan fotoğrafı: yüklenene kadar yerel yol, sonra sunucu adresi.
@freezed
abstract class DraftPhoto with _$DraftPhoto {
  const factory DraftPhoto({
    required String id,
    required RoomKind room,
    required String url,
  }) = _DraftPhoto;
}

/// Ev sahibinin oluşturduğu/düzenlediği ilan. Misafirin İlan Detayı'nda
/// gördüğü her alanın kaynağıdır (§10). Kişisel veriler (TCKN, IBAN, belge
/// dosyaları) cihazda kalıcı saklanmaz; taslak sunucuda tutulur.
@freezed
abstract class ListingDraft with _$ListingDraft {
  const ListingDraft._();

  const factory ListingDraft({
    required String id,
    @Default(ListingStatus.draft) ListingStatus status,

    /// Kaydet ve çık sonrası devam edilecek adım.
    @Default(WizardStep.typeAndLocation) WizardStep resumeStep,
    DateTime? submittedAt,

    /// Yayındaki ilanda yeniden incelemeye giren bölümler.
    @Default(<WizardStep>{}) Set<WizardStep> sectionsInReview,

    /// Reddedilen ilanda incelemenin notu.
    String? reviewNote,

    // 1 · Tür ve konum
    PropertyType? propertyType,
    @Default(<ListingSetting>{}) Set<ListingSetting> settings,
    @Default('') String address,
    @Default('') String city,
    @Default('') String district,
    double? latitude,
    double? longitude,

    // 2 · Temel bilgiler
    @Default(2) int maxGuests,
    @Default(1) int bedrooms,
    @Default(1) int beds,
    @Default(1) int bathrooms,
    @Default(<BedCount>[]) List<BedCount> bedTypes,
    int? indoorM2,
    int? gardenM2,

    /// Bungalovun tamamı misafire mi ait (false: bahçe ortak).
    @Default(true) bool wholePlace,

    // 3 · Havuz ve olanaklar
    @Default(false) bool hasPool,
    @Default(true) bool poolPrivate,
    @Default(false) bool poolHeated,
    int? poolTempC,
    double? poolWidthM,
    double? poolLengthM,
    double? poolDepthMinM,
    double? poolDepthMaxM,
    int? poolSeasonStart,
    int? poolSeasonEnd,
    @Default(<AmenityKind>{}) Set<AmenityKind> amenities,

    // 4 · Fotoğraflar
    @Default(<DraftPhoto>[]) List<DraftPhoto> photos,
    String? coverPhotoId,

    // 5 · Başlık ve açıklama
    @Default('') String title,
    @Default(<HighlightTag>{}) Set<HighlightTag> highlights,
    @Default('') String space,
    @Default('') String guestAccess,
    @Default('') String otherNotes,

    // 6 · Güvenlik ve kurallar
    @Default(<SafetyKind>{}) Set<SafetyKind> safety,
    @Default('') String outdoorCameraNote,
    @Default(false) bool poolNoLifeguardAck,
    @Default(false) bool poolDepthMarked,
    @Default('14:00') String checkInFrom,
    @Default('11:00') String checkOutBy,
    @Default(false) bool petsAllowed,
    @Default(false) bool smokingAllowed,
    @Default(false) bool eventsAllowed,
    @Default(true) bool quietHours,
    @Default('23:00') String quietFrom,
    @Default('08:00') String quietTo,

    // 7 · Fiyat ve rezervasyon
    int? nightlyPrice,
    int? weekendPrice,
    @Default(0) int cleaningFee,
    @Default(0) int weeklyDiscountPercent,
    @Default(1) int minNights,
    @Default(true) bool instantBook,
    @Default(CancellationPolicy.flexible) CancellationPolicy cancellation,

    // 8 · Giriş ve ev kılavuzu
    @Default(SelfCheckIn.keybox) SelfCheckIn checkInMethod,
    @Default('') String lockboxCode,
    @Default('') String lockboxHint,
    @Default('') String wifiName,
    @Default('') String wifiPassword,
    @Default('') String poolInstructions,
    @Default('') String houseInstructions,
    @Default(<String>[]) List<String> checkoutTasks,

    // 9 · Yasal belgeler
    PermitType? permitType,
    @Default('') String permitNo,
    @Default(<HostDocKind, HostDocument>{})
    Map<HostDocKind, HostDocument> documents,
    @Default(false) bool multiUnitParcel,
    @Default(false) bool onBehalfOfOwner,
    @Default(false) bool kbsDeclaration,
    @Default(false) bool permitHolderDeclaration,
    @Default(false) bool updateDeclaration,
    @Default(TaxType.individual) TaxType taxType,

    /// TCKN (şahıs) ya da vergi no (şirket). Yalnızca yazılırken bellekte
    /// durur; kaydedilince silinir ve [taxIdMasked] kalır (KVKK).
    @Default('') String taxId,

    /// Sunucuda kayıtlı vergi numarasının maskeli hali ("•••• 01 46").
    String? taxIdMasked,
    @Default('') String taxOffice,

    // 10 · Kimlik ve ödeme
    @Default(<IdentityStep>{}) Set<IdentityStep> identityDone,
    @Default(VerificationStatus.notStarted) VerificationStatus identityStatus,

    /// Kimlik doğrulamasından gelen ad soyad; IBAN sahibi bununla eşleşmeli.
    String? verifiedName,
    @Default('') String accountHolder,

    /// Yalnızca yazılırken bellekte durur; kaydedilince silinir ve
    /// [ibanMasked] kalır (KVKK).
    @Default('') String iban,

    /// Sunucuda kayıtlı IBAN'ın maskeli hali.
    String? ibanMasked,
    @Default('') String billingAddress,
    @Default('') String emergencyPhone,
    @Default(true) bool reachableDuringStay,

    // 93 · Onaylar
    @Default(false) bool accuracyConsent,
    @Default(false) bool agreementConsent,
    @Default(false) bool ministryConsent,
  }) = _ListingDraft;

  int get photoCount => photos.length;

  List<DraftPhoto> photosIn(RoomKind room) => [
    for (final p in photos)
      if (p.room == room) p,
  ];

  DraftPhoto? get cover =>
      photos.where((p) => p.id == coverPhotoId).firstOrNull ??
      photos.firstOrNull;

  bool get isLive =>
      status == ListingStatus.published || status == ListingStatus.paused;
}

/// İş kuralları (§10). Sayılar backend ile aynı tutulur.
abstract final class ListingRules {
  static const int minPhotos = 8;
  static const int recommendedPhotos = 20;
  static const int maxTitle = 50;
  static const int minTitle = 10;
  static const int maxHighlights = 3;
  static const int minSpace = 50;
  static const int maxDescription = 1000;
  static const int maxGuests = 16;
  static const int maxRooms = 10;

  // Kaydırmalı seçici aralıkları. [NumberRange.start], alan boşken seçicinin
  // açıldığı tipik değerdir (TR havuzlu bungalov ilanlarından derlendi);
  // taslağa kullanıcı "Kaydet" demeden yazılmaz.
  static const indoorM2 = NumberRange(min: 10, max: 500, start: 45);
  static const gardenM2 = NumberRange(min: 0, max: 5000, start: 150);
  static const poolTempC = NumberRange(min: 20, max: 40, start: 28);
  static const poolWidthM = NumberRange(min: 1, max: 20, step: 0.1, start: 4);
  static const poolLengthM = NumberRange(min: 1, max: 40, step: 0.1, start: 8);
  // DB: numeric(3, 1) → 0,1 m adım.
  static const poolDepthMinM = NumberRange(
    min: 0.3,
    max: 3,
    step: 0.1,
    start: 1.2,
  );
  static const poolDepthMaxM = NumberRange(
    min: 0.3,
    max: 3,
    step: 0.1,
    start: 1.6,
  );
  // DB: weekly_discount_percent between 0 and 50, min_nights between 1 and 30.
  static const weeklyDiscount = NumberRange(min: 0, max: 50, start: 0);
  static const minNights = NumberRange(min: 1, max: 30, start: 1);
}

/// Sayısal alanın izinli aralığı ve adımı.
class NumberRange {
  const NumberRange({
    required this.min,
    required this.max,
    required this.start,
    this.step = 1,
  });

  final double min;
  final double max;
  final double step;

  /// Değer yokken seçicinin açıldığı değer.
  final double start;

  /// Adımdaki ondalık basamak sayısı (0,1 → 1).
  int get decimals {
    var d = 0;
    var s = step;
    while (s != s.roundToDouble() && d < 4) {
      s *= 10;
      d++;
    }
    return d;
  }

  int get count => ((max - min) / step).round() + 1;

  double valueAt(int index) =>
      double.parse((min + index * step).toStringAsFixed(decimals));

  /// En yakın adıma yuvarlanmış, aralığa sıkıştırılmış sıra.
  int indexOf(num value) =>
      ((value.toDouble() - min) / step).round().clamp(0, count - 1);
}

abstract final class IbanValidator {
  static const int trLength = 26;

  /// "TR12 0006 …" → "TR120006…"
  static String normalize(String v) =>
      v.replaceAll(RegExp(r'\s'), '').toUpperCase();

  /// TR IBAN biçimi + ISO 13616 mod-97 denetimi.
  static bool isValidTr(String v) {
    final s = normalize(v);
    if (!RegExp(r'^TR\d{24}$').hasMatch(s)) return false;
    final rearranged = s.substring(4) + s.substring(0, 4);
    var rem = 0;
    for (final ch in rearranged.split('')) {
      final code = ch.codeUnitAt(0);
      final digits = code >= 65 ? '${code - 55}' : ch;
      for (final d in digits.split('')) {
        rem = (rem * 10 + int.parse(d)) % 97;
      }
    }
    return rem == 1;
  }

  /// "•••• 89 01" (KVKK: ekranda maskeli).
  static String masked(String v) {
    final s = normalize(v);
    if (s.length < 4) return s;
    final last = s.substring(s.length - 4);
    return '•••• ${last.substring(0, 2)} ${last.substring(2)}';
  }
}

abstract final class NameMatcher {
  /// Türkçe büyük/küçük harf ve boşluk farklarını yok sayar.
  static String _norm(String v) => v
      .trim()
      .replaceAll('I', 'ı')
      .replaceAll('İ', 'i')
      .toLowerCase()
      .replaceAll(RegExp(r'\s+'), ' ');

  static bool same(String a, String b) => _norm(a) == _norm(b);
}

/// Adım tamamlanma kuralları; "Devam" ve "İncelemeye gönder" buna bağlıdır.
abstract final class DraftValidator {
  static bool isComplete(WizardStep step, ListingDraft d) => switch (step) {
    WizardStep.typeAndLocation =>
      d.propertyType != null &&
          d.settings.isNotEmpty &&
          d.address.trim().isNotEmpty &&
          d.city.trim().isNotEmpty &&
          d.district.trim().isNotEmpty,
    WizardStep.basics =>
      d.maxGuests >= 1 &&
          d.beds >= 1 &&
          d.bathrooms >= 1 &&
          d.bedTypes.isNotEmpty &&
          (d.indoorM2 ?? 0) > 0,
    WizardStep.poolAndAmenities =>
      !d.hasPool ||
          ((!d.poolHeated || d.poolTempC != null) &&
              d.poolWidthM != null &&
              d.poolLengthM != null &&
              d.poolDepthMinM != null &&
              d.poolDepthMaxM != null &&
              d.poolSeasonStart != null &&
              d.poolSeasonEnd != null),
    WizardStep.photos =>
      d.photoCount >= ListingRules.minPhotos && d.cover != null,
    WizardStep.titleAndDescription =>
      d.title.trim().length >= ListingRules.minTitle &&
          d.title.trim().length <= ListingRules.maxTitle &&
          d.highlights.isNotEmpty &&
          d.highlights.length <= ListingRules.maxHighlights &&
          d.space.trim().length >= ListingRules.minSpace,
    WizardStep.safetyAndRules =>
      (!d.safety.contains(SafetyKind.outdoorCamera) ||
              d.outdoorCameraNote.trim().isNotEmpty) &&
          (!d.hasPool || d.poolNoLifeguardAck),
    WizardStep.pricing => (d.nightlyPrice ?? 0) > 0 && d.minNights >= 1,
    WizardStep.checkIn =>
      d.checkInMethod != SelfCheckIn.keybox ||
          (d.lockboxCode.trim().isNotEmpty && d.lockboxHint.trim().isNotEmpty),
    WizardStep.legal => _legalComplete(d),
    // Kimlik incelemede olsa da devam edilir; ad eşleşmesi doğrulanmış ad
    // gelince denetlenir (backend ile aynı kural).
    WizardStep.identityAndPayout =>
      !requireIdentityPayout ||
          d.identityDone.length == IdentityStep.values.length &&
          d.identityStatus != VerificationStatus.rejected &&
          (IbanValidator.isValidTr(d.iban) ||
              (d.iban.isEmpty && d.ibanMasked != null)) &&
          d.accountHolder.trim().isNotEmpty &&
          (d.verifiedName == null ||
              NameMatcher.same(d.accountHolder, d.verifiedName!)) &&
          d.billingAddress.trim().isNotEmpty &&
          d.emergencyPhone.replaceAll(RegExp(r'\D'), '').length >= 10,
  };

  /// Belge dosyaları şimdilik zorunlu değil; geri açınca backend'deki
  /// `private.listing_missing_steps` ile birlikte açılmalı.
  static const requireDocuments = false;

  /// Geliştirmede yasal adım (izin no, beyanlar, vergi) şimdilik zorunlu
  /// değil. Canlıdan önce mutlaka true yapılmalı (§10: izin belge numarası
  /// olmayan ilan yayına alınmaz). Backend'de karşılığı:
  /// `platform_settings.auto_approve_reviews` açıkken yasal şart aranmaz.
  static const requireLegal = false;

  /// Geliştirmede kimlik ve ödeme adımı (10) şimdilik zorunlu değil.
  /// Canlıdan önce mutlaka true yapılmalı. Backend'de karşılığı:
  /// `platform_settings.auto_approve_reviews` açıkken bu şart aranmaz.
  static const requireIdentityPayout = false;

  static bool _legalComplete(ListingDraft d) {
    if (!requireLegal) return true;
    bool has(HostDocKind k) => d.documents.containsKey(k);
    final taxOk = switch (d.taxType) {
      _ when d.taxId.isEmpty => d.taxIdMasked != null,
      TaxType.individual => IdValidators.isTckn(d.taxId),
      TaxType.company => RegExp(r'^\d{10}$').hasMatch(d.taxId),
    };
    final docsOk =
        !requireDocuments ||
        (has(HostDocKind.permit) &&
            has(HostDocKind.deed) &&
            has(HostDocKind.entrancePlate) &&
            (!d.multiUnitParcel || has(HostDocKind.condoDecision)) &&
            (!d.onBehalfOfOwner || has(HostDocKind.powerOfAttorney)));
    // İzin belge numarası olmayan ilan yayına alınmaz (§10).
    return d.permitType != null &&
        d.permitNo.trim().isNotEmpty &&
        docsOk &&
        d.kbsDeclaration &&
        d.permitHolderDeclaration &&
        d.updateDeclaration &&
        taxOk &&
        d.taxOffice.trim().isNotEmpty;
  }

  static bool allStepsComplete(ListingDraft d) =>
      WizardStep.values.every((s) => isComplete(s, d));

  /// "İncelemeye gönder" yalnızca tüm adımlar ve 3 onay tamamsa açık.
  static bool canSubmit(ListingDraft d) =>
      allStepsComplete(d) &&
      d.accuracyConsent &&
      d.agreementConsent &&
      d.ministryConsent;
}

/// 89 · "Misafir ne öder, sana ne kalır?" — oranları backend hesaplar.
@freezed
abstract class EarningsEstimate with _$EarningsEstimate {
  const factory EarningsEstimate({
    required int nights,
    required int nightly,
    required int stayTotal,
    required int cleaningFee,

    /// Ev sahibinden kesilen hizmet bedeli (backend oranı).
    required int serviceFee,
    required int hostEarns,

    /// Bölgedeki benzer ilanların gecelik aralığı; bölgede yayında ilan
    /// yoksa null.
    int? similarMin,
    int? similarMax,
  }) = _EarningsEstimate;
}
