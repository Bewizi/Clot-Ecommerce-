import 'package:clot/features/order/domain/orders_domain.dart';

abstract class OrdersRepository {
  Future<List<OrdersDomain>> fetchOrders({required String status});

  Future<OrdersDomain> fetchOrdersById({required String id});
}
