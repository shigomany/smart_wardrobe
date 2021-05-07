import 'package:equatable/equatable.dart';

class ViewClothing extends Equatable {
  final int id;
  final String cardName;
  final String imageUrl;

  bool isSelected;

  ViewClothing({
    this.id,
    this.cardName,
    this.imageUrl,
    this.isSelected,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      cardName,
      imageUrl,
      isSelected,
    ];
  }
}
