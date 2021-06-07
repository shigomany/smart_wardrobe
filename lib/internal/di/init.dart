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
import 'package:smartwardrobe/domain/usecase/get_all_clothing.dart';
import 'package:smartwardrobe/domain/usecase/get_brand_list.dart';
import 'package:smartwardrobe/domain/usecase/get_categories_by_gender.dart';
import 'package:smartwardrobe/domain/usecase/get_clothing_by_id.dart';
import 'package:smartwardrobe/domain/usecase/get_clothing_from_lamoda.dart';
import 'package:smartwardrobe/domain/usecase/get_related_sets.dart';
import 'package:smartwardrobe/domain/usecase/post_new_clothing.dart';
import 'package:smartwardrobe/domain/usecase/get_weather.dart';
import 'package:smartwardrobe/internal/di/global.dart';
import 'package:smartwardrobe/presentation/bloc/auth.dart';
import 'package:smartwardrobe/presentation/bloc/brand.dart';
import 'package:smartwardrobe/presentation/bloc/category.dart';
import 'package:smartwardrobe/presentation/bloc/clothing.dart';
import 'package:smartwardrobe/presentation/bloc/image_file.dart';
import 'package:smartwardrobe/presentation/bloc/set.dart';
import 'package:smartwardrobe/presentation/bloc/weather.dart';

final sl = GetIt.instance;

void sources() {
  sl.registerFactory(() => WeatherSource());
  sl.registerFactory(() => AuthSource());
  sl.registerFactory(() => ClothingSource());
  sl.registerFactory(() => SetSource());
  sl.registerFactory(() => CategorySource());
  sl.registerFactory(() => BrandSource());
  sl.registerFactory(() => ImageFileSource());
}

void repositories() {
  sl.registerFactory<WeatherRepository>(() => WeatherRepositoryImpl(sl()));
  sl.registerFactory<AuthRepository>(() => AuthDataRepository(sl()));
  sl.registerFactory<ClothingRepository>(() => ClothingRepositoryImpl(sl()));
  sl.registerFactory<SetRepository>(() => SetRepositoryImpl(sl()));
  sl.registerFactory<CategoryRepository>(() => CategoryRepostitoryImpl(sl()));
  sl.registerFactory<BrandRepository>(() => BrandRepositoryImpl(sl()));
  sl.registerFactory<ImageFileRepository>(() => ImageFileRepositoryImpl(sl()));
}

void usecases() {
  sl.registerFactory(() => GetWeather(sl()));
  sl.registerFactory(() => GetAllClothing(sl()));
  sl.registerFactory(() => PostNewClothing(sl()));
  sl.registerFactory(() => GetRelatedSets(sl()));
  sl.registerFactory(() => GetClothingById(sl()));
  sl.registerFactory(() => GetCategoriesByGender(sl()));
  sl.registerFactory(() => GetBrandList(sl()));
  sl.registerFactory(() => ClearBackground(sl()));
  sl.registerFactory(() => GetClothingFromLamoda(sl()));
}

void bloc() {
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(() => WeatherBloc(getWeatherCase: sl()));
  sl.registerFactory(() => ClothingBloc(
      getAllClothingCase: sl(),
      postNewClothingCase: sl(),
      getClothingById: sl(),
      getClothingFromLamoda: sl()));
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
}

void setupAfterRender() {}
