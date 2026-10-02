import 'package:bungapp/features/account/domain/account_models.dart';
import 'package:bungapp/features/account/presentation/screens/account_screen.dart';
import 'package:bungapp/features/account/presentation/screens/help_legal_screens.dart';
import 'package:bungapp/features/account/presentation/screens/personal_info_screen.dart';
import 'package:bungapp/features/account/presentation/screens/security_screens.dart';
import 'package:bungapp/features/account/presentation/screens/settings_screens.dart';
import 'package:bungapp/features/auth/domain/auth_models.dart';
import 'package:bungapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:bungapp/features/auth/presentation/screens/code_verification_screens.dart';
import 'package:bungapp/features/auth/presentation/screens/login_required_sheet.dart';
import 'package:bungapp/features/auth/presentation/screens/password_reset_screens.dart';
import 'package:bungapp/features/auth/presentation/screens/register_screen.dart';
import 'package:bungapp/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:bungapp/features/auth/presentation/screens/welcome_screen.dart';
import 'package:bungapp/features/booking/data/mock_booking_repository.dart';
import 'package:bungapp/features/booking/domain/payment.dart';
import 'package:bungapp/features/booking/presentation/controllers/checkout_controller.dart';
import 'package:bungapp/features/booking/presentation/screens/booking_confirm_screen.dart';
import 'package:bungapp/features/booking/presentation/screens/booking_done_screen.dart';
import 'package:bungapp/features/booking/presentation/screens/guest_details_screen.dart';
import 'package:bungapp/features/booking/presentation/screens/payment_failed_screen.dart';
import 'package:bungapp/features/booking/presentation/screens/payment_screen.dart';
import 'package:bungapp/features/booking/presentation/screens/request_status_screens.dart';
import 'package:bungapp/features/booking/presentation/screens/three_ds_screen.dart';
import 'package:bungapp/features/trips/domain/trips_overview.dart';
import 'package:bungapp/features/trips/presentation/controllers/trips_controller.dart';
import 'package:bungapp/features/chat/presentation/screens/chat_screen.dart';
import 'package:bungapp/features/chat/presentation/screens/chats_screen.dart';
import 'package:bungapp/features/chat/presentation/screens/notifications_screen.dart';
import 'package:bungapp/features/saved/domain/wishlist.dart';
import 'package:bungapp/features/saved/presentation/screens/recently_viewed_screen.dart';
import 'package:bungapp/features/saved/presentation/screens/saved_screen.dart';
import 'package:bungapp/features/saved/presentation/screens/wishlist_detail_screen.dart';
import 'package:bungapp/features/trips/presentation/screens/cancel_booking_screen.dart';
import 'package:bungapp/features/trips/presentation/screens/house_guide_screen.dart';
import 'package:bungapp/features/trips/presentation/screens/receipt_screens.dart';
import 'package:bungapp/features/trips/presentation/screens/report_issue_screen.dart';
import 'package:bungapp/features/trips/presentation/screens/trip_detail_screen.dart';
import 'package:bungapp/features/trips/presentation/screens/trips_screen.dart';
import 'package:bungapp/features/trips/presentation/screens/write_review_screen.dart';
import 'package:bungapp/features/booking/presentation/screens/date_picker_screen.dart';
import 'package:bungapp/features/booking/presentation/screens/guest_picker_screen.dart';
import 'package:bungapp/features/listing/data/listing_catalog.dart';
import 'package:bungapp/features/listing/data/listing_repository.dart';
import 'package:bungapp/features/listing/presentation/screens/listing_detail_screen.dart';
import 'package:bungapp/features/listing/presentation/screens/listing_extra_screens.dart';
import 'package:bungapp/features/listing/presentation/screens/listing_info_screens.dart';
import 'package:bungapp/features/listing/presentation/screens/photo_screens.dart';
import 'package:bungapp/features/listing/presentation/widgets/listing_sheets.dart';
import 'package:bungapp/features/saved/presentation/widgets/add_to_list_sheet.dart';
import 'package:bungapp/features/search/domain/search_query.dart';
import 'package:bungapp/features/search/presentation/controllers/search_controller.dart';
import 'package:bungapp/features/search/presentation/screens/filters_screen.dart';
import 'package:bungapp/features/search/presentation/screens/map_screen.dart';
import 'package:bungapp/features/search/presentation/screens/results_screen.dart';
import 'package:bungapp/features/search/presentation/screens/search_screen.dart';
import 'package:bungapp/features/wallet/data/wallet_repository.dart';
import 'package:bungapp/features/wallet/presentation/screens/payment_history_coupons_screens.dart';
import 'package:bungapp/features/wallet/presentation/screens/wallet_screens.dart';
import 'package:bungapp/features/status/presentation/screens/status_screens.dart';
import 'package:bungapp/features/host/data/host_repository.dart';
import 'package:bungapp/features/host/data/mock_host_repository.dart';
import 'package:bungapp/features/host/domain/listing_draft.dart';
import 'package:bungapp/features/host/presentation/controllers/host_controllers.dart';
import 'package:bungapp/features/host/presentation/screens/host_screens.dart';
import 'package:bungapp/features/host/presentation/screens/wizard_step_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'test_app.dart';

