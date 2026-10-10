// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Profile)
final profileProvider = ProfileProvider._();

final class ProfileProvider
    extends $AsyncNotifierProvider<Profile, UserProfile> {
  ProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileHash();

  @$internal
  @override
  Profile create() => Profile();
}

String _$profileHash() => r'8a9ffa63bcd2b790e58e36e2733c1e67040d7f2e';

abstract class _$Profile extends $AsyncNotifier<UserProfile> {
  FutureOr<UserProfile> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserProfile>, UserProfile>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserProfile>, UserProfile>,
              AsyncValue<UserProfile>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// 65 · Konaklama / Yorum / Kayıtlı sayıları mevcut verilerden türetilir.

@ProviderFor(accountStats)
final accountStatsProvider = AccountStatsProvider._();

/// 65 · Konaklama / Yorum / Kayıtlı sayıları mevcut verilerden türetilir.

final class AccountStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<AccountStats>,
          AccountStats,
          FutureOr<AccountStats>
        >
    with $FutureModifier<AccountStats>, $FutureProvider<AccountStats> {
  /// 65 · Konaklama / Yorum / Kayıtlı sayıları mevcut verilerden türetilir.
  AccountStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountStatsHash();

  @$internal
  @override
  $FutureProviderElement<AccountStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AccountStats> create(Ref ref) {
    return accountStats(ref);
  }
}

String _$accountStatsHash() => r'fc72ce94908b0a72e212d2df3fc338ed7589a04b';

@ProviderFor(Security)
final securityProvider = SecurityProvider._();

final class SecurityProvider
    extends $AsyncNotifierProvider<Security, SecuritySettings> {
  SecurityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'securityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$securityHash();

  @$internal
  @override
  Security create() => Security();
}

String _$securityHash() => r'1caeee7f259ddb7bc559bc0860df83d5731ab2b1';

abstract class _$Security extends $AsyncNotifier<SecuritySettings> {
  FutureOr<SecuritySettings> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SecuritySettings>, SecuritySettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SecuritySettings>, SecuritySettings>,
              AsyncValue<SecuritySettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(NotifPrefs)
final notifPrefsProvider = NotifPrefsProvider._();

final class NotifPrefsProvider
    extends $AsyncNotifierProvider<NotifPrefs, NotificationPrefs> {
  NotifPrefsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notifPrefsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notifPrefsHash();

  @$internal
  @override
  NotifPrefs create() => NotifPrefs();
}

String _$notifPrefsHash() => r'2619cd489285b045684ba1a74d708dc79f645544';

abstract class _$NotifPrefs extends $AsyncNotifier<NotificationPrefs> {
  FutureOr<NotificationPrefs> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<NotificationPrefs>, NotificationPrefs>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NotificationPrefs>, NotificationPrefs>,
              AsyncValue<NotificationPrefs>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(Privacy)
final privacyProvider = PrivacyProvider._();

final class PrivacyProvider
    extends $AsyncNotifierProvider<Privacy, PrivacySettings> {
  PrivacyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'privacyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$privacyHash();

  @$internal
  @override
  Privacy create() => Privacy();
}

String _$privacyHash() => r'bc62985d9c7fd3c43209fc807c76dcac8e704607';

abstract class _$Privacy extends $AsyncNotifier<PrivacySettings> {
  FutureOr<PrivacySettings> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PrivacySettings>, PrivacySettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PrivacySettings>, PrivacySettings>,
              AsyncValue<PrivacySettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(closeAccountImpact)
final closeAccountImpactProvider = CloseAccountImpactProvider._();

final class CloseAccountImpactProvider
    extends
        $FunctionalProvider<
          AsyncValue<CloseAccountImpact>,
          CloseAccountImpact,
          FutureOr<CloseAccountImpact>
        >
    with
        $FutureModifier<CloseAccountImpact>,
        $FutureProvider<CloseAccountImpact> {
  CloseAccountImpactProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'closeAccountImpactProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$closeAccountImpactHash();

  @$internal
  @override
  $FutureProviderElement<CloseAccountImpact> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CloseAccountImpact> create(Ref ref) {
    return closeAccountImpact(ref);
  }
}

String _$closeAccountImpactHash() =>
    r'20b73080af7c7ce44885a87d10bd91462a04c307';

@ProviderFor(legalDocument)
final legalDocumentProvider = LegalDocumentFamily._();

final class LegalDocumentProvider
    extends
        $FunctionalProvider<
          AsyncValue<LegalDocument>,
          LegalDocument,
          FutureOr<LegalDocument>
        >
    with $FutureModifier<LegalDocument>, $FutureProvider<LegalDocument> {
  LegalDocumentProvider._({
    required LegalDocumentFamily super.from,
    required LegalDoc super.argument,
  }) : super(
         retry: null,
         name: r'legalDocumentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$legalDocumentHash();

  @override
  String toString() {
    return r'legalDocumentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LegalDocument> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LegalDocument> create(Ref ref) {
    final argument = this.argument as LegalDoc;
    return legalDocument(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LegalDocumentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$legalDocumentHash() => r'554ba469065a154484929be43cc59e782b6c60da';

final class LegalDocumentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LegalDocument>, LegalDoc> {
  LegalDocumentFamily._()
    : super(
        retry: null,
        name: r'legalDocumentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LegalDocumentProvider call(LegalDoc doc) =>
      LegalDocumentProvider._(argument: doc, from: this);

  @override
  String toString() => r'legalDocumentProvider';
}

@ProviderFor(faq)
final faqProvider = FaqProvider._();

final class FaqProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FaqItem>>,
          List<FaqItem>,
          FutureOr<List<FaqItem>>
        >
    with $FutureModifier<List<FaqItem>>, $FutureProvider<List<FaqItem>> {
  FaqProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'faqProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$faqHash();

  @$internal
  @override
  $FutureProviderElement<List<FaqItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FaqItem>> create(Ref ref) {
    return faq(ref);
  }
}

String _$faqHash() => r'b6f13415e19e8f786bb4ea3e486d9146f54c54c5';
