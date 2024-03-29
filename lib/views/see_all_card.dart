import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/models/Api%20Miliy%20Taom%20Model/card_http.dart';
import 'package:recipe_app/pages/On%20open/into_card.dart';

// Uzbek National Recipes See All qismi...!
Widget seeAllView(BuildContext context, Post post) {
  ScreenUtil.init(context, designSize: const Size(360, 690));
  final cards = post;
  return ListView(
    physics: const NeverScrollableScrollPhysics(),
    children: [
      InkWell(
        highlightColor: Colors.white.withOpacity(0.4),
        splashColor: Colors.blueGrey.withOpacity(0.6),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => openedCard(cards),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 5),
          child: Card(
            elevation: 8,
            //  shadowColor: Colors.grey,
            color: Theme.of(context).colorScheme.background,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(15).r,
            ),
            child: Stack(
              children: [
                Hero(
                  tag: '${int.parse(cards.id!)}',
                  child: Image(
                    height: MediaQuery.of(context).size.height * 0.21,
                    width: MediaQuery.of(context).size.width * 0.8,
                    image: NetworkImage(post.photo!),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(5).r,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(post.name!,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 12.sp,
                                    fontFamily: "Lora",
                                    fontWeight: FontWeight.bold,
                                  )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SizedBox(
          child: Text(
            post.header!,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 12.sp,
                  fontFamily: "Lora",
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}
