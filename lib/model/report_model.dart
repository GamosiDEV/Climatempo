import 'package:climatempo/model/city_model.dart';
import 'package:climatempo/model/weather_model.dart';

class ReportModel {
  List<WeatherModel> listOfWeathers = [];
  CityModel city;

  ReportModel(this.city);
}
