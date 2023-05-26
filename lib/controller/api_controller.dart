// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:weatherreport/model/city_model.dart';
import 'package:http/http.dart' as http;

class ApiController {
  static const API_KEY = "appid=e2ecde63bb5920e5225f7a11c1659c3b";
  static const GEOCODING_URI =
      "http://api.openweathermap.org/geo/1.0/direct?q=";
  static const GEOCODING_LIMIT = "limit=20";
  static const CURRENT_WEATHER =
      "https://api.openweathermap.org/data/2.5/weather?";
  static const LATITUDE = "lat=";
  static const LONGITUDE = "lon=";
  static const NEXT_DAYS_WEATHER =
      "https://api.openweathermap.org/data/2.5/forecast?";

  Future<http.Response> getApiDataByString(String uri) async {
    return await http.get(Uri.parse(uri));
  }

  Future<List<CityModel>> citySearchByNameOnly(cityName) async {
    final response = await getApiDataByString(
        "${GEOCODING_URI + cityName}&$GEOCODING_LIMIT&$API_KEY");
    Iterable iterable = jsonDecode(response.body);

    List<CityModel> listOfCitys = List<CityModel>.from(
        iterable.map((json) => CityModel.fromJsonForSearch(json)));

    return listOfCitys;
  }

  Future<CityModel> getWeatherByCity(CityModel actualCity) async {
    final response = await getApiDataByString(
        generateStringForApiRequest(actualCity, CURRENT_WEATHER));

    actualCity = CityModel.fromJsonForWeather(jsonDecode(response.body));
    return actualCity;
  }

  Future<CityModel> getNextDaysWeatherByCity(CityModel actualCity) async {
    final response = await getApiDataByString(
        generateStringForApiRequest(actualCity, NEXT_DAYS_WEATHER));

    actualCity = CityModel.fromJsonForNextDays(jsonDecode(response.body));
    return actualCity;
  }

  String generateStringForApiRequest(CityModel city, String requisitionFor) {
    if (city.name != null && city.state != null && city.country != null) {
      // ignore: prefer_interpolation_to_compose_strings
      return requisitionFor +
          "q=" +
          city.name +
          "," +
          city.state +
          "," +
          city.country +
          "&" +
          API_KEY;
    } else {
      return "$requisitionFor$LATITUDE${city.latitude}&$LONGITUDE${city.longitude}&$API_KEY";
    }
  }
}
