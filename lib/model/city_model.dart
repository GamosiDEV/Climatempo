import 'package:climatempo/model/weather_model.dart';

class CityModel {
  var name;
  var state;
  var country;
  var timezone;
  WeatherModel actualWeather;
  var latitude;
  var longitude;

  CityModel({
    required this.name,
    required this.country,
    this.state,
    this.timezone,
    required this.latitude,
    required this.longitude,
    required this.actualWeather,
  });

  factory CityModel.fromJsonForSearch(Map<String, dynamic> json) {
    return CityModel(
        name: json['name'],
        country: json['country'],
        state:
            json['state'] != '' && json['state'] != null ? json['state'] : '',
        latitude: json['lat'],
        longitude: json['lon'],
        actualWeather: WeatherModel());
  }

  factory CityModel.fromJsonForWeather(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'],
      country: json['sys']['country'],
      timezone: json['timezone'],
      latitude: json['coord']['lat'],
      longitude: json['coord']['lon'],
      actualWeather: WeatherModel.fromJsonForWeather(json),
    );
  }
}
