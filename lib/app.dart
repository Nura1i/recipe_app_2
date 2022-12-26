import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/adaptive_theme/adaptive_cubit.dart';
import 'package:recipe_app/blocs/camera/camera_cubit.dart';
import 'package:recipe_app/blocs/card%20block/list_post_cubit.dart';
import 'package:recipe_app/blocs/like%20and%20saved/likedIcon_cubit.dart';
import 'package:recipe_app/blocs/like%20and%20saved/savedIcon_cubit.dart';
import 'package:recipe_app/blocs/localization/localization_cubit.dart';

import 'package:recipe_app/blocs/login/sign_in_cubit.dart';
import 'package:recipe_app/blocs/login/sign_up_cubit.dart';
import 'package:recipe_app/pages/Menu/menu_page.dart';
import 'package:recipe_app/pages/sign_up_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';
import 'package:recipe_app/utils/theme/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppProvider extends StatefulWidget {
  const AppProvider({super.key});

  @override
  State<AppProvider> createState() => _AppProviderState();

  static void setLLocale(BuildContext context, Locale newLocale) {
    _AppProviderState? state =
        context.findAncestorStateOfType<_AppProviderState>();
    state!.ssetLocale(newLocale);
  }
}

class _AppProviderState extends State<AppProvider> {
  @override

//  void initState() {
//     super.initState();
//     BlocProvider.of<LocaleCubit>(context).chooseLocale(Locale('uz'));
//   }
  Locale? _locale;
  @override
  ssetLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => ssetLocale(locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignUpCubit(),
          ),
          BlocProvider(
            create: (context) => SignInCubit(),
          ),
          BlocProvider(
            create: (context) => ListPostCubit(),
          ),
          BlocProvider(
            create: (context) => LikedCubit(),
          ),
          BlocProvider(
            create: (context) => SavedCubit(),
          ),
          BlocProvider(
            create: (context) => AdaptiveCubit(),
          ),
          BlocProvider(
            create: (context) => LocaleCubit(),
          ),
          BlocProvider(
            create: (context) => CameraCubit(),
          )
        ],
        child: AdaptiveTheme(
            light: AppTheme.whiteTheme,
            dark: AppTheme.darkTheme,
            initial: AppTheme.currentSavedTheme ?? AdaptiveThemeMode.light,
            builder: (light, dark) => MaterialApp(
                title: 'Recipe App',
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: _locale,
                darkTheme: dark,
                theme: light,
                home: FutureBuilder(
                    future: Prefs.loadData<String>(key: 'token'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return const MenuPage();
                      }
                      return const SignUpPage();
                    }))));
  }
}
