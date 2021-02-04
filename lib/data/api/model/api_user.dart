part of 'models.dart';

class ApiUser extends Equatable {
  final int id;
  final String name;
  final String username;
  final String password;
  final String email;
  
  ApiUser({
    this.id,
    this.name,
    this.username,
    this.password,
    this.email,
  });

  factory ApiUser.fromApi(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return ApiUser(
      id: map['id'] as int,
      name: map['name'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
    );
  }

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