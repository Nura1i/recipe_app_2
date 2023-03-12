import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/app.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';

ThemeBottomSheet(BuildContext context, light) {
  showModalBottomSheet(
    backgroundColor: Theme.of(context).backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(40.r),
      ),
    ),
    context: context,
    builder: (ctx) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.25.h,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    translation(context).theme,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 15.sp,
                          fontFamily: "Lora",
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              themeWidget(
                'light',
                'light',
                'Light',
                Icons.sunny,
              ),
              // Dvider...!
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 1.h,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.white,
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 1.h,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.white,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              themeWidget(
                'dark',
                'dark',
                'Dark',
                Icons.dark_mode,
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Theme for Widgets
themeWidget(
  String themechange1,
  String themechange2,
  String themename,
  IconData icon,
) {
  return ThemeSwitcher(
    builder: (context) {
      return InkWell(
        onTap: () async {
          var themeName =
              ThemeModelInheritedNotifier.of(context).theme.brightness ==
                      Brightness.light
                  ? themechange1
                  : themechange2;
          var service = await ThemeService.instance
            ..save(themeName);
          var theme = service.getByName(themeName);
          ThemeSwitcher.of(context).changeTheme(theme: theme);
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 10),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).focusColor,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                // translation(context).accept,
                themename,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14.sp,
                      fontFamily: "Lora",
                      fontWeight: FontWeight.bold,
                    ),
              )
            ],
          ),
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
      AppProvider.setLLocale(context, locale);
      setLocale(
        locale.toString(),
      );
    },
    child: Padding(
      padding: EdgeInsets.all(2.0.sp),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                text1!,
                style: TextStyle(fontSize: 18.sp),
              ),
              SizedBox(
                width: size.width / 30,
              ),
              // Tilni Tanlash Style qismi ...!
              Text(
                text2,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14.sp,
                      fontFamily: "Lora",
                      fontWeight: FontWeight.bold,
                    ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          // Dvider...!
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 1.h,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.white,
                        ],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 1.h,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.white,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Language Bottom Sheet Widget
void displayBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Theme.of(context).backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(40.r),
      ),
    ),
    context: context,
    builder: (ctx) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text Language...!
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    translation(context).language,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp,
                          fontFamily: "Lora",
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              // Tilni Tanlash qismi...!
              LanguageForSheet(
                "🇺🇸",
                "English",
                const Locale('en'),
                context,
              ),
              LanguageForSheet(
                "🇷🇺",
                "Русский",
                const Locale('ru'),
                context,
              ),
              LanguageForSheet(
                "🇺🇿",
                "O'zbekcha",
                const Locale('uz'),
                context,
              ),
            ],
          ),
        ),
      );
    },
  );
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
          ],
        ),
      ),
      child: Icon(
        leading,
      ),
    ),
  );
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
            color: Colors.transparent,
            width: 1.w,
          ),
        ),
        actions: [
          MaterialButton(
            highlightColor: Colors.white,
            color: Colors.grey.shade100,
            onPressed: () {
              Navigator.of(context).pop();
            },
            // Text Cancel...!
            child: Text(translation(context).cancel,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 13.sp,
                      fontFamily: "Lora",
                      fontWeight: FontWeight.bold,
                    )),
          ),
          MaterialButton(
            highlightColor: Colors.white,
            color: Colors.grey.shade100,
            onPressed: () {
              FireDatabaseService.signOutUser(context);
            },
            // Text Sing Out...!
            child: Text(
              translation(context).signOut,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.red,
                    fontSize: 13.sp,
                    fontFamily: "Lora",
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      );
    },
  );
}

// About Dialog...!
Aboutdialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: .0,
        title: const Text('Haqida'),
        content: const Text(
          '''Flutter App Mobile Devolopers 
      Nurali Olimov
      Diyor Omonov,
      Shekhroz Berdiyev''',
        ),
        titleTextStyle: Theme.of(context).textTheme.bodySmall,
        contentTextStyle: Theme.of(context).textTheme.bodySmall,
        backgroundColor: Theme.of(context).backgroundColor,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15).r,
        ),
        actions: [
          MaterialButton(
            color: Colors.grey.shade200,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Ok',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      );
    },
  );
}
