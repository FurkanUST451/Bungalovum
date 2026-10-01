import 'package:bungapp/app/app.dart';
import 'package:bungapp/app/router.dart';
import 'package:bungapp/features/auth/data/auth_repository.dart';
import 'package:bungapp/features/auth/data/mock_auth_repository.dart';
import 'package:bungapp/features/explore/data/explore_repository.dart';
import 'package:bungapp/features/explore/data/mock_explore_repository.dart';
import 'package:bungapp/features/listing/data/listing_repository.dart';
import 'package:bungapp/features/listing/data/mock_listing_repository.dart';
import 'package:bungapp/features/saved/data/wishlist_repository.dart';
import 'package:bungapp/features/search/data/mock_search_repository.dart';
import 'package:bungapp/features/search/data/search_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:go_router/go_router.dart';

/// Figma örnek verisiyle aynı hafta sonu (6 – 8 Kas) çıksın diye sabit saat.
DateTime fixedClock() => DateTime(2026, 11, 3);

/// §12'deki golden/taşma boyutları.
const testDevices = <String, Size>{
  'phone_320x568': Size(320, 568),
  'phone_390x844': Size(390, 844),
  'phone_430x932': Size(430, 932),
  'tablet_768x1024': Size(768, 1024),
  'tablet_1024x1366': Size(1024, 1366),
};

EdgeInsets devicePadding(Size size) => size.width < 600
    ? const EdgeInsets.only(top: 47, bottom: 34)
    : const EdgeInsets.only(top: 24, bottom: 20);

/// Her uygulama örneği için taze mock depolar (testler arası durum sızmaz).
List<Override> get _overrides => [
  exploreRepositoryProvider.overrideWithValue(
    MockExploreRepository(clock: fixedClock, latency: Duration.zero),
  ),
  authRepositoryProvider.overrideWithValue(
    MockAuthRepository(latency: Duration.zero),
  ),
  searchRepositoryProvider.overrideWithValue(
    MockSearchRepository(latency: Duration.zero),
  ),
  listingRepositoryProvider.overrideWithValue(
    MockListingRepository(latency: Duration.zero),
  ),
  wishlistRepositoryProvider.overrideWithValue(
    MockWishlistRepository(latency: Duration.zero),
  ),
];

Widget _device({
  required Size size,
  required double textScale,
  required Widget child,
}) => ProviderScope(
  overrides: _overrides,
  child: MediaQuery(
    data: MediaQueryData(
      size: size,
      devicePixelRatio: 3,
      padding: devicePadding(size),
      viewPadding: devicePadding(size),
      textScaler: TextScaler.linear(textScale),
    ),
    child: child,
  ),
);

/// Uygulamanın tamamı (router + tema + l10n).
Widget testApp({
  required Size size,
  double textScale = 1,
  String initialLocation = AppRoutes.explore,
}) => _device(
  size: size,
  textScale: textScale,
  child: KozalakApp(initialLocation: initialLocation),
);

/// Tek bir ekran, uygulamanın teması ve l10n'u ile (rota parametresi
/// gerektiren ekranlar için).
Widget testScreen(
  Widget screen, {
  required Size size,
  double textScale = 1,
}) => _device(
  size: size,
  textScale: textScale,
  child: KozalakApp(
    router: GoRouter(
      routes: [GoRoute(path: '/', builder: (_, _) => screen)],
    ),
  ),
);
