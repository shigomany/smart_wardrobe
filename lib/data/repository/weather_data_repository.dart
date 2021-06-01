import 'package:smartwardrobe/data/api/datasource/weather_source.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherSource weatherSource;
  WeatherRepositoryImpl(this.weatherSource);

  @override
  Future<Weather> getWeather({String city}) async {
    final result = await weatherSource.fetchWeather(city);

    return result.toEntity();
  }
}
