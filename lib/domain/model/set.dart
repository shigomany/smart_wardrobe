import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:smartwardrobe/presentation/view_models/clothing.dart';
import 'package:smartwardrobe/domain/model/clothing.dart';
import 'package:smartwardrobe/domain/model/case.dart';
import 'package:smartwardrobe/domain/model/season.dart';

class Set extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imgUrl;
  final int minTemp;
  final int maxTemp;
  final List<Clothing> clothes;
  final List<Case> cases;
  final List<Season> seasons;

  Set({
    this.id,
    this.name,
    this.description,
    this.imgUrl,
    this.minTemp,
    this.maxTemp,
    this.clothes,
    this.cases,
    this.seasons,
  });

  ViewClothing get asViewClothing =>
      ViewClothing(id: id, cardName: name, imageUrl: imgUrl, isSelected: false);

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
