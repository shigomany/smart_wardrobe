import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return _pages[_selectedIndex];
  }
}
