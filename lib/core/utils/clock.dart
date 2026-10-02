import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock.g.dart';

/// Şu anki zaman. Geri sayım ve "girişe kaç gün" hesapları buradan okur;
/// testlerde sabit saate çevrilir.
@Riverpod(keepAlive: true)
DateTime Function() clock(Ref ref) => DateTime.now;