/// Testte ekran açılmadan önce aktif aramayı kurar.
class SeedQuery extends ConsumerStatefulWidget {
  const SeedQuery({super.key, required this.query, required this.child});

  final SearchQuery query;
  final Widget child;

  @override
  ConsumerState<SeedQuery> createState() => _SeedQueryState();
}

class _SeedQueryState extends ConsumerState<SeedQuery> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          ref.read(searchQueryControllerProvider.notifier).apply(widget.query),
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Açılışta bir alt sayfayı (sheet) gösteren test sarmalayıcısı.
class OpenSheet extends StatefulWidget {
  const OpenSheet({super.key, required this.open});

  final Future<void> Function(BuildContext context) open;

  @override
  State<OpenSheet> createState() => _OpenSheetState();
}

class _OpenSheetState extends State<OpenSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.open(context));
  }

  @override
  Widget build(BuildContext context) => const Scaffold();
}

/// İlan detayı gerektiren alt sayfalar için veriyi yükleyip açar.
class OpenDetailSheet extends ConsumerWidget {
  const OpenDetailSheet({super.key, required this.id, required this.open});

  final String id;
  final Future<void> Function(BuildContext context, dynamic detail) open;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(listingDetailProvider(id)).value;
    if (d == null) return const Scaffold();
    return OpenSheet(open: (c) => open(c, d));
  }
}

/// Ödeme akışını mock depo üzerinden istenen adıma kadar ilerletir.
enum CheckoutStage { started, challenged, declined }

class SeedCheckout extends ConsumerStatefulWidget {
  const SeedCheckout({
    super.key,
    required this.stage,
    required this.query,
    required this.child,
  });

  final CheckoutStage stage;
  final SearchQuery query;
  final Widget child;

  @override
  ConsumerState<SeedCheckout> createState() => _SeedCheckoutState();
}

class _SeedCheckoutState extends ConsumerState<SeedCheckout> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(_seed);
  }

  Future<void> _seed() async {
    ref.read(searchQueryControllerProvider.notifier).apply(widget.query);
    final checkout = ref.read(checkoutControllerProvider.notifier)..begin(_gol);
    if (widget.stage != CheckoutStage.started) {
      await checkout.pay(
        const SavedCardMethod(
          PaymentCard(
            id: 'card-visa',
            brand: CardBrand.visa,
            last4: '4242',
            expMonth: 12,
            expYear: 28,
            isDefault: true,
          ),
        ),
      );
    }
    if (widget.stage == CheckoutStage.declined) {
      try {
        await checkout.confirm(MockBookingRepository.declineCode);
      } on PaymentDeclined {
        // Beklenen.
      }
    }
    if (mounted) setState(() => _ready = true);
  }

  @override
  Widget build(BuildContext context) =>
      _ready ? widget.child : const SizedBox.shrink();
}

/// Seyahatler'de açılışta istenen sekmeyi seçer.
class SeedTripsTab extends ConsumerStatefulWidget {
  const SeedTripsTab({super.key, required this.tab});

  final TripsTab tab;

  @override
  ConsumerState<SeedTripsTab> createState() => _SeedTripsTabState();
}

