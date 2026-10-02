import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/booking_repository.dart';
import '../../domain/booking.dart';

part 'stay_guests_controller.g.dart';

/// 39 · Misafir Bilgileri: kimlik bildirimi için kayıtlı misafirler.
@riverpod
class StayGuestsController extends _$StayGuestsController {
  @override
  Future<StayGuestList> build(String bookingId) =>
      ref.watch(bookingRepositoryProvider).stayGuests(bookingId);

  Future<void> add(StayGuestInput input) async {
    final list = await ref
        .read(bookingRepositoryProvider)
        .addStayGuest(bookingId, input);
    state = AsyncData(list);
  }
}
