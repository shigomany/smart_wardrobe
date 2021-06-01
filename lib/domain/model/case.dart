part of 'models.dart';

class Case extends Equatable {
  final int id;
  final String name;

  Case({
    this.id,
    this.name,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}
