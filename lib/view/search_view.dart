import 'package:weatherreport/controller/search_controller.dart';
import 'package:weatherreport/model/city_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchView extends StatefulWidget {
  final ValueSetter<CityModel> setSelectedCityCallback;
  final ValueSetter<int> changeScreenCallback;

  SearchView(
      {super.key,
      required this.setSelectedCityCallback,
      required this.changeScreenCallback});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController _searchTextController = TextEditingController();
  SearchController _searchController = SearchController();

  var searchedCitys;

  @override
  Widget build(BuildContext context) {
    var maxItemCount = 100;
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _searchTextController,
            onSubmitted: citySearch,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.question_mark,
                      color: Theme.of(context).iconTheme.color),
                  onPressed: () {
                    Fluttertoast.showToast(
                      msg:
                          "Para uma pesquisa detalhada digite os nomes da seguinte forma: Cidade, Estado, País",
                      toastLength: Toast.LENGTH_SHORT,
                      textColor: Colors.black,
                      fontSize: 16,
                      backgroundColor: Colors.grey[200],
                    );
                  },
                ),
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                prefixIcon: Icon(Icons.search,
                    color: Theme.of(context).iconTheme.color),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: 'Digite sua busca'),
          ),
          Expanded(
            child: FutureBuilder(
              future: searchedCitys,
              builder: (context, snapshot) {
                print(snapshot.data);
                if (!snapshot.hasData ||
                    snapshot.hasError ||
                    snapshot.connectionState != ConnectionState.done) {
                  return Container();
                }
                List<CityModel> listOfSearchedCitys =
                    snapshot.data as List<CityModel>;
                return ListView.builder(
                  itemCount: listOfSearchedCitys.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        widget.setSelectedCityCallback(
                            listOfSearchedCitys[index]);
                        widget.changeScreenCallback(0);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listOfSearchedCitys[index].name,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text(
                                  listOfSearchedCitys[index].state +
                                      " - " +
                                      listOfSearchedCitys[index].country,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
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
              },
            ),
          ),
        ],
      ),
    );
  }

  void citySearch(cityName) async {
    searchedCitys = Future.value(await _searchController.citySearch(cityName));
    setState(() {});
  }
}
