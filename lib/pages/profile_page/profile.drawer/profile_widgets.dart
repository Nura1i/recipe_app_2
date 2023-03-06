import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/app.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/language.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';

ThemeBottomSheet(BuildContext context, light) {
  showModalBottomSheet(
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      context: context,
      builder: (context) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * 0.30.h,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 20),
                    child: Text(
                      'Theme',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  themesheet(context, Icons.sunny, 'Light', 'light', 'light'),
                  const Divider(
                    thickness: 1,
                    color: Colors.orange,
                  ),
                  themesheet(context, Icons.dark_mode, 'Dark', 'dark', 'dark'),
                  const Divider(
                    thickness: 1,
                    color: Colors.orange,
                  ),
                ])));
      });
}

// Theme for Widgets

Widget themesheet(BuildContext context, IconData iconn, String text,
    String themedark, String themelight) {
  return ThemeSwitcher(
    builder: (context) {
      return ListTile(
        onTap: () async {
          var themeName =
              ThemeModelInheritedNotifier.of(context).theme.brightness ==
                      Brightness.light
                  ? themedark
                  : themelight;
          var service = await ThemeService.instance
            ..save(themeName);
          var theme = service.getByName(themeName);
          ThemeSwitcher.of(context).changeTheme(theme: theme);
        },
        leading: Icon(iconn),
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
        ),
      );
    },
  );
}

// Language Widget
Widget LanguageForSheet(
    String? text1, String text2, Locale locale, BuildContext context) {
  var size = MediaQuery.of(context).size;
  return MaterialButton(
      onPressed: () async {
        Language? language;
        AppProvider.setLLocale(context, locale);
      },
      child: Padding(
        padding: EdgeInsets.all(2.0.sp),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  text1!,
                ),
                SizedBox(
                  width: size.width / 30,
                ),
                Text(text2, style: Theme.of(context).textTheme.bodyText1)
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

// Language Bottom Sheet Widget
void displayBottomSheet(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp))),
      context: context,
      builder: (ctx) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 20),
                    child: Text(
                      'Language',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  LanguageForSheet(
                      "🇺🇸", "English", const Locale('en'), context),
                  LanguageForSheet(
                      "🇷🇺", "Russian", const Locale('ru'), context),
                  LanguageForSheet(
                      "🇺🇿", "Uzbek", const Locale('uz'), context),
                ],
              ),
            ));
      });
}

// DrawerWidgetsListTile
Widget drawerlisttile(
  IconData? leading,
  String? text,
  IconData? trailing,
  button,
  BuildContext context,
) {
  return ListTile(
      title: Text(
        text!,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: button,
      trailing: Icon(
        trailing,
        color: Theme.of(context).focusColor,
      ),
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
          child: Icon(
            leading,
          )));
}

Logoutdialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: .0,
        title: const Text('Sign Out'),
        content: const Text(
          'Siz Programmadan chiqib ketishni hoxlaysizmi ?',
        ),
        titleTextStyle: Theme.of(context).textTheme.bodySmall,
        contentTextStyle: Theme.of(context).textTheme.bodySmall,
        backgroundColor: Theme.of(context).backgroundColor,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.orange, width: 2)),
        actions: [
          MaterialButton(
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodySmall,
              )),
          MaterialButton(
              color: Colors.orange,
              onPressed: () {
                FireDatabaseService.signOutUser(context);
              },
              child: Text(
                'Sign Out',
                style: Theme.of(context).textTheme.bodySmall,
              )),
        ],
      );
    },
  );
}

Aboutdialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: .0,
        title: const Text('Haqida'),
        content: const Text(
          'Flutter App Mobile Devoloper',
        ),
        titleTextStyle: Theme.of(context).textTheme.bodySmall,
        contentTextStyle: Theme.of(context).textTheme.bodySmall,
        backgroundColor: Theme.of(context).backgroundColor,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.orange, width: 2)),
        actions: [
          MaterialButton(
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Ok',
                style: Theme.of(context).textTheme.bodySmall,
              )),
        ],
      );
    },
  );
}
