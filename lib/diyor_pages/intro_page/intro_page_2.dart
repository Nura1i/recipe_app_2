import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Intro Page - 22
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
                image: AssetImage('assets/intro/intro2.png'),
              )),
            ),
          ),
          // Text qismi
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 100),
            child: Column(
              children: const [
                Text(
                    "Siz pazandalikka qiziqasizmi? \n Lekin sizning qo'lingizdan kelmayaptimi?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Unday bo'lsa bizning ''Cooking'' - ilovamiz sizga bu borada yordam bera oladi! Biz bilan birga pazandalikni o'rganing! Va yaqinlaringizga xam ulashing.",
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
