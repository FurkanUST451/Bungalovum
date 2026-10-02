import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../booking/domain/payment.dart';
import '../domain/wallet_models.dart';
import 'mock_wallet_repository.dart';

part 'wallet_repository.g.dart';

/// 73–77 · Kartlar ve kuponlar. Kartlar ödeme kuruluşunda tokenize saklanır;
/// uygulama yalnızca marka, son 4 hane ve son kullanma tarihini bilir.
abstract interface class WalletRepository {
  Future<List<PaymentCard>> cards();

  /// Kartı ödeme kuruluşunda doğrulayıp kaydeder; güncel listeyi döner.
  Future<List<PaymentCard>> addCard(NewCardInput input);

  Future<List<PaymentCard>> removeCard(String cardId);

  Future<List<PaymentCard>> setDefaultCard(String cardId);

  Future<List<Coupon>> coupons();

  /// Kodu hesaba ekler; geçersizse [CouponRejected] fırlatır.
  Future<List<Coupon>> redeemCoupon(String code);
}

@Riverpod(keepAlive: true)
WalletRepository walletRepository(Ref ref) => MockWalletRepository();
