import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/pages/profile_page/profile.drawer/profile_widgets.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String uid = auth.currentUser!.uid.toString();
Widget dropdown(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return DropdownButtonHideUnderline(
    child: DropdownButton2(
      customButton: SvgPicture.asset(
        'assets/svg/ProfileUnion.svg',
        height: size.width * 0.015,
        color: Theme.of(context).focusColor,
      ),
      customItemsHeights: [
        ...List<double>.filled(MenuItems.firstItems.length, 48),
        8,
        ...List<double>.filled(MenuItems.secondItems.length, 48),
      ],
      items: [
        ...MenuItems.firstItems.map(
          (item) => DropdownMenuItem<MenuItem>(
            value: item,
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .snapshots(),
              builder: (context, snapshot) {
                var data = snapshot.data;
                return (snapshot.connectionState == ConnectionState.waiting)
                    ? const SizedBox()
                    : TextButton(
                        onPressed: () async {
                          await FireDatabaseService.ProfileImageDelete();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(seconds: 1),
                              elevation: 100,
                              shape: const StadiumBorder(),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.only(
                                  bottom: 40, right: 20, left: 20),
                              backgroundColor: Colors.orange,
                              content: data!['avatarImage'] != null
                                  ? const Text('Your Profile Image Delete')
                                  : const Text('Your Profile Image empty')));
                        },
                        child: MenuItems.buildItem(context, item),
                      );
              },
            ),
            //
          ),
        ),
        const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
        ...MenuItems.secondItems.map(
          (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: TextButton(
                onPressed: () {
                  Logoutdialog(context);
                },
                child: MenuItems.buildItem(context, item),
              )),
        ),
      ],
      onChanged: (value) {
        MenuItems.onChanged(context, value as MenuItem);
      },
      itemHeight: 60,
      itemPadding: const EdgeInsets.only(left: 16, right: 16),
      dropdownWidth: 180,
      dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).backgroundColor,
      ),
      dropdownElevation: 8,
      offset: const Offset(0, 8),
    ),
  );
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [
    delete,
  ];
  static const List<MenuItem> secondItems = [logout];
  static const delete = MenuItem(
    text: 'Delete Image',
    icon: Icons.delete,
  );
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);
  static Widget buildItem(BuildContext context, MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Theme.of(context).iconTheme.color),
        const SizedBox(
          width: 10,
        ),
        Text(item.text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.delete:
        break;
      case MenuItems.logout:
        break;
    }
  }
}
