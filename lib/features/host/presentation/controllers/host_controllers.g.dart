// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ev sahibinin taslağı / ilanı. Sihirbaz ekranları değişiklikleri önce
/// yerelde tutar ([edit]); adım değişince ya da "Kaydet ve çık"ta [save].

@ProviderFor(HostDraft)
final hostDraftProvider = HostDraftProvider._();

/// Ev sahibinin taslağı / ilanı. Sihirbaz ekranları değişiklikleri önce
/// yerelde tutar ([edit]); adım değişince ya da "Kaydet ve çık"ta [save].
final class HostDraftProvider
    extends $AsyncNotifierProvider<HostDraft, ListingDraft?> {
  /// Ev sahibinin taslağı / ilanı. Sihirbaz ekranları değişiklikleri önce
  /// yerelde tutar ([edit]); adım değişince ya da "Kaydet ve çık"ta [save].
  HostDraftProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hostDraftProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hostDraftHash();

  @$internal
  @override
  HostDraft create() => HostDraft();
}

String _$hostDraftHash() => r'f840911d2d1f4d08f08db201550450abcd14ea57';

/// Ev sahibinin taslağı / ilanı. Sihirbaz ekranları değişiklikleri önce
/// yerelde tutar ([edit]); adım değişince ya da "Kaydet ve çık"ta [save].

abstract class _$HostDraft extends $AsyncNotifier<ListingDraft?> {
  FutureOr<ListingDraft?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ListingDraft?>, ListingDraft?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ListingDraft?>, ListingDraft?>,
              AsyncValue<ListingDraft?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// 89 · Kazanç tahmini (oranlar backend'den).

@ProviderFor(hostEarnings)
final hostEarningsProvider = HostEarningsFamily._();

/// 89 · Kazanç tahmini (oranlar backend'den).

final class HostEarningsProvider
    extends
        $FunctionalProvider<
          AsyncValue<EarningsEstimate>,
          EarningsEstimate,
          FutureOr<EarningsEstimate>
        >
    with $FutureModifier<EarningsEstimate>, $FutureProvider<EarningsEstimate> {
  /// 89 · Kazanç tahmini (oranlar backend'den).
  HostEarningsProvider._({
    required HostEarningsFamily super.from,
    required ({int nightly, int cleaningFee, String city}) super.argument,
  }) : super(
         retry: null,
         name: r'hostEarningsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hostEarningsHash();

  @override
  String toString() {
    return r'hostEarningsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<EarningsEstimate> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EarningsEstimate> create(Ref ref) {
    final argument =
        this.argument as ({int nightly, int cleaningFee, String city});
    return hostEarnings(
      ref,
      nightly: argument.nightly,
      cleaningFee: argument.cleaningFee,
      city: argument.city,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HostEarningsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hostEarningsHash() => r'31a3ededd1a701ba37616505e5b4a11716e0eb8b';

/// 89 · Kazanç tahmini (oranlar backend'den).

final class HostEarningsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<EarningsEstimate>,
          ({int nightly, int cleaningFee, String city})
        > {
  HostEarningsFamily._()
    : super(
        retry: null,
        name: r'hostEarningsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 89 · Kazanç tahmini (oranlar backend'den).

  HostEarningsProvider call({
    required int nightly,
    required int cleaningFee,
    required String city,
  }) => HostEarningsProvider._(
    argument: (nightly: nightly, cleaningFee: cleaningFee, city: city),
    from: this,
  );

  @override
  String toString() => r'hostEarningsProvider';
}
