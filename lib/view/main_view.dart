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

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedTab = 0;
  String title = '';

  PageController _pageController = PageController(initialPage: 0);

  CityModel? selectedCity;

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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite, color: Colors.redAccent),
          ),
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
          FavoritesView(),
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
}
