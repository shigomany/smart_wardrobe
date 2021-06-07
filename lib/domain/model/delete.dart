import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'delete.g.dart';

@HiveType(typeId: 0)
class Person extends HiveObject {
  
  static String get boxName => 'Person';

  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  Person({
    @required this.age,
    @required this.name,
  });
}