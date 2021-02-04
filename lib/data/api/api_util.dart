import 'package:flutter/foundation.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/data/api/request/post_auth_body.dart';
import 'package:smartwardrobe/data/api/service/auth_service.dart';
import 'package:smartwardrobe/data/mapper/user_mapper.dart';
import 'package:smartwardrobe/data/mapper/validator_mapper.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:union/union.dart';

class ApiUtil {
  final AuthService _authService;

  ApiUtil(
    this._authService,
  );

  Future<Union2<User, List<Validator>>> signIn({
    @required String username,
    @required String password,
  }) async {
    final body = PostAuthBody(password: password, username: username);
    final result = await _authService.signIn(body);

    if (result.value is ApiUser) {
      final ApiUser user = result.value;
      return UserMapper.fromApi(user).asFirst();
    } else {
      return (result.value as List<ApiValidator>)
          .map(ValidatorMapper.fromApi)
          .toList()
          .asSecond();
    }
  }
}