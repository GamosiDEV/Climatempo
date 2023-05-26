import 'package:weatherreport/controller/api_controller.dart';
import 'package:weatherreport/model/city_model.dart';

class ForecastController {
  final ApiController _apiController = ApiController();

  getWeatherForSelectedCity(CityModel actualCity) async {
    return await _apiController.getWeatherByCity(actualCity);
  }
}
