import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/profile_page/profile.drawer/profile_widgets.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';

class CustomDrawer extends StatefulWidget {
  final changes;
  const CustomDrawer({this.changes});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    // bool tapped = false;
    // final isPlatformDark =
    //  WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    // final initTheme =
    // isPlatformDark ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light;

    MediaQueryData mediaQuery = MediaQuery.of(context);
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: ThemeSwitcher(
                          builder: (context) {
                            return InkWell(
                              onTap: () async {
                                var themeName =
                                    ThemeModelInheritedNotifier.of(context)
                                                .theme
                                                .brightness ==
                                            Brightness.light
                                        ? 'dark'
                                        : 'light';
                                var service = await ThemeService.instance
                                  ..save(themeName);
                                var theme = service.getByName(themeName);
                                ThemeSwitcher.of(context)
                                    .changeTheme(theme: theme);
                              },
                              child: ThemeModelInheritedNotifier.of(context)
                                          .theme
                                          .brightness !=
                                      Brightness.light
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
                            );
                          },
                        ),

                        // child:

                        // ThemeSwitcher.switcher(
                        //     clipper: const ThemeSwitcherCircleClipper(),
                        //     builder: (context, switcher) {
                        //       return Row(
                        //         children: [
                        //           IconButton(
                        //               onPressed: () {
                        //                 switcher.changeTheme(
                        //                     theme: AppTTheme.whiteeTheme);
                        //               },
                        //               icon: const Icon(Icons.home)),
                        //           IconButton(
                        //               onPressed: () {
                        //                 switcher.changeTheme(theme: AppTTheme.darkkTheme);
                        //               },
                        //               icon: const Icon(Icons.home)),
                        //         ],
                        //       );
                        //     }

                        //    IconButton(
                        //     icon: theme.brightness == Brightness.dark
                        //         ? Icon(
                        //             Icons.brightness_3,
                        //             size: 25.sp,
                        //             color: Colors.white,
                        //           )
                        //         : Icon(
                        //             Icons.sunny,
                        //             size: 25.sp,
                        //             color: Colors.black,
                        //           ),
                        //     onPressed: () {
                        //       timeDilation = 1.0;
                        //       var brightness = ThemeModelInheritedNotifier.of(context)
                        //           .theme
                        //           .brightness;
                        //       ThemeSwitcher.of(context).changeTheme(
                        //         theme: Theme.of(context).brightness == Brightness.light
                        //             ? AppTTheme.darkkTheme
                        //             : AppTTheme.whiteeTheme,
                        //         isReversed:
                        //             brightness == Brightness.dark ? true : false,
                        //       );
                        //     },
                        //   );
                        // },
                        // ),
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
                    drawerlisttile(Icons.dark_mode, 'Theme',
                        Icons.arrow_circle_right_outlined, () {
                      ThemeBottomSheet(context, true);
                    }, context),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    drawerlisttile(Icons.language, 'Language',
                        Icons.arrow_circle_right_outlined, () {
                      displayBottomSheet(context);
                    }, context),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    drawerlisttile(Icons.exit_to_app, 'Log Out',
                        Icons.arrow_circle_right_outlined, () {
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
              ),
            ),
          );
        },
      ),
    );
  }
}

ThemeData newTheme = ThemeData(primaryColor: Colors.amber);
