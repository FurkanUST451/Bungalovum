import 'package:supabase_flutter/supabase_flutter.dart';

import '../../booking/domain/price_calculator.dart';
import '../domain/listing.dart';
import '../domain/listing_detail.dart';
import 'listing_json.dart';
import 'listing_repository.dart';

/// 19–30 · İlan detayı Supabase'ten (`listing_detail`, `listing_cards`,
/// `listing_price_estimate`). Fiyat kalemleri veritabanında hesaplanır.
class SupabaseListingRepository implements ListingRepository {
  SupabaseListingRepository(this._client, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final SupabaseClient _client;
  final DateTime Function() _clock;

  @override
  Future<ListingDetail> detail(String id) async {
    final json = await _client.rpc<dynamic>(
      'listing_detail',
      params: {'p_listing': id},
    );
    return ListingJson.detail(json as Map<String, dynamic>, now: _clock());
  }

  @override
  Future<PriceBreakdown> quote(String id, int nights) async {
    final json = await _client.rpc<dynamic>(
      'listing_price_estimate',
      params: {'p_listing': id, 'p_nights': nights},
    );
    return ListingJson.price(json as Map<String, dynamic>);
  }

  @override
  Future<List<Listing>> byIds(List<String> ids) async {
    if (ids.isEmpty) return const [];
    final json = await _client.rpc<dynamic>(
      'listing_cards',
      params: {'p_ids': ids},
    );
    return [
      for (final c in (json as List).cast<Map<String, dynamic>>())
        ListingJson.card(c),
    ];
  }

  @override
  String shareLink(String id) => 'bungalovum.app/b/$id';

  @override
  Future<void> report(String id, ReportReason reason, String details) =>
      _client.from('listing_reports').insert({
        'listing_id': id,
        'reason': ListingJson.snake(reason.name),
        'details': details.trim().isEmpty ? null : details.trim(),
      });
}
