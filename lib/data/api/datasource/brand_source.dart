import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/resources/resources.dart';
import 'package:smartwardrobe/util/constants.dart';

class BrandSource {
  Dio _dio;
  final _headers = <String, String>{
    HttpHeaders.acceptHeader: 'application/json',
  };

  BrandSource() {
    _dio = Dio(BaseOptions(
      baseUrl: apiUrl,
      sendTimeout: 5000, // 5s
      contentType: 'application/json; charset=UTF-8',
      followRedirects: false,
      headers: _headers,
      validateStatus: (status) => status <= 500,
    ));
  }

  Future<List<ApiBrand>> getBrandList() async {
    //DB delay simulate
    //await Future.delayed(Duration(seconds: 5));
    final response =
        await json.decode(await rootBundle.loadString(MockPaths.brands));

    if (response is List<dynamic>) {
      List<ApiBrand> list = response.map((e) => ApiBrand.fromApi(e)).toList();

      return list;
    } else {
      List<ApiBrand> list = [ApiBrand.fromApi(response)];
      return list;
    }
  }
}
