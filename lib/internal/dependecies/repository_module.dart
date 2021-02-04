import 'package:smartwardrobe/data/repository/auth_data_repository.dart';
import 'package:smartwardrobe/domain/repository/auth_repository.dart';
import 'package:smartwardrobe/internal/dependecies/api_module.dart';

class RepositoryModule {
  static AuthRepository _authRepository;

  static AuthRepository authRepository() =>
      _authRepository ??= AuthDataRepository(
        ApiModule.apiUtil(),
      );
}
