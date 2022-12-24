import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Intro Page - 111
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
              children: const [
                Text(
                    "Assalomu Aleykum! \n ''Cooking'' ilovamizga xush kelibsiz!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 10,
                ),
                Text(
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
