part of 'models.dart';

class Set extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final int minTemp;
  final int maxTemp;
  final List<Clothing> clothes;
  final List<Case> cases;
  final List<Season> seasons;

  Set({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.minTemp,
    this.maxTemp,
    this.clothes,
    this.cases,
    this.seasons,
  });

  ViewClothing get asViewClothing => ViewClothing(
      id: id, cardName: name, imageUrl: imageUrl, isSelected: false);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      minTemp,
      maxTemp,
      cases,
      seasons,
    ];
  }
}
