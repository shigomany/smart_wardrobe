import 'package:smartwardrobe/data/api/datasource/clothing_source.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/data/mapper/validator_mapper.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/clothing_repository.dart';
import 'package:union/union.dart';

class ClothingRepositoryImpl extends ClothingRepository {
  final ClothingSource clothingService;
  ClothingRepositoryImpl(this.clothingService);

  @override
  Future<Clothing> postNewClothing({Clothing clothing}) async {
    final result = await clothingService.postNewClothing(clothing);

    if (result.value is ApiClothing) {
      final response = result.value as ApiClothing;
      return response.toEntity();
    }
    return result.value as Clothing;
  }

  @override
  Future<List<Clothing>> getAllClothing() async {
    final result = await clothingService.getAllClothing();
    if (result.value is List<Clothing>)
      return result.value as List<Clothing>;
    else {
      final list = result.value as List<ApiClothing>;

      final clothingList =
          list.map((e) => e.toEntity()).cast<Clothing>().toList();

      return clothingList;
    }
  }

  @override
  Future<Clothing> getClothingById(int id) async {
    final result = await clothingService.getClothingById(id);

    final item = result.toEntity();

    return item;
  }

  @override
  Future<Union2<Clothing, List<Validator>>> getClothingFromLamoda(
      {String id}) async {
    final result = await clothingService.getClothingFromLamoda(id);

    if (result.value is ApiClothing) {
      final ApiClothing clothing = result.value;
      return clothing.toEntity().asFirst();
    } else {
      return (result.value as List<ApiValidator>)
          .map(ValidatorMapper.fromApi)
          .toList()
          .asSecond();
    }
  }
}
