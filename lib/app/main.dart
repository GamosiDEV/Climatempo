import 'package:climatempo/themes/base_theme.dart';
import 'package:climatempo/view/main_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Report',
      theme: baseTheme,
      home: const MainView(),
    );
  }
}
