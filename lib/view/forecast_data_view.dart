// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weatherreport/model/weather_model.dart';

class ForecastDataView extends StatelessWidget {
  final weatherReport;
  const ForecastDataView({super.key, required this.weatherReport});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        weatherReport.actualWeather.temperature,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const Spacer(),
                      ImageIcon(
                        weatherReport.actualWeather.icon,
                        size: MediaQuery.of(context).size.width * 0.25,
                      ),
                    ],
                  ),
                  const Divider(thickness: 2),
                  Text(
                    formatDate(weatherReport.actualWeather.dateTime,
                        [dd, '/', mm, '/', yyyy]),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      WeatherModel().weekdays[
                          weatherReport.actualWeather.dateTime.weekday - 1],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const Divider(thickness: 2),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        const Icon(Icons.cloud_circle),
                        Text(
                          " " +
                              weatherReport.actualWeather.clouds +
                              " de nuvens",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        const Icon(Icons.water_drop),
                        Text(
                          " " +
                              weatherReport.actualWeather.humidity +
                              " de humidade",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        const Icon(Icons.lock_clock),
                        Text(
                          " " +
                              formatDate(weatherReport.actualWeather.dateTime,
                                  [HH, ':', nn]),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        const Icon(Icons.cloud),
                        Text(
                          " O tempo esta: " + weatherReport.actualWeather.sky,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  weatherReport.actualWeather.rain1h == "0"
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              const Icon(Icons.water_sharp),
                              Text(
                                " Millimitros chovidos na ultima hora: " +
                                    weatherReport.actualWeather.rain1h,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                  weatherReport.actualWeather.rain3h == "0"
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              const Icon(Icons.water_sharp),
                              Text(
                                " Millimitros chovidos nas ultimas 3 horas: " +
                                    weatherReport.actualWeather.rain3h,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        const Icon(Icons.circle),
                        Text(
                          " Sensação termica de " +
                              weatherReport.actualWeather.feelsLike,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        const Icon(Icons.wind_power),
                        Text(
                          " Ventos de " +
                              weatherReport.actualWeather.windSpeed +
                              " - " +
                              weatherReport.actualWeather.windDegree,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
