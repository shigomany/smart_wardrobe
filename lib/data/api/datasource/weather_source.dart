import 'package:smartwardrobe/data/api/datasource/base_source.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/util/constants.dart';

class WeatherSource extends BaseSource {
  Future<ApiWeather> fetchWeather(String city) async {
    final requestData = {
      'q': city,
      'appid': weatherAppId,
      'units': 'metric',
      'lang': 'ru',
    };
    final response = await dio.get('/', queryParameters: requestData);

    return ApiWeather.fromApi(response.data);
  }
}
