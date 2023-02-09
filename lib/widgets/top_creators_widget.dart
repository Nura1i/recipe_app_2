import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/On%20open/profile_open.dart';

// Popular Shef Top Category...!
topCreator(contex, data) {
  return GestureDetector(
    onTap: () {
      Navigator.of(contex).push(MaterialPageRoute(
        builder: (context) => profielOnOpen(data: data),
      ));
    },
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20.h),
          child: Container(
            width: 75.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10).r,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 38.r,
                  foregroundImage: CachedNetworkImageProvider(data[
                          'avatarImage'] ??
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  data['username'] ?? 'username',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lora",
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 15.w,
          left: 25.h,
          child: RotatedBox(
            quarterTurns: 4,
            child: Container(
              padding: EdgeInsets.only(
                left: 5.h,
                right: 10.h,
              ).r,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.w,
                  color: Colors.green.shade200,
                ),
                borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(20).r,
                    bottomLeft: const Radius.circular(20).r),
                color: Colors.green,
              ),
              child: Text(
                '  TOP',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Lora",
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// See All Popular Shef Page...!
topCreatorForAll(contex, dataa) {
  return GestureDetector(
    onTap: () {
      Navigator.of(contex).push(
        MaterialPageRoute(
          builder: (context) => profielOnOpen(data: dataa),
        ),
      );
    },
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 5.h,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(
                width: 2.w,
                color: Colors.grey.shade200,
              ),
              borderRadius: BorderRadius.circular(50).r,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                CircleAvatar(
                  radius: 20.r,
                  foregroundImage: CachedNetworkImageProvider(dataa[
                          'avatarImage'] ??
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  dataa['username'] ?? 'username',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lora",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
