part of 'models.dart';

class ApiSet extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final int minTemp;
  final int maxTemp;
  final List<Clothing> clothes;
  final List<Case> cases;
  final List<Season> seasons;

  ApiSet({
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

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      imageUrl,
      minTemp,
      maxTemp,
      clothes,
      cases,
      seasons,
    ];
  }

  @override
  bool get stringify => true;

  factory ApiSet.fromApi(Map<String, dynamic> map) {
    if (map == null) return null;

    List<ApiClothing> clothes = List<ApiClothing>.from(
        map['clothes'].map((clothing) => ApiClothing.fromApi(clothing)));

    List<ApiCase> cases =
        List<ApiCase>.from(map['cases'].map((e) => ApiCase.fromApi(e)));

    List<ApiSeason> seasons =
        List<ApiSeason>.from(map['seasons'].map((e) => ApiSeason.fromApi(e)));

    //TODO:в JSON set.json файле переделать seasons под класс и заменить
    //нулевой id при маппинге
    return ApiSet(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imgUrl'],
      minTemp: int.tryParse(map['minTemp']) ?? 0,
      maxTemp: int.tryParse(map['maxTemp']) ?? 0,
      clothes: clothes.map((e) => e.toEntity()).cast<Clothing>().toList(),
      cases: cases.map((e) => e.toEntity()).cast<Case>().toList(),
      seasons: seasons.map((e) => e.toEntity()).cast<Season>().toList(),
    );
  }

  Set toEntity() => Set(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      minTemp: minTemp,
      maxTemp: maxTemp,
      clothes: clothes,
      cases: cases,
      seasons: seasons);
}
