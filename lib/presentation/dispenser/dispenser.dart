import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:smartwardrobe/domain/model/clothing_image.dart';

import 'package:smartwardrobe/internal/di/hive.dart';
import 'package:smartwardrobe/internal/di/init.dart';
import 'package:smartwardrobe/presentation/items/items.dart';
import 'package:smartwardrobe/presentation/main/main.dart';

class DispneserWindget extends StatefulWidget {
  const DispneserWindget({Key key}) : super(key: key);
  static const String routeName = '/main';

  @override
  _DispneserWindgetState createState() => _DispneserWindgetState();
}

class _DispneserWindgetState extends State<DispneserWindget> {
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ItemsScreen(
        selectedIndex: _selectedIndex,
        onTapNavigator: _onItemTapped,
      ),
      ItemsScreen(
        selectedIndex: _selectedIndex,
        onTapNavigator: _onItemTapped,
      ),
      MainScreen(
        selectedIndex: _selectedIndex,
        onTapNavigator: _onItemTapped,
      ),
      MainScreen(
        selectedIndex: _selectedIndex,
        onTapNavigator: _onItemTapped,
      ),
    ];
    // TODO: Удоли
    //_testHive();
  }

  Future<void> _testHive() async {
    // Тест Hive
    await GetIt.I.isReady<HiveDI>();
    final hiveDi = GetIt.I<HiveDI>();
    // Test
    //final personBox = await hiveDi.getOrOpen<Person>(Person.boxName);
    //personBox.add(Person(name: 'Керилл', age: 21));
    //personBox.clear() //Для удаления всех значений из таблицы
    // await Future.delayed(const Duration(milliseconds: 500));
    //final ss =
    //    personBox.values.where((element) => element.name == 'Керилл').toList();
  }

  @override
  Widget build(BuildContext context) {
    return _pages[_selectedIndex];
  }
}
