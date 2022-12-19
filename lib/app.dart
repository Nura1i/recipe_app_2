import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/card%20block/list_post_cubit.dart';
import 'package:recipe_app/blocs/login/sign_in_cubit.dart';
import 'package:recipe_app/blocs/login/sign_up_cubit.dart';
import 'package:recipe_app/pages/Menu/menu_page.dart';
import 'package:recipe_app/pages/sign_up_page.dart';
import 'package:recipe_app/utils/theme/themes.dart';

import 'utils/shared_pref/preferences.dart' ;


 class AppProvider extends StatefulWidget {
  const AppProvider({super.key});

  @override
  State<AppProvider> createState() => _AppProviderState();
  
  static void setLocale(BuildContext context, Locale newLocale) {
    _AppProviderState? state = context.findAncestorStateOfType<_AppProviderState>();
    state?.setLocale(newLocale);
  }
}

class _AppProviderState extends State<AppProvider> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }
    

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
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

              home: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => SignUpCubit(),
                    ),
                    BlocProvider(
                      create: (context) => SignInCubit(),
                    ),
                    BlocProvider(
                      create: (context) => ListPostCubit(),
                    )
                  ],
                  child: FutureBuilder(
                      future: Prefs.loadData<String>(key: 'token'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return const MenuPage();
                        }
                        return const SignUpPage();
                      })),
              debugShowCheckedModeBanner: false,
            ));
  }
}