import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/On%20open/profile_open.dart';

// popular Shef top 10 talik Home Pagedagi Korinish qismi...!
topCreator(contex, data, index) {
  List TopColors = [
    const Color.fromARGB(255, 255, 191, 0),
    const Color.fromARGB(255, 208, 114, 51),
    const Color.fromARGB(255, 196, 192, 192),
    Colors.green
  ];
  return GestureDetector(
    onTap: () {
      Navigator.of(contex).push(
        MaterialPageRoute(
          builder: (context) => profielOnOpen(data: data),
        ),
      );
    },
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
          child: Container(
            width: 80.w,
            height: 110.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10).r,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40.r,
                  foregroundImage: CachedNetworkImageProvider(
                    data['avatarImage'] ??
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  data['username'] ?? 'username',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lora",
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 4,
          left: 20,
          child: RotatedBox(
            quarterTurns: 4,
            child: Container(
              padding: const EdgeInsets.only(right: 10, left: 3),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(20).r,
                  bottomLeft: const Radius.circular(20).r,
                ),
                color: index < 3 ? TopColors[index] : Colors.green,
              ),
              child: Text(
                '  TOP',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Lora",
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

// popular Shef See All Page qismi...!
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
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 249, 248, 248),
              border: Border.all(
                width: 1,
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(15).r,
            ),
            child: Row(
              children: [
                SizedBox(width: 10.w),
                CircleAvatar(
                  radius: 22.r,
                  foregroundImage: CachedNetworkImageProvider(
                    dataa['avatarImage'] ??
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                  ),
                ),
                SizedBox(width: 20.w),
                Text(
                  dataa['username'] ?? 'username',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 13.sp,
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
