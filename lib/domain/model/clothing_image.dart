import 'package:equatable/equatable.dart';

class ClothingImage extends Equatable {
  final int id;
  final String brandName;
  final String itemName;
  bool isSelected;

  ClothingImage({
    this.id,
    this.brandName,
    this.itemName,
    this.isSelected = false,
  });

  ClothingImage copyWith({
    int id,
    String brandName,
    String itemName,
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
