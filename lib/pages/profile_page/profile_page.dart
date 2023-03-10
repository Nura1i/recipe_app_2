import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/pages/On%20open/into_recipe.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/settings_profile.dart';
import 'package:recipe_app/pages/profile_page/zoom_drawer_page.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import '../../utils/shared_pref/language_prefs/preferences_2.dart';

ScrollController nestedScroll = ScrollController();

class ProfilePage extends StatelessWidget {
  final avatar;
  const ProfilePage({super.key, this.avatar});

  @override
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            extendBodyBehindAppBar: false,
            // AppBar qismi...!
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: AppBar(
                scrolledUnderElevation: 10,
                toolbarHeight: 50.h,
                shadowColor: const Color.fromARGB(255, 255, 255, 255),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(40).r,
                    bottomRight: const Radius.circular(40).r,
                  ),
                ),
                title: Text(
                  translation(context).homePage,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontFamily: "Lora",
                    fontWeight: FontWeight.bold,
                  ),
                  //  Theme.of(context).textTheme.bodyMedium,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: () {
                        z.toggle!();
                      },
                      icon: SvgPicture.asset(
                        'assets/svg/ProfileUnion.svg',
                        height: 6.h,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
                centerTitle: true,
                elevation: 0,
              ),
            ),
            body: NestedScrollView(
                controller: nestedScroll,
                body: Column(
                  children: [
                    TabBar(
                      labelStyle: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "Lora",
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: [
                        // Recipes...!
                        Tab(
                          text: translation(context).recipes,
                        ),
                        // Saved Recipes...!
                        Tab(
                          text: translation(context).savedRecipes,
                        ),
                      ],
                      unselectedLabelColor: Colors.black,
                      overlayColor:
                          const MaterialStatePropertyAll(Colors.white),
                      labelColor: Colors.orange,
                      indicatorColor: Colors.orange,
                      indicatorWeight: 2,
                      padding: const EdgeInsets.all(2),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (context, snapshots) {
                              return (snapshots.connectionState ==
                                      ConnectionState.waiting)
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : snapshots.data!['recepts'] != null
                                      ? GridView.builder(
                                          shrinkWrap: true,
                                          itemCount: 33,
                                          // snapshots
                                          //     .data!['recepts']!.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (contex, index) {
                                            // var data = snapshots
                                            //     .data!['recepts'][index];

                                            ////StreamBuilder updates when scrolling
                                            var dataUser = snapshots.data;
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                color: Colors.red,
                                              ),
                                            );

                                            //showOwnPosts(data, dataUser);
                                          },
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                          ),
                                        )
                                      : const SizedBox();
                            },
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (context, snapshots) {
                              return (snapshots.connectionState ==
                                      ConnectionState.waiting)
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : snapshots.data!['saved'] != null
                                      ? SizedBox(
                                          height: 200,
                                          child: GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: snapshots
                                                .data!['saved']!.length,
                                            itemBuilder: (contex, index) {
                                              var data = snapshots
                                                  .data!['saved'][index];
                                              var dataUser = snapshots.data;
                                              return showOwnPosts(
                                                  data, dataUser);
                                            },
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                headerSliverBuilder: (context, _) {
                  return [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Users Avtar...!
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60).r,
                                      border: Border.all(
                                        width: 1.w,
                                        color: Colors.grey.shade300,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        return (snapshot.connectionState ==
                                                ConnectionState.waiting)
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : CircleAvatar(
                                                foregroundImage: snapshot.data![
                                                            'avatarImage'] !=
                                                        null
                                                    ? CachedNetworkImageProvider(
                                                        snapshot.data![
                                                            'avatarImage'],
                                                      )
                                                    : const CachedNetworkImageProvider(
                                                        'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541',
                                                      ),
                                                radius: 60.r,
                                                backgroundColor: Colors.white,
                                              );
                                      },
                                    ),
                                  ),
                                  // Edit Profile...!
                                  Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        width: 1.w,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30).r,
                                      ),
                                      highlightColor: Colors.orange,
                                      color: const Color.fromARGB(
                                          255, 252, 252, 252),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EditProfilePage(),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        child: Text(
                                          translation(context).editprofile,
                                          style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 13.sp,
                                            fontFamily: "Lora",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          
                            // Users name text...!
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 15),
                              child: username1111 != null
                                  ? Text(
                                      username1111!,
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 14.sp,
                                        fontFamily: "Lora",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                            // Users Bio Text...!
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              child: SizedBox(
                                width: 150.w,
                                child: Text(
                                  bio.toString() == 'null'
                                      ? ''
                                      : bio.toString(),
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                            // Recipes, Saved, Likes, And Recipes & Saved Recipes...!
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20.h),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    log('2');
                                    return (snapshot.connectionState ==
                                            ConnectionState.waiting)
                                        ? const SizedBox()
                                        : Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w),
                                            // Text Recipes, Saved, Likes...!
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Recipes...!
                                                counter(
                                                  snapshot.data!['recepts'] ==
                                                          null
                                                      ? '0'
                                                      : snapshot
                                                          .data!['recepts']
                                                          .length,
                                                  translation(context).recipes,
                                                  context,
                                                ),
                                                // Saved...!
                                                counter(
                                                  snapshot.data!['saved'] ==
                                                          null
                                                      ? '0'
                                                      : snapshot.data!['saved']
                                                          .length,
                                                  translation(context).saved,
                                                  context,
                                                ),
                                                // Likes...!
                                                counter(
                                                  snapshot.data![
                                                              'totalLikes'] ==
                                                          null
                                                      ? '0'
                                                      : snapshot
                                                          .data!['totalLikes']
                                                          .length,
                                                  translation(context).likes,
                                                  context,
                                                ),
                                              ],
                                            ),
                                          );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),
                    )
                  ];
                })));
  }
}

// Recipes, Saved, likeslarni Textstyle qismi...!
counter(count, String field, context) {
  return SizedBox(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            field,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontFamily: "Lora",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Lora",
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

var count;
List lsOfOwnRecipes = [];
Widget showOwnPosts(idRecepts, dataUser) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('Recipes').snapshots(),
    builder: (context, snapshots) {
      return (snapshots.connectionState == ConnectionState.waiting)
          ? const Center(
              child: SizedBox(),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshots.data!.docs[index];

                if (data['id'] == idRecepts) {
                  //  BlocProvider.of<SavedCubit>(context).totalLikes(idRecepts);
                  return GestureDetector(
                    onTap: () async {
                      DocumentSnapshot userDoc = await FirebaseFirestore
                          .instance
                          .collection('users')
                          .doc(data['userId'])
                          .get();

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => recipeOpen(
                              postData: data.data(), userData: userDoc),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 2,
                        right: 0,
                      ),
                      child: Container(
                        height: 127.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.w,
                            color: Colors.grey.shade300,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              data['photo'],
                            ),
                          ),
                          borderRadius: BorderRadius.circular(4).r,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            );
    },
  );
}
