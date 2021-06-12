part of 'models.dart';

@HiveType(typeId: 1)
class Set extends HiveObject implements Equatable {
  static String get boxName => 'Set';

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final int minTemp;
  @HiveField(5)
  final int maxTemp;
  @HiveField(6)
  final List<Clothing> clothes;
  @HiveField(7)
  final List<Case> cases;
  @HiveField(8)
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
