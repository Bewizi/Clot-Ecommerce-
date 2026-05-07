import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:clot/features/products/domain/products_domain.dart';
import 'package:clot/features/products/domain/products_repository.dart';
import 'package:flutter/widgets.dart';

class ProductsDataImpl implements ProductsRepository {
  @override
  Future<List<ProductsDomain>> getProductsByCategoryId(
    String categoryId,
  ) async {
    try {
      final response = await supaBase
          .schema('clot')
          .from('products')
          .select('category_id, image_url, title, price')
          .eq('category_id', categoryId);
      // .order('created_at', ascending: true);
      // print('Response: $response');
      debugPrint('Fetching products for categoryId: [$categoryId]');

      return (response as List<dynamic>)
          .map((e) => ProductsDomain.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  // @override
  // Future<void> getAllProducts() async {}

  // @override
  // Future<void> getProductById(String productId) async {}
}
