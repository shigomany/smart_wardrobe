part of 'models.dart';

@HiveType(typeId: 3)
class Brand extends HiveObject implements Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;

  Brand({
    this.name,
    this.url,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [url, name];
}
