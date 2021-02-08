import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:smartwardrobe/internal/di/global.dart';

void setupInitial() {
  GetIt.I.registerSingleton(GlobalDI());
}

void setupAfterRender() {}
