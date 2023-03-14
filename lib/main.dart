import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';
// ignore: depend_on_referenced_packages, library_prefixes
import 'package:shared_preferences/shared_preferences.dart' as SHp;
import 'app.dart';
import 'firebase_options.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SHp.SharedPreferences prefs = await SHp.SharedPreferences.getInstance();
  String language = prefs.getString('languageCode') ?? "en";
  var themeService = await ThemeService.instance;
  var initThemee = themeService.initial;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MyApp(
      initThem: initThemee,
    ),
  );
}
class MyApp extends StatelessWidget {
  final initThem;
  const MyApp({
    this.initThem,super.key,});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      key: const Key('screenutil'),
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => AppProvider(
        initThem: initThem,
      ),
    );
  }
}
