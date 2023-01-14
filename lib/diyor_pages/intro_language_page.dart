// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:recipe_app/app.dart';
import 'package:recipe_app/blocs/localization/localization_cubit.dart';
import 'package:recipe_app/diyor_pages/diyor.dart';
import 'package:recipe_app/diyor_pages/intro_page/onboarding_screen.dart';
import 'package:recipe_app/diyor_pages/language_intro_widgets.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/language.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
void main() {
  // Native Splashs
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}
class LanguageIntroPage extends StatefulWidget {
  const LanguageIntroPage({super.key});

  @override
  State<LanguageIntroPage> createState() => _LanguageIntroPageState();
}

class _LanguageIntroPageState extends State<LanguageIntroPage> {
    void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1))
        .then((value) => {FlutterNativeSplash.remove()});
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(     
         mainAxisAlignment: MainAxisAlignment.end,
         children: [
       Padding(
     padding: const EdgeInsets.only(bottom: 250),
    child: Row(
   mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [  
        LanguageIntro(const Text("🇺🇸",style: TextStyle(fontSize: 20),), "English", const Locale('en'), context),
         LanguageIntro(const Text("🇷🇺",style: TextStyle(fontSize: 20),), "Russian",  const Locale('ru'), context),
           LanguageIntro(const Text("🇺🇿",style: TextStyle(fontSize: 20),), "Uzbek",  const Locale('uz'), context),    
            ],
              ),
               ),
                Padding(
              padding: const EdgeInsets.only(bottom: 100),
            child: MaterialButton(
          child: Container(
          alignment: Alignment.center,
        height:size.height/9,
        width: size.width/1.5,
      decoration: BoxDecoration(
        color: Colors.red,
           borderRadius: BorderRadius.circular(10),
             ),
              child: Text(translation(context).introPage1,),
                 ),
                   onPressed:() {
                  Navigator.push(context,  MaterialPageRoute(builder:(context) => OnBoardingScreen(),));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}