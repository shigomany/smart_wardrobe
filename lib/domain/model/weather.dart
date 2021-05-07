import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:smartwardrobe/presentation/view_models/clothing.dart';

class Weather extends Equatable {
  final double feelsTemp;
  final double temp;
  final String description;
  final String iconCode;
  DateTime lastUpdated;

  Weather({
    this.feelsTemp,
    this.temp,
    this.lastUpdated,
    this.description,
    this.iconCode,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [feelsTemp, temp, lastUpdated, description, iconCode];
  }
}
