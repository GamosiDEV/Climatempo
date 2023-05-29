import 'package:flutter/material.dart';

ThemeData baseTheme = ThemeData(
  primaryColor: Colors.lightBlue,
  canvasColor: Colors.lightBlue,
  textTheme: textTheme.apply(),
  iconTheme: selectedIconThemeData,
  fontFamily: 'Montserrat',
  cardColor: const Color.fromRGBO(2, 137, 204, 0.8),
  cardTheme: const CardTheme(
    margin: EdgeInsets.all(8.0),
    elevation: 8.0,
  ),
  elevatedButtonTheme: elevatedButtonThemeData,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue),
);

Color backgroundColor = const Color.fromRGBO(40, 98, 128, 0.5);

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromRGBO(255, 247, 15, 1),
  ),
);

TextTheme textTheme = const TextTheme(
  headlineLarge: TextStyle(color: Colors.white, fontSize: 96),
  headlineMedium: TextStyle(color: Colors.white),
  headlineSmall: TextStyle(color: Colors.white),
  bodySmall: TextStyle(color: Colors.white),
  bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
  bodyLarge: TextStyle(color: Colors.white),
  labelSmall: TextStyle(color: Colors.white),
  titleSmall:
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
  titleMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  displaySmall: TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.lightBlueAccent),
);

IconThemeData unselectedIconThemeData = const IconThemeData(
  color: Color.fromRGBO(1, 85, 128, 0.5),
);

IconThemeData selectedIconThemeData = const IconThemeData(
  color: Colors.white,
);
