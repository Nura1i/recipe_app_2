import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/pages/home/home_pages.dart';
import 'package:recipe_app/utils/theme/themes.dart';


class AppProvider extends StatelessWidget {
  const AppProvider({super.key});
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.whiteTheme,
       initial: AppTheme.currentSavedTheme??AdaptiveThemeMode.dark,
        builder:(light, dark) => MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:HomePage()
     // HomePage()
      //  MultiBlocProvider(
      //   providers:[
      //    BlocProvider(create:(context) => ,)
      //   ],
      //    child: HomePage())
    )
  );
  }
}
