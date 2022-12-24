import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Intro Page - 33
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
              children: const [
                Text(
                    "''Cooking'' - ilovamizda siz o'zgalargaxam o'z retseplaringizni ulasha olasiz!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 10,
                ),
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
