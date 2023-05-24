import 'package:weatherreport/model/weather_model.dart';

class CityModel {
  var name;
  var state;
  var country;
  var timezone;
  WeatherModel actualWeather;
  List<WeatherModel> nextDays;
  var latitude;
  var longitude;

  CityModel(
      {this.name,
      this.country,
      this.state,
      this.timezone,
      this.latitude,
      this.longitude,
      required this.actualWeather,
      required this.nextDays});

  factory CityModel.fromJsonForSearch(Map<String, dynamic> json) {
    return CityModel(
        name: json['name'],
        country: json['country'],
        state:
            json['state'] != '' && json['state'] != null ? json['state'] : '',
        latitude: json['lat'],
        longitude: json['lon'],
        actualWeather: WeatherModel(),
        nextDays: []);
  }

  factory CityModel.fromJsonForWeather(Map<String, dynamic> json) {
    return CityModel(
        name: json['name'],
        country: json['sys']['country'],
        timezone: json['timezone'],
        latitude: json['coord']['lat'],
        longitude: json['coord']['lon'],
        actualWeather: WeatherModel.fromJsonForWeather(json, json['timezone']),
        nextDays: []);
  }

  factory CityModel.fromJsonForNextDays(Map<String, dynamic> json) {
    List<WeatherModel> listOfWeathersForNextDays = [];
    for (var weatherPerHour in json['list']) {
      listOfWeathersForNextDays.add(WeatherModel.fromJsonForWeather(
          weatherPerHour, json['city']['timezone']));
    }
    return CityModel(
        name: json['city']['name'],
        country: json['city']['country'],
        timezone: json['city']['timezone'],
        latitude: json['city']['coord']['lat'],
        longitude: json['city']['coord']['lon'],
        actualWeather: WeatherModel(),
        nextDays: listOfWeathersForNextDays);
  }

  factory CityModel.fromFavoritesJsonToFavoritesList(
      Map<String, dynamic> json) {
    return CityModel(
        name: json['name'],
        state: json['state'],
        country: json['country'],
        timezone: json['timezone'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        actualWeather: WeatherModel(),
        nextDays: []);
  }

  toJson() {
    return {
      "name": this.name,
      "state": this.state,
      "country": this.country,
      "timezone": this.timezone,
      "latitude": this.latitude,
      "longitude": this.longitude,
    };
  }
}
