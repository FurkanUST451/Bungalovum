import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/account/domain/account_models.dart';
import '../features/account/presentation/screens/account_screen.dart';
import '../features/account/presentation/screens/help_legal_screens.dart';
import '../features/account/presentation/screens/personal_info_screen.dart';
import '../features/account/presentation/screens/security_screens.dart';
import '../features/account/presentation/screens/settings_screens.dart';
import '../features/auth/presentation/screens/code_verification_screens.dart';
import '../features/auth/presentation/screens/password_reset_screens.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/welcome_screen.dart';
import '../features/booking/presentation/screens/booking_confirm_screen.dart';
import '../features/booking/presentation/screens/booking_done_screen.dart';
import '../features/booking/presentation/screens/date_picker_screen.dart';
import '../features/booking/presentation/screens/guest_details_screen.dart';
import '../features/booking/presentation/screens/payment_failed_screen.dart';
import '../features/booking/presentation/screens/payment_screen.dart';
import '../features/booking/presentation/screens/request_status_screens.dart';
import '../features/booking/presentation/screens/three_ds_screen.dart';
import '../features/booking/presentation/screens/guest_picker_screen.dart';
import '../features/explore/presentation/screens/explore_screen.dart';
import '../features/host/domain/listing_draft.dart';
import '../features/host/presentation/screens/host_screens.dart';
import '../features/host/presentation/screens/wizard_step_screen.dart';
import '../features/listing/domain/listing_detail.dart';
import '../features/listing/presentation/screens/listing_detail_screen.dart';
import '../features/listing/presentation/screens/listing_extra_screens.dart';
import '../features/listing/presentation/screens/listing_info_screens.dart';
import '../features/listing/presentation/screens/photo_screens.dart';
import '../features/search/presentation/screens/filters_screen.dart';
import '../features/search/presentation/screens/map_screen.dart';
import '../features/search/presentation/screens/results_screen.dart';
import '../features/search/presentation/screens/search_screen.dart';
import '../features/chat/presentation/screens/chat_screen.dart';
import '../features/chat/presentation/screens/chats_screen.dart';
import '../features/chat/presentation/screens/notifications_screen.dart';
import '../features/saved/presentation/screens/recently_viewed_screen.dart';
import '../features/saved/presentation/screens/saved_screen.dart';
import '../features/saved/presentation/screens/wishlist_detail_screen.dart';
import '../features/status/presentation/screens/status_screens.dart';
import '../features/trips/presentation/screens/cancel_booking_screen.dart';
import '../features/trips/presentation/screens/house_guide_screen.dart';
import '../features/trips/presentation/screens/receipt_screens.dart';
import '../features/trips/presentation/screens/report_issue_screen.dart';
import '../features/trips/presentation/screens/trip_detail_screen.dart';
import '../features/trips/presentation/screens/trips_screen.dart';
import '../features/trips/presentation/screens/write_review_screen.dart';
import '../features/wallet/presentation/screens/payment_history_coupons_screens.dart';
import '../features/wallet/presentation/screens/wallet_screens.dart';
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
        // 33 ve 40 aynı ekran; mod ilanın anında onay ayarından gelir.
        for (final path in const ['rezervasyon', 'talep'])
          GoRoute(
            path: path,
            builder: (_, s) =>
                BookingConfirmScreen(listingId: s.pathParameters['id']!),
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

    // 34–39 · Ödeme ve rezervasyon sonucu
    GoRoute(path: AppRoutes.payment, builder: (_, _) => const PaymentScreen()),
    GoRoute(
      path: AppRoutes.paymentNewCard,
      builder: (_, _) => const PaymentScreen(newCard: true),
    ),
    GoRoute(
      path: AppRoutes.payment3ds,
      pageBuilder: (_, s) => MaterialPage(
        key: s.pageKey,
        fullscreenDialog: true,
        child: const ThreeDsScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.paymentFailed,
      builder: (_, _) => const PaymentFailedScreen(),
    ),
    GoRoute(
      path: '/rezervasyon/:bookingId/tamam',
      builder: (_, s) =>
          BookingDoneScreen(bookingId: s.pathParameters['bookingId']!),
    ),
    GoRoute(
      path: '/rezervasyon/:bookingId/talep-gonderildi',
      builder: (_, s) =>
          RequestSentScreen(bookingId: s.pathParameters['bookingId']!),
    ),
    GoRoute(
      path: '/rezervasyon/:bookingId/onaylandi',
      builder: (_, s) =>
          RequestApprovedScreen(bookingId: s.pathParameters['bookingId']!),
    ),
    GoRoute(
      path: '/rezervasyon/:bookingId/reddedildi',
      builder: (_, s) =>
          RequestDeclinedScreen(bookingId: s.pathParameters['bookingId']!),
    ),
    GoRoute(
      path: '/rezervasyon/:bookingId/misafir-bilgileri',
      builder: (_, s) =>
          GuestDetailsScreen(bookingId: s.pathParameters['bookingId']!),
    ),

    // 63–64 · Sohbet ve bildirimler
    GoRoute(
      path: '/sohbet/:id',
      builder: (_, s) => ChatScreen(conversationId: s.pathParameters['id']!),
    ),
    GoRoute(
      path: AppRoutes.notifications,
      builder: (_, _) => const NotificationsScreen(),
    ),

    // 58–60 · Kaydedilenler
    GoRoute(
      path: '/liste/:id',
      builder: (_, s) => WishlistDetailScreen(listId: s.pathParameters['id']!),
    ),
    GoRoute(
      path: AppRoutes.recentlyViewed,
      builder: (_, _) => const RecentlyViewedScreen(),
    ),

    // 49–55 · Seyahat
    GoRoute(
      path: '/seyahat/:id',
      builder: (_, s) => TripDetailScreen(bookingId: s.pathParameters['id']!),
      routes: [
        GoRoute(
          path: 'ev-kilavuzu',
          builder: (_, s) =>
              HouseGuideScreen(bookingId: s.pathParameters['id']!),
        ),
        GoRoute(
          path: 'sorun',
          pageBuilder: (_, s) => MaterialPage(
            key: s.pageKey,
            fullscreenDialog: true,
            child: ReportIssueScreen(bookingId: s.pathParameters['id']!),
          ),
        ),
        GoRoute(
          path: 'makbuz',
          builder: (_, s) => ReceiptScreen(bookingId: s.pathParameters['id']!),
        ),
        GoRoute(path: 'fatura', builder: (_, _) => const BillingScreen()),
        GoRoute(
          path: 'iptal',
          builder: (_, s) =>
              CancelBookingScreen(bookingId: s.pathParameters['id']!),
        ),
        GoRoute(
          path: 'degerlendir',
          pageBuilder: (_, s) => MaterialPage(
            key: s.pageKey,
            fullscreenDialog: true,
            child: WriteReviewScreen(bookingId: s.pathParameters['id']!),
          ),
        ),
      ],
    ),

    // Hesap
    GoRoute(
      path: AppRoutes.personalInfo,
      builder: (_, _) => const PersonalInfoScreen(),
    ),
    GoRoute(
      path: AppRoutes.security,
      builder: (_, _) => const SecurityScreen(),
    ),
    GoRoute(
      path: AppRoutes.closeAccount,
      builder: (_, _) => const CloseAccountScreen(),
    ),
    GoRoute(
      path: AppRoutes.notificationPrefs,
      builder: (_, _) => const NotificationPrefsScreen(),
    ),
    GoRoute(path: AppRoutes.privacy, builder: (_, _) => const PrivacyScreen()),
    GoRoute(path: AppRoutes.help, builder: (_, _) => const HelpScreen()),
    GoRoute(
      path: AppRoutes.legal,
      builder: (_, _) => const LegalScreen(),
      routes: [
        GoRoute(
          path: ':doc',
          redirect: (_, s) =>
              LegalDoc.values.asNameMap().containsKey(s.pathParameters['doc'])
              ? null
              : AppRoutes.legal,
          builder: (_, s) => LegalDocScreen(
            doc: LegalDoc.values.byName(s.pathParameters['doc']!),
          ),
        ),
      ],
    ),

    // Cüzdan
    GoRoute(path: AppRoutes.wallet, builder: (_, _) => const WalletScreen()),
    GoRoute(
      path: AppRoutes.paymentMethods,
      builder: (_, _) => const PaymentMethodsScreen(),
    ),
    GoRoute(path: AppRoutes.addCard, builder: (_, _) => const AddCardScreen()),
    GoRoute(
      path: AppRoutes.paymentHistory,
      builder: (_, _) => const PaymentHistoryScreen(),
    ),
    GoRoute(path: AppRoutes.coupons, builder: (_, _) => const CouponsScreen()),

    // Ev sahibi (82–95)
    GoRoute(
      path: AppRoutes.becomeHost,
      pageBuilder: (_, s) => MaterialPage(
        key: s.pageKey,
        fullscreenDialog: true,
        child: const BecomeHostScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.hostPreview,
      builder: (_, _) => const HostPreviewScreen(),
    ),
    GoRoute(
      path: AppRoutes.hostInReview,
      builder: (_, _) => const HostInReviewScreen(),
    ),
    GoRoute(
      path: '/ilan-olustur/:step',
      redirect: (_, s) =>
          WizardStep.fromNumber(int.tryParse(s.pathParameters['step']!) ?? 0) ==
              null
          ? AppRoutes.becomeHost
          : null,
      builder: (_, s) => wizardStepScreen(
        WizardStep.fromNumber(int.parse(s.pathParameters['step']!))!,
        editing: s.uri.query == editQuery,
      ),
    ),
    GoRoute(
      path: AppRoutes.hostListings,
      builder: (_, _) => const HostListingsScreen(),
    ),

    // Durum ekranları
    GoRoute(
      path: AppRoutes.offline,
      pageBuilder: (_, s) => MaterialPage(
        key: s.pageKey,
        fullscreenDialog: true,
        child: const OfflineScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.locationPermission,
      pageBuilder: (_, s) => MaterialPage(
        key: s.pageKey,
        fullscreenDialog: true,
        child: const LocationPermissionScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.notificationPermission,
      pageBuilder: (_, s) => MaterialPage(
        key: s.pageKey,
        fullscreenDialog: true,
        child: const NotificationPermissionScreen(),
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
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.saved,
              builder: (_, _) => const SavedScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.trips,
              builder: (_, _) => const TripsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.chats,
              builder: (_, _) => const ChatsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.account,
              builder: (_, _) => const AccountScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
