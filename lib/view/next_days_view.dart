import 'package:climatempo/controller/next_days_controller.dart';
import 'package:climatempo/model/city_model.dart';
import 'package:climatempo/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:date_format/date_format.dart';

class NextDaysView extends StatefulWidget {
  final CityModel? actualCity;
  final ValueSetter<CityModel> updateSelectedCityCallback;

  const NextDaysView({
    super.key,
    required this.actualCity,
    required this.updateSelectedCityCallback,
  });

  @override
  State<NextDaysView> createState() => _NextDaysViewState();
}

class _NextDaysViewState extends State<NextDaysView> {
  NextDaysController _nextDaysController = NextDaysController();

  Future<CityModel>? selectedCityNextDaysWeather;

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.actualCity != null) {
        getSelectedCityWeatherForNextDays();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: FutureBuilder(
        future: selectedCityNextDaysWeather,
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
    CityModel response = await _nextDaysController
        .getWeatherForSelectedCity(widget.actualCity as CityModel);
    selectedCityNextDaysWeather = Future.value(response);
    widget.updateSelectedCityCallback(response);
    if (this.mounted) {
      setState(() {});
    }
  }
}
