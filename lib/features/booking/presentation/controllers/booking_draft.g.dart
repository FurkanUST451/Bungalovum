// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_draft.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// İlan başına taslak; ilk açılışta aktif aramanın tarih ve misafirleriyle
/// başlar.

@ProviderFor(BookingDraftController)
final bookingDraftControllerProvider = BookingDraftControllerFamily._();

/// İlan başına taslak; ilk açılışta aktif aramanın tarih ve misafirleriyle
/// başlar.
final class BookingDraftControllerProvider
    extends $NotifierProvider<BookingDraftController, BookingDraft> {
  /// İlan başına taslak; ilk açılışta aktif aramanın tarih ve misafirleriyle
  /// başlar.
  BookingDraftControllerProvider._({
    required BookingDraftControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bookingDraftControllerProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookingDraftControllerHash();

  @override
  String toString() {
    return r'bookingDraftControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BookingDraftController create() => BookingDraftController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookingDraft value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookingDraft>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BookingDraftControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookingDraftControllerHash() =>
    r'3e326908eb93d1d0a831c29ff43e11e7382fabb3';

/// İlan başına taslak; ilk açılışta aktif aramanın tarih ve misafirleriyle
/// başlar.

final class BookingDraftControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          BookingDraftController,
          BookingDraft,
          BookingDraft,
          BookingDraft,
          String
        > {
  BookingDraftControllerFamily._()
    : super(
        retry: null,
        name: r'bookingDraftControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// İlan başına taslak; ilk açılışta aktif aramanın tarih ve misafirleriyle
  /// başlar.

  BookingDraftControllerProvider call(String listingId) =>
      BookingDraftControllerProvider._(argument: listingId, from: this);

  @override
  String toString() => r'bookingDraftControllerProvider';
}

/// İlan başına taslak; ilk açılışta aktif aramanın tarih ve misafirleriyle
/// başlar.

abstract class _$BookingDraftController extends $Notifier<BookingDraft> {
  late final _$args = ref.$arg as String;
  String get listingId => _$args;

  BookingDraft build(String listingId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<BookingDraft, BookingDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BookingDraft, BookingDraft>,
              BookingDraft,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

/// Taslak gece sayısı için fiyat kalemleri.

@ProviderFor(bookingQuote)
final bookingQuoteProvider = BookingQuoteFamily._();

/// Taslak gece sayısı için fiyat kalemleri.

final class BookingQuoteProvider
    extends
        $FunctionalProvider<
          AsyncValue<PriceBreakdown>,
          PriceBreakdown,
          FutureOr<PriceBreakdown>
        >
    with $FutureModifier<PriceBreakdown>, $FutureProvider<PriceBreakdown> {
  /// Taslak gece sayısı için fiyat kalemleri.
  BookingQuoteProvider._({
    required BookingQuoteFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bookingQuoteProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookingQuoteHash();

  @override
  String toString() {
    return r'bookingQuoteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PriceBreakdown> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PriceBreakdown> create(Ref ref) {
    final argument = this.argument as String;
    return bookingQuote(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BookingQuoteProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookingQuoteHash() => r'88360ecb520c0fc0a43bc8ed74af67dd7ec7dec4';

/// Taslak gece sayısı için fiyat kalemleri.

final class BookingQuoteFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PriceBreakdown>, String> {
  BookingQuoteFamily._()
    : super(
        retry: null,
        name: r'bookingQuoteProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Taslak gece sayısı için fiyat kalemleri.

  BookingQuoteProvider call(String listingId) =>
      BookingQuoteProvider._(argument: listingId, from: this);

  @override
  String toString() => r'bookingQuoteProvider';
}
