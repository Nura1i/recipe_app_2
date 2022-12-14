import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var current = 0;
    return Scaffold(
      body: Center(child: Text(currentUser!.email.toString())),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          current = value;
        },
        currentIndex: current,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/Inactive.svg',
              ),
              label: 'as',
              activeIcon: SvgPicture.asset(
                'assets/svg/Inactive.svg',
                // color: Colors.red)
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svg/Inactive.svg'),
              label: 'as',
              activeIcon: SvgPicture.asset(
                'assets/svg/Inactive.svg',
                // color: Colors.red
              ))
        ],
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ),
    );
  }
}
