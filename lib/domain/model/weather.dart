part of 'models.dart';

class Weather extends Equatable {
  final double feelsTemp;
  final double temp;
  final String description;
  final String iconCode;
  DateTime lastUpdated;

  Weather({
    this.feelsTemp,
    this.temp,
    this.lastUpdated,
    this.description,
    this.iconCode,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [feelsTemp, temp, lastUpdated, description, iconCode];
  }
}
