import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../booking/domain/price_calculator.dart';
import '../domain/listing.dart';
import '../domain/listing_detail.dart';
import 'mock_listing_repository.dart';

part 'listing_repository.g.dart';

enum ReportReason { inaccurate, fraud, offPlatformPayment, safety, other }

abstract interface class ListingRepository {
  Future<ListingDetail> detail(String id);

  /// Seçili gece sayısı için fiyat kalemleri (backend hesaplar).
  Future<PriceBreakdown> quote(String id, int nights);

  Future<List<Listing>> byIds(List<String> ids);

  /// Paylaşım bağlantısı: "kozalak.app/b/gol-esintisi".
  String shareLink(String id);

  Future<void> report(String id, ReportReason reason, String details);
}

@Riverpod(keepAlive: true)
ListingRepository listingRepository(Ref ref) => MockListingRepository();

@riverpod
Future<ListingDetail> listingDetail(Ref ref, String id) =>
    ref.watch(listingRepositoryProvider).detail(id);

@riverpod
Future<List<Listing>> listingsByIds(Ref ref, List<String> ids) =>
    ref.watch(listingRepositoryProvider).byIds(ids);
