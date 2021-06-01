import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/category_repository.dart';
import 'package:smartwardrobe/internal/usecase.dart';

class GetCategoriesByGender extends UseCase<String, List<ClothingCategory>> {
  final CategoryRepository repository;

  GetCategoriesByGender(this.repository);

  @override
  Future<List<ClothingCategory>> call(String gender) async {
    final result = await repository.getCategoriesByGender(gender);

    return result;
  }
}
