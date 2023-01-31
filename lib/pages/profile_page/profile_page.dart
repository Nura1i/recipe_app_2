import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/consts/consts.dart';
import 'package:recipe_app/pages/On%20open/into_recipe.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/settings_profile.dart';
import 'package:recipe_app/pages/profile_page/zoom_drawer_page.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import '../../utils/shared_pref/language_prefs/preferences_2.dart';

var UserId = FirebaseAuth.instance.currentUser!.uid;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    FireDatabaseService.getdata();
    FireDatabaseService.totalLikesUser(lsOfOwnRecipes)
        .whenComplete(() => log(count.toString()));

    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: .0,
          title: Text(
            translation(context).homePage,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.03),
              child: IconButton(
                  onPressed: () {
                    z.toggle!();
                  },
                  icon: SvgPicture.asset(
                    'assets/svg/ProfileUnion.svg',
                    height: size.width * 0.015,
                    color: Colors.black,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.015,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        foregroundImage: avatarImage != null
                            ? CachedNetworkImageProvider(avatarImage!)
                            : const CachedNetworkImageProvider(
                                'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541'),
                        radius: 50,
                        backgroundColor: Colors.grey,
                      ),
                      SizedBox(
                        width: size.width * 0.23,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const EditProfilePage(),
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.orange),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.015,
                                  bottom: size.height * 0.015,
                                  right: size.width * 0.05,
                                  left: size.width * 0.05),
                              child: const Text(
                                'Edit profile',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                      )
                    ]),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 17),
                  child: username1111 != null
                      ? Text(
                          username1111!,
                          style: const TextStyle(color: Colors.black),
                        )
                      : const SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 17.0, top: 12),
                  child: SizedBox(
                    width: size.width * 0.60,
                    child: Text(
                      bio.toString() == 'null' ? 'bio' : bio.toString(),
                      style: const TextStyle(
                        color: Color(0xffA9A9A9),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(currentUser)
                            .snapshots(),
                        builder: (context, snapshot) {
                          return (snapshot.connectionState ==
                                  ConnectionState.waiting)
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.06,
                                    ),
                                    counter(
                                        snapshot.data!['recepts'] == null
                                            ? '0'
                                            : snapshot.data!['recepts'].length,
                                        'Recipes'),
                                    SizedBox(
                                      width: size.width * 0.2,
                                    ),
                                    counter(
                                        snapshot.data!['saved'] == null
                                            ? '0'
                                            : snapshot.data!['saved'].length,
                                        'Saved'),
                                    SizedBox(
                                      width: size.width * 0.2,
                                    ),
                                    counter(snapshot.data!['totalLikes'] ?? '0',
                                        'Likes'),
                                  ],
                                );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: const [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, bottom: 5, top: 5),
                              child: TabBar(
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.w600),
                                tabs: [
                                  Tab(
                                    text: 'Recipes',
                                  ),
                                  Tab(
                                    text: 'Saved Recipes',
                                  )
                                ],
                                unselectedLabelColor: Colors.black,
                                overlayColor:
                                    MaterialStatePropertyAll(Colors.white),
                                labelColor: Colors.orange,
                                indicatorColor: Colors.orange,
                                indicatorWeight: 2,
                                padding: EdgeInsets.all(4),
                                // indicator: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(5),
                                //   color: Colors.orange,
                                // ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: TabBarView(
                        children: [
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(UserId)
                                .snapshots(),
                            builder: (context, snapshots) {
                              return (snapshots.connectionState ==
                                      ConnectionState.waiting)
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : snapshots.data!['recepts'] != null
                                      ? SizedBox(
                                          height: 200,
                                          child: GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: snapshots
                                                .data!['recepts']!.length,
                                            itemBuilder: (contex, index) {
                                              var data = snapshots
                                                  .data!['recepts'][index];
                                              var dataUser = snapshots.data;
                                              return showOwnPosts(
                                                  data, dataUser);
                                            },
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3),
                                          ))
                                      : const SizedBox();
                            },
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(UserId)
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
                                                    crossAxisCount: 3),
                                          ))
                                      : const SizedBox();
                            },
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

counter(count, String field) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          field,
          style: const TextStyle(color: Color(0xffA9A9A9)),
        ),
      ),
      Text(
        count.toString(),
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
      )
    ],
  );
}

var count;
List lsOfOwnRecipes = [];
Widget showOwnPosts(dataaId, dataUser) {
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

                if (data['id'] == dataaId) {
                  lsOfOwnRecipes.add(dataaId);

                  return GestureDetector(
                    onTap: () async {
                      DocumentSnapshot userDoc = await FirebaseFirestore
                          .instance
                          .collection('users')
                          .doc(data['userId'])
                          .get();

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => recipeOpen(
                            postData: data.data(), userData: userDoc),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      child: Container(
                        height: 120.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    CachedNetworkImageProvider(data['photo'])),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                      ),
                    ),
                  );
                }

                return const SizedBox();
              });
    },
  );
}



  //  Shimmer.fromColors(
  //       highlightColor: Colors.white,
  //       baseColor: Colors.grey.shade400,
  //       child: cardView(contex, posts[index]),
  //       period: Duration(seconds: time),
  //       enabled: true,
  //     );