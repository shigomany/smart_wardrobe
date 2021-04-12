import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smartwardrobe/internal/di/init.dart';
import 'package:smartwardrobe/presentation/bloc/weather_bloc.dart';
import 'package:smartwardrobe/util/custom_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key key}) : super(key: key);

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  WeatherBloc _weatherBloc;
  @override
  void initState() {
    super.initState();
    _weatherBloc = sl<WeatherBloc>();
    _weatherBloc.add(GetWeatherInfo('tyumen'));
    //     bloc.listen((data) {
    //   if (data is WeatherLoaded) {
    //     print(data.weather.description);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
        bloc: _weatherBloc,
        builder: (context, state) {
          if (state is WeatherInitial) {
            return CircularProgressIndicator();
          } else if (state is WeatherLoaded) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 64.w,
                      width: 64.w,
                      child: Image.network(
                          'https://openweathermap.org/img/wn/' +
                              state.weather.iconCode +
                              '@2x.png'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            ((state.weather.temp).round()).toString() + '°',
                            style: TextStyle(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w300,
                                color: CustomColors.darkGrey),
                          ),
                          Text(
                            state.weather.description,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'По ощущениям:' +
                        ((state.weather.feelsTemp).round()).toString() +
                        '°',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w300,
                        color: CustomColors.darkGrey),
                  ),
                )
              ],
            );
          }
        });
  }
}
