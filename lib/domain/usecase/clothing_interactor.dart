import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/clothing_repository.dart';
import 'package:union/union.dart';

class ClothingInteractor {
  final ClothingRepository repository;
  ClothingInteractor(this.repository);

  Future<List<Clothing>> getAllCLothing() async {
    final result = await repository.getAllClothing();

    result.forEach((element) {
      element.isSelected = false;
    });

    return result;
  }

  Future<Clothing> getClothingById(int id) async {
    final result = await repository.getClothingById(id);

    return result;
  }

  ///Получить вещь из CSV файла AdmitAD по ее id в URL
  Future<Union2<Clothing, List<Validator>>> getClothingFromLamoda(
      String id) async {
    final result = await repository.getClothingFromLamoda(id: id);

    if (result.value is Clothing) {
      Clothing clothing = result.value;
      return clothing.asFirst();
    } else {
      List<Validator> validators = result.value;
      return validators.asSecond();
    }
  }

  Future<Clothing> createClothing(Clothing value) async {
    final result = await repository.postNewClothing(clothing: value);

    result.isSelected = false;

    return result;
  }
}
