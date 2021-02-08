import 'package:flutter/material.dart';
import 'package:smartwardrobe/presentation/general/slider_with_button.dart';
import 'package:smartwardrobe/util/custom_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smartwardrobe/presentation/general/custom_textfield.dart';
import 'package:smartwardrobe/presentation/general/image_block.dart';
import 'package:smartwardrobe/presentation/general/image_block_text.dart';
import 'package:smartwardrobe/presentation/general/slider_with_button.dart';

class MainScreen extends StatelessWidget {
  static String routeName = '/main';
  final int itemsCount = 4;
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(119, 119, 119, 0.5),
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ]),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Icon(FontAwesome.sun_o,
                            color: CustomColors.lightGrey),
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '01',
                            style: TextStyle(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w300,
                                color: CustomColors.darkGrey),
                          ),
                          Text(
                            'февраля, пн',
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w300,
                                color: CustomColors.darkGrey),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Expanded(
                        flex: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Feather.cloud_snow,
                              color: CustomColors.darkGrey,
                              size: 64.sp,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 24.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    '-10°',
                                    style: TextStyle(
                                        fontSize: 48.sp,
                                        fontWeight: FontWeight.w300,
                                        color: CustomColors.darkGrey),
                                  ),
                                  Text(
                                    'снег',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w300,
                                        color: CustomColors.darkGrey),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SliderWithButton(
                title: 'Комплекты на сегодня',
                titleColor: Color(0xFFFFFFFF),
                buttonText: 'Перейти к комплектам',
                buttonLink: 'Перейти к комплектам',
                buttonTextColor: Color(0xFF84B3ED),
                backgroundColor: Color(0xFF84B3ED),
              ),
              Container(
                decoration: BoxDecoration(color: Color(0xFFFFFF)),
                child: Padding(
                  padding: EdgeInsets.only(top: 16.w, bottom: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Text("Рекомендации для вас",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF696767))),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: itemsCount,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return new Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 120.w,
                                  height: 120.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Color(0xFFF2F2F2)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.w)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w),
                                  child: Text(
                                    'Brand Name',
                                    style: TextStyle(
                                        color: Color(0xFF696767),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4.w),
                                  child: Text(
                                    'Item Name',
                                    style: TextStyle(
                                        color: Color(0xFF696767),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 8.w, left: 16.w, right: 16.w),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFFf2f2f2)),
                                      borderRadius:
                                          BorderRadius.circular(5.w))),
                              onPressed: () {
                                print('Перейти к рекомендациям');
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.w),
                                child: Text(
                                  'Перейти к рекомендациям',
                                  style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
