import 'package:flutter/material.dart';
import '../../utils/shared_pref/language_prefs/preferences_2.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Intro Page - 2
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 300,
              width: 310,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/intro/intro2.jpg',
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
                  translation(context).introPage2,
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
                  translation(context).introPage22,
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
