import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smartwardrobe/data/api/model/api_weather.dart';
import 'package:smartwardrobe/util/constants.dart';

class WeatherSource {
  Dio _dio;
  final _headers = <String, String>{
    HttpHeaders.acceptHeader: 'application/json',
  };

  WeatherSource() {
    _dio = Dio(BaseOptions(
      baseUrl: weatherUri,
      sendTimeout: 5000, // 5s
      contentType: 'application/json; charset=UTF-8',
      followRedirects: false,
      headers: _headers,
      validateStatus: (status) => status <= 500,
    ));
  }

  Future<ApiWeather> fetchWeather(String city) async {
    final requestData = {
      'q': city,
      'appid': weatherAppId,
      'units': 'metric',
      'lang': 'ru',
    };
    final response = await _dio.get('/', queryParameters: requestData);

    return ApiWeather.fromApi(response.data);
  }
}
