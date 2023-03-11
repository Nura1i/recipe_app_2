
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:recipe_app/app.dart';
// import 'package:recipe_app/diyor_pages/intro_language_page.dart';
// import 'package:recipe_app/diyor_pages/language_intro_widgets.dart';
// import 'package:recipe_app/main.dart';
// import 'package:recipe_app/utils/shared_pref/preferences.dart';

// void main() async {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   WidgetsFlutterBinding.ensureInitialized();
//   var themeService = await ThemeService.instance;
//   var initThemee = themeService.initial;
//   testWidgets('Reverse Widgets tests dart', (WidgetTester widgetTester,) async {
//     var screenutilinit = find.byKey(ValueKey('screenutil'));
//     await widgetTester.pumpWidget(MyApp(
//       initThem: initThemee,
//     ));
//     await widgetTester.pumpWidget(AppProvider(
//       initThem: initThemee,
//     ));
//     await widgetTester.pumpWidget( LanguageIntro(
//                           const Text(
//                             "🇺🇿",
//                             style: TextStyle(fontSize: 23),
//                           ),
//                           "O'zbekcha",
//                           ),);
//     //  find.byType(ScreenUtilInit);
//     // expect(screenutilinit, findsOneWidget);
//   });
// }
