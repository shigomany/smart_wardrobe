import 'package:dio/dio.dart';
import 'package:smartwardrobe/internal/usecase.dart';

import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/clothing_repository.dart';
import 'package:smartwardrobe/internal/usecase.dart';

class PostNewClothing implements UseCase<Clothing, Clothing> {
  final ClothingRepository repository;

  PostNewClothing(this.repository);

  @override
  Future<Clothing> call(Clothing value) async {
    final result = await repository.postNewClothing(clothing: value);

    result.isSelected = false;

    return result;
  }
}
