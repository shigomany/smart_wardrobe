part of 'models.dart';

class Clothing extends Equatable {
  final int id;
  final ClothingCategory category;
  final ClothingCategory subCategory;
  final Brand brand;
  final String size;
  final String imageUrl;
  final String url;
  final int price;
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

  ViewClothing get asViewClothing => ViewClothing(
      id: id,
      cardName: brand.name + ' ' + subCategory.name,
      imageUrl: imageUrl,
      isSelected: isSelected);

  @override
  bool get stringify => true;

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
