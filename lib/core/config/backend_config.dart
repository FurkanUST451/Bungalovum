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
    defaultValue: 'https://kuncwgfudkgmubdaawok.supabase.co',
  );

  static const supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_KEY',
    defaultValue: 'sb_publishable_YaBdr729iKgKhkVuvZe9-w_u8f3U0BI',
  );

  /// Google Cloud Console › Web uygulaması OAuth istemci kimliği. Supabase'te
  /// Google sağlayıcısına girilen kimlikle aynıdır.
  static const googleWebClientId = String.fromEnvironment('GOOGLE_WEB_CLIENT_ID');

  /// Google Cloud Console › iOS OAuth istemci kimliği (yalnızca iOS).
  static const googleIosClientId = String.fromEnvironment('GOOGLE_IOS_CLIENT_ID');
}
