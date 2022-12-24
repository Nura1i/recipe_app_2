import 'package:flutter/material.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({Key? key}) : super(key: key);
  @override
  State<IntroPage2> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/intro/intro2.png'),
                      fit: BoxFit.cover)),
            ),
          ),
          const Text(
            'nma gap kere',
            style: TextStyle(color: Colors.black, fontSize: 20),
          )
        ],
      ),
    );
  }
}