class _SeedTripsTabState extends ConsumerState<SeedTripsTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(selectedTripsTabProvider.notifier).select(widget.tab),
    );
  }

  @override
  Widget build(BuildContext context) => const TripsScreen();
}

/// Hesap ekranları için oturumu açık başlatır.
class SignedIn extends ConsumerStatefulWidget {
  const SignedIn({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<SignedIn> createState() => _SignedInState();
}

class _SignedInState extends ConsumerState<SignedIn> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(authSessionProvider.notifier)
          .signedIn(const AuthUser(id: 'u1', firstName: 'Deniz')),
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Kayıtlı kartları silip boş durumu (74) gösterir.
class SeedNoCards extends ConsumerStatefulWidget {
  const SeedNoCards({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<SeedNoCards> createState() => _SeedNoCardsState();
}

class _SeedNoCardsState extends ConsumerState<SeedNoCards> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final repo = ref.read(walletRepositoryProvider);
      for (final c in await repo.cards()) {
        await repo.removeCard(c.id);
      }
      if (mounted) setState(() => _ready = true);
    });
  }

  @override
  Widget build(BuildContext context) =>
      _ready ? widget.child : const SizedBox.shrink();
}

/// Ev sahibi ekranları için Figma'daki dolu taslağı yükler.
class SeedHostDraft extends ConsumerStatefulWidget {
  const SeedHostDraft({super.key, required this.child, this.change});

  final Widget child;
  final ListingDraft Function(ListingDraft d)? change;

  @override
  ConsumerState<SeedHostDraft> createState() => _SeedHostDraftState();
}

class _SeedHostDraftState extends ConsumerState<SeedHostDraft> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final sample = MockHostRepository.sample();
      await ref
          .read(hostRepositoryProvider)
          .save(widget.change?.call(sample) ?? sample);
      ref.invalidate(hostDraftProvider);
      await ref.read(hostDraftProvider.future);
      if (mounted) setState(() => _ready = true);
    });
  }

  @override
  Widget build(BuildContext context) =>
      _ready ? widget.child : const SizedBox.shrink();
}

const _gol = 'gol-esintisi';

final _requestStay = StayDates(
  checkIn: DateTime(2026, 11, 20),
  checkOut: DateTime(2026, 11, 22),
);

final _stay = StayDates(
  checkIn: DateTime(2026, 11, 6),
  checkOut: DateTime(2026, 11, 8),
);

