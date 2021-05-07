import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smartwardrobe/presentation/bloc/weather.dart';
import 'package:smartwardrobe/util/custom_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart' as localeFile;

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key key}) : super(key: key);

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  DateFormat dayOfWeek;
  DateFormat month;
  DateFormat day;
  Size weatherInfoSize;
  GlobalKey _keyWeatherInfo = GlobalKey();

  @override
  void initState() {
    super.initState();
    localeFile.initializeDateFormatting('ru');
    dayOfWeek = DateFormat.EEEE('ru');
    month = DateFormat.MMMM('ru');
    day = DateFormat.d('ru');
    weatherInfoSize = Size.zero;
  }

  void getSize() {
    final RenderBox renderBoxRed =
        _keyWeatherInfo.currentContext.findRenderObject();
    weatherInfoSize = renderBoxRed.size;
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = new DateTime.now();
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherInitial) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 64.w),
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
          ),
        );
      } else if (state is WeatherLodaing) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 64.w),
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          ),
        );
      } else if (state is WeatherLoaded) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Image.network(
                        'https://openweathermap.org/img/wn/' +
                            state.weather.iconCode +
                            '@2x.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        key: _keyWeatherInfo,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ((state.weather.temp).round()).toString() + '°',
                            //'d',
                            style: TextStyle(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w300,
                                color: CustomColors.darkGrey),
                          ),
                          Text(
                            state.weather.description,
                            //'d',
                            //'heavy intensity shower rain',
                            overflow: TextOverflow.visible,
                            //maxLines: 3,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w300,
                                color: CustomColors.darkGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
    });
  }
}
