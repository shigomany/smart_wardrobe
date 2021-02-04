import 'package:flutter/foundation.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:union/union.dart';

abstract class AuthRepository {
  Future<Union2<User, List<Validator>>> signIn(
      {@required String username, @required String password});
}
