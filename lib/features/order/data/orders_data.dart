import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:clot/features/cart/domain/cart_domain.dart';
import 'package:clot/features/order/domain/order_item_domain.dart';
import 'package:clot/features/order/domain/orders_domain.dart';
import 'package:clot/features/order/domain/orders_repository.dart';
import 'package:flutter/cupertino.dart';

class OrdersDataImp implements OrdersRepository {
  @override
  Future<List<OrdersDomain>> fetchOrdersByUser({String? status}) async {
    try {
      var query = supaBase
          .schema('clot')
          .from('orders')
          .select()
          .eq('user_id', supaBase.auth.currentUser!.id);

      if (status != null) {
        query = query.eq('status', status);
      }

      final response = await query.order('placed_at', ascending: false);
      debugPrint(response.toString());
      return response.map(OrdersDomain.fromJson).toList();
    } on Exception catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }

  @override
  Future<OrdersDomain> fetchOrdersById({required String id}) async {
    try {
      final response = await supaBase
          .schema('clot')
          .from('orders')
          .select()
          .eq('id', id)
          .single();
      debugPrint(response.toString());
      return OrdersDomain.fromJson(response);
    } on Exception catch (e) {
      throw Exception('Failed to fetch order: $e');
    }
  }

  @override
  Future<List<OrderItemDomain>> fetchOrders({required String orderId}) async {
    try {
      final response = await supaBase
          .schema('clot')
          .from('order_items')
          .select()
          .eq('order_id', orderId);
      debugPrint(response.toString());
      return response.map(OrderItemDomain.fromJson).toList();
    } on Exception catch (e) {
      throw Exception('Failed to fetch order items: $e');
    }
  }

  @override
  Future<String> placeOrder({
    required String shippingAddress,
    String? shippingPhone,
    required List<CartDomain> cartItems,
  }) async {
    try {
      // Generate a unique order number using timestamp + random suffix
      final orderNumber = '${DateTime.now().millisecondsSinceEpoch}';

      final orderResponse = await supaBase
          .schema('clot')
          .from('orders')
          .insert({
            'user_id': supaBase.auth.currentUser!.id,
            'order_number': orderNumber,
            'status': 'Processing',
            'shipping_address': shippingAddress,
            'shipping_phone': shippingPhone,
          })
          .select()
          .single();

      final orderId = orderResponse['id'] as String;

      // Insert all order items in one batch
      final items = cartItems
          .map(
            (item) => {
              'order_id': orderId,
              'product_id': item.productId,
              'quantity': item.quantity,
              'price_at_purchase': item.price,
            },
          )
          .toList();

      await supaBase.schema('clot').from('order_items').insert(items);

      // Clear the user's cart
      // await supaBase
      //     .schema('clot')
      //     .from('cart')
      //     .delete()
      //     .eq('user_id', supaBase.auth.currentUser!.id);

      return orderId;
    } on Exception catch (e) {
      throw Exception('Failed to place order: $e');
    }
  }
}
