import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:smartwardrobe/data/api/datasource/base_source.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/internal/di/hive.dart';
import 'package:smartwardrobe/resources/resources.dart';
import 'package:smartwardrobe/util/constants.dart';
import 'package:union/union.dart';

class ClothingSource extends BaseSource {
  Future<Union2<List<ApiClothing>, List<Clothing>>> getAllClothing() async {
    //Пока нет бэка - эмуляция отсутствия инета для работы с локальной базой
    //bool connection = await DataConnectionChecker().hasConnection;
    bool connection = true;
    if (connection) {
      if (IS_DEV_VER) {
        final response =
            await json.decode(await rootBundle.loadString(MockPaths.clothing));
        if (response is List) {
          return response.map((e) => ApiClothing.fromApi(e)).toList().asFirst();
        }
        return [ApiClothing.fromApi(response)].asFirst();
      }
      final response = await dio.get('clothing/all_clothing');
      if (response.statusCode == 201) {
        if (response is List) {
          return response.data
              .map((e) => ApiClothing.fromApi(e))
              .toList()
              .asFirst();
        }
        return [ApiClothing.fromApi(response.data)].asFirst();
      }
    }
    await GetIt.I.isReady<HiveDI>();
    final clothingBox =
        await GetIt.I<HiveDI>().getOrOpen<Clothing>(Clothing.boxName);

    return clothingBox.values.toList().asSecond();
  }

  Future<ApiClothing> getClothingById(int id) async {
    final response =
        await json.decode(await rootBundle.loadString(MockPaths.clothing_one));

    return ApiClothing.fromApi(response);
  }

  Future<Union2<Clothing, ApiClothing>> postNewClothing(
      Clothing clothing) async {
    bool networkConnection = await DataConnectionChecker().hasConnection;

    if (networkConnection) {
      if (IS_DEV_VER) {
        final response = await json
            .decode(await rootBundle.loadString(MockPaths.clothing_one));
        return ApiClothing.fromApi(response).asSecond();
      }

      final data = ApiClothing().toJson(clothing);
      final response = await dio.post('clothing/post_new_clothing',
          data: FormData.fromMap(data));
      return ApiClothing.fromApi(response.data).asSecond();
    }

    await GetIt.I.isReady<HiveDI>();
    final clothingBox =
        await GetIt.I<HiveDI>().getOrOpen<Clothing>(Clothing.boxName);
    clothingBox.add(clothing);
    return clothing.asFirst();
  }

  Future<Union2<ApiClothing, List<ApiValidator>>> getClothingFromLamoda(
      String id) async {
    //TODO:когда будет бэк раскоментить
    //final requestData = {'id': id};
    //final response = await _dio.post('/api/v1/clothing/fetch_from_lamoda',
    //    data: jsonEncode(requestData));
    //TODO:когда будет бэк убрать
    final response = await json
        .decode(await rootBundle.loadString(MockPaths.clothing_from_lamoda));

    return ApiClothing.fromApi(response as Map<String, dynamic>).asFirst();

    // if (response.statusCode == 201) {
    //   return ApiClothing.fromApi(
    //           response.data['clothing'] as Map<String, dynamic>)
    //       .asFirst();
    // } else if (response.statusCode == 422) {
    //   return (response.data as List<dynamic>)
    //       ?.map((e) => ApiValidator.fromApi(e as Map<String, dynamic>))
    //       ?.toList()
    //       ?.asSecond();
    // } else {
    //   return null;
    // }
  }
}
