import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../listing/domain/listing_detail.dart';
import '../domain/listing_draft.dart';
import 'mock_host_repository.dart';

part 'host_repository.g.dart';

/// 82–95 · İlan oluşturma ve yönetimi. Taslak sunucuda tutulur; belge,
/// kimlik ve fotoğraf dosyaları yüklenir yüklenmez cihazdan bırakılır (KVKK).
abstract interface class HostRepository {
  /// Ev sahibinin taslağı ya da yayındaki ilanı; yoksa null.
  Future<ListingDraft?> current();

  Future<ListingDraft> start();

  /// Taslağı kaydeder ("Kaydet ve çık" dahil). Yayındaki ilanda belge,
  /// kimlik ya da IBAN değiştiyse yalnızca o bölüm incelemeye girer.
  Future<ListingDraft> save(ListingDraft draft);

  Future<DraftPhoto> uploadPhoto(RoomKind room, String localPath);

  Future<HostDocument> uploadDocument(HostDocKind kind, String localPath);

  /// Kimlik adımını doğrular; üçü tamamlanınca doğrulanmış ad döner.
  Future<ListingDraft> verifyIdentity(IdentityStep step, String localPath);

  /// Komisyon ve vergi oranları backend'den gelir (§10).
  Future<EarningsEstimate> earnings({
    required int nightly,
    required int cleaningFee,
    required String city,
  });

  Future<ListingDraft> submitForReview();

  /// true: rezervasyona kapalı (paused).
  Future<ListingDraft> setPaused(bool paused);

  /// İlanı yayından kaldırır; taslak olarak kalır.
  Future<ListingDraft> unpublish();
}

@Riverpod(keepAlive: true)
HostRepository hostRepository(Ref ref) => MockHostRepository();
