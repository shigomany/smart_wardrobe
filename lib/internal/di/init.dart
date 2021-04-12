import 'package:get_it/get_it.dart';
import 'package:smartwardrobe/data/api/datasource/auth_source.dart';
import 'package:smartwardrobe/data/api/datasource/weather_source.dart';
import 'package:smartwardrobe/data/repository/auth_data_repository.dart';
import 'package:smartwardrobe/data/repository/weather_data_repository.dart';
import 'package:smartwardrobe/domain/repository/auth_repository.dart';
import 'package:smartwardrobe/domain/repository/weather_repository.dart';
import 'package:smartwardrobe/domain/usecase/get_weather.dart';
import 'package:smartwardrobe/internal/di/global.dart';
import 'package:smartwardrobe/presentation/bloc/auth.dart';
import 'package:smartwardrobe/presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;

void sources() {
  sl.registerFactory(() => WeatherSource());
  sl.registerFactory(() => AuthSource());
}

void repositories() {
  sl.registerFactory<WeatherRepository>(() => WetherRepositoryImpl(sl()));
  sl.registerFactory<AuthRepository>(() => AuthDataRepository(sl()));
}

void usecases() {
  sl.registerFactory(() => GetWeather(sl()));
}

void bloc() {
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(() => WeatherBloc(getWeatherCase: sl()));
}

void setupInitial() {
  sources();
  repositories();
  usecases();
  bloc();

  GetIt.I.registerSingleton(GlobalDI());
}

void setupAfterRender() {}
