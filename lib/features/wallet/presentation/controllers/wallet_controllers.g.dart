// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Kayıtlı kartlar (74/75); ödeme ekranı (34) da aynı listeyi kullanır.

@ProviderFor(SavedCards)
final savedCardsProvider = SavedCardsProvider._();

/// Kayıtlı kartlar (74/75); ödeme ekranı (34) da aynı listeyi kullanır.
final class SavedCardsProvider
    extends $AsyncNotifierProvider<SavedCards, List<PaymentCard>> {
  /// Kayıtlı kartlar (74/75); ödeme ekranı (34) da aynı listeyi kullanır.
  SavedCardsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedCardsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedCardsHash();

  @$internal
  @override
  SavedCards create() => SavedCards();
}

String _$savedCardsHash() => r'536ca2f3dea9c43f31e3ff8212b5ed572a0bb07f';

/// Kayıtlı kartlar (74/75); ödeme ekranı (34) da aynı listeyi kullanır.

abstract class _$SavedCards extends $AsyncNotifier<List<PaymentCard>> {
  FutureOr<List<PaymentCard>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PaymentCard>>, List<PaymentCard>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PaymentCard>>, List<PaymentCard>>,
              AsyncValue<List<PaymentCard>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// 77 · Hesaptaki kuponlar.

@ProviderFor(Coupons)
final couponsProvider = CouponsProvider._();

/// 77 · Hesaptaki kuponlar.
final class CouponsProvider
    extends $AsyncNotifierProvider<Coupons, List<Coupon>> {
  /// 77 · Hesaptaki kuponlar.
  CouponsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'couponsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$couponsHash();

  @$internal
  @override
  Coupons create() => Coupons();
}

String _$couponsHash() => r'003e15df9ce866c00f0f26e7cd0d03448168f765';

/// 77 · Hesaptaki kuponlar.

abstract class _$Coupons extends $AsyncNotifier<List<Coupon>> {
  FutureOr<List<Coupon>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Coupon>>, List<Coupon>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Coupon>>, List<Coupon>>,
              AsyncValue<List<Coupon>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Kullanılabilir kuponlar (süresi geçmemiş, kullanılmamış).

@ProviderFor(activeCoupons)
final activeCouponsProvider = ActiveCouponsProvider._();

/// Kullanılabilir kuponlar (süresi geçmemiş, kullanılmamış).

final class ActiveCouponsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Coupon>>,
          List<Coupon>,
          FutureOr<List<Coupon>>
        >
    with $FutureModifier<List<Coupon>>, $FutureProvider<List<Coupon>> {
  /// Kullanılabilir kuponlar (süresi geçmemiş, kullanılmamış).
  ActiveCouponsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeCouponsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeCouponsHash();

  @$internal
  @override
  $FutureProviderElement<List<Coupon>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Coupon>> create(Ref ref) {
    return activeCoupons(ref);
  }
}

String _$activeCouponsHash() => r'534b1635bdfcd83f0c92a617bb1971aed82bbbb2';

/// 76 · Ödeme ve iade hareketleri rezervasyonlardan türetilir.

@ProviderFor(paymentHistory)
final paymentHistoryProvider = PaymentHistoryProvider._();

/// 76 · Ödeme ve iade hareketleri rezervasyonlardan türetilir.

final class PaymentHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PaymentRecord>>,
          List<PaymentRecord>,
          FutureOr<List<PaymentRecord>>
        >
    with
        $FutureModifier<List<PaymentRecord>>,
        $FutureProvider<List<PaymentRecord>> {
  /// 76 · Ödeme ve iade hareketleri rezervasyonlardan türetilir.
  PaymentHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<PaymentRecord>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PaymentRecord>> create(Ref ref) {
    return paymentHistory(ref);
  }
}

String _$paymentHistoryHash() => r'a2b16c0bf53d9665c610a2987c60503886814f00';
