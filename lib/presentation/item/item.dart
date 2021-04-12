import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartwardrobe/presentation/edit_item/edit_item.dart';
import 'package:smartwardrobe/presentation/general/bottom_bar.dart';
import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/item_card.dart';
import 'package:smartwardrobe/presentation/general/logo_bar.dart';
import 'package:smartwardrobe/presentation/general/multi_select_chip.dart';
import 'package:smartwardrobe/presentation/main/main.dart';
import 'package:smartwardrobe/util/custom_colors.dart';

class ItemScreen extends StatefulWidget {
  static String routeName = '/item';
  const ItemScreen({Key key}) : super(key: key);

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  Future navigateBack(context) async {
    Navigator.of(context).pop();
  }

  Future navigateToEditScreen(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditItemScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(119, 119, 119, 0.5),
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 8.w, right: 16.w, bottom: 8.w, left: 4.w),
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
                            Text('Вещь',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: CustomColors.textDark)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateToEditScreen(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: Icon(
                          MaterialCommunityIcons.pencil,
                          size: 24.sp,
                        ),
                      ),
                    ),
                    Icon(
                      MaterialCommunityIcons.trash_can,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16.w, left: 8.w, right: 8.w),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(119, 119, 119, 0.25),
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 328.w,
                          height: 328.w,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            border: Border.all(
                                color: Color(0xFFF2F2F2), width: 4.w),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nike",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text("Кроссовки AIR MONARCH IV",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.sp,
                                      height: 1.5)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.w, left: 8.w, right: 8.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Container(
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(119, 119, 119, 0.25),
                                  blurRadius: 7,
                                  offset: Offset(0, 3))
                            ]),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Размер',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xFF696767)),
                                  ),
                                  Text('44',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w300,
                                          height: 1.5))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(119, 119, 119, 0.25),
                                blurRadius: 7,
                                offset: Offset(0, 3))
                          ]),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'URL вещи в магазине',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF696767)),
                                ),
                                Text(
                                    'www.lamoda.ru/p/ni4ad14fg564q...'
                                        .replaceAll("", "\u{200B}"),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w300,
                                        height: 1.5))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xFFf2f2f2)),
                                borderRadius: BorderRadius.circular(5.w))),
                        onPressed: () {
                          print('Составить образ с вещью');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.w),
                          child: Text(
                            'Составить образ с вещью',
                            style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: Text(
                      'Комплекты с этой вещью',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w300),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 8.w, bottom: 16.w),
                  child: Wrap(
                    children: [
                      ItemCard(widthScreen: widthScreen),
                      ItemCard(widthScreen: widthScreen),
                      ItemCard(widthScreen: widthScreen)
                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print('pressed');
            },
            child: Icon(Icons.add,
                color: Color.fromRGBO(253, 253, 253, 1), size: 36.sp),
            backgroundColor: CustomColors.textPrimaryLight,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomBar()),
    );
  }
}
