import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// import 'package:injectable/injectable.dart';
import 'package:smartwardrobe/internal/application.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartwardrobe/internal/di/init.dart';

// final getIt = GetIt.instance;

// @InjectableInit(
//   initializerName: r'$initGetIt', // default
//   preferRelativeImports: true, // default
//   asExtension: false, // default
// )
// void configureDependencies() => $initGetIt(getIt);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInitial();
  // configureDependencies();
  runApp(const Application());
}
