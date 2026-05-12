import 'package:clot/features/cart/domain/cart_domain.dart';

abstract class CartRepository {
  Future<CartDomain> addToCart({
    required String productId,
    required String userId,
    required String title,
    required double price,
    required String image,
    int quantity = 1,
  });

  Future<List<CartDomain>> getCartItems({required String userId});

  Future<void> removeFromCart({required String cartItemId});

  Future<CartDomain> updateQuantity({
    required String cartItemId,
    required int newQuantity,
  });
}
