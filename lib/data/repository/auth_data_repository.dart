import 'package:smartwardrobe/data/api/api_util.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/auth_repository.dart';
import 'package:tuple/tuple.dart';
import 'package:union/union.dart';

class AuthDataRepository extends AuthRepository {
  final ApiUtil _apiUtil;

  AuthDataRepository(this._apiUtil);

  @override
  Future<Union2<User, List<Validator>>> signIn(
      {String username, String password}) => _apiUtil.signIn(username: username, password: password);
}