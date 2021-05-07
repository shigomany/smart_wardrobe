import 'package:flutter/material.dart';
import 'package:smartwardrobe/domain/model/models.dart';

class InheritedDataProvider extends InheritedWidget {
  final String data;
  InheritedDataProvider({
    Widget child,
    this.data,
  }) : super(child: child);
  @override
  bool updateShouldNotify(InheritedDataProvider oldWidget) =>
      data != oldWidget.data;
  static InheritedDataProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedDataProvider>();
}
