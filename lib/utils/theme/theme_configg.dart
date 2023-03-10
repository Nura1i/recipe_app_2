import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';


// part 'dark_theme.dart';
class AppTTheme {
  // static  AdaptiveThemeMode? currentSavedTheme = AdaptiveThemeMode.light;
  static final ThemeData whiteeTheme = ThemeData.light().copyWith(
    //  brightness: Brightness.light,
    backgroundColor: Colors.white,
    canvasColor: Colors.orange,
    //  textTheme: darkTextTheme,
    splashColor: Colors.white,
    primaryColor: const Color(0xFFB3A1F8),
    iconTheme: const IconThemeData(color: Colors.black),
    shadowColor: Colors.white,
    highlightColor: Colors.orange,
    focusColor: const Color.fromARGB(255, 13, 25, 36),
    hoverColor: const Color.fromARGB(255, 13, 25, 36),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.white.withOpacity(0.1)),
  );

  static final ThemeData darkkTheme = ThemeData.dark().copyWith(
      //  brightness: Brightness.dark,
      backgroundColor: const Color.fromARGB(255, 13, 25, 36),
      primaryColor: const Color(0xFF574699),
      splashColor: const Color(0xFF201F24),
      canvasColor: const Color.fromARGB(255, 13, 25, 36),
      highlightColor: Colors.orange,
      //textTheme: lightTextTheme,
      shadowColor: const Color.fromARGB(255, 90, 57, 6),
      focusColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      hoverColor: Colors.white);
}
//
// class AppTheme {
//     static AdaptiveThemeMode? currentSavedTheme=AdaptiveThemeMode.light;
//      static final ThemeData whiteTheme=ThemeData(
//     textTheme: lightTextTheme,
//     backgroundColor: Colors.white,
//     primarySwatch: Colors.grey,
//     splashColor: Colors.white,
//      primaryColor: const Color(0xFFB3A1F8),

//   );
//   static final ThemeData darkTheme=ThemeData(
//     backgroundColor: Colors.black,
//     primarySwatch: Colors.blue,
//      primaryColor: const Color(0xFF574699),
//     splashColor: const Color(0xFF201F24),
//     textTheme: darkTextTheme

//   );
// }

extension on BuildContext {
  get light {
    AdaptiveTheme.of(this).setLight();
  }

  get dark {
    AdaptiveTheme.of(this).setDark();
  }

  ThemeData get theme {
    return AdaptiveTheme.of(this).theme;
  }

  get changeTheme {
    if (AdaptiveTheme.of(this).mode == AdaptiveThemeMode.dark) {
      light;
    } else {
      dark;
    }
  }
}
