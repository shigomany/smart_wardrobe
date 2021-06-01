import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/clothing_repository.dart';
import 'package:smartwardrobe/internal/usecase.dart';

///Получить с бэка вещь по ID
class GetClothingById extends UseCase<int, Clothing> {
  final ClothingRepository repository;

  GetClothingById(this.repository);

  @override
  Future<Clothing> call(int id) async {
    final result = await repository.getClothingById(id);

    return result;
  }
}
