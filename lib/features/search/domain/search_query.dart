import 'package:freezed_annotation/freezed_annotation.dart';

import '../../listing/domain/listing.dart';

part 'search_query.freezed.dart';

@freezed
abstract class GuestCount with _$GuestCount {
  const GuestCount._();

  const factory GuestCount({
    @Default(2) int adults,
    @Default(0) int children,
    @Default(0) int infants,
    @Default(0) int pets,
  }) = _GuestCount;

  /// Kapasiteye sayılan misafir (bebekler sayılmaz).
  int get total => adults + children;
}

@freezed
abstract class StayDates with _$StayDates {
  const StayDates._();

  const factory StayDates({
    required DateTime checkIn,
    required DateTime checkOut,
  }) = _StayDates;

  int get nights => checkOut.difference(checkIn).inDays;
}

/// Filtrelerdeki özellik çipleri.
enum SearchFeature {
  pool,
  heatedPool,
  jacuzzi,
  fireplace,
  lakeView,
  forest,
  airConditioning,
  wifi,
  parking;

  bool matches(Listing l) => switch (this) {
    pool => l.amenities.contains(Amenity.pool),
    heatedPool => l.amenities.contains(Amenity.heatedPool),
    jacuzzi => l.amenities.contains(Amenity.jacuzzi),
    fireplace => l.amenities.contains(Amenity.fireplace),
    lakeView => l.settings.any(
      (s) => s == ListingSetting.lakeView || s == ListingSetting.lakeside,
    ),
    forest => l.settings.contains(ListingSetting.forest),
    airConditioning => l.amenities.contains(Amenity.airConditioning),
    wifi => l.amenities.contains(Amenity.wifi),
    parking => l.amenities.contains(Amenity.parking),
  };
}

enum SearchSort { recommended, priceLow, priceHigh, rating }

@freezed
abstract class SearchFilters with _$SearchFilters {
  const SearchFilters._();

  const factory SearchFilters({
    /// Gecelik fiyat aralığı (TRY); null = sınır yok.
    int? priceMin,
    int? priceMax,
    @Default(<SearchFeature>{}) Set<SearchFeature> features,

    /// null = farketmez; 4 = 4 ve üzeri.
    int? bedrooms,
    @Default(false) bool instantBook,
    @Default(false) bool freeCancellation,
    @Default(false) bool petsAllowed,
    @Default(false) bool accessible,
  }) = _SearchFilters;

  /// Filtre butonundaki rozet sayısı.
  int get activeCount =>
      features.length +
      (priceMin != null || priceMax != null ? 1 : 0) +
      (bedrooms != null ? 1 : 0) +
      (instantBook ? 1 : 0) +
      (freeCancellation ? 1 : 0) +
      (petsAllowed ? 1 : 0) +
      (accessible ? 1 : 0);

  bool matches(Listing l) =>
      (priceMin == null || l.nightlyPrice >= priceMin!) &&
      (priceMax == null || l.nightlyPrice <= priceMax!) &&
      features.every((f) => f.matches(l)) &&
      (bedrooms == null ||
          (bedrooms! >= 4 ? l.bedrooms >= 4 : l.bedrooms == bedrooms)) &&
      (!instantBook || l.instantBook) &&
      (!freeCancellation || l.freeCancellation) &&
      (!petsAllowed || l.petsAllowed) &&
      (!accessible || l.accessible);
}

@freezed
abstract class SearchQuery with _$SearchQuery {
  const SearchQuery._();

  const factory SearchQuery({
    @Default('') String location,
    StayDates? dates,
    @Default(GuestCount()) GuestCount guests,
    @Default(SearchFilters()) SearchFilters filters,
    @Default(SearchSort.recommended) SearchSort sort,
  }) = _SearchQuery;

  /// Tarih seçilmemişse fiyatlar bu kadar gece için gösterilir.
  static const defaultNights = 2;

  int get nights => dates?.nights ?? defaultNights;
}

/// "Son aramalar" satırı.
@freezed
abstract class RecentSearch with _$RecentSearch {
  const factory RecentSearch({
    required String location,
    StayDates? dates,
    required GuestCount guests,
  }) = _RecentSearch;
}

/// "Sonuç yok" önerisi: uygulanırsa çıkacak ek ilan sayısıyla.
enum RelaxKind { flexibleDates, removeHeatedPool, widenPrice }

@freezed
abstract class RelaxSuggestion with _$RelaxSuggestion {
  const factory RelaxSuggestion({
    required RelaxKind kind,
    required int extraCount,
  }) = _RelaxSuggestion;
}

/// Takvimde bir gün.
@freezed
abstract class CalendarDay with _$CalendarDay {
  const factory CalendarDay({
    required DateTime date,
    required bool available,

    /// Gecelik fiyat (TRY); dolu günlerde null.
    int? price,

    /// Ortalamadan uygun fiyatlı gün (yeşil nokta).
    @Default(false) bool isDeal,
  }) = _CalendarDay;
}
