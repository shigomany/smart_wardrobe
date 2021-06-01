import 'package:smartwardrobe/data/api/datasource/category_source.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/category_repository.dart';

class CategoryRepostitoryImpl extends CategoryRepository {
  final CategorySource categoryService;

  CategoryRepostitoryImpl(this.categoryService);

  @override
  Future<List<ClothingCategory>> getCategoriesByGender(String gender) async {
    List<ApiCategory> result =
        await categoryService.getCategoriesByGender(gender);
    List<ClothingCategory> response =
        result.map((e) => e.toEntity()).cast<ClothingCategory>().toList();
    return response;
  }
}
