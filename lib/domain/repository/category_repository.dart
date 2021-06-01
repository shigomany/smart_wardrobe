import 'package:smartwardrobe/domain/model/models.dart';

abstract class CategoryRepository {
  Future<List<ClothingCategory>> getCategoriesByGender(String gender);
}
