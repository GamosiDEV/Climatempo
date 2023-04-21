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

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: baseTheme.backgroundColor,
      body: Center(
        child: PageView(
          controller: _pageController,
          onPageChanged: (value) {
            setState(() {
              _selectedTab = value;
            });
          },
          children: [
            ForecastView(),
            NextDaysView(),
            SearchView(),
            FavoritesView(),
            AboutView(),
          ],
        ),
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
      _selectedTab = index;
    });
  }
}
