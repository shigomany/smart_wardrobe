part of 'models.dart';

@HiveType(typeId: 2)
class ClothingCategory extends HiveObject implements Equatable, BoxName {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;
  @HiveField(2)
  final List<String> tags;
  @HiveField(3)
  final List<ClothingCategory> subcategory;

  ClothingCategory({
    this.name,
    this.url,
    this.tags,
    this.subcategory,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, url, tags, subcategory];

  @override
  String get boxName => 'ClothingCategory';
}
