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
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Lora",
          ),
        ),
      ),
      body: Column(
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
                    height: 230.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40).r,
                    ),
                    child: Column(
                      children: [
                        // Uzbek National Recipes...!
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h, top: 20.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(translation(context).milliytaom,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Lora",
                                      )),
                              SizedBox(width: 10.w),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const seeAllMilliyTaom(),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      translation(context).seeAll,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Lora",
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    SvgPicture.asset('assets/svg/Belgi.svg'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Uzbek National Recipes...! Cards
                        SizedBox(height: 170.h, child: builder(posts)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Recent Add $ Top 10 Userc...!
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //Popular Shef Top 10 Users...!
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(translation(context).popularShef,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14.sp,
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
                                translation(context).seeAll,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              SvgPicture.asset('assets/svg/Belgi.svg')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Popular Shef Top 10 Users...! Cards
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
                              height: 138.h,
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
                  // Recent Added...!
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translation(context).recentAdded,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
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
                                translation(context).seeAll,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              SvgPicture.asset('assets/svg/Belgi.svg')
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
                              height: 245.h,
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
                  Container(
                    height: 35.h,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
