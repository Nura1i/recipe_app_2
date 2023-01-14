
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:recipe_app/pages/profile_page/profile_drawer_page.dart';
import 'package:recipe_app/pages/profile_page/profile_page.dart';
final ZoomDrawerController z = ZoomDrawerController();
class ZoomDrawerPage extends StatefulWidget {
  const ZoomDrawerPage({super.key});
  @override
  State<ZoomDrawerPage> createState() => _ZoomDrawerPageState();
}
class _ZoomDrawerPageState extends State<ZoomDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return  ThemeSwitchingArea(   
      child: ZoomDrawer(
        shadowLayer1Color: Colors.red,
        shadowLayer2Color: Colors.red.shade200,
        controller: z,
        borderRadius: 24,
        angle: 0,   
        style: DrawerStyle.defaultStyle,
        disableDragGesture: false,
        showShadow: true,
        openCurve: Curves.fastOutSlowIn,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
        duration: const Duration(milliseconds: 500),
        // angle: 0.0,
        menuBackgroundColor:
        //Theme.of(context).disabledColor,
        Colors.red.shade100,
        menuScreenOverlayColor:Theme.of(context).backgroundColor,
         //Colors.red.shade300,
        mainScreen: const ProfilePage(),
        menuScreen:CustomDrawer()  
      ),
    );
  }
}