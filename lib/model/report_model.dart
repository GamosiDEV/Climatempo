import 'package:weatherreport/model/city_model.dart';
import 'package:weatherreport/model/weather_model.dart';

class ReportModel {
  List<WeatherModel> listOfWeathers = [];
  CityModel city;

  ReportModel(this.city);
}
