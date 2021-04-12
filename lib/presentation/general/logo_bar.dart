import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smartwardrobe/presentation/main/main.dart';
import 'package:smartwardrobe/util/custom_colors.dart';

class LogoBar extends StatelessWidget {
  const LogoBar({Key key, this.title}) : super(key: key);

  final String title;

  Future navigateBack(context) async {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(119, 119, 119, 0.5),
            blurRadius: 7,
            offset: Offset(0, 3))
      ]),
      child: Padding(
        padding: EdgeInsets.only(top: 8.w, right: 16.w, bottom: 8.w, left: 4.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  navigateBack(context);
                },
                child: Row(
                  children: [
                    Icon(MaterialIcons.keyboard_arrow_left,
                        size: 36.sp, color: CustomColors.textDark),
                    Text(title,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color: CustomColors.textDark)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Icon(FontAwesome.sun_o, color: CustomColors.lightGrey),
            ),
            Text(
              'L O G O N A M E',
              style: TextStyle(
                  color: CustomColors.lightGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp),
            )
          ],
        ),
      ),
    );
  }
}
