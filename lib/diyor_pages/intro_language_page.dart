import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/app.dart';
import 'package:recipe_app/diyor_pages/intro_page/onboarding_screen.dart';
import 'package:recipe_app/diyor_pages/language_intro_widgets.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/language.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

enum LanguageEnum {
  en(data: 'en'),
  uz(data: 'uz'),
  ru(data: 'ru');

  final String data;
  const LanguageEnum({required this.data});
}

class LanguageIntroPage extends StatefulWidget {
  const LanguageIntroPage({super.key});

  @override
  State<LanguageIntroPage> createState() => _LanguageIntroPageState();
}

// Til talanadigan Home Page qismi...!
class _LanguageIntroPageState extends State<LanguageIntroPage>
    with TickerProviderStateMixin {
  LanguageEnum selectedType = LanguageEnum.en;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Cooking App',
          style: TextStyle(
            color: Colors.blue.shade200,
            fontSize: 20.sp,
            fontFamily: "Lora",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Images Language...!
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: size.height * 0.28,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/globe.png'),
                  ),
                ),
              ),
              // Text qismi...!
              Text(
                translation(context).selectLanguage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue.shade200,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Lora",
                ),
              ),
              // Tilni Tanlash qismi...!
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.08,
                  child: CupertinoSlidingSegmentedControl<LanguageEnum>(
                    thumbColor: Colors.blue.shade100,
                    children: {
                      LanguageEnum.en: LanguageIntro(
                        const Text(
                          "🇺🇸",
                          style: TextStyle(fontSize: 23),
                        ),
                        "English",
                        context,
                      ),
                      LanguageEnum.uz: LanguageIntro(
                        const Text(
                          "🇺🇿",
                          style: TextStyle(fontSize: 22),
                        ),
                        "O'zbekcha",
                        context,
                      ),
                      LanguageEnum.ru: LanguageIntro(
                        const Text(
                          "🇷🇺",
                          style: TextStyle(fontSize: 23),
                        ),
                        "Русский",
                        context,
                      ),
                    },
                    groupValue: selectedType,
                    onValueChanged: (value) {
                      selectedType = value!;
                      Language? language;
                      Locale locale = Locale(value.data);
                      AppProvider.setLLocale(context, locale);
                      setLocale(locale.toString());
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
          // MaterialButton qismi...!
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnBoardingScreen(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: size.height / 17,
                width: size.width / 2.5,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(15).r,
                ),
                child: Text(
                  translation(context).next,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: "Lora",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
