import 'package:weatherreport/controller/api_controller.dart';
import 'package:weatherreport/model/city_model.dart';

class CitySearchController {
  final ApiController _apiController = ApiController();

  Future<List<CityModel>> citySearch(cityName) async {
    return await _apiController.citySearchByNameOnly(cityName);
  }
}
