import 'package:smartwardrobe/data/api/datasource/brand_source.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/brand_repository.dart';
import 'package:smartwardrobe/domain/usecase/get_brand_list.dart';

class BrandRepositoryImpl extends BrandRepository {
  final BrandSource brandService;
  BrandRepositoryImpl(this.brandService);

  @override
  Future<List<Brand>> getBrandList() async {
    final result = await brandService.getBrandList();

    final list = result.map((e) => e.toEntity()).cast<Brand>().toList();

    return list;
  }
}
