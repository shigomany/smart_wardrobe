import 'package:smartwardrobe/domain/model/models.dart';

abstract class SetRepository {
  Future<List<Set>> getRelatedSets(int id);
}
