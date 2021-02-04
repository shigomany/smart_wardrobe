part of 'models.dart';

class Validator extends Equatable {
  final String field;
  final String message;
  final String description;

  const Validator({
    @required this.field,
    @required this.message,
    @required this.description,
  });
  
  @override
  List<Object> get props => [field, message, description];

  @override
  bool get stringify => true;
}