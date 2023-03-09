import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/widgets/recent_added.dart';
import 'package:recipe_app/widgets/top_creators_widget.dart';

// Uzbek National Recipes See All Page...!
class seeAllMilliyTaom extends StatelessWidget {
  const seeAllMilliyTaom({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          scrolledUnderElevation: 10,
          toolbarHeight: 50.h,
          shadowColor: Colors.orange,
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(40).r,
              bottomRight: const Radius.circular(40).r,
            ),
          ),
          title: Text(
            translation(context).milliytaom,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: "Lora",
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: builderAll(posts),
          ),
        ],
      ),
    );
  }
}

// Recent Added See All Page...!
class seeAllRecentAdded extends StatelessWidget {
  const seeAllRecentAdded({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          scrolledUnderElevation: 10,
          toolbarHeight: 50.h,
          shadowColor: Colors.orange,
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(30).r,
              bottomRight: const Radius.circular(30).r,
            ),
          ),
          title: Text(
            translation(context).recentAddedRecipes,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Lora",
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: ListView(
          children: [
            SizedBox(
              height: 5.h,
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Recipes').snapshots(),
              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshots.data!.docs[index].data()
                              as Map<String, dynamic>;

                          return recentAddedForAll(context, data);
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                      );
              },
            ),
            SizedBox(
              height: 5.h,
            )
          ],
        ),
      ),
    );
  }
}

// See All Popular Shef See All Home Page...!
class seeAllTopCreators extends StatelessWidget {
  final topUsers;
  const seeAllTopCreators({super.key, required this.topUsers});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          scrolledUnderElevation: 10,
          toolbarHeight: 50.h,
          shadowColor: Colors.orange,
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(40).r,
              bottomRight: const Radius.circular(40).r,
            ),
          ),
          title: Text(
            translation(context).popularShef,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontFamily: "Lora",
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: topUsers.length,
              itemBuilder: (context, index) => StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(topUsers[index])
                    .snapshots(),
                builder: (context, snapshots) {
                  return (snapshots.connectionState == ConnectionState.waiting)
                      ? const SizedBox()
                      : Builder(
                          builder: (_) {
                            var data = snapshots.data!;
                            return topCreatorForAll(context, data);
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
