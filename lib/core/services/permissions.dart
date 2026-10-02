import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permissions.g.dart';

enum AppPermission { location, notifications }

enum AppPermissionStatus {
  granted,

  /// Henüz sorulmadı ya da reddedildi; yeniden sorulabilir.
  askable,

  /// Kalıcı olarak reddedildi; yalnızca sistem ayarlarından açılır.
  blocked,
}

/// Sistem izinleri (80 · Konum, 81 · Bildirim). Testte sahtesiyle değiştirilir.
abstract interface class PermissionService {
  Future<AppPermissionStatus> status(AppPermission p);

  Future<AppPermissionStatus> request(AppPermission p);

  /// Uygulamanın sistem ayarları sayfasını açar.
  Future<bool> openSettings();
}

class SystemPermissionService implements PermissionService {
  const SystemPermissionService();

  ph.Permission _of(AppPermission p) => switch (p) {
    AppPermission.location => ph.Permission.locationWhenInUse,
    AppPermission.notifications => ph.Permission.notification,
  };

  AppPermissionStatus _map(ph.PermissionStatus s) => switch (s) {
    ph.PermissionStatus.granted ||
    ph.PermissionStatus.limited ||
    ph.PermissionStatus.provisional => AppPermissionStatus.granted,
    ph.PermissionStatus.permanentlyDenied ||
    ph.PermissionStatus.restricted => AppPermissionStatus.blocked,
    ph.PermissionStatus.denied => AppPermissionStatus.askable,
  };

  @override
  Future<AppPermissionStatus> status(AppPermission p) async =>
      _map(await _of(p).status);

  @override
  Future<AppPermissionStatus> request(AppPermission p) async =>
      _map(await _of(p).request());

  @override
  Future<bool> openSettings() => ph.openAppSettings();
}

@Riverpod(keepAlive: true)
PermissionService permissionService(Ref ref) => const SystemPermissionService();

@riverpod
Future<AppPermissionStatus> permissionStatus(Ref ref, AppPermission p) =>
    ref.watch(permissionServiceProvider).status(p);

/// Bildirim ön-izni (81) bu oturumda gösterildi mi; tekrar rahatsız etmeyiz.
@Riverpod(keepAlive: true)
class NotificationPromptShown extends _$NotificationPromptShown {
  @override
  bool build() => false;

  void markShown() => state = true;
}
