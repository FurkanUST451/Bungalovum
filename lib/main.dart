import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'app/routes.dart';
import 'core/config/backend_config.dart';
import 'core/utils/formatters.dart';
import 'features/account/data/account_repository.dart';
import 'features/account/data/mock_account_repository.dart';
import 'features/account/data/supabase_account_repository.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/data/remembering_session_storage.dart';
import 'features/auth/data/supabase_auth_repository.dart';
import 'features/host/data/host_repository.dart';
import 'features/host/data/supabase_host_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(kzLocale);
  final sessionStorage = RememberingSessionStorage(
    supabaseUrl: BackendConfig.supabaseUrl,
  );
  await Supabase.initialize(
    url: BackendConfig.supabaseUrl,
    publishableKey: BackendConfig.supabasePublishableKey,
    authOptions: FlutterAuthClientOptions(localStorage: sessionStorage),
  );
  // Saklı oturum varsa giriş ekranları atlanır.
  final signedIn = Supabase.instance.client.auth.currentSession != null;
  runApp(
    ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(
          SupabaseAuthRepository(Supabase.instance.client, sessionStorage),
        ),
        accountRepositoryProvider.overrideWithValue(
          SupabaseAccountRepository(
            Supabase.instance.client,
            MockAccountRepository(),
          ),
        ),
        hostRepositoryProvider.overrideWithValue(
          SupabaseHostRepository(Supabase.instance.client),
        ),
      ],
      child: BungalovumApp(
        initialLocation: signedIn ? AppRoutes.explore : AppRoutes.welcome,
      ),
    ),
  );
}
