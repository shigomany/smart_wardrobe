import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/set_repository.dart';
import 'package:smartwardrobe/internal/usecase.dart';

///Получить список комплектов, в которых используется вещь с ID
class GetRelatedSets extends UseCase<int, List<Set>> {
  final SetRepository repository;

  GetRelatedSets(this.repository);

  @override
  Future<List<Set>> call(int id) async {
    final result = await repository.getRelatedSets(id);

    return result;
  }
}
