import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smartwardrobe/util/constants.dart';

class BaseSource {
  Dio dio;
  final _headers = <String, String>{
    HttpHeaders.acceptHeader: 'application/json',
  };

  BaseSource() {
    dio = Dio(BaseOptions(
      baseUrl: weatherUri,
      sendTimeout: 5000, // 5s
      contentType: 'application/json; charset=UTF-8',
      followRedirects: false,
      headers: _headers,
      validateStatus: (status) => status <= 500,
    ));
  }
}
