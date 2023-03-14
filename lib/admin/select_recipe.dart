import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import 'package:recipe_app/widgets/alertForDeletPost.dart';

class onSelectRecipe extends StatefulWidget {
  final recipeData;
  final userData;
  const onSelectRecipe({super.key, this.recipeData, this.userData});

  @override
  State<onSelectRecipe> createState() => _onSelectRecipeState();
}

class _onSelectRecipeState extends State<onSelectRecipe> {
  @override
  Widget build(BuildContext context) {
    String? rule;
    if (widget.recipeData['totalLike'] == 1) {
      rule = 'Boshqa kontent';
    }
    if (widget.recipeData['totalLike'] == 2) {
      rule = '18+ kontent';
    }
    if (widget.recipeData['totalLike'] == 3) {
      rule = 'Boshqa sabab';
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: [
              const Text(
                'Otmena',
                style: TextStyle(fontSize: 17),
              ),
              IconButton(
                onPressed: () async {
                  await FireDatabaseService.cancelBlokPost(widget.recipeData);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                const Text(
                  'block',
                  style: TextStyle(fontSize: 17),
                ),
                IconButton(
                    onPressed: () {
                      DeletePostDialog(context, widget.recipeData);
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.red,
                    )),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(color: Colors.red),
                        child: Text(
                          rule!,
                          style: const TextStyle(color: Colors.white),
                        ))),
              ),
              SizedBox(
                height: 40.w,
              ),
              // User toamga nom qo'yadigan qismi...!
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Center(
                  child: Text(
                    widget.recipeData['head'] ?? '',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 16.sp,
                      fontFamily: "Lora",
                      fontWeight: FontWeight.bold,
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
                      child: widget.recipeData['photo'] != null
                          ? Stack(
                              children: [
                                Image(
                                  height: double.infinity,
                                  width: double.infinity,
                                  image: CachedNetworkImageProvider(
                                    widget.recipeData['photo'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ],
                            )
                          : const Image(
                              image: AssetImage('assets/images/noImage.png'),
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
                          onTap: () {},
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.recipeData['userId'])
                                .snapshots(),
                            builder: (context, snapshot) {
                              var data = snapshot.data;
                              return (snapshot.hasData)
                                  ? CircleAvatar(
                                      radius: 20.r,
                                      foregroundImage:
                                          CachedNetworkImageProvider(
                                        data!['avatarImage'] ??
                                            'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541',
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          )),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                          width: 210.w,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.recipeData['userId'])
                                .snapshots(),
                            builder: (context, snapshot) {
                              var data = snapshot.data;
                              return (snapshot.hasData)
                                  ? Text(data!['username'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13.sp,
                                        fontFamily: "Lora",
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                  : const SizedBox();
                            },
                          )),
                    ),

                    // Like Button...!
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            '${widget.recipeData['serves'].toString()} kishilik',
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
                            'vaqti: ${widget.recipeData['cookTime'].toString()}',
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
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
                          '${widget.recipeData['text']}',
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
                        'ingredientlar ',
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
                  widget.recipeData['items'] != null
                      ? (ListView.builder(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.recipeData['items'].length,
                          itemBuilder: (context, index) {
                            Map item = widget.recipeData['items'][index];
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
        ));
  }
}
