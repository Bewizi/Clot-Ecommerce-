import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:clot/features/cart/domain/cart_domain.dart';
import 'package:clot/features/cart/domain/cart_repository.dart';

class CartDataImpl implements CartRepository {
  @override
  Future<CartDomain> addToCart({
    required String productId,
    required String userId,
    required String title,
    required double price,
    required String image,
    int quantity = 1,
  }) async {
    try {
      final response = await supaBase
          .schema('clot')
          .from('cart')
          .insert({
            'product_id': productId,
            'user_id': userId,
            'quantity': quantity,
            'title': title,
            'price': price,
            'image': image,
          })
          .select()
          .single();
      return CartDomain.fromJson(response);
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  @override
  Future<List<CartDomain>> getCartItems({required String userId}) async {
    try {
      final response = await supaBase
          .schema('clot')
          .from('cart')
          .select()
          .eq('user_id', userId);
      return (response as List<dynamic>)
          .map((item) => CartDomain.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get cart items: $e');
    }
  }

  @override
  Future<void> removeFromCart({required String cartItemId}) async {
    try {
      await supaBase.schema('clot').from('cart').delete().eq('id', cartItemId);
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  @override
  Future<CartDomain> updateQuantity({
    required String cartItemId,
    required int newQuantity,
  }) async {
    try {
      final response = await supaBase
          .schema('clot')
          .from('cart')
          .update({
            'quantity': newQuantity,
          })
          .eq('id', cartItemId)
          .select()
          .single();
      return CartDomain.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }
}
