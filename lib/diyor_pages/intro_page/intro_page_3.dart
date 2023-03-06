import 'package:flutter/material.dart';
import '../../utils/shared_pref/language_prefs/preferences_2.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Intro Page - 3
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            // Images qismi...!
            child: Container(
              height: 300,
              width: 270,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/intro/intro3.jpg',
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
                // // Text 1
                Text(
                  translation(context).introPage3,
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
                // // Text 2
                Text(
                  translation(context).introPage33,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
