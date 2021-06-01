part of 'models.dart';

class Season extends Equatable {
  final int id;
  final String name;

  Season({
    this.id,
    this.name,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}
