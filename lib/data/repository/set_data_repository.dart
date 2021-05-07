import 'package:smartwardrobe/data/api/datasource/set_source.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/set_repository.dart';

class SetRepositoryImpl extends SetRepository {
  final SetSource setService;
  SetRepositoryImpl(this.setService);

  @override
  Future<List<Set>> getRelatedSets(int id) async {
    final result = await setService.getRelatedSets(id);

    final list = result.map((e) => e.toEntity()).cast<Set>().toList();

    return list;
  }
}
