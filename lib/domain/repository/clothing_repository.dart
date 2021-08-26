import 'package:flutter/foundation.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:union/union.dart';

abstract class ClothingRepository {
  Future<List<Clothing>> getAllClothing();

  Future<Clothing> postNewClothing({Clothing clothing});

  Future<Clothing> getClothingById(int id);

  Future<Union2<Clothing, List<Validator>>> getClothingFromLamoda(
      {@required String id});
}
