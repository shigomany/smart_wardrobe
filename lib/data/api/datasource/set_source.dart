import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/resources/resources.dart';
import 'package:smartwardrobe/util/constants.dart';

class SetSource {
  Dio _dio;
  final _headers = <String, String>{
    HttpHeaders.acceptHeader: 'application/json',
  };

  SetSource() {
    _dio = Dio(BaseOptions(
      baseUrl: apiUrl,
      sendTimeout: 5000, // 5s
      contentType: 'application/json; charset=UTF-8',
      followRedirects: false,
      headers: _headers,
      validateStatus: (status) => status <= 500,
    ));
  }

  Future<List<ApiSet>> getRelatedSets(int id) async {
    final response =
        await json.decode(await rootBundle.loadString(MockPaths.sets));

    if (response is List<dynamic>) {
      List<ApiSet> sets = response.map((e) => ApiSet.fromApi(e)).toList();

      return sets;
    } else {
      List<ApiSet> sets = [ApiSet.fromApi(response)];
      return sets;
    }
  }
}
