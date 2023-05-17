import 'dart:convert';
import 'dart:io';

import 'package:climatempo/model/city_model.dart';
import 'package:climatempo/themes/base_theme.dart';
import 'package:climatempo/view/about_view.dart';
import 'package:climatempo/view/favorites_view.dart';
import 'package:climatempo/view/forecast_view.dart';
import 'package:climatempo/view/next_days_view.dart';
import 'package:climatempo/view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedTab = 0;
  String title = '';
  bool asPermissionGaranted = false;

  List<CityModel> listOfFavoriteCities = [];

  PageController _pageController = PageController(initialPage: 0);

  CityModel? selectedCity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _readData().then((data) {
        if (data != null) {
          listOfFavoriteCities = List<CityModel>.from(jsonDecode(data)
              .map((json) => CityModel.fromFavoritesJsonToFavoritesList(json)));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          _selectedTab > 1 || selectedCity == null
              ? Container()
              : asSelectedCityFavorited()
                  ? IconButton(
                      onPressed: removeSelectedCityFromFavorites,
                      icon: Icon(Icons.favorite, color: Colors.redAccent),
                    )
                  : IconButton(
                      onPressed: saveSelectedCityAsFavorite,
                      icon: Icon(Icons.favorite),
                    )
        ],
      ),
      backgroundColor: baseTheme.backgroundColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: changeSelectedTab,
        children: [
          ForecastView(
            actualCity: selectedCity,
            updateSelectedCityCallback: setSelectedCity,
          ),
          NextDaysView(
            actualCity: selectedCity,
            updateSelectedCityCallback: setSelectedCity,
          ),
          SearchView(
              setSelectedCityCallback: setSelectedCity,
              changeScreenCallback: _changeScreenWithoutAnimation),
          FavoritesView(
              listOfFavoriteCities: listOfFavoriteCities,
              updateSelectedCityCallback: setSelectedCity,
              changeScreenCallback: _changeScreenWithoutAnimation),
          AboutView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: selectedIconThemeData,
        unselectedIconTheme: unselectedIconThemeData,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Clima Agora',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_sync),
            label: 'Proximos dias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Sobre',
          ),
        ],
        currentIndex: _selectedTab,
        onTap: _onTabItemTapped,
      ),
    );
  }

  void _onTabItemTapped(index) {
    setState(() {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      _changeTitle(index);
      _selectedTab = index;
    });
  }

  void _changeScreenWithoutAnimation(index) {
    setState(() {
      _pageController.jumpToPage(index);

      _changeTitle(index);
      _selectedTab = index;
    });
  }

  void _changeTitle(index) {
    switch (index) {
      case 0:
      case 1:
        title = selectedCity?.name == null
            ? 'Cidade'
            : selectedCity?.name +
                (selectedCity?.state == null
                    ? ""
                    : (" - " + selectedCity?.state)) +
                " - " +
                selectedCity?.country;
        break;
      case 2:
        title = 'Buscar';
        break;
      case 3:
        title = 'Favoritos';
        break;
      case 4:
        title = 'Sobre';
        break;
    }
  }

  setSelectedCity(CityModel _selectedCity) {
    selectedCity = _selectedCity;
  }

  changeSelectedTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  bool asSelectedCityFavorited() {
    for (CityModel city in listOfFavoriteCities) {
      if (selectedCity?.latitude == city.latitude &&
          selectedCity?.latitude != null &&
          selectedCity?.longitude == city.longitude &&
          selectedCity?.longitude != null) {
        return true;
      }
    }
    return false;
  }

  onFavoriteButtonPressed() {}

  saveSelectedCityAsFavorite() {
    if (selectedCity?.latitude != null && selectedCity?.longitude != null) {
      listOfFavoriteCities.add(selectedCity as CityModel);
      setState(() {
        _saveFavoritesData();
      });
    }
  }

  removeSelectedCityFromFavorites() {
    for (CityModel city in listOfFavoriteCities) {
      if (selectedCity?.latitude == city.latitude &&
          selectedCity?.latitude != null &&
          selectedCity?.longitude == city.longitude &&
          selectedCity?.longitude != null) {
        listOfFavoriteCities.remove(city);
        setState(() {
          _saveFavoritesData();
        });
        return;
      }
    }
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File?> _saveFavoritesData() async {
    PermissionStatus permission = await Permission.storage.request();
    if (permission.isGranted) {
      List<Map<String, dynamic>> mapList = [];

      for (var city in listOfFavoriteCities) {
        mapList.add(city.toJson());
      }
      String data = jsonEncode(mapList);

      final file = await _getFile();
      return file.writeAsString(data);
    }
    return null;
  }

  Future<String?> _readData() async {
    try {
      PermissionStatus permission = await Permission.storage.request();
      if (permission.isGranted) {
        final file = await _getFile();
        if (file.existsSync()) {
          return file.readAsString();
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
