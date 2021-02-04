import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/domain/model/models.dart';

class ValidatorMapper {
  static Validator fromApi(ApiValidator apiValidator) => Validator(
        field: apiValidator.field,
        message: apiValidator.message,
        description: apiValidator.description,
      );
}