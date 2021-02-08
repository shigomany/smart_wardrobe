import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:smartwardrobe/presentation/login/login.dart';
import 'package:smartwardrobe/presentation/register/register.dart';
import 'package:smartwardrobe/presentation/main/main.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(_redirect);
  }

  Future<void> _redirect() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('!'),
      ),
    );
  }
}
