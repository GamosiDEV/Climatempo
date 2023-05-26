// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:weatherreport/controller/forecast_controller.dart';
import 'package:weatherreport/model/city_model.dart';
import 'package:flutter/material.dart';
import 'package:weatherreport/view/forecast_data_view.dart';
import 'package:weatherreport/view/location_not_found.view.dart';

class ForecastView extends StatefulWidget {
  final CityModel? actualCity;
  final ValueSetter<CityModel> updateSelectedCityCallback;
  final VoidCallback getLocationCallback;
  final ValueSetter<int> changeScreenCallback;
  final ValueSetter<String> setCityNameToTittleCallback;

  const ForecastView({
    super.key,
    required this.actualCity,
    required this.updateSelectedCityCallback,
    required this.getLocationCallback,
    required this.changeScreenCallback,
    required this.setCityNameToTittleCallback,
  });

  @override
  State<ForecastView> createState() => _ForecastViewState();
}

class _ForecastViewState extends State<ForecastView> {
  final ForecastController _forecastController = ForecastController();

  Future<CityModel>? selectedCityWeather;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWeatherForSelectedCity(),
      builder: (context, snapshot) {
        if (snapshot.hasError ||
            snapshot.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (!snapshot.hasData) {
          return LocationNotFoundView(
              getLocationCallback: widget.getLocationCallback,
              changeScreenCallback: widget.changeScreenCallback);
        }
        return ForecastDataView(weatherReport: snapshot.data as CityModel);
      },
    );
  }

  getWeatherForSelectedCity() async {
    if (widget.actualCity == null) {
      return null;
    }
    CityModel response = await _forecastController
        .getWeatherForSelectedCity(widget.actualCity as CityModel);
    widget.setCityNameToTittleCallback(response.name == null
        ? 'Cidade'
        : response.name +
            (response.state == null ? "" : (" - " + response.state)) +
            " - " +
            response.country);
    selectedCityWeather = Future.value(response);
    widget.updateSelectedCityCallback(response);
    return selectedCityWeather;
  }
}
