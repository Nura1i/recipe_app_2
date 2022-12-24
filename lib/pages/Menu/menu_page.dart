import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/pages/add_page.dart';
import 'package:recipe_app/pages/bookmark_page/bookmark_page.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/pages/notification/notification_page.dart';
import 'package:recipe_app/pages/profile_page/profile_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  dynamic screens = [
    const HomePage(),
    const BookMarkPage(),
    const AddPage(),
    const NotificatonPage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    var current = 0;
    var size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF6F6F6),
        child: Scaffold(
          body: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/svg/Inactive.svg',
                    ),
                    activeIcon: _pages('home', 'assets/svg/Inactive.svg')),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/svg/Menu.svg'),
                    activeIcon: _pages('menu', 'assets/svg/Menu.svg')),
                BottomNavigationBarItem(
                  icon: Container(
                    width: size.width * 0.1,
                    height: size.height * 0.04,
                    margin: EdgeInsets.only(bottom: size.height * 0.01),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: SvgPicture.asset(
                      'assets/svg/Plus.svg',
                      color: Colors.white,
                    ),
                  ),
                  //activeIcon: _pages('add', 'assets/svg/Plus.svg')
                ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/svg/Notification.svg'),
                    activeIcon:
                        _pages('notification', 'assets/svg/Notification.svg')),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/svg/Profile.svg'),
                    activeIcon: _pages('profile', 'assets/svg/Profile.svg'))
              ],
            ),
            tabBuilder: (BuildContext context, int index) {
              return screens[index];
            },
          ),
        ));
  }

  Widget _pages(String text, String svg) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 10,
          child: SvgPicture.asset(
            svg,
            color: Colors.red,
          ),
        ),
        const Spacer()
      ],
    );
  }
}
