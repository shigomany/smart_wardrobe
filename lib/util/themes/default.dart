import 'package:flutter/material.dart';

ThemeData defaultTheme(BuildContext context) => ThemeData(
      // fontFamily: 'Rubik',
      accentColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 0.5),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)))),
      // outlinedButtonTheme: OutlinedButtonThemeData(
      //   style: OutlinedButton.styleFrom(
      //       backgroundColor: CustomColors.main, elevation: 0),
      // ),
      // buttonTheme: const ButtonThemeData(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(12)),
      //   ),
      //   textTheme: ButtonTextTheme.accent,
      //   buttonColor: CustomColors.main,
      //   disabledColor: CustomColors.main,
      //   height: 44,
      // ),
      // inputDecorationTheme: const InputDecorationTheme(
      //   border: OutlineInputBorder(
      //     borderSide: BorderSide(
      //       color: Color.fromRGBO(0, 0, 0, 0.1),
      //       style: BorderStyle.solid,
      //     ),
      //     borderRadius: BorderRadius.all(
      //       Radius.circular(8),
      //     ),
      //     gapPadding: 0,
      //   ),
      //   // disabledBorder: OutlineInputBorder(
      //   //     borderSide: BorderSide(
      //   //       color: Color.fromRGBO(0, 0, 0, 0.1),
      //   //       style: BorderStyle.solid,
      //   //     ),
      //   //     borderRadius: BorderRadius.all(
      //   //       Radius.circular(12),
      //   //     ),
      //   //     gapPadding: 0),
      //   enabledBorder: OutlineInputBorder(
      //       borderSide: BorderSide(
      //         color: Color.fromRGBO(0, 0, 0, 0.1),
      //         style: BorderStyle.solid,
      //       ),
      //       borderRadius: BorderRadius.all(
      //         Radius.circular(12),
      //       ),
      //       gapPadding: 0),
      //   focusedBorder: OutlineInputBorder(
      //       borderSide: BorderSide(
      //         color: CustomColors.main,
      //         style: BorderStyle.solid,
      //       ),
      //       borderRadius: BorderRadius.all(
      //         Radius.circular(12),
      //       ),
      //       gapPadding: 0),
      //   focusedErrorBorder: OutlineInputBorder(
      //       borderSide: BorderSide(
      //         color: CustomColors.error,
      //         style: BorderStyle.solid,
      //       ),
      //       borderRadius: BorderRadius.all(
      //         Radius.circular(12),
      //       ),
      //       gapPadding: 0),
      //   errorBorder: OutlineInputBorder(
      //       borderSide: BorderSide(
      //         color: CustomColors.error,
      //         style: BorderStyle.solid,
      //       ),
      //       borderRadius: BorderRadius.all(
      //         Radius.circular(12),
      //       ),
      //       gapPadding: 0),
      //   errorStyle: TextStyle(
      //       color: CustomColors.error,
      //       fontWeight: FontWeight.w400,
      //       fontSize: 13),
      //   filled: true,
      //   isDense: true,
      //   contentPadding: EdgeInsets.fromLTRB(0, 12, 14, 14),
      //   hintStyle: TextStyle(color: Color.fromRGBO(170, 170, 170, 1)),
      //   fillColor: Colors.white,
      // ),
    );
