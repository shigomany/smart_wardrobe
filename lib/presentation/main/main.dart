import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:quiver/iterables.dart';

import 'package:smartwardrobe/domain/model/clothing_image.dart';
import 'package:smartwardrobe/internal/di/init.dart';
import 'package:smartwardrobe/presentation/bloc/weather_bloc.dart';
import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/list_menu_slider.dart';
import 'package:smartwardrobe/presentation/general/slider_with_button.dart';
import 'package:smartwardrobe/presentation/main/weather_widget.dart';
import 'package:smartwardrobe/util/custom_colors.dart';
import 'package:intl/date_symbol_data_local.dart' as localeFile;

class MainScreen extends StatefulWidget {
  static String routeName = '/main';

  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateFormat dayOfWeek;
  DateFormat month;
  DateFormat day;

  final List<ClothingImage> items = [
    ClothingImage(id: 98, brandName: 'Columbia', itemName: 'Куртка'),
    ClothingImage(id: 89, brandName: 'Nike', itemName: 'Air Monarch IV'),
    ClothingImage(
        id: 77,
        brandName: 'Under Armor',
        itemName: 'Худи UA Rival Fleece Big Logo HD'),
  ];

  @override
  void initState() {
    super.initState();
    localeFile.initializeDateFormatting('ru');
    dayOfWeek = DateFormat.EEEE('ru');
    month = DateFormat.MMMM('ru');
    day = DateFormat.d('ru');

    final bloc = sl<WeatherBloc>();
    bloc.add(GetWeatherInfo('tyumen'));
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = new DateTime.now();
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
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
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
        )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                            day.format(dateTime),
                            style: TextStyle(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w300,
                                color: CustomColors.darkGrey),
                          ),
                          Text(
                            month.format(dateTime) +
                                ', ' +
                                dayOfWeek.format(dateTime),
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w300,
                                color: CustomColors.darkGrey),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: WeatherWidget(),
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
              ListMenuSlider(title: 'Добавить новую вещь'),
              ListMenuSlider(title: 'Добавить новый образ'),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.w, bottom: 16.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.w),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var i in enumerate(items))
                                ItemWidget(
                                  item: i,
                                ),
                            ],
                          ),
                        ),
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
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final IndexedValue<ClothingImage> item;

  const ItemWidget({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFF2F2F2)),
              borderRadius: BorderRadius.all(Radius.circular(4.w)),
            ),
          ),
          Container(
            width: 120.w,
            child: Padding(
              padding: EdgeInsets.only(top: 8.w),
              child: Text(
                item.value.brandName.replaceAll("", "\u{200B}"),
                maxLines: 1,
                style: TextStyle(
                    color: Color(0xFF696767),
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp),
              ),
            ),
          ),
          Container(
            width: 120.w,
            child: Padding(
              padding: EdgeInsets.only(top: 4.w),
              child: Text(
                item.value.itemName.replaceAll("", "\u{200B}"),
                maxLines: 1,
                style: TextStyle(
                    color: Color(0xFF696767),
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp),
              ),
            ),
          )
        ],
      ),
    );
  }
}
