import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';
import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var themeService = await ThemeService.instance;
  var initThemee = themeService.initial;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(initThem: initThemee));
}

class MyApp extends StatelessWidget {
  final initThem;
  const MyApp({
    this.initThem,super.key,});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(  
      key: const Key('screenutil'),
      designSize: const Size(390, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => AppProvider(initThem: initThem),
    );
  }
}
