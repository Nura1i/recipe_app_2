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
  final topUsers;

  const HomeView2({super.key, required this.topUsers});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScrollController controller = ScrollController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).backgroundColor,
      // AppBar...!
      appBar: AppBar(
        scrolledUnderElevation: 7,
        shadowColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(40).r,
            bottomRight: const Radius.circular(40).r,
          ),
        ),
        backgroundColor: Colors.orange,
        elevation: .0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
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
        // Card Uzbek National Recipes..!
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, size.height * 0.28),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40).r,
              ),
              // Uzbek National Recipes See All...!
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          translation(context).milliytaom,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Lora",
                                  ),
                        ),
                        SizedBox(width: 15.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const seeAllMilliyTaom(),
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
                              SvgPicture.asset(
                                'assets/svg/Belgi.svg',
                                width: 12.w,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Uzbek National Recipes...! Cards
                  SizedBox(height: size.height * 0.24, child: builder(posts)),
                ],
              ),
            )),
      ),
      // Divider and Cards Popular Shef, Recent Added...!
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: size.height * 0.33,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      // Divider...!
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 1.h,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.black, Colors.orange],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 15,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 30,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 1.h,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.black, Colors.orange],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Top 10 Users...!
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translation(context).popularShef,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: "Lora",
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        seeAllTopCreators(topUsers: topUsers),
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
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  SvgPicture.asset(
                                    'assets/svg/Belgi.svg',
                                    width: 12.w,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      // Top 10 Users...! Cards
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .snapshots(),
                        builder: (context, snapshots) {
                          if (snapshots.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: SizedBox(),
                            );
                          }
                          return (snapshots.data == null)
                              ? const SizedBox()
                              : SizedBox(
                                  height: 125.h,
                                  child: ListView.builder(
                                    controller: controller,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: topUsers.length,
                                    itemBuilder: (context, index) =>
                                        StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(topUsers[index])
                                          .snapshots(),
                                      builder: (context, snapshots) {
                                        if (snapshots.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: SizedBox(),
                                          );
                                        }
                                        return (snapshots.data == null)
                                            ? const SizedBox()
                                            : Builder(
                                                builder: (context) {
                                                  var data = snapshots.data!;
                                                  return topCreator(
                                                      context, data, index);
                                                },
                                              );
                                      },
                                    ),
                                  ),
                                );
                        },
                      ),
                      SizedBox(height: 5.h),
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
                                    builder: (context) =>
                                        const seeAllRecentAdded(),
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
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  SvgPicture.asset(
                                    'assets/svg/Belgi.svg',
                                    width: 12.w,
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
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
