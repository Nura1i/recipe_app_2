import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/widgets/recent_added.dart';
import 'package:recipe_app/widgets/top_creators_widget.dart';

class seeAllMilliyTaom extends StatelessWidget {
  const seeAllMilliyTaom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.red.withOpacity(0.6),
          title: const Text('All'),
          centerTitle: true,
          elevation: 10,
        ),
      ),
      body: Column(
        children: [
          Expanded(flex: 1, child: builderAll(posts)),
          // Padding(
          //   padding: const EdgeInsets.all(3),
          //   child: CircleAvatar(
          //     backgroundColor: Colors.red,
          //     radius: 21,
          //     child: SvgPicture.asset(
          //       'assets/svg/Inactive.svg',
          //       color: Colors.white,
          //       height: 30,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

class seeAllRecentAdded extends StatelessWidget {
  const seeAllRecentAdded({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          scrolledUnderElevation: 20,
          toolbarHeight: 50,
          shadowColor: Colors.orange,
          backgroundColor: Colors.orange,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
          title: const Text('Recent Added Recipes'),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Recipes')
                    .snapshots(),
                builder: (context, snapshots) {
                  return (snapshots.connectionState == ConnectionState.waiting)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: GridView.builder(
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
                                    crossAxisCount: 2),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class seeAllTopCreators extends StatelessWidget {
  final topUsers;
  const seeAllTopCreators({super.key, required this.topUsers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          scrolledUnderElevation: 20,
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
              fontSize: 20.sp,
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
