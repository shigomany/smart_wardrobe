part of 'models.dart';

@HiveType(typeId: 0)
class Clothing extends HiveObject implements Equatable, BoxName {
  
  @override
  String get boxName => 'Clothing';

  @HiveField(0)
  final int id;
  @HiveField(1)
  final ClothingCategory category;
  @HiveField(2)
  final ClothingCategory subCategory;
  @HiveField(3)
  final Brand brand;
  @HiveField(4)
  final String size;
  @HiveField(5)
  final String imageUrl;
  @HiveField(6)
  final String url;
  @HiveField(7)
  final int price;
  @HiveField(8)
  final List<String> seasons;

  bool isSelected;

  Clothing(
      {this.id,
      this.category,
      this.subCategory,
      this.brand,
      this.size,
      this.imageUrl,
      this.url,
      this.price,
      this.seasons,
      this.isSelected});

  @override
  bool get stringify => true;

  bool get isRemouteImage => RegExp(
          '(\b(https?|http)://)?[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]')
      .hasMatch(this.imageUrl);

  @override
  List<Object> get props {
    return [
      id,
      category,
      subCategory,
      brand,
      size,
      imageUrl,
      url,
      price,
      seasons,
      isSelected,
    ];
  }
}
