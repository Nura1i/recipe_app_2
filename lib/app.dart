import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/login/sign_in_cubit.dart';
import 'package:recipe_app/blocs/login/sign_up_cubit.dart';
import 'package:recipe_app/pages/Menu/menu_page.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/pages/sign_in_page.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';
import 'package:recipe_app/utils/theme/themes.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: AppTheme.whiteTheme,
        initial: AppTheme.currentSavedTheme ?? AdaptiveThemeMode.dark,
        builder: (light, dark) => MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              //  home: const signUpPage()
              // HomePage()
              // home: signUpView()

              home: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => SignUpCubit(),
                    ),
                    BlocProvider(
                      create: (context) => SignInCubit(),
                    )
                  ],
                  child: FutureBuilder(
                      future: Prefs.loadData<String>(key: 'token'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return const MenuPage();
                        }
                        return const SignInPage();
                      })),
              debugShowCheckedModeBanner: false,
            ));
  }
}
