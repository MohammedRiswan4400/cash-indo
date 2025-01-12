import 'package:cash_indo/core/color/app_color.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: const Color.fromARGB(255, 246, 246, 246),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: AppColor.kBackgroundColor,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
  );
}
