part of 'models.dart';

class ApiClothing extends Equatable {
  final int id;
  final ApiCategory category;
  final ApiCategory subCategory;
  final ApiBrand brand;
  final String size;
  final String imageUrl;
  final String url;
  final int price;

  final List<String> seasons;

  ApiClothing(
      {this.id,
      this.category,
      this.subCategory,
      this.brand,
      this.size,
      this.imageUrl,
      this.url,
      this.price,
      this.seasons});

  factory ApiClothing.fromApi(Map<String, dynamic> map) {
    if (map == null) return null;
    print(map['subCategory']);
    //List<ApiSeason> seasons =
    //    List<ApiSeason>.from(map['seasons'].map((e) => ApiSeason.fromApi(e)));

    //TODO:маппинг брендов
    //TODO: разобраться - должны ли быть Seasons, а не ApiSeasons
    return ApiClothing(
      id: map['id'],
      category: ApiCategory.fromApi(map['category']),
      subCategory: ApiCategory.fromApi(map['subCategory']),
      brand: ApiBrand.fromApi(map['brand']),
      size: map['size'],
      imageUrl: map['image_url'],
      url: map['url'],
      price: map['price'],
      seasons: List<String>.from(map["seasons"].map((x) => x)),
      //seasons: seasons.map((e) => e.toEntity()).cast<Season>().toList(),
    );
  }

  Map<String, dynamic> toJson(Clothing clothing) {
    return {
      "category": clothing.category == null ? null : clothing.category,
      "subCategory": clothing.subCategory == null ? null : clothing.subCategory,
      "brand": clothing.brand == null ? null : clothing.brand,
      "size": clothing.size == null ? null : clothing.size,
      "imageUrl": clothing.imageUrl == null ? null : clothing.imageUrl,
      "url": clothing.url == null ? null : clothing.url,
      "price": clothing.price == null ? null : clothing.price
    };
  }

  Clothing toEntity() => Clothing(
      id: id,
      category: category.toEntity(),
      subCategory: subCategory.toEntity(),
      brand: brand.toEntity(),
      size: size,
      imageUrl: imageUrl,
      url: url,
      price: price,
      seasons: seasons);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [id, category, subCategory, brand, size, imageUrl, price, seasons];
  }
}
