import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PostAuthBody extends Equatable {
  final String username;
  final String password;
  
  const PostAuthBody({
    @required this.username,
    @required this.password,
  });

  Map<String, dynamic> toApi() => <String, dynamic>{
    'username': username,
    'password': password
  };

  @override
  List<Object> get props => <Object>[username, password];

  @override
  bool get stringify => true;
}