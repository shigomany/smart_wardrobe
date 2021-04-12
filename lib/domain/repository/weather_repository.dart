import 'package:flutter/material.dart';
import 'package:smartwardrobe/domain/model/models.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather({@required String city});
}
