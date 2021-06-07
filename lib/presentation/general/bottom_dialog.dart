import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartwardrobe/presentation/new_item/item_from_camera.dart';
import 'package:smartwardrobe/presentation/new_item/item_from_lamoda.dart';
import 'package:smartwardrobe/resources/resources.dart';
import 'package:smartwardrobe/util/custom_colors.dart';

Future navigateToScreen(context, routeLink) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => routeLink));
}

YYDialog bottomAddMenu(BuildContext context) {
  return YYDialog().build(context)
    ..gravity = Gravity.bottom
    ..gravityAnimationEnable = true
    ..backgroundColor = Colors.white
    ..widget(Container(
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFEDEDED)),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, top: 16.w, bottom: 16.w),
                child: Text(
                  'Добавить новую вещь',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  navigateToScreen(context, ItemFromCamera());
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFEDEDED)),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 8.w, bottom: 8.w, left: 32.w, right: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Сделать фото',
                            style: TextStyle(
                              fontSize: 14.sp,
                            )),
                        Icon(
                          MaterialIcons.keyboard_arrow_right,
                          size: 32.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  print("Выбрать фото из галереи");
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFEDEDED)),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 8.w, bottom: 8.w, left: 32.w, right: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Выбрать фото из галереи',
                            style: TextStyle(
                              fontSize: 14.sp,
                            )),
                        Icon(
                          MaterialIcons.keyboard_arrow_right,
                          size: 32.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  navigateToScreen(context, ItemFromLamodaScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFEDEDED)),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 8.w, bottom: 8.w, left: 32.w, right: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Подобрать из каталога Lamoda',
                            style: TextStyle(
                              fontSize: 14.sp,
                            )),
                        Icon(
                          MaterialIcons.keyboard_arrow_right,
                          size: 32.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFEDEDED)),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, top: 16.w, bottom: 16.w),
                child: Text(
                  'Добавить новый образ',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  print("Подобрать из интернета");
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFEDEDED)),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 8.w, bottom: 8.w, left: 32.w, right: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Новый образ',
                            style: TextStyle(
                              fontSize: 14.sp,
                            )),
                        Icon(
                          MaterialIcons.keyboard_arrow_right,
                          size: 32.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )))
    ..show();
}
