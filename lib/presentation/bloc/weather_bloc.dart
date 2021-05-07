part of 'weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeatherCase;

  WeatherBloc({
    this.getWeatherCase,
  }) : super(WeatherInitial());

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherInfo) {
      yield WeatherLodaing();

      final result = await getWeatherCase(event.city);

      yield (WeatherLoaded(weather: result));
    }
  }
}
