import 'package:get_it/get_it.dart';
import 'package:smartwardrobe/data/api/datasource/auth_source.dart';
import 'package:smartwardrobe/data/api/datasource/clothing_source.dart';
import 'package:smartwardrobe/data/api/datasource/set_source.dart';
import 'package:smartwardrobe/data/api/datasource/weather_source.dart';
import 'package:smartwardrobe/data/repository/auth_data_repository.dart';
import 'package:smartwardrobe/data/repository/clothing_data_repository.dart';
import 'package:smartwardrobe/data/repository/set_data_repository.dart';
import 'package:smartwardrobe/data/repository/weather_data_repository.dart';
import 'package:smartwardrobe/domain/repository/auth_repository.dart';
import 'package:smartwardrobe/domain/repository/clothing_repository.dart';
import 'package:smartwardrobe/domain/repository/set_repository.dart';
import 'package:smartwardrobe/domain/repository/weather_repository.dart';
import 'package:smartwardrobe/domain/usecase/get_all_clothing.dart';
import 'package:smartwardrobe/domain/usecase/get_related_sets.dart';
import 'package:smartwardrobe/domain/usecase/post_new_clothing.dart';
import 'package:smartwardrobe/domain/usecase/get_weather.dart';
import 'package:smartwardrobe/internal/di/global.dart';
import 'package:smartwardrobe/presentation/bloc/auth.dart';
import 'package:smartwardrobe/presentation/bloc/clothing.dart';
import 'package:smartwardrobe/presentation/bloc/set.dart';
import 'package:smartwardrobe/presentation/bloc/weather.dart';

final sl = GetIt.instance;

void sources() {
  sl.registerFactory(() => WeatherSource());
  sl.registerFactory(() => AuthSource());
  sl.registerFactory(() => ClothingSource());
  sl.registerFactory(() => SetSource());
}

void repositories() {
  sl.registerFactory<WeatherRepository>(() => WetherRepositoryImpl(sl()));
  sl.registerFactory<AuthRepository>(() => AuthDataRepository(sl()));
  sl.registerFactory<ClothingRepository>(() => ClothingRepositoryImpl(sl()));
  sl.registerFactory<SetRepository>(() => SetRepositoryImpl(sl()));
}

void usecases() {
  sl.registerFactory(() => GetWeather(sl()));
  sl.registerFactory(() => GetAllClothing(sl()));
  sl.registerFactory(() => PostNewClothing(sl()));
  sl.registerFactory(() => GetRelatedSets(sl()));
}

void bloc() {
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(() => WeatherBloc(getWeatherCase: sl()));
  sl.registerFactory(
      () => ClothingBloc(getAllClothingCase: sl(), postNewClothingCase: sl()));
  sl.registerFactory(() => SetBloc(getRelatedSetsCase: sl()));
}

void setupInitial() {
  sources();
  repositories();
  usecases();
  bloc();

  GetIt.I.registerSingleton(GlobalDI());
}

void setupAfterRender() {}
