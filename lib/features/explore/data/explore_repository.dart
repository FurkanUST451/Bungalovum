import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/explore_category.dart';
import '../domain/explore_feed.dart';
import 'mock_explore_repository.dart';

part 'explore_repository.g.dart';

/// Keşfet akışının veri kaynağı. UI bu arayüz dışında API'ye dokunmaz.
abstract interface class ExploreRepository {
  Future<ExploreFeed> fetchFeed({required ExploreCategory category});
}

/// API hazır olduğunda `dio` tabanlı uygulama ile değiştirilir.
@Riverpod(keepAlive: true)
ExploreRepository exploreRepository(Ref ref) => MockExploreRepository();
