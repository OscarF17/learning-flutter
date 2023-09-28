import 'package:flutter/material.dart';
import 'package:mortgage/ui/mortgage_app.dart';

ColorScheme myColorScheme() {
  return ColorScheme(
      background: Colors.black,
      brightness: Brightness.light,
      error: Colors.red,
      onBackground: Colors.white,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      primary: Colors.blue,
      secondary: Colors.green,
      surface: Colors.white);
}

void main() => runApp(new MaterialApp(
      title: "Mortgage App",
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey,
          colorScheme: ,
          textTheme: TextTheme(displayLarge: TextStyle(fontSize: 36))),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: MortgageApp(),
    ));
