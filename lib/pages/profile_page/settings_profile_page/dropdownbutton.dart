import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/pages/profile_page/profile.drawer/profile_widgets.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String uid = auth.currentUser!.uid.toString();
Widget dropdown(BuildContext context) {
  ScreenUtil.init(context, designSize: const Size(360, 690));
  return DropdownButtonHideUnderline(
    child: DropdownButton2(
      buttonHighlightColor: Colors.white,
      customButton: SvgPicture.asset(
        'assets/svg/ProfileUnion.svg',
        width: 22.w,
        color: Theme.of(context).backgroundColor,
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
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                        ),
                        onPressed: () async {
                          await FireDatabaseService.ProfileImageDelete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 1),
                              elevation: 100,
                              shape: const StadiumBorder(),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 20.h),
                              backgroundColor: Colors.orange,
                              content: data!['avatarImage'] != null
                                  // Your Profile Image Delete...!
                                  ? Text(
                                      translation(context)
                                          .yourProfileImageDelete,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontFamily: "Lora",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  // Your Profile Image empty...!
                                  : Text(
                                      translation(context)
                                          .yourProfileImageempty,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontFamily: "Lora",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          );
                        },
                        child: MenuItems.buildItem(context, item),
                      );
              },
            ),
          ),
        ),
        const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
        ...MenuItems.secondItems.map(
          (item) => DropdownMenuItem<MenuItem>(
            value: item,
            child: TextButton(
              style: ButtonStyle(
                overlayColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
              ),
              onPressed: () {
                Logoutdialog(context);
              },
              child: MenuItems.buildItem(context, item),
            ),
          ),
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
        borderRadius: BorderRadius.circular(15).r,
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
        Icon(item.icon, color: Colors.black),
        // Theme.of(context).iconTheme.color),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.black,
                fontSize: 12.sp,
                fontFamily: 'Lora',
              ),
        ),
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
