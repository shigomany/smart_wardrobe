import 'package:smartwardrobe/data/api/datasource/auth_source.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/data/mapper/validator_mapper.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/auth_repository.dart';
import 'package:union/union.dart';

class AuthDataRepository extends AuthRepository {
  final AuthSource authSource;

  AuthDataRepository(this.authSource);

  @override
  Future<Union2<User, List<Validator>>> signIn(
      {String username, String password}) async {
    final result =
        await authSource.signIn(username: username, password: password);

    if (result.value is ApiUser) {
      final ApiUser user = result.value;
      return user.toEntity().asFirst();
    } else {
      return (result.value as List<ApiValidator>)
          .map(ValidatorMapper.fromApi)
          .toList()
          .asSecond();
    }
  }
}