/// Figma ekran numarasıyla tüm ekranlar (durum ekranları ayrı anahtarla).
final allScreens = <String, Widget Function()>{
  '01_hos_geldin': () => const WelcomeScreen(),
  '02_giris_eposta': () => const SignInScreen(),
  '03_giris_telefon': () =>
      const SignInScreen(initialMethod: SignInMethod.phone),
  '04_sms_dogrulama': () => const SmsVerifyScreen(phone: '5324184218'),
  '06_kayit_ol': () => RegisterScreen(today: fixedClock()),
  '07_hesabi_dogrula': () => const VerifyEmailScreen(email: 'deniz@ornek.com'),
  '08_sifremi_unuttum': () => const ForgotPasswordScreen(),
  '09_sifirlama_kodu': () => const ResetCodeScreen(email: 'deniz@ornek.com'),
  '10_yeni_sifre': () => const NewPasswordScreen(token: 'test'),
  '11_sifre_guncellendi': () => const PasswordUpdatedScreen(),
  '12_giris_gerekli': () => const Scaffold(
    body: Align(alignment: Alignment.bottomCenter, child: LoginRequiredSheet()),
  ),
  '14_arama': () => const SearchScreen(),
  '15_filtreler': () => const FiltersScreen(),
  '16_arama_sonuclari': () => SeedQuery(
    query: SearchQuery(location: 'Sapanca', dates: _stay),
    child: const ResultsScreen(),
  ),
  '17_harita': () => SeedQuery(
    query: SearchQuery(location: 'Sapanca', dates: _stay),
    child: const MapScreen(),
  ),
  '18_sonuc_yok': () => SeedQuery(
    query: SearchQuery(
      location: 'Sapanca',
      dates: _stay,
      filters: const SearchFilters(
        features: {SearchFeature.heatedPool, SearchFeature.fireplace},
        priceMax: 3000,
      ),
    ),
    child: const ResultsScreen(),
  ),
  '31_tarih_sec': () => DatePickerScreen(
    args: DatePickerArgs(initial: _stay),
    today: fixedClock(),
  ),
  '32_misafirler': () => const GuestPickerScreen(
    args: GuestPickerArgs(maxGuests: 2, petsAllowed: false),
  ),
  '19_ilan_detayi': () => const ListingDetailScreen(id: _gol),
  '20_ilan_aciklamasi': () =>
      OpenDetailSheet(id: _gol, open: (c, d) => showDescriptionSheet(c, d)),
  '21_fotograf_turu': () => const PhotoTourScreen(id: _gol),
  '22_fotograf_goruntuleyici': () =>
      const PhotoViewerScreen(id: _gol, index: 3),
  '23_degerlendirmeler': () => const ReviewsScreen(id: _gol),
  '24_olanaklar': () => const AmenitiesScreen(id: _gol),
  '25_kurallar_ve_iptal': () => const RulesScreen(id: _gol),
  '26_konum': () => const LocationScreen(id: _gol),
  '27_ev_sahibi_profili': () =>
      const HostProfileScreen(hostId: 'ayla', listingId: _gol),
  '28_paylas': () =>
      OpenSheet(open: (c) => showShareSheet(c, ListingCatalog.byId(_gol)!)),
  '29_ilani_bildir': () => const ReportListingScreen(id: _gol),
  '30_listeye_ekle': () => OpenSheet(open: (c) => showAddToListSheet(c, _gol)),
  '33_rezervasyonu_onayla': () => SeedQuery(
    query: SearchQuery(location: 'Sapanca', dates: _stay),
    child: const BookingConfirmScreen(listingId: _gol),
  ),
  '34_odeme_kayitli_kart': () => SeedCheckout(
    stage: CheckoutStage.started,
    query: SearchQuery(location: 'Sapanca', dates: _stay),
    child: const PaymentScreen(),
  ),
  '35_odeme_yeni_kart': () => SeedCheckout(
    stage: CheckoutStage.started,
    query: SearchQuery(location: 'Sapanca', dates: _stay),
    child: PaymentScreen(newCard: true, today: fixedClock()),
  ),
  '36_3d_secure': () => SeedCheckout(
    stage: CheckoutStage.challenged,
    query: SearchQuery(location: 'Sapanca', dates: _stay),
    child: const ThreeDsScreen(),
  ),
  '37_odeme_basarisiz': () => SeedCheckout(
    stage: CheckoutStage.declined,
    query: SearchQuery(location: 'Sapanca', dates: _stay),
    child: const PaymentFailedScreen(),
  ),
  '38_rezervasyon_tamam': () =>
      const BookingDoneScreen(bookingId: MockBookingRepository.sampleBookingId),
  '39_misafir_bilgileri': () => const GuestDetailsScreen(
    bookingId: MockBookingRepository.sampleBookingId,
  ),
  '40_rezervasyon_talebi': () => SeedQuery(
    query: SearchQuery(location: 'Sapanca', dates: _requestStay),
    child: const BookingConfirmScreen(listingId: 'cam-yamac'),
  ),
  '41_talep_gonderildi': () =>
      const RequestSentScreen(bookingId: MockBookingRepository.sampleRequestId),
  '42_talep_onaylandi': () => const RequestApprovedScreen(
    bookingId: MockBookingRepository.sampleApprovedId,
  ),
  '43_talep_reddedildi': () => const RequestDeclinedScreen(
    bookingId: MockBookingRepository.sampleDeclinedId,
  ),
  '45_seyahatler_yaklasan': () => const SeedTripsTab(tab: TripsTab.upcoming),
  '46_seyahatler_gecmis': () => const SeedTripsTab(tab: TripsTab.past),
  '47_seyahatler_iptal': () => const SeedTripsTab(tab: TripsTab.cancelled),
  '49_konaklama_detayi': () =>
      const TripDetailScreen(bookingId: MockBookingRepository.sampleBookingId),
  '49b_konaklama_detayi_acik': () =>
      const TripDetailScreen(bookingId: MockBookingRepository.sampleRevealedId),
  '50_ev_kilavuzu': () =>
      const HouseGuideScreen(bookingId: MockBookingRepository.sampleRevealedId),
  '50b_ev_kilavuzu_kilitli': () =>
      const HouseGuideScreen(bookingId: MockBookingRepository.sampleBookingId),
  '51_sorun_bildir': () => const ReportIssueScreen(
    bookingId: MockBookingRepository.sampleRevealedId,
  ),
  '52_makbuz': () =>
      const ReceiptScreen(bookingId: MockBookingRepository.sampleBookingId),
  '53_fatura_bilgileri': () => const BillingScreen(),
  '54_rezervasyonu_iptal_et': () => const CancelBookingScreen(
    bookingId: MockBookingRepository.sampleBookingId,
  ),
  '55_degerlendirme_yaz': () =>
      const WriteReviewScreen(bookingId: MockBookingRepository.samplePastId),
  '56_kaydettiklerim': () => const SavedScreen(),
  '58_liste_detayi': () => SeedQuery(
    query: SearchQuery(location: 'Sapanca', dates: _stay),
    child: const WishlistDetailScreen(listId: 'hafta-sonu'),
  ),
  '59_listeyi_duzenle': () => OpenSheet(
    open: (c) => showEditListSheet(
      c,
      Wishlist(
        id: 'hafta-sonu',
        name: 'Hafta sonu kaçamağı',
        updatedAt: DateTime(2026, 9, 30),
      ),
    ),
  ),
  '60_son_baktiklarin': () => const RecentlyViewedScreen(),
  '62_sohbetler': () => const ChatsScreen(),
  '63_sohbet': () => const ChatScreen(conversationId: 'c-ayla'),
  '64_bildirim_merkezi': () => const NotificationsScreen(),
  '65_hesabim': () => const SignedIn(child: AccountScreen()),
  '65b_hesabim_misafir': () => const AccountScreen(),
  '66_bilgilerim': () => const PersonalInfoScreen(),
  '67_giris_ve_guvenlik': () => const SecurityScreen(),
  '68_hesabi_kapat': () => const SignedIn(child: CloseAccountScreen()),
  '69_bildirim_tercihleri': () => const NotificationPrefsScreen(),
  '70_gizlilik': () => const PrivacyScreen(),
  '71_yardim': () => const HelpScreen(),
  '72_hukuki_bilgiler': () => const LegalScreen(),
  '72b_aydinlatma_metni': () => const LegalDocScreen(doc: LegalDoc.kvkk),
  '73_cuzdan': () => const WalletScreen(),
  '74_odeme_yontemleri_bos': () =>
      const SeedNoCards(child: PaymentMethodsScreen()),
  '74b_kart_ekle': () => AddCardScreen(today: fixedClock()),
  '75_odeme_yontemleri_kayitli': () => const PaymentMethodsScreen(),
  '76_odeme_gecmisi': () => const PaymentHistoryScreen(),
  '77_kuponlar': () => const CouponsScreen(),
  '79_baglanti_yok': () => const OfflineScreen(),
  '80_konum_izni': () => const LocationPermissionScreen(),
  '81_bildirim_izni': () => const NotificationPermissionScreen(),
  '82_ev_sahibi_ol': () => const BecomeHostScreen(),
  for (final step in WizardStep.values)
    '${82 + step.number}_ilan_${step.number}_${step.name}': () =>
        SeedHostDraft(child: wizardStepScreen(step)),
  '93_ilan_onizleme': () => SeedHostDraft(
    change: (d) => d.copyWith(
      identityDone: IdentityStep.values.toSet(),
      verifiedName: MockHostRepository.verifiedSampleName,
      accuracyConsent: true,
      agreementConsent: true,
      ministryConsent: true,
    ),
    child: const HostPreviewScreen(),
  ),
  '94_ilan_incelemede': () => SeedHostDraft(
    change: (d) =>
        d.copyWith(status: ListingStatus.inReview, submittedAt: fixedClock()),
    child: const HostInReviewScreen(),
  ),
  '95_ilan_yonetimi': () => SeedHostDraft(
    change: (d) => d.copyWith(
      status: ListingStatus.published,
      identityDone: IdentityStep.values.toSet(),
      verifiedName: MockHostRepository.verifiedSampleName,
    ),
    child: const HostListingsScreen(),
  ),
};
