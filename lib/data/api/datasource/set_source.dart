import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:smartwardrobe/data/api/datasource/base_source.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/resources/resources.dart';

class SetSource extends BaseSource {
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
