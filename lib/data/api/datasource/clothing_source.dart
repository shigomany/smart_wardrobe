import 'dart:convert';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/internal/di/hive.dart';
import 'package:smartwardrobe/resources/resources.dart';
import 'package:smartwardrobe/util/common_methods.dart';
import 'package:smartwardrobe/util/constants.dart';
import 'package:union/union.dart';

class ClothingSource {
  Dio _dio;
  final _headers = <String, String>{
    HttpHeaders.acceptHeader: 'application/json',
  };

  ClothingSource() {
    _dio = Dio(BaseOptions(
      baseUrl: apiUrl,
      sendTimeout: 5000, // 5s
      contentType: 'application/json; charset=UTF-8',
      followRedirects: false,
      headers: _headers,
      validateStatus: (status) => status <= 500,
    ));
  }

  //TODO: когда будет готов бэк
  // Future<List<ApiClothing>> getAllClothing() async {
  //   final response = await _dio.get('clothing/all_clothing');

  //    if (response is List<dynamic>) {
  //     List<ApiClothing> clothes =
  //         response.data.map((e) => ApiClothing.fromApi(e)).toList();

  //     return clothes;
  //   } else {
  //     List<ApiClothing> clothes = [ApiClothing.fromApi(response.data)];
  //     return clothes;
  //   }
  // }

  Future<Union2<List<ApiClothing>, List<Clothing>>> getAllClothing() async {
    bool connection = await DataConnectionChecker().hasConnection;

//     if (connection) {
//           final response =
//           await json.decode(await rootBundle.loadString(MockPaths.clothing));
//           List<ApiClothing> clothes;
//           if (response is List<dynamic>) { List<ApiClothing> clothes =
//           response.map((e) => ApiClothing.fromApi(e)).toList();}
//           else{
// List<ApiClothing> clothes = [ApiClothing.fromApi(response)];
//           }

//            return clothes.asFirst();
//     }
//     } else {
//       await GetIt.I.isReady<HiveDI>();
//       final hiveDI = GetIt.I<HiveDI>();
//       final clothingBox = await hiveDI.getOrOpen<Clothing>(Clothing.boxName);

//       final response = clothingBox.values.toList();
//       return response.asSecond();
//     }
  }

  Future<ApiClothing> getClothingById(int id) async {
    final response =
        await json.decode(await rootBundle.loadString(MockPaths.clothing_one));

    return ApiClothing.fromApi(response);
  }

  Future<Union2<Clothing, ApiClothing>> postNewClothing(
      Clothing clothing) async {
    //TODO:код для бэка
    // final data = ApiClothing().toJson(clothing);
    // final response = await _dio.post('clothing/post_new_clothing',
    //     data: FormData.fromMap(data));
    // return ApiClothing.fromApi(response.data).asFirst();
    /*****************************************************************/
    //TODO : mock дата
    final response =
        await json.decode(await rootBundle.loadString(MockPaths.clothing_one));
    final response_test = ApiClothing.fromApi(response);
    return response_test.asSecond();

    // await GetIt.I.isReady<HiveDI>();
    // final hiveDI = GetIt.I<HiveDI>();
    // final clothingBox = await hiveDI.getOrOpen<Clothing>(Clothing.boxName);
    // CommonMethods.printNamesOfBoxed();
    // //clothingBox.add(clothing);
    // print(clothingBox.values.where((element) => element == clothing));
    // return clothing as Clothing;
    // Clothing clothing =
    //     response.map((e) => ApiClothing.fromApi(e)).cast<ApiClothing>();

    // return response.data;
    //
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
