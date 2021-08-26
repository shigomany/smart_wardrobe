import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartwardrobe/data/api/datasource/base_source.dart';

class ImageFileSource extends BaseSource {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<File> clearBackground(File file) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path,
          filename: file.path.split("/").last)
    });
    final response = await dio.post('/',
        data: formData, options: Options(responseType: ResponseType.bytes));
    print(response);

    Directory directory;
    try {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File file = new File(tempPath + getRandomString(6) + '.png');
      print(tempPath);
      await file.writeAsBytes(response.data);
      return file;

      // directory = await getExternalStorageDirectory();
      // String newPath = "";
      // print(directory);
      // List<String> paths = directory.path.split("/");
      // for (int x = 1; x < paths.length; x++) {
      //   String folder = paths[x];
      //   if (folder != "Android") {
      //     newPath += "/" + folder;
      //   } else {
      //     break;
      //   }
      // }
      // newPath = newPath + "/SmartWardrobe";
      // directory = Directory(newPath);
      // if (!await directory.exists()) {
      //   await directory.create(recursive: true);
      // }
      // if (await directory.exists()) {
      //   String tempPath = directory.path + '/' + getRandomString(6);
      //   File saveFile = new File(tempPath + '.png');

      //   await file.writeAsBytes(response.data);
      //   return saveFile;
      // }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
