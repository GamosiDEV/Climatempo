import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:weatherreport/model/city_model.dart';
import 'package:weatherreport/model/weather_model.dart';

class NextDaysDataView extends StatelessWidget {
  final CityModel nextDaysReport;
  const NextDaysDataView({super.key, required this.nextDaysReport});

  @override
  Widget build(BuildContext context) {
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
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              formatDate(
                                  nextDaysReport.nextDays[index].dateTime,
                                  [dd, '/', mm, '/', yyyy]),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Text(
                            WeatherModel().weekdays[nextDaysReport
                                    .nextDays[index].dateTime.weekday -
                                1],
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.water_drop),
                              Text(
                                nextDaysReport.nextDays[index].humidity,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                nextDaysReport.nextDays[index].temperature,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              ImageIcon(
                                nextDaysReport.nextDays[index].icon,
                                size: MediaQuery.of(context).size.width * 0.10,
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
  }
}
