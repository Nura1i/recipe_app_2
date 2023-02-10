import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/On%20open/profile_open.dart';

topCreator(contex, data, index) {
  List TopColors = [
    Colors.orange,
    const Color.fromARGB(255, 149, 68, 18),
    Colors.grey,
    Colors.green
  ];
  return GestureDetector(
    onTap: () {
      Navigator.of(contex).push(MaterialPageRoute(
        builder: (context) => profielOnOpen(data: data),
      ));
    },
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10.h),
          child: Container(
            width: 80.w,
            height: 110.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40.r,
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
                    fontSize: 14.sp,
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
          top: 0,
          left: 22,
          child: RotatedBox(
            quarterTurns: 4,
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.green),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: index < 3 ? TopColors[index] : Colors.green,
              ),
              child: Text(
                '  TOP',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Lora",
                  fontSize: 12.sp,
                  //color: Color.fromARGB(255, 14, 242, 21),
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

topCreatorForAll(contex, dataa) {
  return GestureDetector(
    onTap: () {
      Navigator.of(contex).push(MaterialPageRoute(
        builder: (context) => profielOnOpen(data: dataa),
      ));
    },
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(width: 2, color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 25,
                  foregroundImage: CachedNetworkImageProvider(dataa[
                          'avatarImage'] ??
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  dataa['username'] ?? 'username',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lora",
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
