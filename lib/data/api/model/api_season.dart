part of 'models.dart';

class ApiSeason extends Equatable {
  final int id;
  final String name;
  ApiSeason({
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

  factory ApiSeason.fromApi(Map<String, dynamic> map) {
    if (map == null) return null;

    return ApiSeason(
      id: map['id'],
      name: map['name'],
    );
  }

  Season toEntity() => Season(
        id: id,
        name: name,
      );
}
