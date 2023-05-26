// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:weatherreport/controller/search_controller.dart';
import 'package:weatherreport/model/city_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weatherreport/view/show_data_search_view.dart';

class SearchView extends StatefulWidget {
  final ValueSetter<CityModel> setSelectedCityCallback;
  final ValueSetter<int> changeScreenCallback;

  const SearchView(
      {super.key,
      required this.setSelectedCityCallback,
      required this.changeScreenCallback});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchTextController = TextEditingController();
  final SearchController _searchController = SearchController();

  var searchedCitys;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
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
                    showSearchHelp();
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
                if (!snapshot.hasData ||
                    snapshot.hasError ||
                    snapshot.connectionState != ConnectionState.done) {
                  return Container();
                }
                return ShowDataSearchView(
                    listOfSearchedCitys: snapshot.data as List<CityModel>,
                    setSelectedCityCallback: widget.setSelectedCityCallback,
                    changeScreenCallback: widget.changeScreenCallback);
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

  showSearchHelp() {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg:
          "Para uma pesquisa detalhada digite os nomes da seguinte forma: Cidade, Estado, País",
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.black,
      fontSize: 16,
      backgroundColor: Colors.grey[200],
    );
  }
}
