import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/pages/On%20open/see_all.dart';

import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/widgets/recent_added.dart';
import 'package:recipe_app/widgets/top_creators_widget.dart';

var allRecipes;

class HomeView2 extends StatelessWidget {
  const HomeView2({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // AppBar...!
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: .0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        centerTitle: true,
        title: Text(
          'Cooking Uno',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Lora",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 100.h,
                  color: Colors.orange,
                ),
                Column(
                  children: [
                    Container(
                      height: 225.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40).r,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Uzbek National Recipes...! Cards
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(translation(context).milliytaom,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 16.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Lora",
                                        )),
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) => const see_all(),
                                //       ),
                                //     );
                                //   },
                                //   child: Row(
                                //     children: [
                                //       Text(
                                //         'See All',
                                //         style: TextStyle(
                                //           fontSize: 14.sp,
                                //           fontWeight: FontWeight.bold,
                                //           fontFamily: "Lora",
                                //           color: Colors.red,
                                //         ),
                                //       ),
                                //       // IconButton(
                                //       //   onPressed: () {},
                                //       //   icon: SvgPicture.asset(
                                //       //     'assets/svg/Belgi.svg',
                                //       //     width: 20.w,
                                //       //   ),
                                //       //   color: Colors.red,
                                //       // ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          // Uzbek National Recipes...! Cards
                          SizedBox(
                            height: 170.h,
                            child: builder(posts),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Recent Added...!
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Added',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Lora",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const seeAllRecentAdded(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/svg/Belgi.svg',
                                  width: 20.w,
                                ),
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Recent Added...! Cards
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Recipes')
                        .snapshots(),
                    builder: (context, snapshots) {
                      return (snapshots.connectionState ==
                              ConnectionState.waiting)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
                              height: 190.h,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshots.data!.docs.length,
                                itemBuilder: (context, index) {
                                  allRecipes = snapshots.data!.docs[index]
                                      .data() as Map<String, dynamic>;

                                  return recentAdded(context, allRecipes);
                                },
                              ),
                            );
                    },
                  ),
                  // Top 10 Users...!
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(translation(context).milliytaom,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: "Lora",
                                    ),
                            textAlign: TextAlign.center),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const seeAllTopCreators(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/svg/Belgi.svg',
                                  width: 20.w,
                                ),
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Top 10 Users...! Cards
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshots) {
                      return (snapshots.connectionState ==
                              ConnectionState.waiting)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
                              height: 150.h,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshots.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var data = snapshots.data!.docs[index].data()
                                      as Map<String, dynamic>;

                                  return topCreator(context, data);
                                },
                              ),
                            );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
