import 'package:smartwardrobe/domain/bloc/auth.dart';
import 'package:smartwardrobe/internal/dependecies/repository_module.dart';

class MainModule {
  static AuthBloc authBloc() => AuthBloc(
        authRepository: RepositoryModule.authRepository(),
      );
}