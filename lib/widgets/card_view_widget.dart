import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/models/Api%20Miliy%20Taom%20Model/card_http.dart';
import 'package:recipe_app/pages/On%20open/into_card.dart';

// Uzbek National recipes Homedagi ko'rinish qismi...!
Widget cardView(BuildContext context, Post post) {
  final cards = post;
  return Column(
    children: [
      InkWell(
        onLongPress: () {},
        radius: 10000,
        borderRadius: BorderRadius.circular(15).r,
        highlightColor: Colors.white.withOpacity(0.4),
        splashColor: Colors.red.withOpacity(0.1),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => openedCard(cards),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Card(
            elevation: 8,
            shadowColor: Colors.grey,
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(20).r,
            ),
            child: Stack(
              children: [
                Hero(
                  tag: '${int.parse(post.id!)}',
                  child: Image(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 0.8,
                    image: CachedNetworkImageProvider(post.photo!),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8).r,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        post.name!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontFamily: "Lora",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.78,
        height: MediaQuery.of(context).size.height * 0.04,
        child: Text(
          post.header!,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
            fontFamily: "Lora",
            fontSize: 10.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
