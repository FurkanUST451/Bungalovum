import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase oturumunu cihazda saklar; "Beni hatırla" kapalıyken oturum yalnızca
/// bellekte kalır ve uygulama kapanınca biter.
///
/// Supabase'in varsayılan anahtarını kullanır; önceden saklanmış oturumlar
/// geçerliliğini korur.
class RememberingSessionStorage extends LocalStorage {
  RememberingSessionStorage({required String supabaseUrl})
    : _inner = SharedPreferencesLocalStorage(
        persistSessionKey:
            'sb-${Uri.parse(supabaseUrl).host.split('.').first}-auth-token',
      );

  final SharedPreferencesLocalStorage _inner;

  /// Girişten önce ayarlanır; jeton yenilemeleri de bu tercihe uyar.
  bool remember = true;

  @override
  Future<void> initialize() => _inner.initialize();

  @override
  Future<bool> hasAccessToken() => _inner.hasAccessToken();

  @override
  Future<String?> accessToken() => _inner.accessToken();

  @override
  Future<void> removePersistedSession() => _inner.removePersistedSession();

  @override
  Future<void> persistSession(String persistSessionString) => remember
      ? _inner.persistSession(persistSessionString)
      : _inner.removePersistedSession();
}
