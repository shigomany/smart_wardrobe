import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smartwardrobe/presentation/items/items.dart';
import 'package:smartwardrobe/presentation/main/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartwardrobe/resources/resources.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key key}) : super(key: key);

  Future navigateToScreen(context, routeLink) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => routeLink));
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(left: 16.w, top: 8.w, right: 8.w, bottom: 8.w),
            child: SizedBox(
              width: 36.w,
              height: 36.w,
              child: SvgPicture.asset(IconsPaths.clothes),
            ),
          ),
          GestureDetector(
            onTap: () {
              navigateToScreen(context, ItemsScreen());
            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: 8.w, left: 8.w, right: 32.w, bottom: 8.w),
              child: SizedBox(
                width: 36.w,
                height: 36.w,
                child: SvgPicture.asset(IconsPaths.kit),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 8.w, left: 32.w, right: 8.w, bottom: 8.w),
            child: SizedBox(
              width: 36.w,
              height: 36.w,
              child: SvgPicture.asset(IconsPaths.settings),
            ),
          ),
          GestureDetector(
            onTap: () {
              navigateToScreen(context, MainScreen());
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: 8.w, top: 8.w, right: 16.w, bottom: 8.w),
              child: SizedBox(
                width: 36.w,
                height: 36.w,
                child: SvgPicture.asset(IconsPaths.user),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
