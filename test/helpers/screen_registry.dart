import 'package:bungapp/features/auth/presentation/screens/code_verification_screens.dart';
import 'package:bungapp/features/auth/presentation/screens/login_required_sheet.dart';
import 'package:bungapp/features/auth/presentation/screens/password_reset_screens.dart';
import 'package:bungapp/features/auth/presentation/screens/register_screen.dart';
import 'package:bungapp/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:bungapp/features/auth/presentation/screens/welcome_screen.dart';
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
      () => ref.read(searchQueryControllerProvider.notifier).apply(widget.query),
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

const _gol = 'gol-esintisi';

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
    body: Align(
      alignment: Alignment.bottomCenter,
      child: LoginRequiredSheet(),
    ),
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
  '20_ilan_aciklamasi': () => OpenDetailSheet(
    id: _gol,
    open: (c, d) => showDescriptionSheet(c, d),
  ),
  '21_fotograf_turu': () => const PhotoTourScreen(id: _gol),
  '22_fotograf_goruntuleyici': () =>
      const PhotoViewerScreen(id: _gol, index: 3),
  '23_degerlendirmeler': () => const ReviewsScreen(id: _gol),
  '24_olanaklar': () => const AmenitiesScreen(id: _gol),
  '25_kurallar_ve_iptal': () => const RulesScreen(id: _gol),
  '26_konum': () => const LocationScreen(id: _gol),
  '27_ev_sahibi_profili': () =>
      const HostProfileScreen(hostId: 'ayla', listingId: _gol),
  '28_paylas': () => OpenSheet(
    open: (c) => showShareSheet(c, ListingCatalog.byId(_gol)!),
  ),
  '29_ilani_bildir': () => const ReportListingScreen(id: _gol),
  '30_listeye_ekle': () => OpenSheet(
    open: (c) => showAddToListSheet(c, _gol),
  ),
};
