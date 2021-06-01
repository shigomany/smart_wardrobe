part of 'models.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String username;
  final String password;
  final String email;

  User({
    this.id,
    this.name,
    this.username,
    this.password,
    this.email,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      username,
      password,
      email,
    ];
  }
}
