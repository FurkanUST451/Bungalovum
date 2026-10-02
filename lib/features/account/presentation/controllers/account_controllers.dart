import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../booking/data/booking_repository.dart';
import '../../../booking/domain/booking.dart';
import '../../../saved/presentation/controllers/saved_listings_controller.dart';
import '../../data/account_repository.dart';
import '../../domain/account_models.dart';

part 'account_controllers.g.dart';

@Riverpod(keepAlive: true)
class Profile extends _$Profile {
  @override
  Future<UserProfile> build() => ref.watch(accountRepositoryProvider).profile();

  AccountRepository get _repo => ref.read(accountRepositoryProvider);

  Future<void> save(UserProfile p) async =>
      state = AsyncData(await _repo.updateProfile(p));

  Future<void> setAvatar(String localPath) async =>
      state = AsyncData(await _repo.updateAvatar(localPath));
}

/// 65 · Konaklama / Yorum / Kayıtlı sayıları mevcut verilerden türetilir.
@riverpod
Future<AccountStats> accountStats(Ref ref) async {
  final bookings = await ref.watch(myBookingsProvider.future);
  final saved = ref.watch(savedListingIdsProvider);
  return AccountStats(
    stays: bookings.where((b) => b.status == BookingStatus.completed).length,
    reviews: bookings.where((b) => b.myRating != null).length,
    saved: saved.length,
  );
}

@riverpod
class Security extends _$Security {
  @override
  Future<SecuritySettings> build() =>
      ref.watch(accountRepositoryProvider).security();

  AccountRepository get _repo => ref.read(accountRepositoryProvider);

  Future<void> _apply(Future<SecuritySettings> request) async {
    final s = await request;
    if (ref.mounted) state = AsyncData(s);
  }

  Future<void> setBiometric(bool on) => _apply(_repo.setBiometric(on));

  /// Geçerli şifre yanlışsa [PasswordChangeRejected] fırlatır.
  Future<void> changePassword(String current, String next) =>
      _apply(_repo.changePassword(current, next));

  Future<void> signOutDevice(String id) => _apply(_repo.signOutDevice(id));
}

@riverpod
class NotifPrefs extends _$NotifPrefs {
  @override
  Future<NotificationPrefs> build() =>
      ref.watch(accountRepositoryProvider).notificationPrefs();

  Future<void> _save(NotificationPrefs p) async {
    // İyimser: anahtar hemen döner, kayıt arkadan gelir; hata olursa geri al.
    final before = state.requireValue;
    state = AsyncData(p);
    try {
      final saved = await ref
          .read(accountRepositoryProvider)
          .saveNotificationPrefs(p);
      if (ref.mounted) state = AsyncData(saved);
    } catch (_) {
      if (ref.mounted) state = AsyncData(before);
      rethrow;
    }
  }

  Future<void> toggle(NotifTopic t, bool on) {
    final p = state.requireValue;
    return _save(
      p.copyWith(topics: {...p.topics, t: on ? t.defaultChannels : const {}}),
    );
  }

  Future<void> disableMarketing() {
    final p = state.requireValue;
    return _save(
      p.copyWith(
        topics: {
          for (final t in NotifTopic.values)
            t: t.isMarketing ? const <NotifChannel>{} : p.channels(t),
        },
      ),
    );
  }
}

@riverpod
class Privacy extends _$Privacy {
  @override
  Future<PrivacySettings> build() =>
      ref.watch(accountRepositoryProvider).privacy();

  Future<void> save(PrivacySettings s) async {
    final before = state.requireValue;
    state = AsyncData(s);
    try {
      final saved = await ref.read(accountRepositoryProvider).savePrivacy(s);
      if (ref.mounted) state = AsyncData(saved);
    } catch (_) {
      if (ref.mounted) state = AsyncData(before);
      rethrow;
    }
  }
}

@riverpod
Future<CloseAccountImpact> closeAccountImpact(Ref ref) =>
    ref.watch(accountRepositoryProvider).closeAccountImpact();

@riverpod
Future<LegalDocument> legalDocument(Ref ref, LegalDoc doc) =>
    ref.watch(accountRepositoryProvider).legalDocument(doc);

@riverpod
Future<List<FaqItem>> faq(Ref ref) =>
    ref.watch(accountRepositoryProvider).faq();
