import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/utils/theme/themes.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: ThemeSwitcher.withTheme(
                    builder: (_, switcher, theme) {
                      return IconButton(
                        onPressed: () => switcher.changeTheme(
                          theme: theme.brightness == Brightness.light
                              ? darkkTheme
                              : whiteeTheme,
                        ),
                        icon: const Icon(Icons.brightness_3, size: 25),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Flutter Demo Home Page',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: const TextStyle(fontSize: 200),
              ),
              CheckboxListTile(
                title: const Text('Slow Animation'),
                value: timeDilation == 5.0,
                onChanged:
                 (value) {
                  setState(() {
                    timeDilation = value != null && value ? 5.0 : 0.0;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ThemeSwitcher.switcher(
                    clipper: const ThemeSwitcherBoxClipper(),
                    builder: (context, switcher) {
                      return MaterialButton(
                        child: const Text('Box Animation'),
                        onPressed: () {
                          switcher.changeTheme(
                            theme: ThemeModelInheritedNotifier.of(context)
                                        .theme
                                        .brightness ==
                                    Brightness.light
                                ? darkkTheme
                                : whiteeTheme,
                          );
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    clipper: const ThemeSwitcherCircleClipper(),
                    builder: (context) {
                      return OutlinedButton(
                        child: const Text('Circle Animation'),
                        onPressed: () {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: ThemeModelInheritedNotifier.of(context)
                                        .theme
                                        .brightness ==
                                    Brightness.light
                                ? darkkTheme
                                : whiteeTheme,
                          );
                        },
                      );
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ThemeSwitcher(
                    clipper: const ThemeSwitcherBoxClipper(),
                    builder: (context) {
                      return MaterialButton(
                        child: const Text('Box (Reverse)'),
                        onPressed: () {
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
                  ),
                  ThemeSwitcher(
                    clipper: const ThemeSwitcherCircleClipper(),
                    builder: (context) {
                      return MaterialButton(
                        child: const Text('Circle (Reverse)'),
                        onPressed: () {
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
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeModelInheritedNotifier.of(context).theme ==
                            darkkTheme,
                        onChanged: (needPink) {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: needPink != null && needPink
                                ? darkkTheme
                                : whiteeTheme,
                          );
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeModelInheritedNotifier.of(context).theme ==
                            darkkTheme,
                        onChanged: (needDarkBlue) {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: needDarkBlue != null && needDarkBlue
                                ? darkkTheme
                                : whiteeTheme,
                          );
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeModelInheritedNotifier.of(context).theme ==
                            darkkTheme,
                        onChanged: (needBlue) {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: needBlue != null && needBlue
                                ? darkkTheme
                                : whiteeTheme,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
