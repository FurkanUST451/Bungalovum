import 'package:bungalovum/app/app.dart';
import 'package:bungalovum/app/router.dart';
import 'package:bungalovum/core/services/connectivity.dart';
import 'package:bungalovum/core/services/permissions.dart';
import 'package:bungalovum/core/utils/clock.dart';
import 'package:bungalovum/features/account/data/account_repository.dart';
import 'package:bungalovum/features/account/data/mock_account_repository.dart';
import 'package:bungalovum/features/auth/data/auth_repository.dart';
import 'package:bungalovum/features/auth/data/mock_auth_repository.dart';
import 'package:bungalovum/features/booking/data/booking_repository.dart';
import 'package:bungalovum/features/chat/data/chat_repository.dart';
import 'package:bungalovum/features/chat/data/mock_chat_repository.dart';
import 'package:bungalovum/features/booking/data/mock_booking_repository.dart';
import 'package:bungalovum/features/explore/data/explore_repository.dart';
import 'package:bungalovum/features/host/data/host_repository.dart';
import 'package:bungalovum/features/host/data/mock_host_repository.dart';
import 'package:bungalovum/features/explore/data/mock_explore_repository.dart';
import 'package:bungalovum/features/listing/data/listing_repository.dart';
import 'package:bungalovum/features/listing/data/mock_listing_repository.dart';
import 'package:bungalovum/features/saved/data/wishlist_repository.dart';
import 'package:bungalovum/features/search/data/mock_search_repository.dart';
import 'package:bungalovum/features/search/data/search_repository.dart';
import 'package:bungalovum/features/wallet/data/mock_wallet_repository.dart';
import 'package:bungalovum/features/wallet/data/wallet_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:go_router/go_router.dart';

import 'fake_services.dart';

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
List<Override> _overrides({
  PermissionService? permissions,
  ConnectivityService? connectivity,
  ExploreRepository? explore,
}) => [
  exploreRepositoryProvider.overrideWithValue(
    explore ?? MockExploreRepository(clock: fixedClock, latency: Duration.zero),
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
    MockWishlistRepository(latency: Duration.zero, clock: fixedClock),
  ),
  bookingRepositoryProvider.overrideWithValue(
    MockBookingRepository(latency: Duration.zero, clock: fixedClock),
  ),
  chatRepositoryProvider.overrideWithValue(
    MockChatRepository(latency: Duration.zero, clock: fixedClock),
  ),
  accountRepositoryProvider.overrideWithValue(
    MockAccountRepository(latency: Duration.zero, clock: fixedClock),
  ),
  walletRepositoryProvider.overrideWithValue(
    MockWalletRepository(latency: Duration.zero, clock: fixedClock),
  ),
  hostRepositoryProvider.overrideWithValue(
    MockHostRepository(latency: Duration.zero, clock: fixedClock),
  ),
  permissionServiceProvider.overrideWithValue(
    permissions ?? FakePermissionService(),
  ),
  connectivityServiceProvider.overrideWithValue(
    connectivity ?? FakeConnectivityService(),
  ),
  clockProvider.overrideWithValue(fixedClock),
];

Widget _device({
  required Size size,
  required double textScale,
  required Widget child,
  PermissionService? permissions,
  ConnectivityService? connectivity,
  ExploreRepository? explore,
}) => ProviderScope(
  overrides: _overrides(
    permissions: permissions,
    connectivity: connectivity,
    explore: explore,
  ),
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
  PermissionService? permissions,
  ConnectivityService? connectivity,
}) => _device(
  size: size,
  textScale: textScale,
  permissions: permissions,
  connectivity: connectivity,
  child: BungalovumApp(initialLocation: initialLocation),
);

/// Tek bir ekran, uygulamanın teması ve l10n'u ile (rota parametresi
/// gerektiren ekranlar için).
Widget testScreen(
  Widget screen, {
  required Size size,
  double textScale = 1,
  PermissionService? permissions,
  ConnectivityService? connectivity,
  ExploreRepository? explore,
}) => _device(
  size: size,
  textScale: textScale,
  permissions: permissions,
  connectivity: connectivity,
  explore: explore,
  child: BungalovumApp(
    router: GoRouter(
      routes: [GoRoute(path: '/', builder: (_, _) => screen)],
    ),
  ),
);
