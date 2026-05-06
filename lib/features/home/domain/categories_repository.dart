import 'package:clot/features/home/domain/categories_domain.dart';

abstract class CategoriesRepository {
  Future<List<CategoriesDomain>> getCategories();
}
