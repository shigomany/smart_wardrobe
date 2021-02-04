import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/data/api/request/post_auth_body.dart';
import 'package:smartwardrobe/util/constants.dart';
import 'package:union/union.dart';

class AuthService {
  Dio _dio;
  AuthService() {
    _dio = Dio(BaseOptions(
      baseUrl: apiUrl,
      sendTimeout: 5000, // 5s
      contentType: 'application/json; charset=UTF-8',
      followRedirects: false,
      headers: _headers,
      validateStatus: (status) => status <= 500,
    ));
  }

  Future<Union2<ApiUser, List<ApiValidator>>> signIn(
      PostAuthBody body) async {
    final response =
        await _dio.post('/api/v1/auth/signin', data: jsonEncode(body.toApi()));

    if (response.statusCode == 201) {
      return ApiUser.fromApi(response.data['user'] as Map<String, dynamic>).asFirst();
    } else if (response.statusCode == 422) {
      return (response.data as List<dynamic>)
          ?.map((e) => ApiValidator.fromApi(e as Map<String, dynamic>))
          ?.toList()
          ?.asSecond();
    } else {
      return null;
    }
  }

  void _setAuthToken() {
    // final token = GetIt.I<GlobalDI>()?.token;
    // _headers[HttpHeaders.authorizationHeader] =
    //     '${token.tokenType} ${token.accessToken}';
    // _dio.options.headers = _headers;
  }

  final _headers = <String, String>{
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
  };
}