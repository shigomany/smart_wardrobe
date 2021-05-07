import 'package:smartwardrobe/domain/model/models.dart';

abstract class ClothingRepository {
  Future<List<Clothing>> getAllClothing();

  Future<Clothing> postNewClothing({Clothing clothing});
}
