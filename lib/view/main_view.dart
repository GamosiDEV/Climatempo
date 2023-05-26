// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_cast

import 'dart:convert';
import 'dart:io';

import 'package:weatherreport/model/city_model.dart';
import 'package:weatherreport/model/weather_model.dart';
import 'package:weatherreport/themes/base_theme.dart';
import 'package:weatherreport/view/about_view.dart';
import 'package:weatherreport/view/favorites_view.dart';
import 'package:weatherreport/view/forecast_view.dart';
import 'package:weatherreport/view/next_days_view.dart';
import 'package:weatherreport/view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location;

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedTab = 0;
  String appBarTitle = '';
  bool asPermissionGaranted = false;
  List<CityModel> listOfFavoriteCities = [];
  final PageController _pageController = PageController(initialPage: 0);
  CityModel? selectedCity;

  @override
  void initState() {
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
        actions: [
          _selectedTab > 1 || selectedCity == null
              ? Container()
              : asSelectedCityFavorited()
                  ? IconButton(
                      onPressed: removeSelectedCityFromFavorites,
                      icon: const Icon(Icons.favorite, color: Colors.redAccent),
                    )
                  : IconButton(
                      onPressed: saveSelectedCityAsFavorite,
                      icon: Icon(Icons.favorite,
                          color: unselectedIconThemeData.color),
                    ),
          IconButton(
            onPressed: verifyLocalizationPermissionAndGetLocation,
            alignment: Alignment.center,
            icon: Icon(Icons.location_on,
                color: Theme.of(context).iconTheme.color),
          ),
        ],
        title: Text(
          appBarTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      backgroundColor: baseTheme.backgroundColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: changeSelectedTab,
        children: [
          ForecastView(
              actualCity: selectedCity,
              updateSelectedCityCallback: setSelectedCity,
              getLocationCallback: verifyLocalizationPermissionAndGetLocation,
              changeScreenCallback: _changeScreenWithoutAnimation,
              setCityNameToTittleCallback: setCityNameToTittle),
          NextDaysView(
            actualCity: selectedCity,
            updateSelectedCityCallback: setSelectedCity,
            getLocationCallback: verifyLocalizationPermissionAndGetLocation,
            changeScreenCallback: _changeScreenWithoutAnimation,
          ),
          SearchView(
              setSelectedCityCallback: setSelectedCity,
              changeScreenCallback: _changeScreenWithoutAnimation),
          FavoritesView(
              listOfFavoriteCities: listOfFavoriteCities,
              updateSelectedCityCallback: setSelectedCity,
              changeScreenCallback: _changeScreenWithoutAnimation),
          const AboutView(),
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

  void setCityNameToTittle(cityName) {
    if (cityName == appBarTitle) {
      return;
    }
    appBarTitle = cityName;
    setState(() {});
  }

  void _changeTitle(index) {
    switch (index) {
      case 0:
      case 1:
        setCityNameToTittle(selectedCity?.name == null
            ? 'Cidade'
            : selectedCity?.name +
                (selectedCity?.state == null
                    ? ""
                    : (" - " + selectedCity?.state)) +
                " - " +
                selectedCity?.country);
        break;
      case 2:
        appBarTitle = 'Buscar';
        break;
      case 3:
        appBarTitle = 'Favoritos';
        break;
      case 4:
        appBarTitle = 'Sobre';
        break;
    }
  }

  setSelectedCity(CityModel selectedCity) {
    this.selectedCity = selectedCity;
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
    if (requestStoragePermission()) {
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

  requestStoragePermission() async {
    PermissionStatus permission = await Permission.storage.request();
    return permission.isGranted;
  }

  Future<String?> _readData() async {
    try {
      if (requestStoragePermission()) {
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

  verifyLocalizationPermissionAndGetLocation() async {
    var localization = location.Location();
    var locationServiceEnabled = await localization.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await localization.requestService();
      if (!locationServiceEnabled) {
        return;
      }
    }

    var permissionGranted = await localization.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await localization.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    var currentLocation = await localization.getLocation();

    selectedCity ??= CityModel(actualWeather: WeatherModel(), nextDays: []);
    selectedCity?.latitude = currentLocation.latitude;
    selectedCity?.longitude = currentLocation.longitude;
    _changeScreenWithoutAnimation(0);
    setState(() {});
  }

  hasLocalizationAndPermissionGranted(localization) async {
    return true;
  }
}
