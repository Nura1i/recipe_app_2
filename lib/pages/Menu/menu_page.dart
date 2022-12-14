import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/pages/add_page.dart';
import 'package:recipe_app/pages/bookmark_page.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/pages/notification_page.dart';
import 'package:recipe_app/pages/profile_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}
class _MenuPageState extends State<MenuPage> {
     dynamic screens = [HomePage(),BookMarkPage(), AddPage(),NotificationPage(),ProfilePage()];
  @override
  Widget build(BuildContext context) {
    var current = 0;
    return  CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF6F6F6),
      child: Scaffold(
        body: CupertinoTabScaffold(
          tabBar:CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/Inactive.svg',
              ),
              label: 'home',
              activeIcon: SvgPicture.asset(
                'assets/svg/Inactive.svg',
                color: Colors.red,
                // color: Colors.red)
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svg/Menu.svg'),
              label: 'Saved',
              activeIcon: SvgPicture.asset(
                'assets/svg/Menu.svg',
              color: Colors.red
              )),
                BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svg/Plus.svg'),
              label: 'add',
              activeIcon: SvgPicture.asset(
                'assets/svg/Plus.svg',
               color: Colors.red
              )),
                BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svg/Notification.svg'),
              label: 'Notification',
              activeIcon: SvgPicture.asset(
                'assets/svg/Notification.svg',
              color: Colors.red
              )),
               BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svg/Profile.svg'),
              label: 'Profile',
              activeIcon: SvgPicture.asset(
                'assets/svg/Profile.svg',
               color: Colors.red
              ))
        ],
          ),
            tabBuilder: (BuildContext context, int index) {
            return screens[index];
          },
           ),
     
      
         )
         
          );
    
  }
}