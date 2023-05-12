import 'package:climatempo/controller/api_controller.dart';
import 'package:climatempo/model/city_model.dart';

class ForecastController {
  ApiController _apiController = ApiController();

  getWeatherForSelectedCity(CityModel actualCity) async {
    return await _apiController.getWeatherByCity(actualCity);
  }
}
