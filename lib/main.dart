import 'package:weatherreport/themes/base_theme.dart';
import 'package:weatherreport/view/main_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Report',
      theme: baseTheme,
      home: const MainView(),
    );
  }
}
