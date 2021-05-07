part of 'models.dart';

class ApiCase extends Equatable {
  final int id;
  final String name;
  ApiCase({
    this.id,
    this.name,
  });

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ApiCase.fromApi(Map<String, dynamic> map) {
    if (map == null) return null;

    return ApiCase(
      id: map['id'],
      name: map['name'],
    );
  }

  Case toEntity() => Case(
        id: id,
        name: name,
      );
}
