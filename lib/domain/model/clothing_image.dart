import 'package:equatable/equatable.dart';

class ClothingImage extends Equatable {
  final int id;
  final String brandName;
  final String itemName;
  final String size;
  final String url;
  bool isSelected;

  ClothingImage({
    this.id,
    this.brandName,
    this.itemName,
    this.size,
    this.url,
    this.isSelected = false,
  });

  ClothingImage copyWith({
    int id,
    String brandName,
    String itemName,
    String size,
    String url,
    bool isSelected,
  }) {
    return ClothingImage(
      id: id ?? this.id,
      brandName: brandName ?? this.brandName,
      itemName: itemName ?? this.itemName,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        brandName,
        itemName,
        isSelected,
      ];
}
