import 'package:flutter/material.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Intro Page - 1
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/intro/intro1.png'),
              )),
            ),
          ),
          // Text qismi
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 100),
            child: Column(
              children: [
                // Text 1
                Text(translation(context).introPage1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),

                // Text(
                //     "Assalomu Aleykum! \n ''Cooking'' ilovamizga xush kelibsiz!",
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontSize: 18,
                //         fontWeight: FontWeight.w700)),

                const SizedBox(
                  height: 10,
                ),

                // // Text 2
                // Text(translation(context).introPage11,
                //     textAlign: TextAlign.center,
                //     style: const TextStyle(
                //         color: Colors.black,
                //         fontSize: 18,
                //         fontWeight: FontWeight.w700)),

                const Text(
                  "Sizni Cooking ilovamizda ko'rganimizdan juda xursandmiz! Bizning ilovamiz bilan tanishish uchun ''Next'' tugmachasini bosing!",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
