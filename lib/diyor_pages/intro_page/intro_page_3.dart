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
            child: Container(
              height: 300,
              width: 270,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/intro/intro3.png'),
              )),
            ),
          ),
          // Text qismi
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 100),
            child: Column(
              children: [
                // // Text 1
                // Text(translation(context).introPage3,
                //     textAlign: TextAlign.center,
                //     style: const TextStyle(
                //         color: Colors.black,
                //         fontSize: 18,
                //         fontWeight: FontWeight.w700)),

                Text(
                    "''Cooking'' - ilovamizda siz o'zgalargaxam o'z retseplaringizni ulasha olasiz!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),

                const SizedBox(
                  height: 10,
                ),

                // // Text 2
                // Text(translation(context).introPage33,
                //     textAlign: TextAlign.center,
                //     style: const TextStyle(
                //         color: Colors.black,
                //         fontSize: 18,
                //         fontWeight: FontWeight.w700)),

                Text(
                  "Siz o'zingiz tuzgan retseplaringizni Dunyoga mashxur qiling! va yaqinlaringizni o'z retseplaringiz bilan hayron qoldiring!.",
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
