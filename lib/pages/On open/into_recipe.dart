import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_app/blocs/like%20and%20saved/savedIcon_cubit.dart';
import 'package:recipe_app/blocs/like%20and%20saved/savedIcon_state.dart';
import 'package:recipe_app/pages/On%20open/profile_open.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/widgets/alertForDeletPost.dart';

// Recent Addedni ustiga bosganda kirganda ochiladigan Page...!
class recipeOpen extends StatefulWidget {
  final postData;
  final userData;

  const recipeOpen({super.key, this.postData, this.userData});

  @override
  State<recipeOpen> createState() => _recipeOpenState();
}

class _recipeOpenState extends State<recipeOpen> {
  @override
  void initState() {
    BlocProvider.of<SavedCubit>(context).saved(widget.postData);
    BlocProvider.of<SavedCubit>(context).liked(widget.postData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    bool? issSaved;
    bool? issLaked;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      // AppBar...!
      appBar: AppBar(
        actions: [
          widget.postData != null
              ? widget.postData['userId'] ==
                      FirebaseAuth.instance.currentUser!.uid
                  ? Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () {
                          DeletePostDialog(context, widget.postData);
                        },
                        child: const Icon(
                          Icons.delete_forever,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const SizedBox()
              : const SizedBox()
        ],
        scrolledUnderElevation: 10,
        toolbarHeight: 50.h,
        shadowColor: Colors.orange,
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(40).r,
            bottomRight: const Radius.circular(40).r,
          ),
        ),
        title: Text(widget.postData['categorie'] ?? '',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lora",
                )),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      // Body qismi...!
      body: BlocBuilder<SavedCubit, SavedState>(
        builder: (context, savedState) {
          if (savedState is Save) {
            issSaved = savedState.isSaved;
          }
          if (savedState is Like) {
            issLaked = savedState.isLiked;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70.w,
                  ),
                  // User toamga nom qo'yadigan qismi...!
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    child: Center(
                      child: Text(
                        widget.postData['head'] ?? '',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Lora",
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Images...!
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: GestureDetector(
                      onDoubleTap: () {},
                      child: Container(
                        height: 200.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20).r,
                          border: Border.all(
                            width: 1.w,
                            color: Colors.white,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20).r,
                          child: widget.postData['photo'] != null
                              ? Stack(
                                  children: [
                                    Hero(
                                      tag: 'detailImage',
                                      child: Image(
                                        height: double.infinity,
                                        width: double.infinity,
                                        image: CachedNetworkImageProvider(
                                          widget.postData['photo'],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) {
                                                return detailImage(context);
                                              },
                                            ),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.image_search_outlined,
                                          size: 33,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : const Image(
                                  image:
                                      AssetImage('assets/images/noImage.png'),
                                ),
                        ),
                      ),
                    ),
                  ),
                  // Profile Open Avatar, Text, Like, Saved...!
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Profile open Avatar...!
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      profielOnOpen(data: widget.userData),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              foregroundImage: CachedNetworkImageProvider(
                                widget.userData!['avatarImage'] ??
                                    'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      profielOnOpen(data: widget.userData),
                                ),
                              );
                            },
                            // Text Users...!
                            child: SizedBox(
                              width: 210.w,
                              child: Text(
                                widget.userData!['username'],
                                style:
                Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 15.sp,        
                  fontWeight: FontWeight.bold,
                                fontFamily: "Lora",
                               )
                              ),
                            ),
                          ),
                        ),
                        // Like Button...!
                        LikeButton(
                          isLiked: issLaked,
                          onTap: onLikeButtonTapped,
                          size: 33,
                          circleColor: const CircleColor(
                            start: Colors.red,
                            end: Colors.orange,
                          ),
                          bubblesColor: const BubblesColor(
                            dotPrimaryColor: Colors.orange,
                            dotSecondaryColor: Colors.red,
                          ),
                          likeBuilder: (issLaked) {
                            return issLaked
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.orange,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    size: 30,
                                  );
                          },
                        ),
                        // Saved Button...!
                        LikeButton(
                          isLiked: issSaved,
                          onTap: onBookMarkButtonTapped,
                          size: 33,
                          circleColor: const CircleColor(
                            start: Color.fromARGB(255, 96, 92, 89),
                            end: Colors.grey,
                          ),
                          bubblesColor: const BubblesColor(
                            dotPrimaryColor: Color.fromARGB(255, 96, 92, 89),
                            dotSecondaryColor: Color.fromARGB(255, 96, 92, 89),
                          ),
                          likeBuilder: (issSaved) {
                            return issSaved
                                ? const Icon(
                                    Icons.bookmark_outlined,
                                    color: Color.fromARGB(255, 96, 92, 89),
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.bookmark_border,
                                    size: 30,
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Recipes')
                            .doc(widget.postData['id'])
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            log('error');
                            return const Center(
                              child: Text('error 404 ,files not found'),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            log('waiting');
                            const Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 20,
                                  bottom: 5,
                                ),
                                child: Text(''),
                              ),
                            );
                          }
                          // Total Likes 0...!
                          return (snapshot.data != null)
                              ? Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 25,
                                      bottom: 10,
                                    ),
                                    child: Text(
                                      snapshot.data!['totalLikes'] != null
                                          ? '${translation(context).like}  ${snapshot.data!['totalLikes'].length}'
                                              .toString()
                                          : '${translation(context).like} 0',
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 12.sp,
                                        fontFamily: "Lora",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        },
                      ),
                      // Servise and CookTime...!
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Servis qismi...!
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.w,
                                  color: Colors.grey.shade300,
                                ),
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15).r,
                              ),
                              height: 30.h,
                              width: 150.w,
                              child: Text(
                                '${widget.postData['serves'].toString()} ${translation(context).kishilik}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Cook Time qismi...!
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.w,
                                  color: Colors.grey.shade300,
                                ),
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15).r,
                              ),
                              height: 30.h,
                              width: 150.w,
                              child: Text(
                                '${translation(context).time} ${widget.postData['cookTime'].toString()}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Qo'shimcha Text Qismi...!
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.w,
                              color: Colors.grey.shade300,
                            ),
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15).r,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Text(
                              '${widget.postData['text']}',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14.sp,
                                fontFamily: "Lora",
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                      // Text Ingredients...!
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 80.w),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(15).r,
                          ),
                          child: Text(
                            translation(context).ingredients,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: "Lora",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Ingredients new post...!
                      widget.postData['items'] != null
                          ? (ListView.builder(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 20),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.postData['items'].length,
                              itemBuilder: (context, index) {
                                Map item = widget.postData['items'][index];
                                List myList = item.values.toList();
                                String itemName = myList[1];
                                String itemQuant = myList[0];

                                return itemName != ''
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                          vertical: 5.h,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 120,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10.h,
                                                horizontal: 10.w,
                                              ),
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1.w,
                                                  color: Colors.grey.shade400,
                                                ),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10).r,
                                              ),
                                              child: Text(
                                                "$itemName  ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.sp,
                                                  fontFamily: "Lora",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              width: 190,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10.h,
                                                horizontal: 10.h,
                                              ),
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1.w,
                                                  color: Colors.grey.shade400,
                                                ),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10).r,
                                              ),
                                              child: Text(
                                                "$itemQuant  ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.sp,
                                                  fontFamily: "Lora",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox();
                              },
                            ))
                          : const SizedBox()
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget detailImage(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: Center(
            child: Hero(
                tag: 'detailImage',
                child: Stack(children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.95,
                      child: Image(
                          image: CachedNetworkImageProvider(
                              widget.postData['photo']))),
                  Positioned(
                      top: 30,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.expand_circle_down,
                          size: 50,
                          color: Colors.orange,
                        ),
                      ))
                ]))),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<bool> onBookMarkButtonTapped(bool isSaved) async {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    if (isSaved == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          elevation: 100,
          shape: const StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 40, right: 20, left: 20),
          backgroundColor: Colors.orange,
          content: Row(
            children: [
              Image(
                  height: 30,
                  width: 30,
                  image: CachedNetworkImageProvider(
                    widget.postData['photo'],
                  )),
              const SizedBox(
                width: 20,
              ),
              Text(
                '${widget.postData['categorie'].toString()}  |saved|',
              ),
            ],
          )));
    }
    FireDatabaseService.saved(widget.postData['id'], isSaved);
    return !isSaved;
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    FireDatabaseService.like(widget.postData['id'], isLiked);

    return !isLiked;
  }
}
