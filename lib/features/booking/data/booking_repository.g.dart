// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookingRepository)
final bookingRepositoryProvider = BookingRepositoryProvider._();

final class BookingRepositoryProvider
    extends
        $FunctionalProvider<
          BookingRepository,
          BookingRepository,
          BookingRepository
        >
    with $Provider<BookingRepository> {
  BookingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingRepositoryHash();

  @$internal
  @override
  $ProviderElement<BookingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookingRepository create(Ref ref) {
    return bookingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookingRepository>(value),
    );
  }
}

String _$bookingRepositoryHash() => r'4a9ef1f1c39785900babbda4928dfb93973e86cf';

@ProviderFor(myBookings)
final myBookingsProvider = MyBookingsProvider._();

final class MyBookingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Booking>>,
          List<Booking>,
          FutureOr<List<Booking>>
        >
    with $FutureModifier<List<Booking>>, $FutureProvider<List<Booking>> {
  MyBookingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myBookingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myBookingsHash();

  @$internal
  @override
  $FutureProviderElement<List<Booking>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Booking>> create(Ref ref) {
    return myBookings(ref);
  }
}

String _$myBookingsHash() => r'9a9e18315efc8ae28e07e6ca103b6e72f5ad8a33';

@ProviderFor(tripAccess)
final tripAccessProvider = TripAccessFamily._();

final class TripAccessProvider
    extends
        $FunctionalProvider<
          AsyncValue<TripAccess>,
          TripAccess,
          FutureOr<TripAccess>
        >
    with $FutureModifier<TripAccess>, $FutureProvider<TripAccess> {
  TripAccessProvider._({
    required TripAccessFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tripAccessProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tripAccessHash();

  @override
  String toString() {
    return r'tripAccessProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TripAccess> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<TripAccess> create(Ref ref) {
    final argument = this.argument as String;
    return tripAccess(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TripAccessProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tripAccessHash() => r'b22652d414c945d4a518ef3dd87489fd2e644096';

final class TripAccessFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TripAccess>, String> {
  TripAccessFamily._()
    : super(
        retry: null,
        name: r'tripAccessProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TripAccessProvider call(String bookingId) =>
      TripAccessProvider._(argument: bookingId, from: this);

  @override
  String toString() => r'tripAccessProvider';
}

@ProviderFor(cancellationQuote)
final cancellationQuoteProvider = CancellationQuoteFamily._();

final class CancellationQuoteProvider
    extends
        $FunctionalProvider<
          AsyncValue<CancellationQuote>,
          CancellationQuote,
          FutureOr<CancellationQuote>
        >
    with
        $FutureModifier<CancellationQuote>,
        $FutureProvider<CancellationQuote> {
  CancellationQuoteProvider._({
    required CancellationQuoteFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'cancellationQuoteProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cancellationQuoteHash();

  @override
  String toString() {
    return r'cancellationQuoteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CancellationQuote> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CancellationQuote> create(Ref ref) {
    final argument = this.argument as String;
    return cancellationQuote(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CancellationQuoteProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cancellationQuoteHash() => r'2a69c943e1788549010bf615eca4c4b8541106b3';

final class CancellationQuoteFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CancellationQuote>, String> {
  CancellationQuoteFamily._()
    : super(
        retry: null,
        name: r'cancellationQuoteProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CancellationQuoteProvider call(String bookingId) =>
      CancellationQuoteProvider._(argument: bookingId, from: this);

  @override
  String toString() => r'cancellationQuoteProvider';
}

@ProviderFor(billingInfo)
final billingInfoProvider = BillingInfoProvider._();

final class BillingInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<BillingInfo>,
          BillingInfo,
          FutureOr<BillingInfo>
        >
    with $FutureModifier<BillingInfo>, $FutureProvider<BillingInfo> {
  BillingInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billingInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billingInfoHash();

  @$internal
  @override
  $FutureProviderElement<BillingInfo> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BillingInfo> create(Ref ref) {
    return billingInfo(ref);
  }
}

String _$billingInfoHash() => r'8bf464cca481f26861ddfe3bf7629cdfbe787f3d';

@ProviderFor(booking)
final bookingProvider = BookingFamily._();

final class BookingProvider
    extends $FunctionalProvider<AsyncValue<Booking>, Booking, FutureOr<Booking>>
    with $FutureModifier<Booking>, $FutureProvider<Booking> {
  BookingProvider._({
    required BookingFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bookingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookingHash();

  @override
  String toString() {
    return r'bookingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Booking> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Booking> create(Ref ref) {
    final argument = this.argument as String;
    return booking(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BookingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookingHash() => r'ecef3ac8f60c696bbe3674df4a23a3dadbf9c491';

final class BookingFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Booking>, String> {
  BookingFamily._()
    : super(
        retry: null,
        name: r'bookingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BookingProvider call(String id) =>
      BookingProvider._(argument: id, from: this);

  @override
  String toString() => r'bookingProvider';
}

@ProviderFor(installmentOptions)
final installmentOptionsProvider = InstallmentOptionsFamily._();

final class InstallmentOptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<int>>,
          List<int>,
          FutureOr<List<int>>
        >
    with $FutureModifier<List<int>>, $FutureProvider<List<int>> {
  InstallmentOptionsProvider._({
    required InstallmentOptionsFamily super.from,
    required ({String? cardId, String? bin}) super.argument,
  }) : super(
         retry: null,
         name: r'installmentOptionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$installmentOptionsHash();

  @override
  String toString() {
    return r'installmentOptionsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<int>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<int>> create(Ref ref) {
    final argument = this.argument as ({String? cardId, String? bin});
    return installmentOptions(ref, cardId: argument.cardId, bin: argument.bin);
  }

  @override
  bool operator ==(Object other) {
    return other is InstallmentOptionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$installmentOptionsHash() =>
    r'de13510d1bcefbb7111b55ea6162379e3f169e39';

final class InstallmentOptionsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<int>>,
          ({String? cardId, String? bin})
        > {
  InstallmentOptionsFamily._()
    : super(
        retry: null,
        name: r'installmentOptionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  InstallmentOptionsProvider call({String? cardId, String? bin}) =>
      InstallmentOptionsProvider._(
        argument: (cardId: cardId, bin: bin),
        from: this,
      );

  @override
  String toString() => r'installmentOptionsProvider';
}

@ProviderFor(similarAvailable)
final similarAvailableProvider = SimilarAvailableFamily._();

final class SimilarAvailableProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ListingOffer>>,
          List<ListingOffer>,
          FutureOr<List<ListingOffer>>
        >
    with
        $FutureModifier<List<ListingOffer>>,
        $FutureProvider<List<ListingOffer>> {
  SimilarAvailableProvider._({
    required SimilarAvailableFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'similarAvailableProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$similarAvailableHash();

  @override
  String toString() {
    return r'similarAvailableProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ListingOffer>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ListingOffer>> create(Ref ref) {
    final argument = this.argument as String;
    return similarAvailable(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SimilarAvailableProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$similarAvailableHash() => r'5e55182223f5815aa5f7e2cc695f363f1c9e5865';

final class SimilarAvailableFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ListingOffer>>, String> {
  SimilarAvailableFamily._()
    : super(
        retry: null,
        name: r'similarAvailableProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SimilarAvailableProvider call(String bookingId) =>
      SimilarAvailableProvider._(argument: bookingId, from: this);

  @override
  String toString() => r'similarAvailableProvider';
}
