import 'dart:ui';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/blocs/adaptive_theme/adaptive_cubit.dart';
import 'package:recipe_app/blocs/adaptive_theme/adaptive_theme_view.dart';
import 'package:recipe_app/diyor_pages/language_intro_widgets.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/language.dart';
import 'package:recipe_app/utils/theme/themes.dart';
import '../../app.dart';
import '../../blocs/camera/camera_cubit.dart';


class CustomDrawer extends StatelessWidget {
  final changes;
  const CustomDrawer({this.changes});
  @override
  Widget build(BuildContext context) {
    bool tapped = false;
    final isPlatformDark =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final initTheme =
        isPlatformDark ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SafeArea(
        child: Container(
      color: Theme.of(context).backgroundColor,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
            child: Align(
              alignment: Alignment.topRight,
              child: ThemeSwitcher.withTheme(
                builder: (_, switcher, theme) {
                  return IconButton(
                    onPressed: () => switcher.changeTheme(
                      theme: theme.brightness == Brightness.light
                          ? darkTheme
                          : whiteTheme,
                    ),
                    icon: const Icon(Icons.brightness_3, size: 25),
                  );
                },
              ),
            ),
          ),
          SizedBox(
              width: double.infinity,
              height: 200,
              //  color:Theme.of(context).backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: mediaQuery.size.height / 10,
                    width: mediaQuery.size.width / 5,
                    decoration: BoxDecoration(
                        //  color:Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(50),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/wallpaper.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "RetroPortal Studio",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              )),
          ListTile(
            onTap: () {
              debugPrint(
                "Tapped Profile",
              );
            },
            leading: const Icon(Icons.person),
            title: Text(
              "Your Profile",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
              onTap: () {
                // changes==true? BlocProvider.of<ThemeCubit>(context).changedLight:BlocProvider.of<ThemeCubit>(context).changedDark;
                ThemeBottomSheet(context, true);
                // BlocProvider.of<ThemeCubit>(context,listen: false);
                // IconButton(onPressed: (){BlocProvider.of<ThemeCubit>(ctx).dataDark;}, icon: Icon(Icons.sunny));
                //       Navigator.of(context).push(MaterialPageRoute(builder:(context) => ThemePage()
                //  )
                //      );
              },
              trailing: const Icon(Icons.arrow_circle_right_outlined),
              leading: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.orange.shade100,
                            Colors.orange.shade200,
                            Colors.orange.shade300,
                            Colors.orange.shade700,
                          ])),
                  child: const Icon(
                    Icons.dark_mode,
                    color: Colors.black,
                  )),
              title: Text("Themes",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 10))),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          const Divider(height: 1, color: Colors.grey),
          ListTile(
            onTap: () {
              displayBottomSheet(context);
            },
            leading: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.orange.shade100,
                          Colors.orange.shade200,
                          Colors.orange.shade300,
                          Colors.orange.shade700,
                        ])),
                child: const Icon(
                  Icons.language,
                  color: Colors.black,
                )),
            trailing: const Icon(Icons.arrow_circle_right_outlined),
            title:
                Text("Language", style: Theme.of(context).textTheme.bodySmall),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Log Out");
            },
            leading: const Icon(Icons.exit_to_app),
            title:
                Text("Log Out", style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    ));
  }
}

// Language Bottom Sheet Widget
void displayBottomSheet(BuildContext context) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (ctx) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 20),
                    child: Text('Language'),
                  ),
                  LanguageForSheet(
                      const Text(
                        "🇺🇸",
                        style: TextStyle(fontSize: 20),
                      ),
                      "English",
                      const Locale('en'),
                      context),
                  LanguageForSheet(
                      const Text(
                        "🇷🇺",
                        style: TextStyle(fontSize: 20),
                      ),
                      "Russian",
                      const Locale('ru'),
                      context),
                  LanguageForSheet(
                      const Text(
                        "🇺🇿",
                        style: TextStyle(fontSize: 20),
                      ),
                      "Uzbek",
                      const Locale('uz'),
                      context),
                ],
              ),
            ));
      });
}

// Language Widget
Widget LanguageForSheet(
    Text text1, String text2, Locale locale, BuildContext context) {
  var size = MediaQuery.of(context).size;
  return MaterialButton(
      onPressed: () async {
        Language? language;
        AppProvider.setLLocale(context, locale);
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Row(
              children: [
                text1,
                SizedBox(
                  width: size.width / 30,
                ),
                Text(text2)
              ],
            ),
            const Divider(
              thickness: 1,
              color: Colors.orange,
            )
          ],
        ),
      ));
}

ThemeBottomSheet(BuildContext context, light) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (ctx) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 20),
                    child: Text('Theme'),
                  ),
                  TextButton(
                    onPressed: () {
                      light == false
                         ? BlocProvider.of<ThemeCubit>(context).lightTheme()
                          : BlocProvider.of<ThemeCubit>(context).DarkkTheme();
                    },
                    child: Row(
                      children: const [Icon(Icons.sunny), Text('Light')],
                    ),
                  ),
                  ThemeSwitcher.withTheme(
                    builder: (_, switcher, theme) {
                      return TextButton(
                        onPressed: () => switcher.changeTheme(
                          theme: theme.brightness == Brightness.dark
                              ? whiteTheme
                              : darkTheme,
                        ),
                        child: Row(
                          children: const [Icon(Icons.sunny), Text('Dark')],
                        ),
                      );
                    },
                  )
                ])));
      });
}
