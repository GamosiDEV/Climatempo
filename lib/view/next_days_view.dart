import 'package:weatherreport/controller/next_days_controller.dart';
import 'package:weatherreport/model/city_model.dart';
import 'package:weatherreport/view/location_not_found.view.dart';
import 'package:flutter/material.dart';
import 'package:weatherreport/view/next_days_data_view.dart';

class NextDaysView extends StatefulWidget {
  final CityModel? actualCity;
  final ValueSetter<CityModel> updateSelectedCityCallback;
  final VoidCallback getLocationCallback;
  final ValueSetter<int> changeScreenCallback;

  const NextDaysView(
      {super.key,
      required this.actualCity,
      required this.updateSelectedCityCallback,
      required this.getLocationCallback,
      required this.changeScreenCallback});

  @override
  State<NextDaysView> createState() => _NextDaysViewState();
}

class _NextDaysViewState extends State<NextDaysView> {
  final NextDaysController _nextDaysController = NextDaysController();

  Future<CityModel>? selectedCityNextDaysWeather;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: FutureBuilder(
        future: getSelectedCityWeatherForNextDays(),
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
          return NextDaysDataView(nextDaysReport: snapshot.data as CityModel);
        },
      ),
    );
  }

  getSelectedCityWeatherForNextDays() async {
    if (widget.actualCity == null) {
      return null;
    }
    CityModel response = await _nextDaysController
        .getWeatherForSelectedCity(widget.actualCity as CityModel);
    selectedCityNextDaysWeather = Future.value(response);
    widget.updateSelectedCityCallback(response);
    return selectedCityNextDaysWeather;
  }
}
