import 'package:flutter/material.dart';

ThemeData baseTheme = ThemeData(
  primaryColor: Colors.lightBlue,
  canvasColor: Colors.lightBlue,
  textTheme: textTheme.apply(),
  iconTheme: selectedIconThemeData,
  fontFamily: 'Montserrat',
  cardColor: Color.fromRGBO(2, 137, 204, 0.8),
  cardTheme: CardTheme(
    margin: EdgeInsets.all(8.0),
    elevation: 8.0,
  ),
  elevatedButtonTheme: elevatedButtonThemeData,
  backgroundColor: Color.fromRGBO(40, 98, 128, 0.5),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue),
);

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromRGBO(255, 247, 15, 1),
  ),
);

TextTheme textTheme = TextTheme(
  headline1: TextStyle(color: Colors.white),
  headline2: TextStyle(color: Colors.white),
  headline3: TextStyle(color: Colors.white),
  headline4: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  headline5: TextStyle(color: Colors.white),
  headline6: TextStyle(color: Colors.white),
  subtitle1: TextStyle(color: Colors.white),
  subtitle2: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
  bodyText1: TextStyle(color: Colors.white),
);

IconThemeData unselectedIconThemeData = IconThemeData(
  color: Color.fromRGBO(1, 85, 128, 0.5),
);

IconThemeData selectedIconThemeData = IconThemeData(
  color: Colors.white,
);
