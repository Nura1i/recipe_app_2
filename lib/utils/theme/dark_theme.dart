// part of 'theme_configg.dart';

// var darkTextTheme = TextTheme().copyWith(
//     bodyMedium: const TextStyle(
//       color: Colors.black,
//     ),
//     bodyLarge: const TextStyle(
//       color: Colors.black,
//     ),
//     displayMedium: const TextStyle(color: Colors.black),
//     displaySmall: const TextStyle(
//       color: Colors.black,
//     ),
//     bodySmall: const TextStyle(color: Colors.black),
//     titleLarge: const TextStyle(color: Colors.black));



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 TextTheme darkTextTheme = TextTheme(
    bodyText1: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'SFPro',
        color: Colors.red),
    bodyMedium: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontFamily: 'SFPro',
    ),
    bodyLarge: TextStyle(
      fontSize: 30.sp,
      fontWeight: FontWeight.w700,
      fontFamily: 'Parisienne',
      color: Colors.black,
    ),
    displayMedium: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        color: Colors.black),
    displaySmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto',
      color: Colors.black,
    ),
    bodySmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'SFPro',
        color: Colors.black),
    titleLarge: const TextStyle(color: Colors.black));