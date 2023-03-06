import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/app.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/language.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';

ThemeBottomSheet(BuildContext context, light) {
  showModalBottomSheet(
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      context: context,
      builder: (ctx) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * 0.35.h,
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
                  // themeWidget('light', 'light', 'Light', Icons.sunny, context),
                  // const Divider(
                  //   thickness: 1,
                  //   color: Colors.orange,
                  // ),
                  // themeWidget('dark', 'dark', 'Dark', Icons.dark_mode, context),
                  // const Divider(
                  //   thickness: 1,
                  //   color: Colors.orange,
                  // ),
                  // themeWidget(
                  //     'dark', 'light', 'System', Icons.sunny_snowing, context),
                ])));
      });
}

// Theme for Widgets

//  ThemeSwitcher.withTheme(
//   builder: (_, switcher, theme) {
//     return TextButton(
//       onPressed: () => switcher.changeTheme(
//         theme:
//             theme.brightness == Brightness.dark ? themechange1 : themechange2,
//       ),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             color: Theme.of(context).focusColor,
//           ),
//           const SizedBox(
//             width: 3,
//           ),
//           Text(
//             texttheme,
//             style: Theme.of(context).textTheme.bodySmall,
//           )
//         ],
//       ),
//     );
//   },
// );
//}

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
                Text(
                  text2,
                  style: Theme.of(context).textTheme.bodySmall,
                )
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

// Log Out Page...!
Logoutdialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: .0,
        title: Text(
          translation(context).signOut,
          style: TextStyle(
            color: Colors.red,
            fontSize: 14.sp,
            fontFamily: "Lora",
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          translation(context).doyouwanttoexittheApplication,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 13.sp,
            fontFamily: "Lora",
            fontWeight: FontWeight.bold,
          ),
        ),
        titleTextStyle: Theme.of(context).textTheme.bodySmall,
        contentTextStyle: Theme.of(context).textTheme.bodySmall,
        backgroundColor: Theme.of(context).backgroundColor,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15).r,
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.w,
          ),
        ),
        actions: [
          MaterialButton(
            color: Colors.grey.shade100,
            onPressed: () {
              Navigator.of(context).pop();
            },
            // Text Cancel...!
            child: Text(
              translation(context).cancel,
              style: TextStyle(
                color: Colors.black,
                fontSize: 13.sp,
                fontFamily: "Lora",
                fontWeight: FontWeight.bold,
              ),
              //Theme.of(context).textTheme.bodySmall,
            ),
          ),
          MaterialButton(
            color: Colors.grey.shade100,
            onPressed: () {
              FireDatabaseService.signOutUser(context);
            },
            // Text Sing Out...!
            child: Text(
              translation(context).signOut,
              style: TextStyle(
                color: Colors.red,
                fontSize: 13.sp,
                fontFamily: "Lora",
                fontWeight: FontWeight.bold,
              ),
              //Theme.of(context).textTheme.bodySmall,
            ),
          ),
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
