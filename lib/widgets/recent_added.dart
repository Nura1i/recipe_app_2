import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/On%20open/into_recipe.dart';

// Recent Added  Cards...!
recentAdded(contex, data) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('users')
        .doc(data['userId'])
        .snapshots(),
    builder: (context, snapshot) {
      ScreenUtil.init(context, designSize: const Size(360, 690));
      final userData = snapshot.data;

      return GestureDetector(
        onTap: () {
          Navigator.of(contex).push(
            MaterialPageRoute(
              builder: (context) =>
                  recipeOpen(postData: data, userData: userData),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Container(
            color: Colors.white,
            width: 150.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 8,
                  shadowColor: Colors.grey,
                  color: const Color.fromARGB(255, 214, 214, 214),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.circular(15).r,
                  ),
                  child: Container(
                    height: 160.h,
                    width: 190.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(data['photo']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: SizedBox(
                    width: data['head'].toString().length > 22 ? 250 : null,
                    child: Text(
                      data['head'],
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Lora",
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// Recent Added See All Page...!
recentAddedForAll(context, data) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('users')
        .doc(data['userId'])
        .snapshots(),
    builder: (context, snapshot) {
      final userData = snapshot.data;
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                recipeOpen(postData: data, userData: userData),
          ));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
          child: Container(
            height: 102.h,
            width: 140.w,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    data['photo'],
                  ),
                  fit: BoxFit.cover),
              border: Border.all(width: 1.w, color: Colors.white),
              borderRadius: BorderRadius.circular(8).r,
            ),
          ),
        ),
      );
    },
  );
}
