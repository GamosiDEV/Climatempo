import 'package:climatempo/model/weather_model.dart';

class CityModel {
  var name;
  var country;
  var timezone;
  WeatherModel actualWeather;

  CityModel(this.name, this.country, this.timezone, this.actualWeather);
}
