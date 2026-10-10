/// Backend bağlantı ayarları. Buradaki değerlerin hepsi herkese açıktır
/// (publishable key istemci tarafında yer almak üzere tasarlanmıştır).
///
/// Gizli anahtarlar (`service_role`, R2, ödeme sağlayıcısı) uygulamada
/// bulunmaz; yalnızca Supabase secrets'ta durur (CLAUDE.md §14).
///
/// Farklı ortama (staging/prod) geçmek için kodu değiştirmeden:
/// `flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_KEY=...`
abstract final class BackendConfig {
  static const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://opsgxubtmxxowygmtyzn.supabase.co',
  );

  static const supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_KEY',
    defaultValue: 'sb_publishable_rz56Eb4F7gfk9jrQdbGt9g_iwTw_Q6D',
  );

  /// Google Cloud Console › Web uygulaması OAuth istemci kimliği. Supabase'te
  /// Google sağlayıcısına girilen kimlikle aynıdır.
  static const googleWebClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
    defaultValue:
        '149686384993-39h1b2n2ektkmtdvjsjunqmuuitga333.apps.googleusercontent.com',
  );

  /// Google Cloud Console › iOS OAuth istemci kimliği (yalnızca iOS).
  static const googleIosClientId = String.fromEnvironment('GOOGLE_IOS_CLIENT_ID');
}
