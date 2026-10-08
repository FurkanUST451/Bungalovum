import 'package:bungalovum/features/host/data/mock_host_repository.dart';
import 'package:bungalovum/features/host/domain/listing_draft.dart';
import 'package:bungalovum/features/listing/domain/listing_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  final sample = MockHostRepository.sample();
  final complete = sample.copyWith(
    identityDone: IdentityStep.values.toSet(),
    verifiedName: MockHostRepository.verifiedSampleName,
  );

  group('IBAN', () {
    test('geçerli TR IBAN mod-97 ile doğrulanır', () {
      expect(
        IbanValidator.isValidTr('TR33 0006 1005 1978 6457 8413 26'),
        isTrue,
      );
      expect(IbanValidator.isValidTr('tr330006100519786457841326'), isTrue);
    });

    test('kontrol hanesi ya da biçim hatalıysa reddedilir', () {
      expect(
        IbanValidator.isValidTr('TR34 0006 1005 1978 6457 8413 26'),
        isFalse,
      );
      expect(IbanValidator.isValidTr('DE89 3704 0044 0532 0130 00'), isFalse);
      expect(IbanValidator.isValidTr('TR33 0006'), isFalse);
    });

    test('maskeli gösterim son 4 haneyi bırakır', () {
      expect(
        IbanValidator.masked('TR12 0006 4000 0011 2345 6789 01'),
        '•••• 89 01',
      );
    });
  });

  test('ad eşleşmesi Türkçe büyük/küçük harfi yok sayar', () {
    expect(NameMatcher.same('DENİZ YILMAZ', 'Deniz Yılmaz'), isTrue);
    expect(NameMatcher.same('  deniz   yılmaz ', 'Deniz Yılmaz'), isTrue);
    expect(NameMatcher.same('Deniz Aksoy', 'Deniz Yılmaz'), isFalse);
  });

  group('Adım kuralları (§10)', () {
    test(
      'örnek taslakta kimlik eksikken yalnızca 10. adım eksik',
      () {
        expect(
          WizardStep.values.where((s) => !DraftValidator.isComplete(s, sample)),
          [WizardStep.identityAndPayout],
        );
      },
      skip: !DraftValidator.requireIdentityPayout,
    );

    test('en az 8 fotoğraf olmadan 4. adım tamamlanmaz', () {
      final few = sample.copyWith(photos: sample.photos.take(7).toList());
      expect(DraftValidator.isComplete(WizardStep.photos, few), isFalse);
    });

    test(
      'izin belge numarası olmadan yasal adım tamamlanmaz',
      () {
        expect(
          DraftValidator.isComplete(
            WizardStep.legal,
            sample.copyWith(permitNo: ''),
          ),
          isFalse,
        );
      },
      skip: !DraftValidator.requireLegal,
    );

    test(
      'koşullu belgeler yalnızca koşul işaretlenince zorunlu',
      () {
        final multi = sample.copyWith(multiUnitParcel: true);
        expect(DraftValidator.isComplete(WizardStep.legal, multi), isFalse);
        final withDoc = multi.copyWith(
          documents: {
            ...multi.documents,
            HostDocKind.condoDecision: const HostDocument(id: 'x'),
          },
        );
        expect(DraftValidator.isComplete(WizardStep.legal, withDoc), isTrue);
      },
      skip: !DraftValidator.requireLegal || !DraftValidator.requireDocuments,
    );

    test(
      'belge zorunluluğu kapalıyken belgesiz de devam edilir',
      () {
        final noDocs = sample.copyWith(documents: const {});
        expect(DraftValidator.isComplete(WizardStep.legal, noDocs), isTrue);
        // İzin belge numarası yine zorunlu.
        expect(
          DraftValidator.isComplete(
            WizardStep.legal,
            noDocs.copyWith(permitNo: ''),
          ),
          isFalse,
        );
      },
      skip: !DraftValidator.requireLegal || DraftValidator.requireDocuments,
    );

    test(
      'KBS beyanı işaretlenmeden yasal adım tamamlanmaz',
      () {
        expect(
          DraftValidator.isComplete(
            WizardStep.legal,
            sample.copyWith(kbsDeclaration: false),
          ),
          isFalse,
        );
      },
      skip: !DraftValidator.requireLegal,
    );

    test(
      'yasal adım kapalıyken boş bilgilerle de devam edilir',
      () {
        expect(
          DraftValidator.isComplete(
            WizardStep.legal,
            const ListingDraft(id: 'bos'),
          ),
          isTrue,
        );
      },
      skip: DraftValidator.requireLegal,
    );

    test('dış kamera varsa konumu zorunlu', () {
      final cam = sample.copyWith(
        safety: {...sample.safety, SafetyKind.outdoorCamera},
      );
      expect(
        DraftValidator.isComplete(WizardStep.safetyAndRules, cam),
        isFalse,
      );
      expect(
        DraftValidator.isComplete(
          WizardStep.safetyAndRules,
          cam.copyWith(outdoorCameraNote: 'Bahçe kapısı'),
        ),
        isTrue,
      );
    });

    test(
      'IBAN sahibi doğrulanan adla eşleşmezse ödeme adımı eksik',
      () {
        expect(
          DraftValidator.isComplete(WizardStep.identityAndPayout, complete),
          isTrue,
        );
        expect(
          DraftValidator.isComplete(
            WizardStep.identityAndPayout,
            complete.copyWith(accountHolder: 'Başka Biri'),
          ),
          isFalse,
        );
      },
      skip: !DraftValidator.requireIdentityPayout,
    );

    test('onaylar olmadan incelemeye gönderilemez', () {
      expect(DraftValidator.canSubmit(complete), isFalse);
      expect(
        DraftValidator.canSubmit(
          complete.copyWith(
            accuracyConsent: true,
            agreementConsent: true,
            ministryConsent: true,
          ),
        ),
        isTrue,
      );
    });
  });

  group('Mock depo', () {
    test(
      'yayındaki ilanda IBAN değişince yalnızca o bölüm incelemeye girer',
      () async {
        final repo = MockHostRepository(
          latency: Duration.zero,
          seed: complete.copyWith(status: ListingStatus.published),
        );
        final saved = await repo.save(
          complete.copyWith(
            status: ListingStatus.published,
            iban: 'TR12 0006 4000 0011 2345 6789 01',
          ),
        );
        expect(saved.status, ListingStatus.published);
        expect(saved.sectionsInReview, {WizardStep.identityAndPayout});
      },
    );

    test('başlık değişikliği incelemeye sokmaz', () async {
      final repo = MockHostRepository(
        latency: Duration.zero,
        seed: complete.copyWith(status: ListingStatus.published),
      );
      final saved = await repo.save(
        complete.copyWith(status: ListingStatus.published, title: 'Yeni ad'),
      );
      expect(saved.sectionsInReview, isEmpty);
    });

    test('üç kimlik adımı tamamlanınca doğrulanmış ad gelir', () async {
      final repo = MockHostRepository(latency: Duration.zero, seed: sample);
      final d = await repo.verifyIdentity(IdentityStep.selfie, '/tmp/x.jpg');
      expect(d.verifiedName, MockHostRepository.verifiedSampleName);
    });

    test('kazanç tahmini backend oranıyla hesaplanır', () async {
      final repo = MockHostRepository(latency: Duration.zero);
      final e = await repo.earnings(nightly: 4900, cleaningFee: 600, city: '');
      expect(e.stayTotal, 9800);
      expect(e.serviceFee, 1040);
      expect(e.hostEarns, 9360);
    });

    test('incelemeye gönderilince durum ve zaman yazılır', () async {
      final repo = MockHostRepository(
        latency: Duration.zero,
        clock: fixedClock,
        seed: complete,
      );
      final d = await repo.submitForReview();
      expect(d.status, ListingStatus.inReview);
      expect(d.submittedAt, fixedClock());
    });
  });
}
