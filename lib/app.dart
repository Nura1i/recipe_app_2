import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/pages/login_page.dart';
import 'package:recipe_app/utils/theme/themes.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: AppTheme.whiteTheme,
        initial: AppTheme.currentSavedTheme ?? AdaptiveThemeMode.dark,
        builder: (light, dark) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cooking Recipe',
            home: loginPage()
            // HomePage()
            //  MultiBlocProvider(
            //   providers:[
            //    BlocProvider(create:(context) => ,)
            //   ],
            //    child: HomePage())
            ));
  }
}
