import 'package:flutter/material.dart';
import 'ui/home.dart';

/*
void main() {
  runApp(const ScaffoldExample());
}
*/
final ThemeData _appTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      brightness: Brightness.dark,
      primaryColor: Colors.green,
      scaffoldBackgroundColor: Colors.red,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.green,
          onPrimary: Colors.amber,
          secondary: Colors.pink,
          onSecondary: Colors.pink,
          error: Colors.red,
          onError: Colors.black,
          background: Colors.amber,
          onBackground: Colors.pink,
          surface: Colors.pink,
          onSurface: Colors.pink));
}

void main() => runApp(MaterialApp(
      theme: _appTheme,
      /*
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.grey[800],
          textTheme: TextTheme(
              displayMedium: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
              bodyMedium: TextStyle(
                fontSize: 16.9,
                color: Colors.white,
              ))),
              */
      home: MovieListView(),
    ));
