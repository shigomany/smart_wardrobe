import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:smartwardrobe/data/api/datasource/base_source.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/resources/resources.dart';

class CategorySource extends BaseSource {
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
