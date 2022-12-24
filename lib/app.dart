import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/card%20block/list_post_cubit.dart';
import 'package:recipe_app/blocs/like%20and%20saved/likedIcon_cubit.dart';
import 'package:recipe_app/blocs/like%20and%20saved/savedIcon_cubit.dart';

import 'package:recipe_app/blocs/login/sign_in_cubit.dart';
import 'package:recipe_app/blocs/login/sign_up_cubit.dart';
import 'package:recipe_app/pages/Menu/menu_page.dart';
import 'package:recipe_app/pages/sign_up_page.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';
import 'package:recipe_app/utils/theme/themes.dart';

class AppProvider extends StatefulWidget {
  const AppProvider({super.key});

  @override
  State<AppProvider> createState() => _AppProviderState();
}

class _AppProviderState extends State<AppProvider> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SignInCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ListPostCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SavedCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => LikedCubit(),
        ),
      ],
      child: AdaptiveTheme(
          light: AppTheme.whiteTheme,
          initial: AppTheme.currentSavedTheme ?? AdaptiveThemeMode.dark,
          builder: (light, dark) => MaterialApp(
                title: 'Recipe App',
                //localizationsDelegates: AppLocalizations.localizationsDelegates,
                // supportedLocales: AppLocalizations.supportedLocales,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                //  home: const signUpPage()
                // HomePage()
                // home: signUpView()

                home: FutureBuilder(
                    future: Prefs.loadData<String>(key: 'token'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return const MenuPage();
                      }
                      return const SignUpPage();
                    }),
                debugShowCheckedModeBanner: false,
              )),
    );
  }
}
