import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:smartwardrobe/data/api/datasource/base_source.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/resources/resources.dart';

class BrandSource extends BaseSource {
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
