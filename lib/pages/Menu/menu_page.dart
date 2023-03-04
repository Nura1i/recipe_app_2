import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/pages/add_page.dart';
import 'package:recipe_app/pages/bookmark_page/bookmark_page.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/pages/notification/notification_page.dart';
import 'package:recipe_app/pages/profile_page/zoom_drawer_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

// ButtonNavigatorBar
class _MenuPageState extends State<MenuPage> {
  dynamic screens = [
    const HomePage(),
    const BookMarkPage(),
    const AddPage(),
    SearchPerson(),
    //const NotificatonPage(),
    const ZoomDrawerPage()
    // const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.red,
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/Inactive.svg',
                width: 30.w,
                color: Colors.orange.shade600,
              ),
              activeIcon: _pages(
                'home',
                'assets/svg/Inactive.svg',
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/Menu.svg',
                width: 50.w,
                color: Colors.orange.shade600,
              ),
              activeIcon: _pages(
                'menu',
                'assets/svg/Menu.svg',
              ),
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddPage(),
                  ));
                },
                child: Container(
                  width: size.width * 0.10,
                  height: size.height * 0.038,
                  margin: EdgeInsets.only(
                      bottom: size.height * 0.005, top: size.height * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade500,
                    borderRadius: BorderRadius.circular(10).r,
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/Plus.svg',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/Notification.svg',
                width: 50.w,
                color: Colors.orange.shade600,
              ),
              activeIcon: _pages(
                'notification',
                'assets/svg/Notification.svg',
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/Profile.svg',
                width: 50.w,
                color: Colors.orange.shade600,
              ),
              activeIcon: _pages(
                'profile',
                'assets/svg/Profile.svg',
              ),
            )
          ],
        ),
        tabBuilder: (
          BuildContext context,
          int index,
        ) {
          return screens[index];
        },
      ),
    );
  }

  Widget _pages(String text, String svg) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 50,
          child: SvgPicture.asset(
            svg,
            color: Colors.black,
          ),
        ),
        const Spacer()
      ],
    );
  }
}
