import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/domain/repository/weather_repository.dart';
import 'package:smartwardrobe/internal/usecase.dart';

class GetWeather extends UseCase<String, Weather> {
  final WeatherRepository repository;

  GetWeather(this.repository);

  @override
  Future<Weather> call(String value) async {
    final result = await repository.getWeather(city: value);
    result.lastUpdated = DateTime.now();

    return result;
  }
}
