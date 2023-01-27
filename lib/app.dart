import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/blocs/add_cubits/add_cubit.dart';

import 'package:recipe_app/blocs/card%20block/list_post_cubit.dart';
import 'package:recipe_app/blocs/like%20and%20saved/likedIcon_cubit.dart';
import 'package:recipe_app/blocs/like%20and%20saved/savedIcon_cubit.dart';
import 'package:recipe_app/blocs/localization/localization_cubit.dart';
import 'package:recipe_app/blocs/login/sign_in_cubit.dart';
import 'package:recipe_app/blocs/login/sign_up_cubit.dart';
import 'package:recipe_app/blocs/publish_profile/publishimage_cubit.dart';
import 'package:recipe_app/blocs/search%20Page/searchCubit.dart';
import 'package:recipe_app/diyor_pages/intro_language_page.dart';
import 'package:recipe_app/pages/Menu/menu_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipe_app/utils/theme/theme_configg.dart';

class AppProvider extends StatefulWidget {
  const AppProvider({
    super.key,
  });

  @override
  State<AppProvider> createState() => _AppProviderState();

  static void setLLocale(BuildContext context, Locale newLocale) {
    _AppProviderState? state =
        context.findAncestorStateOfType<_AppProviderState>();
    state!.ssetLocale(newLocale);
  }
}

final isPlatformDark =
    WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
final initTheme = isPlatformDark ? AppTTheme.darkkTheme : AppTTheme.whiteeTheme;

class _AppProviderState extends State<AppProvider> {
  var themmm;
  @override
  void initState() {
    changer();

    super.initState();
  }

  changer() async {
    var themeService = await ThemeService.instance;
    var initThemee = themeService.initial;
    themmm = initThemee;

    return themmm;
  }

  @override
  // void initState() {
  //   changer();
  //   super.initState();
  // }

  @override
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
    ScreenUtil.init(
      context,
      designSize: const Size(390, 870),
    );

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
          create: (context) => LocaleCubit(),
        ),
        BlocProvider(
          create: (context) => CameraCubit(),
        ),
        BlocProvider(
          create: (context) => ImagePublishCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        )
      ],
      child: ThemeProvider(
        duration: const Duration(milliseconds: 600),
        initTheme: initTheme,
        builder: (_, myTheme) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Recipe App',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: _locale,
            
              theme: myTheme,
              home: FutureBuilder(
                  future: Prefs.loadData<String>(key: 'token'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return const LanguageIntroPage();
                    }
                    return const LanguageIntroPage();
                  }));

          //  CustomDrawer(),
        },
      ),

      //  AdaptiveTheme(

      //     light: AppTheme.whiteTheme,
      //     dark: AppTheme.darkTheme,
      //     initial: AppTheme.currentSavedTheme ?? AdaptiveThemeMode.light,
      //     builder: (light, dark) => MaterialApp(
      //         title: 'Recipe App',
      //         localizationsDelegates: AppLocalizations.localizationsDelegates,
      //         supportedLocales: AppLocalizations.supportedLocales,

      //         locale: _locale,
      //         darkTheme: dark,
      //         theme: light,
      //         home: FutureBuilder(
      //             future: Prefs.loadData<String>(key: 'token'),
      //             builder: (context, snapshot) {
      //               if (snapshot.hasData && snapshot.data != null) {
      //                 return const MenuPage();
      //               }
      //               return const LanguageIntroPage();
      //             }
      //           )
      //         )
      //       )
    );
  }
}
