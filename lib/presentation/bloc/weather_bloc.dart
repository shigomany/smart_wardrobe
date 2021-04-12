import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartwardrobe/domain/model/models.dart';

import 'package:smartwardrobe/domain/usecase/get_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeatherCase;

  WeatherBloc({
    this.getWeatherCase,
  }) : super(WeatherInitial());

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherInfo) {
      final result = await getWeatherCase(event.city);

      yield (WeatherLoaded(weather: result));
    }
  }
}
