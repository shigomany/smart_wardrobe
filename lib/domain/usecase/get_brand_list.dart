import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/internal/usecase.dart';
import 'package:smartwardrobe/domain/repository/brand_repository.dart';

class GetBrandList extends UseCase<NoParams, List<Brand>> {
  final BrandRepository repository;

  GetBrandList(this.repository);

  @override
  Future<List<Brand>> call(NoParams value) async {
    final result = await repository.getBrandList();

    //мутировать данные при необходимости тут

    return result;
  }
}
