import 'dart:ui';

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
  headlineLarge: TextStyle(color: Colors.white, fontSize: 96),
  headlineMedium: TextStyle(color: Colors.white),
  headlineSmall: TextStyle(color: Colors.white),
  bodySmall: TextStyle(color: Colors.white),
  bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
  bodyLarge: TextStyle(color: Colors.white),
  labelSmall: TextStyle(color: Colors.white),
  titleSmall: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  titleMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  displaySmall: TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.lightBlueAccent),
);

IconThemeData unselectedIconThemeData = IconThemeData(
  color: Color.fromRGBO(1, 85, 128, 0.5),
);

IconThemeData selectedIconThemeData = IconThemeData(
  color: Colors.white,
);
