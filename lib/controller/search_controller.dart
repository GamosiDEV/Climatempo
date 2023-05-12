import 'package:climatempo/controller/api_controller.dart';
import 'package:climatempo/model/city_model.dart';
import 'package:climatempo/model/weather_model.dart';

class SearchController {
  ApiController _apiController = ApiController();

  Future<List<CityModel>> citySearch(cityName) async {
    return await _apiController.citySearchByNameOnly(cityName);
  }
}
