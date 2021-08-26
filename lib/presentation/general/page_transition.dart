import 'package:flutter/material.dart';

PageRouteBuilder pageTransition(Widget screen) => PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return screen;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Interval(0.5, 1.0),
            ),
          ),
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 250),
    );
