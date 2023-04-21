import 'package:flutter/material.dart';

ThemeData baseTheme = ThemeData(
  primaryColor: Colors.lightBlue,
  canvasColor: Colors.lightBlue,
  backgroundColor: Color.fromRGBO(40, 98, 128, 0.5),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.lightBlue,
  ),
);

IconThemeData unselectedIconThemeData = IconThemeData(
  color: Color.fromRGBO(1, 85, 128, 0.5),
);

IconThemeData selectedIconThemeData = IconThemeData(
  color: Colors.white,
);
