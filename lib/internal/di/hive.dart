import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartwardrobe/domain/model/delete.dart';

class HiveDI {
// for sample

  static Future<HiveDI> initDI() async {
    await Hive.initFlutter();
    _initAdapters();

    return HiveDI();
  }

  static void _initAdapters() {
    // Где стоит @HiveType(typeId: <№>) нужно зарегать адаптеры. Имена адатеров через быстрое действие и
    // рефакторинг можно подключать <ClassName>Adapter
    Hive.registerAdapter(PersonAdapter());
  }

  Future<Box<T>> getOrOpen<T extends Object>(String name) async {
    if (Hive.isBoxOpen(name)) {
      return Hive.box<T>(name);
    }
    return await Hive.openBox<T>(name);
  }

  Future<LazyBox<T>> getOrOpenLazy<T extends Object>(String name) async {
    if (Hive.isBoxOpen(name)) {
      return Hive.lazyBox<T>(name);
    }
    return await Hive.openLazyBox<T>(name);
  }
}
