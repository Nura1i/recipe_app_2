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
            // Images qismi...!
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/intro/intro1.jpg',
                  ),
                ),
              ),
            ),
          ),
          // Text qismi
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 100),
            child: Column(
              children: [
                // Text 1
                Text(
                  translation(context).introPage1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Lora",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text 2
                Text(
                  translation(context).introPage11,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Lora",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
