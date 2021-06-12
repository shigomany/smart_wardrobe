import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartwardrobe/domain/interfaces/box_name.dart';
import 'package:smartwardrobe/domain/model/models.dart';

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
    Hive.registerAdapter(ClothingAdapter());
    Hive.registerAdapter(SetAdapter());
    Hive.registerAdapter(ClothingCategoryAdapter());
    Hive.registerAdapter(BrandAdapter());
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

  Future<List<T>> getAll<T>() async {
    if (T is BoxName) {
      final boxName = (T as BoxName).boxName;
      final box = await getOrOpen(boxName);
      return box.values.toList();
    }
    
    return null;
  }

  Future<List<T>> getWhere<T>(bool Function(T) selector) async {
    if (T is BoxName) {
      final boxName = (T as BoxName).boxName;
      final box = await getOrOpen(boxName);
      return box.values.where(selector).toList();
    }
    
    return null;
  }

  Future<T> getSingleWhere<T>(bool Function(T) selector) async {
    if (T is BoxName) {
      final boxName = (T as BoxName).boxName;
      final box = await getOrOpen(boxName);
      return box.values.singleWhere(selector);
    }
    
    return null;
  }
}
