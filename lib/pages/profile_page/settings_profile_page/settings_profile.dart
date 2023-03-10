import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/dropdownbutton.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/croppPage.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/widgets.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

// Edit Profile Page...!
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          // AppBar...!
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: AppBar(
              scrolledUnderElevation: 10,
              toolbarHeight: 50.h,
              shadowColor: Colors.grey.shade100,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(40).r,
                  bottomRight: const Radius.circular(40).r,
                ),
              ),
              centerTitle: true,
              elevation: 1,
              title: Text(
                controllerUserName!.text.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontFamily: "Lora",
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Theme.of(context).textTheme.bodySmall),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: dropdown(context),
                ),
              ],
              // icon Back...!
              leading: IconButton(
                highlightColor:Theme.of(context).backgroundColor,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 22,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 250.h,
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .snapshots(),
                      builder: (_, snapshot) {
                        var data = snapshot.data;
                        return (snapshot.connectionState ==
                                ConnectionState.waiting)
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                color: Theme.of(_).backgroundColor,
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    // Edit Profile...!
                                    Text(
                                      translation(context).editprofile,
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 15.sp,
                                        fontFamily: "Lora",
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                      //Theme.of(_).textTheme.titleLarge,
                                    ),
                                    SizedBox(height: 15.h),
                                    // Rasim Qo'yadigan qismi...!
                                    Center(
                                      child: Stack(
                                        children: [
                                          Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CropperScreenn(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 130.w,
                                                  height: 130.h,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 2.w,
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset:
                                                            const Offset(0, 3),
                                                      ),
                                                    ],
                                                    shape: BoxShape.circle,
                                                    image: data![
                                                                'avatarImage'] !=
                                                            null
                                                        ? DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              data[
                                                                  'avatarImage'],
                                                            ),
                                                          )
                                                        : const DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              // Icon Camera...!
                                              Positioned(
                                                left: 90,
                                                child: Container(
                                                  height: 40.h,
                                                  width: 40.w,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      width: 4.w,
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor,
                                                    ),
                                                    color: Colors.green,
                                                  ),
                                                  child: const Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                  ),
                  // Text User Name...!
                  buildTextField(
                    context,
                    translation(context).userName,
                    translation(context).userName,
                    controllerUserName!,
                    true,
                    true,
                  ),
                  // Text Bio...!
                  buildTextField(
                    context,
                    translation(context).bio,
                    translation(context).bio,
                    controllerBio!,
                    false,
                    true,
                  ),
                  // Text Email...!
                  buildTextField(
                    context,
                    translation(context).email,
                    translation(context).email,
                    controllerEmail!,
                    true,
                    false,
                  ),
                  // Saved Button...!
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15).r,
                    ),
                    disabledTextColor: Theme.of(context).backgroundColor,
                    highlightColor: Colors.green,
                    color: Colors.green,
                    child: Text(
                      translation(context).saved,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontFamily: "Lora",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      await yourProfileSetting();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
