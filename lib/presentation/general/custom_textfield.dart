import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function onChanged;
  //final Function validator;

  CustomTextField(
      {@required this.labelText,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.onChanged});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  //TO DO : validation
  //Color currentColor;
  // @override
  // void initState() {
  //   super.initState();
  //   currentColor = widget.borderColor;
  // }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged(value);
        }
        //TO DO : validation
        // setState(() {
        //   if (!widget.validator(value) || value.length == 0) {
        //     currentColor = widget.errorColor;
        //   } else {
        //     currentColor = widget.baseColor;
        //   }
        // });
      },
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.labelText,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w)),
    );
  }
}
