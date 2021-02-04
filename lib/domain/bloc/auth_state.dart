part of 'auth.dart';

class AuthState extends Equatable {
  final List<Validator> validatorMessages;
  final User user;
  final bool isSubmiting;
  final bool isSuccess;
  final bool isFailure;
  final bool isLogout;

  const AuthState({
    this.validatorMessages,
    this.user,
    this.isSubmiting,
    this.isSuccess,
    this.isFailure,
    this.isLogout,
  });

  factory AuthState.initial() => const AuthState(
        isSubmiting: false,
        isSuccess: false,
        isFailure: false,
      );

  factory AuthState.loading() => const AuthState(
        validatorMessages: [],
        isSubmiting: true,
        isSuccess: false,
        isFailure: false,
      );

  factory AuthState.failure() => const AuthState(
        validatorMessages: [],
        isSubmiting: false,
        isSuccess: false,
        isFailure: true,
      );

  factory AuthState.invalid({List<Validator> validatorMessages}) => AuthState(
        validatorMessages: validatorMessages,
        isSubmiting: false,
        isSuccess: false,
        isFailure: true,
      );

  factory AuthState.success({@required User user}) => AuthState(
        validatorMessages: const [],
        isSubmiting: false,
        isSuccess: true,
        isFailure: false,
        user: user,
      );

  @override
  List<Object> get props => [];
}
