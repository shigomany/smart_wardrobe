import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/domain/model/models.dart';

class UserMapper {
  static User fromApi(ApiUser apiUser) => User(
        id: apiUser.id,
        username: apiUser.username,
        email: apiUser.email,
        password: apiUser.password,
        name: apiUser.name,
      );
}