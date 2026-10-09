import 'package:bungalovum/features/host/data/mock_host_repository.dart';
import 'package:bungalovum/features/host/domain/listing_draft.dart';
import 'package:bungalovum/features/host/presentation/host_errors.dart';
import 'package:bungalovum/l10n/app_localizations_tr.dart';
import 'package:flutter_test/flutter_test.dart';

/// Backend'e bağlanınca değişen kurallar: hassas alanlar cihazda tutulmaz
/// (yalnızca maskeli hali kalır) ve kimlik incelemedeyken devam edilebilir.
void main() {
  final sample = MockHostRepository.sample().copyWith(
    identityDone: IdentityStep.values.toSet(),
  );
  bool legal(ListingDraft d) => DraftValidator.isComplete(WizardStep.legal, d);
  bool payout(ListingDraft d) =>
      DraftValidator.isComplete(WizardStep.identityAndPayout, d);

  group('Yasal adım · vergi numarası', skip: !DraftValidator.requireLegal, () {
    test('kaydedilmiş (maskeli) numara yeterli', () {
      expect(
        legal(sample.copyWith(taxId: '', taxIdMasked: '•••• 01 46')),
        isTrue,
      );
    });

    test('ne yazılmış ne kaydedilmiş numara varsa eksik', () {
      expect(legal(sample.copyWith(taxId: '', taxIdMasked: null)), isFalse);
    });

    test('yeni yazılan numara geçersizse maskeli olsa da eksik', () {
      expect(
        legal(sample.copyWith(taxId: '123', taxIdMasked: '•••• 01 46')),
        isFalse,
      );
    });
  });

  group('Kimlik ve ödeme', skip: !DraftValidator.requireIdentityPayout, () {
    test('kimlik incelemedeyken (ad henüz yok) devam edilebilir', () {
      expect(
        payout(
          sample.copyWith(
            identityStatus: VerificationStatus.pending,
            verifiedName: null,
          ),
        ),
        isTrue,
      );
    });

    test('doğrulanan ad gelince IBAN sahibi onunla eşleşmeli', () {
      expect(payout(sample.copyWith(verifiedName: 'Başka Biri')), isFalse);
      expect(payout(sample.copyWith(verifiedName: 'DENİZ YILMAZ')), isTrue);
    });

    test('kaydedilmiş IBAN (maskeli) yeterli', () {
      expect(
        payout(sample.copyWith(iban: '', ibanMasked: '•••• 13 26')),
        isTrue,
      );
      expect(payout(sample.copyWith(iban: '', ibanMasked: null)), isFalse);
    });

    test('reddedilen kimlikle devam edilemez', () {
      expect(
        payout(sample.copyWith(identityStatus: VerificationStatus.rejected)),
        isFalse,
      );
    });
  });

  group('Hata mesajları', () {
    final l = AppLocalizationsTr();

    test('backend kodları çözüm odaklı metne çevrilir', () {
      expect(
        hostErrorMessage(l, const HostFailure('iban_name_mismatch')),
        l.errorIbanHolder,
      );
      expect(
        hostErrorMessage(
          l,
          const HostFailure('listing_incomplete', 'legal,identity_and_payout'),
        ),
        l.errorListingIncompleteSteps(
          '${l.stepLegal}, ${l.stepIdentityPayout}',
        ),
      );
      expect(
        hostErrorMessage(l, const HostFailure('listing_incomplete')),
        l.errorListingIncomplete,
      );
      expect(
        hostErrorMessage(l, const HostFailure('address_not_found')),
        l.errorAddressNotFound,
      );
    });

    test('tanınmayan hata bağlantı hatası sayılır', () {
      expect(hostErrorMessage(l, const HostFailure('xyz')), l.errorNetwork);
      expect(hostErrorMessage(l, Exception('?')), l.errorNetwork);
    });
  });
}
