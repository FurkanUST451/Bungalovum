import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../listing/data/listing_repository.dart';
import '../../../search/domain/search_query.dart';
import '../../../search/presentation/controllers/search_controller.dart';
import '../../domain/price_calculator.dart';

part 'booking_draft.freezed.dart';
part 'booking_draft.g.dart';

/// İlan Detayı → Rezervasyon akışında seçilen tarih ve misafirler.
@freezed
abstract class BookingDraft with _$BookingDraft {
  const BookingDraft._();

  const factory BookingDraft({
    required String listingId,
    StayDates? dates,
    @Default(GuestCount()) GuestCount guests,
  }) = _BookingDraft;

  int get nights => dates?.nights ?? SearchQuery.defaultNights;
}

/// İlan başına taslak; ilk açılışta aktif aramanın tarih ve misafirleriyle
/// başlar.
@Riverpod(keepAlive: true)
class BookingDraftController extends _$BookingDraftController {
  @override
  BookingDraft build(String listingId) {
    final q = ref.read(searchQueryControllerProvider);
    return BookingDraft(listingId: listingId, dates: q.dates, guests: q.guests);
  }

  void setDates(StayDates? d) => state = state.copyWith(dates: d);

  void setGuests(GuestCount g) => state = state.copyWith(guests: g);
}

/// Taslak gece sayısı için fiyat kalemleri.
@riverpod
Future<PriceBreakdown> bookingQuote(Ref ref, String listingId) {
  final nights = ref.watch(bookingDraftControllerProvider(listingId)).nights;
  return ref.watch(listingRepositoryProvider).quote(listingId, nights);
}
