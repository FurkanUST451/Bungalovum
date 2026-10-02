// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ödeme ekranında gösterilecek fiyat: kupon varsa kuponlu, yoksa taslak.

@ProviderFor(checkoutQuote)
final checkoutQuoteProvider = CheckoutQuoteProvider._();

/// Ödeme ekranında gösterilecek fiyat: kupon varsa kuponlu, yoksa taslak.

final class CheckoutQuoteProvider
    extends
        $FunctionalProvider<
          AsyncValue<PriceBreakdown>,
          PriceBreakdown,
          FutureOr<PriceBreakdown>
        >
    with $FutureModifier<PriceBreakdown>, $FutureProvider<PriceBreakdown> {
  /// Ödeme ekranında gösterilecek fiyat: kupon varsa kuponlu, yoksa taslak.
  CheckoutQuoteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkoutQuoteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkoutQuoteHash();

  @$internal
  @override
  $FutureProviderElement<PriceBreakdown> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PriceBreakdown> create(Ref ref) {
    return checkoutQuote(ref);
  }
}

String _$checkoutQuoteHash() => r'62d9aefcc20c6a1deaa69d46bf65d1b8916513fb';

@ProviderFor(CheckoutController)
final checkoutControllerProvider = CheckoutControllerProvider._();

final class CheckoutControllerProvider
    extends $NotifierProvider<CheckoutController, CheckoutState> {
  CheckoutControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkoutControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkoutControllerHash();

  @$internal
  @override
  CheckoutController create() => CheckoutController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckoutState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckoutState>(value),
    );
  }
}

String _$checkoutControllerHash() =>
    r'7d95f37314ea6a4aaa211e5909794742a4fc164b';

abstract class _$CheckoutController extends $Notifier<CheckoutState> {
  CheckoutState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CheckoutState, CheckoutState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CheckoutState, CheckoutState>,
              CheckoutState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
