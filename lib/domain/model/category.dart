part of 'models.dart';

class ClothingCategory extends Equatable {
  final String name;
  final String url;
  final List<String> tags;
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
}
