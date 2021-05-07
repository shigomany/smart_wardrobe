import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:smartwardrobe/presentation/view_models/clothing.dart';

import 'package:smartwardrobe/domain/model/case.dart';
import 'package:smartwardrobe/domain/model/season.dart';

part 'clothing.freezed.dart';

@freezed
abstract class Clothing with _$Clothing {
  const Clothing._();

  const factory Clothing.listCardClothing(
      {@required int id,
      @required String category,
      @required String subCategory,
      @required String brand,
      @required String size,
      @required String imageUrl,
      @required String url,
      @required int price,
      @required List<String> seasons,
      @Default(false) bool isSelected}) = _ListCardClothing;

  const factory Clothing.listCardSet(
      {@required int id,
      @required String name,
      @required String description,
      @required String imgUrl,
      @required int minTemp,
      @required int maxTemp,
      @required List<Clothing> clothes,
      @required List<Case> cases,
      @required List<Season> seasons,
      @Default(false) bool isSelected}) = _ListCardSet;
}
// class Clothing extends Equatable {
//   final int id;
//   final String category;
//   final String subCategory;
//   final String brand;
//   final String size;
//   final String imageUrl;
//   final String url;
//   final int price;
//   final List<String> seasons;

//   bool isSelected;

//   Clothing(
//       {this.id,
//       this.category,
//       this.subCategory,
//       this.brand,
//       this.size,
//       this.imageUrl,
//       this.url,
//       this.price,
//       this.seasons,
//       this.isSelected});

//   ViewClothing get asViewClothing => ViewClothing(
//       id: id,
//       cardName: "$brand $subCategory",
//       imageUrl: imageUrl,
//       isSelected: false);

//   @override
//   bool get stringify => true;

//   @override
//   List<Object> get props {
//     return [
//       id,
//       category,
//       subCategory,
//       brand,
//       size,
//       imageUrl,
//       url,
//       price,
//       seasons,
//       isSelected,
//     ];
//   }
// }
