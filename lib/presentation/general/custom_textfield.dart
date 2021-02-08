import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  CustomTextField({@required this.labelText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w)),
    );
  }
}
