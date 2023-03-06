import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'dark_theme.dart';
part 'white_theme.dart';

class AppTTheme {
  static final ThemeData whiteeTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    canvasColor: Colors.orange,
    splashColor: Colors.white,
    primaryColor: const Color(0xFFB3A1F8),
    iconTheme: const IconThemeData(color: Colors.black),
    shadowColor: Colors.white,
    focusColor: const Color.fromARGB(255, 13, 25, 36),
    hoverColor: const Color.fromARGB(255, 13, 25, 36), 
    textTheme: darkTextTheme
  );

  static final ThemeData darkkTheme = ThemeData.dark().copyWith(
    backgroundColor: const Color.fromARGB(255, 13, 25, 36),
    primaryColor: const Color(0xFF574699),
    splashColor: const Color(0xFF201F24),
    canvasColor: const Color.fromARGB(255, 13, 25, 36),
    shadowColor: const Color.fromARGB(255, 90, 57, 6),
    focusColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white),
    hoverColor: Colors.white,
     textTheme: lightTextTheme
  );
}
