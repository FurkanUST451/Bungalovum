import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity.g.dart';

/// Ağ bağlantısı (79 · Bağlantı Yok). Testte sahtesiyle değiştirilir.
abstract interface class ConnectivityService {
  Future<bool> isOnline();

  Stream<bool> changes();
}

class SystemConnectivityService implements ConnectivityService {
  SystemConnectivityService([Connectivity? c]) : _c = c ?? Connectivity();

  final Connectivity _c;

  static bool _online(List<ConnectivityResult> r) =>
      r.any((x) => x != ConnectivityResult.none);

  @override
  Future<bool> isOnline() async => _online(await _c.checkConnectivity());

  @override
  Stream<bool> changes() => _c.onConnectivityChanged.map(_online).distinct();
}

@Riverpod(keepAlive: true)
ConnectivityService connectivityService(Ref ref) => SystemConnectivityService();

/// Bağlantı durumu; ilk değer anlık kontrolden gelir.
@Riverpod(keepAlive: true)
Stream<bool> isOnline(Ref ref) async* {
  final service = ref.watch(connectivityServiceProvider);
  yield await service.isOnline();
  yield* service.changes();
}
