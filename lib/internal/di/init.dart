import 'package:get_it/get_it.dart';
import 'package:smartwardrobe/data/api/datasource/auth_source.dart';
import 'package:smartwardrobe/data/api/datasource/brand_source.dart';
import 'package:smartwardrobe/data/api/datasource/category_source.dart';
import 'package:smartwardrobe/data/api/datasource/clothing_source.dart';
import 'package:smartwardrobe/data/api/datasource/image_file_source.dart';
import 'package:smartwardrobe/data/api/datasource/set_source.dart';
import 'package:smartwardrobe/data/api/datasource/weather_source.dart';
import 'package:smartwardrobe/data/repository/auth_data_repository.dart';
import 'package:smartwardrobe/data/repository/brand_data_repository.dart';
import 'package:smartwardrobe/data/repository/clothing_data_repository.dart';
import 'package:smartwardrobe/data/repository/category_data_repository.dart';
import 'package:smartwardrobe/data/repository/image_file_data_repository.dart';
import 'package:smartwardrobe/data/repository/set_data_repository.dart';
import 'package:smartwardrobe/data/repository/weather_data_repository.dart';
import 'package:smartwardrobe/domain/repository/auth_repository.dart';
import 'package:smartwardrobe/domain/repository/brand_repository.dart';
import 'package:smartwardrobe/domain/repository/category_repository.dart';
import 'package:smartwardrobe/domain/repository/clothing_repository.dart';
import 'package:smartwardrobe/domain/repository/image_file_repository.dart';
import 'package:smartwardrobe/domain/repository/set_repository.dart';
import 'package:smartwardrobe/domain/repository/weather_repository.dart';
import 'package:smartwardrobe/domain/usecase/clear_bg.dart';
import 'package:smartwardrobe/domain/usecase/clothing_interactor.dart';
import 'package:smartwardrobe/domain/usecase/get_brand_list.dart';
import 'package:smartwardrobe/domain/usecase/get_categories_by_gender.dart';
import 'package:smartwardrobe/domain/usecase/get_related_sets.dart';
import 'package:smartwardrobe/domain/usecase/get_weather.dart';
import 'package:smartwardrobe/internal/di/global.dart';
import 'package:smartwardrobe/internal/di/hive.dart';
import 'package:smartwardrobe/presentation/bloc/auth.dart';
import 'package:smartwardrobe/presentation/bloc/brand.dart';
import 'package:smartwardrobe/presentation/bloc/category.dart';
import 'package:smartwardrobe/presentation/bloc/clothing.dart';
import 'package:smartwardrobe/presentation/bloc/image_file.dart';
import 'package:smartwardrobe/presentation/bloc/set.dart';
import 'package:smartwardrobe/presentation/bloc/weather.dart';

final sl = GetIt.I;

void sources() {
  GetIt.I.registerFactory(() => WeatherSource());
  GetIt.I.registerFactory(() => AuthSource());
  GetIt.I.registerFactory(() => ClothingSource());
  GetIt.I.registerFactory(() => SetSource());
  GetIt.I.registerFactory(() => CategorySource());
  GetIt.I.registerFactory(() => BrandSource());
  GetIt.I.registerFactory(() => ImageFileSource());
}

void repositories() {
  GetIt.I.registerFactory<WeatherRepository>(
      () => WeatherRepositoryImpl(GetIt.I()));
  GetIt.I.registerFactory<AuthRepository>(() => AuthDataRepository(GetIt.I()));
  GetIt.I.registerFactory<ClothingRepository>(
      () => ClothingRepositoryImpl(GetIt.I()));
  GetIt.I.registerFactory<SetRepository>(() => SetRepositoryImpl(GetIt.I()));
  GetIt.I.registerFactory<CategoryRepository>(
      () => CategoryRepostitoryImpl(GetIt.I()));
  GetIt.I
      .registerFactory<BrandRepository>(() => BrandRepositoryImpl(GetIt.I()));
  GetIt.I.registerFactory<ImageFileRepository>(
      () => ImageFileRepositoryImpl(GetIt.I()));
}

void usecases() {
  sl.registerFactory(() => ClothingInteractor(sl()));
  sl.registerFactory(() => GetWeather(sl()));
  sl.registerFactory(() => GetRelatedSets(sl()));
  sl.registerFactory(() => GetCategoriesByGender(sl()));
  sl.registerFactory(() => GetBrandList(sl()));
  sl.registerFactory(() => ClearBackground(sl()));
}

void bloc() {
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(() => WeatherBloc(getWeatherCase: sl()));
  sl.registerFactory(() => ClothingBloc(sl()));
  sl.registerFactory(() => SetBloc(getRelatedSetsCase: sl()));
  sl.registerFactory(() => CategoryBloc(getCategoriesByGender: sl()));
  sl.registerFactory(() => BrandBloc(getBrandList: sl()));
  sl.registerFactory(() => ImageFileBloc(clearBackground: sl()));
}

void setupInitial() {
  sources();
  repositories();
  usecases();
  bloc();

  GetIt.I.registerSingleton(GlobalDI());
  GetIt.I.registerSingletonAsync(() => HiveDI.initDI());
}

void setupAfterRender() {}
