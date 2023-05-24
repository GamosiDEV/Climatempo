import 'package:weatherreport/controller/next_days_controller.dart';
import 'package:weatherreport/model/city_model.dart';
import 'package:weatherreport/model/weather_model.dart';
import 'package:weatherreport/view/location_not_found.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:date_format/date_format.dart';

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
  NextDaysController _nextDaysController = NextDaysController();

  Future<CityModel>? selectedCityNextDaysWeather;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
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
          } else if (!snapshot.hasData || snapshot == null) {
            return LocationNotFoundView(
                getLocationCallback: widget.getLocationCallback,
                changeScreenCallback: widget.changeScreenCallback);
          }
          CityModel nextDaysReport = snapshot.data as CityModel;
          return ListView.builder(
            itemCount: nextDaysReport.nextDays.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    formatDate(
                                        nextDaysReport.nextDays[index].dateTime,
                                        [HH, ':', nn]),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    formatDate(
                                        nextDaysReport.nextDays[index].dateTime,
                                        [dd, '/', mm, '/', yyyy]),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Text(
                                  WeatherModel().weekdays[nextDaysReport
                                          .nextDays[index].dateTime.weekday -
                                      1],
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.water_drop),
                                    Text(
                                      nextDaysReport.nextDays[index].humidity,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      nextDaysReport
                                          .nextDays[index].temperature,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    ImageIcon(
                                      nextDaysReport.nextDays[index].icon,
                                      size: MediaQuery.of(context).size.width *
                                          0.10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 2),
                ],
              );
            },
          );
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
