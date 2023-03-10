import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:recipe_app/pages/profile_page/profile.drawer/profile_drawer_page.dart';
import 'package:recipe_app/pages/profile_page/profile_page.dart';

final ZoomDrawerController z = ZoomDrawerController();
class ZoomDrawerPage extends StatelessWidget {
  const ZoomDrawerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(builder: (context) {
        return ZoomDrawer(
            shadowLayer1Color: Theme.of(context).canvasColor,
            shadowLayer2Color: Theme.of(context).shadowColor,
            controller: z,
            borderRadius: 24,
            angle: 0,
            style: DrawerStyle.defaultStyle,
            disableDragGesture: false,
            showShadow: true,
            openCurve: Curves.fastOutSlowIn,
            slideWidth: MediaQuery.of(context).size.width * 0.65,
            duration: const Duration(milliseconds: 500),
            menuBackgroundColor: Theme.of(context).backgroundColor,
            menuScreenOverlayColor: Theme.of(context).backgroundColor,
            mainScreen: const ProfilePage(),
            menuScreen: const CustomDrawer());
      }),
    );
  }
}
