import 'dart:async';

import 'package:bungalovum/core/services/connectivity.dart';
import 'package:bungalovum/core/services/permissions.dart';

/// Varsayılan: tüm izinler verilmiş (testlerde 80/81 kendiliğinden açılmaz).
class FakePermissionService implements PermissionService {
  FakePermissionService({Map<AppPermission, AppPermissionStatus>? statuses})
    : statuses = {...?statuses};

  final Map<AppPermission, AppPermissionStatus> statuses;

  /// İstek gelince dönecek sonuç.
  AppPermissionStatus onRequest = AppPermissionStatus.granted;
  int requests = 0;
  int settingsOpened = 0;

  @override
  Future<AppPermissionStatus> status(AppPermission p) async =>
      statuses[p] ?? AppPermissionStatus.granted;

  @override
  Future<AppPermissionStatus> request(AppPermission p) async {
    requests++;
    return statuses[p] = onRequest;
  }

  @override
  Future<bool> openSettings() async {
    settingsOpened++;
    return true;
  }
}

class FakeConnectivityService implements ConnectivityService {
  FakeConnectivityService({this.online = true});

  bool online;
  final _changes = StreamController<bool>.broadcast();

  void set(bool value) {
    online = value;
    _changes.add(value);
  }

  @override
  Future<bool> isOnline() async => online;

  @override
  Stream<bool> changes() => _changes.stream;
}
