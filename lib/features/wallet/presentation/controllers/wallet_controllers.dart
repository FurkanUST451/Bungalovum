import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/clock.dart';
import '../../../booking/data/booking_repository.dart';
import '../../../booking/domain/payment.dart';
import '../../data/wallet_repository.dart';
import '../../domain/wallet_models.dart';

part 'wallet_controllers.g.dart';

/// Kayıtlı kartlar (74/75); ödeme ekranı (34) da aynı listeyi kullanır.
@riverpod
class SavedCards extends _$SavedCards {
  @override
  Future<List<PaymentCard>> build() => _repo.cards();

  WalletRepository get _repo => ref.read(walletRepositoryProvider);

  Future<void> _apply(Future<List<PaymentCard>> request) async {
    final cards = await request;
    if (ref.mounted) state = AsyncData(cards);
  }

  Future<void> add(NewCardInput input) => _apply(_repo.addCard(input));

  Future<void> remove(String id) => _apply(_repo.removeCard(id));

  Future<void> makeDefault(String id) => _apply(_repo.setDefaultCard(id));
}

/// 77 · Hesaptaki kuponlar.
@riverpod
class Coupons extends _$Coupons {
  @override
  Future<List<Coupon>> build() => ref.watch(walletRepositoryProvider).coupons();

  /// Geçersizse [CouponRejected] fırlatır.
  Future<void> redeem(String code) async {
    final coupons = await ref.read(walletRepositoryProvider).redeemCoupon(code);
    if (ref.mounted) state = AsyncData(coupons);
  }
}

/// Kullanılabilir kuponlar (süresi geçmemiş, kullanılmamış).
@riverpod
Future<List<Coupon>> activeCoupons(Ref ref) async {
  final all = await ref.watch(couponsProvider.future);
  final now = ref.watch(clockProvider)();
  return [
    for (final c in all)
      if (c.isActive(now)) c,
  ];
}

/// 76 · Ödeme ve iade hareketleri rezervasyonlardan türetilir.
@riverpod
Future<List<PaymentRecord>> paymentHistory(Ref ref) async =>
    PaymentHistory.fromBookings(await ref.watch(myBookingsProvider.future));
