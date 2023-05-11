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
  @override
  Widget build(BuildContext context) {
    var maxItemCount = 10;
    return SingleChildScrollView(
      child: Column(
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
                          '35°',
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
                            'Levemente nublado',
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
                            '46%',
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
                            '14:29',
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
          Container(
            margin: EdgeInsets.all(8.0),
            height: 100,
            child: ListView.builder(
              itemCount: maxItemCount,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Min",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    "10°",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Max",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    "30°",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(Icons.cloud),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            '15:30',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                    index != maxItemCount - 1
                        ? VerticalDivider(thickness: 2)
                        : Container()
                  ],
                );
              },
            ),
          ),
          Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "24/04/2023",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Spacer(),
                        Icon(Icons.arrow_upward, color: Colors.red),
                        Text(
                          '30°',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Spacer(),
                        Icon(Icons.arrow_downward,
                            color: Color.fromRGBO(15, 255, 205, 1)),
                        Text(
                          '10°',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Divider(thickness: 2),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(Icons.cloud),
                        Text(
                          'Probabilidade de Nuvens',
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
                          'Feels Like',
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
                          'Probabilidade de Tempestades',
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
                          'Ventos há 10km/h - N',
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

  String changeCityAppBarName() {
    return '';
  }
}
