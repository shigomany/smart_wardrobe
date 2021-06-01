import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/domain/usecase/get_categories_by_gender.dart';
import 'package:smartwardrobe/resources/resources.dart';
import 'package:smartwardrobe/util/constants.dart';

class CategorySource {
  Dio _dio;
  final _headers = <String, String>{
    HttpHeaders.acceptHeader: 'application/json',
  };

  CategorySource() {
    _dio = Dio(BaseOptions(
      baseUrl: apiUrl,
      sendTimeout: 5000, // 5s
      contentType: 'application/json; charset=UTF-8',
      followRedirects: false,
      headers: _headers,
      validateStatus: (status) => status <= 500,
    ));
  }

  Future<List<ApiCategory>> getCategoriesByGender(String gender) async {
    final response = await json
        .decode(await rootBundle.loadString(MockPaths.categories_tags));

    if (response is List<dynamic>) {
      List<ApiCategory> categories =
          response.map((e) => ApiCategory.fromApi(e)).toList();

      return categories;
    } else {
      List<ApiCategory> categories = [ApiCategory.fromApi(response)];
      return categories;
    }
  }
}
