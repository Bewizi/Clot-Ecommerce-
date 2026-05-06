import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:clot/features/home/domain/categories_domain.dart';
import 'package:clot/features/home/domain/categories_repository.dart';

class CategoriesDataImpl implements CategoriesRepository {
  @override
  Future<List<CategoriesDomain>> getCategories() async {
    try {
      final response = await supaBase
          .schema('clot')
          .from('categories')
          .select('id, name, image_url')
          .order('created_at', ascending: true);

      return (response as List<dynamic>)
          .map((e) => CategoriesDomain.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }
}
