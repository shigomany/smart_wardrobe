import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/internal/usecase.dart';
import 'package:smartwardrobe/domain/repository/clothing_repository.dart';

class GetAllClothing extends UseCase<NoParams, List<Clothing>> {
  final ClothingRepository repository;

  GetAllClothing(this.repository);

  @override
  Future<List<Clothing>> call(NoParams value) async {
    final result = await repository.getAllClothing();

    //мутировать данные при необходимости тут

    result.forEach((element) {
      element.isSelected = false;
    });

    return result;
  }
}
