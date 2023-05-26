import 'package:flutter/material.dart';
import 'package:weatherreport/model/city_model.dart';

class ShowDataSearchView extends StatelessWidget {
  final List<CityModel> listOfSearchedCitys;
  final ValueSetter<CityModel> setSelectedCityCallback;
  final ValueSetter<int> changeScreenCallback;

  const ShowDataSearchView(
      {super.key,
      required this.listOfSearchedCitys,
      required this.setSelectedCityCallback,
      required this.changeScreenCallback});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfSearchedCitys.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setSelectedCityCallback(listOfSearchedCitys[index]);
            changeScreenCallback(0);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listOfSearchedCitys[index].name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      listOfSearchedCitys[index].state +
                          " - " +
                          listOfSearchedCitys[index].country,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 2),
            ],
          ),
        );
      },
    );
  }
}
