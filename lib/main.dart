import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'core/config/backend_config.dart';
import 'core/utils/formatters.dart';
import 'features/account/data/account_repository.dart';
import 'features/account/data/mock_account_repository.dart';
import 'features/account/data/supabase_account_repository.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/data/supabase_auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(kzLocale);
  await Supabase.initialize(
    url: BackendConfig.supabaseUrl,
    publishableKey: BackendConfig.supabasePublishableKey,
  );
  runApp(
    ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(
          SupabaseAuthRepository(Supabase.instance.client),
        ),
        accountRepositoryProvider.overrideWithValue(
          SupabaseAccountRepository(
            Supabase.instance.client,
            MockAccountRepository(),
          ),
        ),
      ],
      child: const BungalovumApp(),
    ),
  );
}
