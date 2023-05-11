import 'package:climatempo/controller/forecast_controller.dart';
import 'package:climatempo/model/city_model.dart';
import 'package:flutter/material.dart';
import 'package:climatempo/view/location_not_found.view.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ForecastView extends StatefulWidget {
  final CityModel? actualCity;

  const ForecastView({super.key, required this.actualCity});

  @override
  State<ForecastView> createState() => _ForecastViewState();
}

class _ForecastViewState extends State<ForecastView> {
  ForecastController _forecastController = ForecastController();

  Future<CityModel>? selectedCityWeather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.actualCity != null) {
        getWeatherForSelectedCity();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var maxItemCount = 10;
    return SingleChildScrollView(
        child: FutureBuilder(
      future: selectedCityWeather,
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.hasError ||
            snapshot.connectionState != ConnectionState.done ||
            snapshot == null) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        CityModel weatherReport = snapshot.data as CityModel;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            weatherReport.actualWeather.temperature.toString() +
                                "°",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Spacer(),
                          Icon(
                            Icons.cloud,
                            size: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Icon(Icons.cloud_circle),
                            Text(
                              weatherReport.actualWeather.clouds.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Icon(Icons.water_drop),
                            Text(
                              weatherReport.actualWeather.humidity.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Icon(Icons.lock_clock),
                            Text(
                              weatherReport.actualWeather.dateTime.hour
                                      .toString() +
                                  ":" +
                                  weatherReport.actualWeather.dateTime.minute
                                      .toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        weatherReport.actualWeather.dateTime.day.toString() +
                            "/" +
                            weatherReport.actualWeather.dateTime.month
                                .toString() +
                            "/" +
                            weatherReport.actualWeather.dateTime.year
                                .toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          weatherReport.actualWeather.dateTime.weekday
                              .toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Divider(thickness: 2),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(Icons.cloud),
                            Text(
                              weatherReport.actualWeather.sky,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(Icons.thunderstorm),
                            Text(
                              weatherReport.actualWeather.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(Icons.circle),
                            Text(
                              weatherReport.actualWeather.feelsLike.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(Icons.wind_power),
                            Text(
                              'Ventos de ' +
                                  weatherReport.actualWeather.windSpeed
                                      .toString() +
                                  "Km/H - " +
                                  weatherReport.actualWeather.windDegree
                                      .toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ));
  }

  getWeatherForSelectedCity() async {
    selectedCityWeather = Future.value(await _forecastController
        .getWeatherForSelectedCity(widget.actualCity as CityModel));
    setState(() {});
  }
}
