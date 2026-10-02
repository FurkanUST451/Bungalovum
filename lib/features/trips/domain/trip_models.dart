import 'package:freezed_annotation/freezed_annotation.dart';

import '../../listing/domain/house_guide.dart';

part 'trip_models.freezed.dart';

/// Konaklamaya erişim bilgileri (49 · Konaklama Detayı, 50 · Ev Kılavuzu).
/// Tam adres, ev sahibi telefonu, anahtar kutusu ve Wi-Fi bilgileri yalnızca
/// onaylı rezervasyonda, [revealAt] anından sonra backend tarafından
/// doldurulur (§10). Cihazda kalıcı saklanmaz.
@freezed
abstract class TripAccess with _$TripAccess {
  const TripAccess._();

  const factory TripAccess({
    required DateTime revealAt,

    /// "Kırkpınar, Sapanca" — açılmadan önce gösterilen yaklaşık konum.
    required String areaLabel,

    /// Açılmadan önce yaklaşık, sonra tam konum.
    required double latitude,
    required double longitude,

    /// "14:00", "11:00"
    required String checkInFrom,
    required String checkOutBy,

    /// Ev kuralları ve çıkış listesi her zaman görünür.
    @Default(<GuideSection>[]) List<GuideSection> sections,
    @Default(<String>[]) List<String> checkoutTasks,

    // Açıldıktan sonra dolu gelenler:
    List<String>? addressLines,
    String? hostPhone,
    String? lockboxCode,
    String? lockboxHint,
    String? wifiName,
    String? wifiPassword,
  }) = _TripAccess;

  bool get revealed => addressLines != null;

  String get addressText => (addressLines ?? const []).join('\n');
}

enum IssueTopic { pool, hotWater, cleaning, wifi, climate, other }

enum IssueUrgency { low, today, urgent }

/// 51 · Sorun Bildir.
class IssueReport {
  const IssueReport({
    required this.topic,
    required this.urgency,
    required this.description,
    this.photoPaths = const [],
  });

  final IssueTopic topic;
  final IssueUrgency urgency;
  final String description;

  /// Seçilen fotoğrafların geçici dosya yolları (yüklendikten sonra silinir).
  final List<String> photoPaths;
}

enum BillingType { individual, corporate }

/// 53 · Fatura Bilgileri (kullanıcı düzeyinde).
@freezed
abstract class BillingInfo with _$BillingInfo {
  const factory BillingInfo({
    @Default(BillingType.individual) BillingType type,
    @Default('') String fullName,

    /// Bireyselde isteğe bağlı. KVKK: yalnızca maskeli döner.
    String? tcknLast2,
    @Default('') String address,
    @Default('') String email,
    @Default('') String companyName,
    @Default('') String taxOffice,
    @Default('') String taxNumber,
  }) = _BillingInfo;
}

/// Kaydetmek için form girdisi; TCKN yalnızca burada, bellekte bulunur.
class BillingInput {
  const BillingInput({required this.info, this.tckn});

  final BillingInfo info;
  final String? tckn;
}

/// 54 · İptalde iade hesabı (backend hesaplar).
@freezed
abstract class CancellationQuote with _$CancellationQuote {
  const CancellationQuote._();

  const factory CancellationQuote({
    required int paid,
    required int deduction,
    required int refund,

    /// Ücretsiz iptalin son anı.
    required DateTime freeUntil,
  }) = _CancellationQuote;

  bool get fullRefund => deduction == 0;

  bool get noRefund => refund == 0;
}

enum CancelReason { plansChanged, foundOther, hostAsked, other }

enum ReviewCategory { cleanliness, accuracy, communication, location, value }

enum ReviewLike { pool, view, quiet, cleanliness, host, location }

/// 55 · Değerlendirme Yaz.
class ReviewInput {
  const ReviewInput({
    required this.overall,
    required this.categories,
    required this.likes,
    required this.text,
    this.photoPaths = const [],
  });

  final int overall;
  final Map<ReviewCategory, int> categories;
  final Set<ReviewLike> likes;
  final String text;
  final List<String> photoPaths;
}

abstract final class ReviewPolicy {
  static const maxLength = 500;
  static const minLength = 20;
  static const maxPhotos = 6;
}

abstract final class IssuePolicy {
  static const maxPhotos = 5;
  static const minLength = 10;
}
