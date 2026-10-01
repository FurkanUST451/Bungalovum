import '../../../core/icons/kz_icons.dart';
import '../../../core/utils/formatters.dart';
import '../../../l10n/l10n.dart';
import '../../listing/domain/listing.dart';
import '../../listing/presentation/listing_labels.dart';
import '../domain/search_query.dart';

extension SearchFeatureUi on SearchFeature {
  String label(AppLocalizations l) => switch (this) {
    SearchFeature.pool => l.amenityPool,
    SearchFeature.heatedPool => l.amenityHeatedPool,
    SearchFeature.jacuzzi => l.amenityJacuzzi,
    SearchFeature.fireplace => l.amenityFireplace,
    SearchFeature.lakeView => l.featureLakeView,
    SearchFeature.forest => l.settingForest,
    SearchFeature.airConditioning => l.amenityAirConditioning,
    SearchFeature.wifi => l.amenityWifi,
    SearchFeature.parking => l.amenityParking,
  };

  KzIcons get icon => switch (this) {
    SearchFeature.pool => KzIcons.waves,
    SearchFeature.heatedPool => KzIcons.thermo,
    SearchFeature.jacuzzi => KzIcons.bath,
    SearchFeature.fireplace => KzIcons.flame,
    SearchFeature.lakeView => KzIcons.mountain,
    SearchFeature.forest => KzIcons.trees,
    SearchFeature.airConditioning => KzIcons.snow,
    SearchFeature.wifi => KzIcons.wifi,
    SearchFeature.parking => KzIcons.car,
  };
}

extension SearchSortUi on SearchSort {
  String label(AppLocalizations l) => switch (this) {
    SearchSort.recommended => l.sortRecommended,
    SearchSort.priceLow => l.sortPriceLow,
    SearchSort.priceHigh => l.sortPriceHigh,
    SearchSort.rating => l.sortRating,
  };
}

/// "2 misafir"
String guestsLabel(AppLocalizations l, GuestCount g) =>
    l.listingGuests(g.total);

/// "6 – 8 Kas" ya da "Esnek tarih".
String datesLabel(AppLocalizations l, StayDates? d) =>
    d == null ? l.searchAnyDate : KzFormat.dateRange(d.checkIn, d.checkOut);

/// Arama özeti alt satırı: "6 – 8 Kas · 2 misafir".
String querySummary(AppLocalizations l, SearchQuery q) =>
    l.searchSummary(datesLabel(l, q.dates), guestsLabel(l, q.guests));

extension ListingSearchLine on Listing {
  /// Sonuç kartı alt satırı: "Göl manzarası · Isıtmalı havuz · 2 misafir".
  String resultLine(AppLocalizations l) {
    final setting = settings.isEmpty
        ? null
        : (settings.first == ListingSetting.lakeView
              ? l.featureLakeView
              : settings.first.label(l));
    final amenity = amenities.where((a) => a.isFeatured).firstOrNull;
    return [
      ?setting,
      ?amenity?.label(l),
      l.listingGuests(maxGuests),
    ].join(' · ');
  }
}
