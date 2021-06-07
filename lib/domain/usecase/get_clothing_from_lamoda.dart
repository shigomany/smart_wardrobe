import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/clothing_repository.dart';
import 'package:smartwardrobe/internal/usecase.dart';
import 'package:union/union.dart';

///Получить вещь из CSV файла AdmitAD по ее id в URL
class GetClothingFromLamoda
    extends UseCase<String, Union2<Clothing, List<Validator>>> {
  final ClothingRepository repository;

  GetClothingFromLamoda(this.repository);

  @override
  Future<Union2<Clothing, List<Validator>>> call(String id) async {
    final result = await repository.getClothingFromLamoda(id: id);

    if (result.value is Clothing) {
      Clothing clothing = result.value;
      return clothing.asFirst();
    } else {
      List<Validator> validators = result.value;
      return validators.asSecond();
    }
  }
}
