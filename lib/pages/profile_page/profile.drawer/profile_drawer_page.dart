import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/profile_page/profile.drawer/profile_widgets.dart';
import 'package:recipe_app/pages/profile_page/profile.drawer/theme.dart';
import 'package:recipe_app/utils/theme/themes.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class CustomDrawer extends StatelessWidget {
  final changes;
  const CustomDrawer({this.changes});
  @override
  Widget build(BuildContext context) {
    // bool tapped = false;
    // final isPlatformDark =
    //     WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    // final initTheme =
    //     isPlatformDark ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light;
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
                  return ThemeSwitcher(
                    clipper: const ThemeSwitcherCircleClipper(),
                    builder: (context) {
                      return IconButton(
                        icon: theme.brightness == Brightness.dark
                            ? Icon(
                                Icons.brightness_3,
                                size: 25.sp,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.sunny,
                                size: 25.sp,
                                color: Colors.black,
                              ),
                        onPressed: () {
                          timeDilation = 1.0;

                          var brightness =
                              ThemeModelInheritedNotifier.of(context)
                                  .theme
                                  .brightness;
                          ThemeSwitcher.of(context).changeTheme(
                            theme: brightness == Brightness.light
                                ? darkkTheme
                                : whiteeTheme,
                            isReversed:
                                brightness == Brightness.dark ? true : false,
                          );
                        },
                      );
                    },
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
                children: const <Widget>[
                  SizedBox(
                    height: 100,
                  )
                ],
              )),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          drawerlisttile(
              Icons.dark_mode, 'Theme', Icons.arrow_circle_right_outlined, () {
            ThemeBottomSheet(context, true);
          }, context),
          drawerlisttile(Icons.dark_mode, 'Theme goooooooooooood',
              Icons.arrow_circle_right_outlined, () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ThemePage(),
            ));
          }, context),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          const Divider(height: 1, color: Colors.grey),
          drawerlisttile(
              Icons.language, 'Language', Icons.arrow_circle_right_outlined,
              () {
            displayBottomSheet(context);
          }, context),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          drawerlisttile(
              Icons.exit_to_app, 'Log Out', Icons.arrow_circle_right_outlined,
              () {
            Logoutdialog(context);
          }, context),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: () => Aboutdialog(context),
            child: ListTile(
              title: Text(
                'Haqida',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    ));
  }
}
