import 'package:smartwardrobe/domain/model/models.dart';

abstract class BrandRepository {
  Future<List<Brand>> getBrandList();
}
