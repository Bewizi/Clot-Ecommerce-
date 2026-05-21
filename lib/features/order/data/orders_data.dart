import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:clot/features/order/domain/orders_domain.dart';
import 'package:clot/features/order/domain/orders_repository.dart';
import 'package:flutter/cupertino.dart';

class OrdersDataImp implements OrdersRepository {
  @override
  Future<List<OrdersDomain>> fetchOrders({required String status}) async {
    try {
      final respose = await supaBase
          .schema('clot')
          .from('orders')
          .select()
          .eq('user_id', supaBase.auth.currentUser!.id)
          .eq('status', status);
      debugPrint(respose.toString());
      return respose.map(OrdersDomain.fromJson).toList();
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
          .eq('id', id);
      debugPrint(response.toString());
      return OrdersDomain.fromJson(response.first);
    } on Exception catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }
}
