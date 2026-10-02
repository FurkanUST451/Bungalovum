import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/clock.dart';
import '../../../booking/data/booking_repository.dart';
import '../../domain/trip_models.dart';
import '../../domain/trips_overview.dart';

part 'trips_controller.g.dart';

/// Seyahatler sekmesinin verisi.
@riverpod
Future<TripsOverview> tripsOverview(Ref ref) async {
  final all = await ref.watch(myBookingsProvider.future);
  return TripsOverview.from(all, ref.watch(clockProvider)());
}

/// Seçili sekme (geri dönünce korunur).
@Riverpod(keepAlive: true)
class SelectedTripsTab extends _$SelectedTripsTab {
  @override
  TripsTab build() => TripsTab.upcoming;

  void select(TripsTab tab) => state = tab;
}

/// Seyahat aksiyonları.
@riverpod
class TripActions extends _$TripActions {
  @override
  void build() {}

  Future<void> withdrawRequest(String bookingId) async {
    await ref.read(bookingRepositoryProvider).withdrawRequest(bookingId);
    _refresh(bookingId);
  }

  Future<void> cancelBooking(String bookingId, CancelReason reason) async {
    await ref.read(bookingRepositoryProvider).cancelBooking(bookingId, reason);
    _refresh(bookingId);
  }

  Future<void> submitReview(String bookingId, ReviewInput review) async {
    await ref.read(bookingRepositoryProvider).submitReview(bookingId, review);
    _refresh(bookingId);
  }

  void _refresh(String bookingId) => ref
    ..invalidate(myBookingsProvider)
    ..invalidate(bookingProvider(bookingId))
    ..invalidate(tripAccessProvider(bookingId));
}

/// 50 · Çıkış kontrol listesinde işaretlenenler (oturum boyunca).
@Riverpod(keepAlive: true)
class CheckoutChecklist extends _$CheckoutChecklist {
  @override
  Set<int> build(String bookingId) => const {};

  void toggle(int index) => state = state.contains(index)
      ? ({...state}..remove(index))
      : {...state, index};
}
