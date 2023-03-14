import 'dart:ui';

import 'package:flutter/material.dart';


class AppTTheme {
  
  static final ThemeData whiteeTheme = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    canvasColor: Colors.orange,


    textTheme: const TextTheme(
     titleMedium: TextStyle(color: Colors.green),
     titleSmall: TextStyle(color: Colors.black)),


    splashColor: Colors.white,
    primaryColor: const Color(0xFFB3A1F8),
    iconTheme: const IconThemeData(color: Colors.black),
    shadowColor: Colors.white,
    highlightColor: Colors.white,
    focusColor: const Color.fromARGB(255, 13, 25, 36),
    hoverColor: const Color.fromARGB(255, 13, 25, 36),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.white.withOpacity(0.1)),
  );



  static final ThemeData darkkTheme = ThemeData.dark().copyWith(
      backgroundColor: const Color.fromARGB(255, 13, 25, 36),
      primaryColor: const Color(0xFF574699),
      splashColor: const Color(0xFF201F24),
      canvasColor: const Color.fromARGB(255, 13, 25, 36),
      highlightColor: Colors.orange,


      textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.amber),
        titleSmall: TextStyle(color: Colors.white)),

      
      shadowColor: const Color.fromARGB(255, 90, 57, 6),
      focusColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      hoverColor: Colors.white);
}

