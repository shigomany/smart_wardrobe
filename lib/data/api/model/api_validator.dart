part of 'models.dart';

class ApiValidator extends Equatable {
  final String field;
  final String message;
  final String description;

  const ApiValidator({
    @required this.field,
    @required this.message,
    @required this.description,
  });

  
  @override
  List<Object> get props => [field, message, description];

  factory ApiValidator.fromApi(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
  
    return ApiValidator(
      field: map['field'] as String,
      message: map['message'] as String,
      description: map['description'] as String,
    );
  }

  @override
  bool get stringify => true;
}
