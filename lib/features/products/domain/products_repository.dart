import 'package:clot/features/products/domain/products_domain.dart';

abstract class ProductsRepository {
  Future<List<ProductsDomain>> getProductsByCategoryId(String categoryId);
  Future<List<ProductsDomain>> getAllProducts();
  Future<List<ProductsDomain>> getTopSellingProducts();
  Future<List<ProductsDomain>> getNewInProducts();
  Future<ProductsDomain> getProductById(String productId);
}
