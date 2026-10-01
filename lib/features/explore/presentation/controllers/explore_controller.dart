import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/explore_repository.dart';
import '../../domain/explore_category.dart';
import '../../domain/explore_feed.dart';

part 'explore_controller.g.dart';

/// Keşfet'te seçili kategori.
@riverpod
class SelectedExploreCategory extends _$SelectedExploreCategory {
  @override
  ExploreCategory build() => ExploreCategory.all;

  void select(ExploreCategory category) => state = category;
}

/// Seçili kategoriye göre Keşfet akışı.
@riverpod
Future<ExploreFeed> exploreFeed(Ref ref) {
  final category = ref.watch(selectedExploreCategoryProvider);
  return ref.watch(exploreRepositoryProvider).fetchFeed(category: category);
}
