import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/admin/select_recipe.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

class adminPanel extends StatefulWidget {
  const adminPanel({super.key});

  @override
  State<adminPanel> createState() => _adminPanelState();
}

class _adminPanelState extends State<adminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('BlokRecipes').snapshots(),
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var blockData = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          DocumentSnapshot<Map<String, dynamic>>? userData;
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(blockData['userId'])
                                  .snapshots(),
                              builder: (context, snapshot) {
                                userData = snapshot.data;
                                return const Text('');
                              });
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return onSelectRecipe(
                                  recipeData: blockData,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 130.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.w,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.all(
                              const Radius.circular(15).r,
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    // Text Head Name...!
                                    SizedBox(
                                      width: 200.w,
                                      height: 20.h,
                                      child: Text(
                                        blockData["head"],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: "Lora",
                                        ),
                                      ),
                                    ),
                                    // Text Percon...!
                                    Text(
                                      "${blockData["serves"]} : ${translation(context).kishilik}",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey.shade900,
                                        fontFamily: "Lora",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    // Text Cook Time...!
                                    Text(
                                      "${translation(context).cookTime} : ${blockData["cookTime"]}",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Lora",
                                      ),
                                    )
                                  ],
                                ),
                                // Image qismi...1
                                Container(
                                  height: 110.h,
                                  width: 95.w,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    border: Border.all(
                                      width: 1.w,
                                      color: Colors.grey.shade200,
                                    ),
                                    borderRadius: BorderRadius.circular(10).r,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                        blockData['photo'],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox();
        },
      ),
    );
  }
}
