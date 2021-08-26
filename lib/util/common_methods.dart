import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class CommonMethods {
  static void showSnack(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.amber,
        content: WillPopScope(
          onWillPop: () async {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            return true;
          },
          child: Text(title),
        ),
      ),
    );
  }

  static FutureOr<List<String>> getNamesOfBoxes() async {
    final appDir = await getApplicationDocumentsDirectory();
    var files = appDir.listSync();
    var _list = <String>[];

    files.forEach((file) {
      if (file.statSync().type == FileSystemEntityType.file &&
          p.extension(file.path).toLowerCase() == '.hive') {
        _list.add(p.basenameWithoutExtension(file.path));
      }
    });
    print('Current boxes: $_list');
    return _list;
  }

  static void printNamesOfBoxed() async {
    final appDir = await getApplicationDocumentsDirectory();
    var files = appDir.listSync();
    var _list = <String>[];

    files.forEach((file) {
      if (file.statSync().type == FileSystemEntityType.file &&
          p.extension(file.path).toLowerCase() == '.hive') {
        _list.add(p.basenameWithoutExtension(file.path));
      }
    });
    print('Current boxes: $_list');
  }
}
//TODO:SlideTransition
// transitionsBuilder:
//     (context, animation, secondaryAnimation, child) {
//   var begin = Offset(1, 0.0);
//   var end = Offset(0, 0);
//   var tween = Tween(begin: begin, end: end);
//   var offsetAnimation = animation.drive(tween);

//   return SlideTransition(
//     position: offsetAnimation,
//     child: child,
//   );
// },