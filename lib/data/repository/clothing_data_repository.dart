import 'package:smartwardrobe/data/api/datasource/clothing_source.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/clothing_repository.dart';

class ClothingRepositoryImpl extends ClothingRepository {
  final ClothingSource clothingService;
  ClothingRepositoryImpl(this.clothingService);

  @override
  Future<Clothing> postNewClothing({Clothing clothing}) async {
    final result = await clothingService.postNewClothing(clothing);

    final response = result.toEntity();

    return response;
  }

  @override
  Future<List<Clothing>> getAllClothing() async {
    final result = await clothingService.getAllClothing();
    final list = result.map((e) => e.toEntity()).cast<Clothing>().toList();

    return list;
  }

  @override
  Future<Clothing> getClothingById(int id) async {
    final result = await clothingService.getClothingById(id);

    final item = result.toEntity();

    return item;
  }
}
