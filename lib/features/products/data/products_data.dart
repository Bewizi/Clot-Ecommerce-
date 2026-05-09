import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:clot/features/products/domain/products_domain.dart';
import 'package:clot/features/products/domain/products_repository.dart';
import 'package:flutter/foundation.dart';

class ProductsDataImpl implements ProductsRepository {
  @override
  Future<List<ProductsDomain>> getProductsByCategoryId(
    String categoryId,
  ) async {
    try {
      final response = await supaBase
          .schema('clot')
          .from('products')
          .select('category_id, image_url, title, price,product_tag')
          .eq('category_id', categoryId)
          .order('created_at', ascending: true);

      return (response as List<dynamic>)
          .map((e) => ProductsDomain.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  @override
  Future<List<ProductsDomain>> getAllProducts() async {
    try {
      final response = await supaBase
          .schema('clot')
          .from('products')
          .select('tilte, price, image_url, product_tag');

      debugPrint(response.length.toString());
      return (response as List<dynamic>)
          .map((e) => ProductsDomain.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  @override
  Future<List<ProductsDomain>> getTopSellingProducts() async {
    try {
      final response = await supaBase
          .schema('clot')
          .from('products')
          .select('title, price, image_url, product_tag')
          .eq('product_tag', 'top_selling')
          .order('created_at', ascending: true);
      debugPrint(response.length.toString());
      return (response as List<dynamic>)
          .map((e) => ProductsDomain.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch top selling products: $e');
    }
  }

  @override
  Future<List<ProductsDomain>> getNewInProducts() async {
    try {
      final response = await supaBase
          .schema('clot')
          .from('products')
          .select('title, price, image_url, product_tag')
          .eq('product_tag', 'new_in')
          .order('created_at', ascending: true);
      debugPrint(response.length.toString());
      return (response as List<dynamic>)
          .map((e) => ProductsDomain.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch new in products: $e');
    }
  }
}
