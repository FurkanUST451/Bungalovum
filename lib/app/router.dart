import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/screens/code_verification_screens.dart';
import '../features/auth/presentation/screens/password_reset_screens.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/welcome_screen.dart';
import '../features/booking/presentation/screens/date_picker_screen.dart';
import '../features/booking/presentation/screens/guest_picker_screen.dart';
import '../features/explore/presentation/screens/explore_screen.dart';
import '../features/listing/domain/listing_detail.dart';
import '../features/listing/presentation/screens/listing_detail_screen.dart';
import '../features/listing/presentation/screens/listing_extra_screens.dart';
import '../features/listing/presentation/screens/listing_info_screens.dart';
import '../features/listing/presentation/screens/photo_screens.dart';
import '../features/search/presentation/screens/filters_screen.dart';
import '../features/search/presentation/screens/map_screen.dart';
import '../features/search/presentation/screens/results_screen.dart';
import '../features/search/presentation/screens/search_screen.dart';
import 'app_shell.dart';
import 'routes.dart';

export 'routes.dart';

/// Akış adımları arası taşınan değer (telefon, e-posta, jeton) `extra` ile
/// gelir. Uygulama yeniden başlatıldığında kaybolursa akışın başına dönülür.
GoRoute _withExtra(
  String path,
  String fallback,
  GoRouterWidgetBuilder Function(String value) build,
) => GoRoute(
  path: path,
  redirect: (_, state) => state.extra is String ? null : fallback,
  builder: (context, state) => build(state.extra! as String)(context, state),
);

/// Alttan açılan tam ekran (Arama, Filtreler, Tarih, Misafirler...).
GoRoute _modal(String path, Widget Function(GoRouterState state) build) =>
    GoRoute(
      path: path,
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        fullscreenDialog: true,
        child: build(state),
      ),
    );

GoRouter buildRouter({String initialLocation = AppRoutes.welcome}) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    // 01–12 · Giriş ve kayıt
    GoRoute(path: AppRoutes.welcome, builder: (_, _) => const WelcomeScreen()),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (_, state) => SignInScreen(
        initialMethod: state.uri.queryParameters['yontem'] == 'telefon'
            ? SignInMethod.phone
            : SignInMethod.email,
      ),
    ),
    _withExtra(
      AppRoutes.smsVerify,
      AppRoutes.signIn,
      (phone) =>
          (_, _) => SmsVerifyScreen(phone: phone),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (_, _) => const RegisterScreen(),
    ),
    _withExtra(
      AppRoutes.verifyEmail,
      AppRoutes.register,
      (email) =>
          (_, _) => VerifyEmailScreen(email: email),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (_, _) => const ForgotPasswordScreen(),
    ),
    _withExtra(
      AppRoutes.resetCode,
      AppRoutes.forgotPassword,
      (email) =>
          (_, _) => ResetCodeScreen(email: email),
    ),
    _withExtra(
      AppRoutes.newPassword,
      AppRoutes.forgotPassword,
      (token) =>
          (_, _) => NewPasswordScreen(token: token),
    ),
    GoRoute(
      path: AppRoutes.passwordUpdated,
      builder: (_, _) => const PasswordUpdatedScreen(),
    ),

    // 14–18 · Arama
    _modal(AppRoutes.search, (_) => const SearchScreen()),
    _modal(AppRoutes.filters, (_) => const FiltersScreen()),
    GoRoute(path: AppRoutes.results, builder: (_, _) => const ResultsScreen()),
    GoRoute(path: AppRoutes.map, builder: (_, _) => const MapScreen()),

    // 19–29 · İlan
    GoRoute(
      path: '/ilan/:id',
      builder: (_, s) => ListingDetailScreen(id: s.pathParameters['id']!),
      routes: [
        GoRoute(
          path: 'fotograflar',
          builder: (_, s) => PhotoTourScreen(id: s.pathParameters['id']!),
          routes: [
            GoRoute(
              path: ':index',
              pageBuilder: (_, s) => MaterialPage(
                key: s.pageKey,
                fullscreenDialog: true,
                child: PhotoViewerScreen(
                  id: s.pathParameters['id']!,
                  index: int.tryParse(s.pathParameters['index']!) ?? 0,
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'degerlendirmeler',
          builder: (_, s) => ReviewsScreen(
            id: s.pathParameters['id']!,
            topic: ReviewTopic.values
                .where((t) => t.name == s.uri.queryParameters['konu'])
                .firstOrNull,
          ),
        ),
        GoRoute(
          path: 'olanaklar',
          builder: (_, s) => AmenitiesScreen(id: s.pathParameters['id']!),
        ),
        GoRoute(
          path: 'kurallar',
          builder: (_, s) => RulesScreen(
            id: s.pathParameters['id']!,
            initialTab: int.tryParse(s.uri.queryParameters['sekme'] ?? '') ?? 0,
          ),
        ),
        GoRoute(
          path: 'konum',
          builder: (_, s) => LocationScreen(id: s.pathParameters['id']!),
        ),
        GoRoute(
          path: 'bildir',
          pageBuilder: (_, s) => MaterialPage(
            key: s.pageKey,
            fullscreenDialog: true,
            child: ReportListingScreen(id: s.pathParameters['id']!),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/ev-sahibi/:hostId',
      builder: (_, s) => HostProfileScreen(
        hostId: s.pathParameters['hostId']!,
        listingId: s.uri.queryParameters['ilan'] ?? '',
      ),
    ),

    // 31–32 · Seçiciler
    _modal(
      AppRoutes.dates,
      (s) => DatePickerScreen(
        args: s.extra is DatePickerArgs
            ? s.extra! as DatePickerArgs
            : const DatePickerArgs(),
      ),
    ),
    _modal(
      AppRoutes.guests,
      (s) => GuestPickerScreen(
        args: s.extra is GuestPickerArgs
            ? s.extra! as GuestPickerArgs
            : const GuestPickerArgs(),
      ),
    ),

    // Sekmeler
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => AppShell(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.explore,
              builder: (_, _) => const ExploreScreen(),
            ),
          ],
        ),
        for (final path in const [
          AppRoutes.saved,
          AppRoutes.trips,
          AppRoutes.chats,
          AppRoutes.account,
        ])
          StatefulShellBranch(
            routes: [
              GoRoute(path: path, builder: (_, _) => const PendingTabScreen()),
            ],
          ),
      ],
    ),
  ],
);
