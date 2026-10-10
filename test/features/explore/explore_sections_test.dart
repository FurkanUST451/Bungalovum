import 'package:bungalovum/features/explore/data/explore_repository.dart';
import 'package:bungalovum/features/explore/domain/explore_category.dart';
import 'package:bungalovum/features/explore/domain/explore_feed.dart';
import 'package:bungalovum/features/explore/presentation/screens/explore_screen.dart';
import 'package:bungalovum/features/listing/data/listing_catalog.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

class _FakeExplore implements ExploreRepository {
  _FakeExplore(this.feed);

  final ExploreFeed feed;

  @override
  Future<ExploreFeed> fetchFeed({required ExploreCategory category}) async =>
      feed;
}

void main() {
  Future<void> pump(WidgetTester tester, ExploreFeed feed) async {
    final size = testDevices['phone_390x844']!;
    tester.view.physicalSize = size * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      testScreen(
        const ExploreScreen(),
        size: size,
        explore: _FakeExplore(feed),
      ),
    );
    await tester.pumpAndSettle();
  }

  final friday = DateTime(2026, 11, 6);
  final samsunListing = ListingCatalog.all.first;

  testWidgets('bölge şeritleri sırayla, kendi başlıklarıyla görünür', (
    tester,
  ) async {
    await pump(
      tester,
      ExploreFeed(
        locationLabel: 'Sapanca, Sakarya',
        weekendStart: friday,
        weekendEnd: friday.add(const Duration(days: 2)),
        sections: [
          ExploreSection(
            kind: ExploreSectionKind.loved,
            regionLocative: "Sapanca'da",
            location: 'Sapanca',
            listings: [ListingCatalog.all[1]],
          ),
          ExploreSection(
            kind: ExploreSectionKind.favorites,
            regionLocative: "Samsun'da",
            location: 'Samsun',
            listings: [samsunListing],
          ),
        ],
      ),
    );
    expect(find.text("Sapanca'da en sevilenler"), findsOneWidget);
    // İkinci şerit ekranın altında; kaydırınca görünür.
    await tester.scrollUntilVisible(
      find.text("Samsun'da favori mekanlar"),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text("Samsun'da favori mekanlar"), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text(samsunListing.title),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text(samsunListing.title), findsOneWidget);
  });

  testWidgets('ilanı olmayan bölge şeridi gizlenir', (tester) async {
    await pump(
      tester,
      ExploreFeed(
        locationLabel: 'Sapanca, Sakarya',
        weekendStart: friday,
        weekendEnd: friday.add(const Duration(days: 2)),
        sections: [
          const ExploreSection(
            kind: ExploreSectionKind.loved,
            regionLocative: "Sapanca'da",
            location: 'Sapanca',
          ),
          ExploreSection(
            kind: ExploreSectionKind.favorites,
            regionLocative: "Samsun'da",
            location: 'Samsun',
            listings: [samsunListing],
          ),
        ],
      ),
    );
    expect(find.text("Sapanca'da en sevilenler"), findsNothing);
    expect(find.text("Samsun'da favori mekanlar"), findsOneWidget);
  });
}
