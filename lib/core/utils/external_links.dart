import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Uygulama dışı bağlantılar: harita yol tarifi ve telefon araması.
/// Açılamazsa false döner; çağıran kullanıcıya bilgi verir.
abstract final class ExternalLinks {
  /// iOS'ta Apple Haritalar, diğerlerinde Google Haritalar yol tarifi.
  static Future<bool> directions(double lat, double lng) {
    final uri = defaultTargetPlatform == TargetPlatform.iOS
        ? Uri.https('maps.apple.com', '/', {'daddr': '$lat,$lng'})
        : Uri.https('www.google.com', '/maps/dir/', {
            'api': '1',
            'destination': '$lat,$lng',
          });
    return _open(uri);
  }

  static Future<bool> call(String phone) =>
      _open(Uri(scheme: 'tel', path: phone));

  /// Web bağlantısı / dosya (ör. makbuz PDF'i) dış uygulamada açılır.
  static Future<bool> open(Uri uri) => _open(uri);

  static Future<bool> _open(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on Object {
      return false;
    }
  }
}
