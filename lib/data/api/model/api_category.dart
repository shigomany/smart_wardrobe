part of 'models.dart';

class ApiCategory extends Equatable {
  final String name;
  final String url;
  final List<String> tags;
  final List<ApiCategory> subcategory;

  ApiCategory({this.name, this.url, this.tags, this.subcategory});

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, url, subcategory];

  factory ApiCategory.fromApi(Map<String, dynamic> map) {
    if (map == null) return null;

    return ApiCategory(
        name: map["name"],
        url: map["URL"],
        tags: List<String>.from(map["tags"].map((x) => x)),
        subcategory: List<ApiCategory>.from(
            map["subcategory"].map((x) => ApiCategory.fromApi(x))));
  }

  ClothingCategory toEntity() => ClothingCategory(
      name: name,
      url: url,
      tags: tags,
      subcategory: subcategory.map((e) => e.toEntity()).toList());
}
