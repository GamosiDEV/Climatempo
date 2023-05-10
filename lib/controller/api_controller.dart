import 'dart:convert';

import 'package:climatempo/model/city_model.dart';
import 'package:http/http.dart' as http;

class ApiController {
  static final API_KEY = "&appid=e2ecde63bb5920e5225f7a11c1659c3b";
  static final GEOCODING_URI =
      "http://api.openweathermap.org/geo/1.0/direct?q=";
  static final GEOCODING_LIMIT = "&limit=20";

  Future<List<CityModel>> citySearchByNameOnly(cityName) async {
    final response = await getApiByString(
        GEOCODING_URI + cityName + GEOCODING_LIMIT + API_KEY);
    Iterable iterable = jsonDecode(response.body);

    List<CityModel> listOfCitys = List<CityModel>.from(
        iterable.map((json) => CityModel.fromJsonForSearch(json)));

    return listOfCitys;
  }

  Future<http.Response> getApiByString(String uri) async {
    return await http.get(Uri.parse(uri));
  }
}
