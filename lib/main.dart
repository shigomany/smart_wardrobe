import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smartwardrobe/internal/application.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Application());
}
