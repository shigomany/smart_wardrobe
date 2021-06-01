import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/resources/resources.dart';
import 'package:smartwardrobe/util/constants.dart';

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

  Future<List<ApiClothing>> getAllClothing() async {
    final response =
        await json.decode(await rootBundle.loadString(MockPaths.clothing));

    if (response is List<dynamic>) {
      List<ApiClothing> clothes =
          response.map((e) => ApiClothing.fromApi(e)).toList();

      return clothes;
    } else {
      List<ApiClothing> clothes = [ApiClothing.fromApi(response)];
      return clothes;
    }
  }

  Future<ApiClothing> getClothingById(int id) async {
    final response =
        await json.decode(await rootBundle.loadString(MockPaths.clothing_one));

    return ApiClothing.fromApi(response);
  }

  Future<ApiClothing> postNewClothing(Clothing clothing) async {
    final data = ApiClothing().toJson(clothing);
    final data_test = FormData.fromMap(data);
    print(data_test);
    // final response = await _dio.post('clothing/post_new_clothing',
    //     data: FormData.fromMap(data));
    //return ApiClothing.fromApi(response.data);

    final response =
        await json.decode(await rootBundle.loadString(MockPaths.clothing_one));
    final response_test = ApiClothing.fromApi(response);

    print(response_test);
    return response_test;
    // Clothing clothing =
    //     response.map((e) => ApiClothing.fromApi(e)).cast<ApiClothing>();

    // return response.data;
    //
  }
}
