import 'package:clot/features/cart/domain/cart_domain.dart';
import 'package:clot/features/order/domain/order_item_domain.dart';
import 'package:clot/features/order/domain/orders_domain.dart';

abstract class OrdersRepository {
  Future<List<OrdersDomain>> fetchOrdersByUser({required String? status});

  Future<OrdersDomain> fetchOrdersById({required String id});

  Future<List<OrderItemDomain>> fetchOrders({required String orderId});

  /// Returns the new order's ID on success
  Future<String> placeOrder({
    required String shippingAddress,
    String? shippingPhone,
    required List<CartDomain> cartItems,
  });
}
