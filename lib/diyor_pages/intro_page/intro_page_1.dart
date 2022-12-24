import 'package:flutter/material.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
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
                      image: AssetImage('assets/intro/intro1.png'),
                      fit: BoxFit.cover)),
                  ),
               ),
              const Text(
            'My Recipes',
            style: TextStyle(color: Colors.black, fontSize: 20),
          )
        ],
      ),
    );
  }
}
