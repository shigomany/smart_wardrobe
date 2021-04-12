//part of 'models.dart'

import 'package:equatable/equatable.dart';
import 'package:smartwardrobe/domain/model/models.dart';

class ApiWeather extends Equatable {
  final double feelsTemp;
  final double temp;
  final String description;
  final String iconCode;

  ApiWeather({
    this.feelsTemp,
    this.temp,
    this.description,
    this.iconCode,
  });

  factory ApiWeather.fromApi(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return ApiWeather(
      feelsTemp: double.tryParse(map["main"]["feels_like"].toString()),
      temp: double.tryParse(map["main"]["temp"].toString()),
      description: map['weather'][0]['description'],
      iconCode: map["weather"][0]["icon"],
    );
  }

  Weather toEntity() => Weather(
        feelsTemp: feelsTemp,
        temp: temp,
        description: description,
        iconCode: iconCode,
      );

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      feelsTemp,
      temp,
      description,
      iconCode,
    ];
  }
}
