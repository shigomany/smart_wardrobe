part of 'auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({@required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthState.initial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthLogin) {
      yield* _mapLoginToState(event);
    }
  }

  Stream<AuthState> _mapLoginToState(AuthLogin authLoginEvent) async* {
    yield AuthState.loading();
    try {
      final response = await _authRepository.signIn(
          username: authLoginEvent.username, password: authLoginEvent.password);

      if (response.value is User) {
        yield AuthState.success(user: response.value);
      } else {
        yield AuthState.invalid(
          validatorMessages: response.value as List<Validator>,
        );
      }
    } catch (_) {
      yield AuthState.failure();
    }
  }
}
