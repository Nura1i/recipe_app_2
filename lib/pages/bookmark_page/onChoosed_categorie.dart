import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/On%20open/into_recipe.dart';

import '../../utils/shared_pref/language_prefs/preferences_2.dart';

class onChoosedCategorie extends StatelessWidget {
  final categorie;
  final categorie1;
  final categorie2;
  final categorie3;

  const onChoosedCategorie(
      {super.key,
      this.categorie,
      this.categorie1,
      this.categorie2,
      this.categorie3});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // AppBar...!
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
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
          title: Text(
            categorie['name'],
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontFamily: "Lora",
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Recipes').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var recipes = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (categorie1['name'] == recipes['categorie'] ||
                          categorie2['name'] == recipes['categorie'] ||
                          categorie3['name'] == recipes['categorie'] ||
                          categorie['name'] == recipes['categorie']) {
                        return GestureDetector(
                          onTap: () async {
                            DocumentSnapshot userDoc = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .doc(recipes['userId'])
                                .get();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return recipeOpen(
                                    postData: recipes,
                                    userData: userDoc,
                                  );
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 2.h),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 200.w,
                                          height: 20.h,
                                          child: Text(
                                            recipes["head"],
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
                                          "${recipes["serves"]} : ${translation(context).kishilik}",
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
                                          "${translation(context).cookTime} : ${recipes["cookTime"]}",
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
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 3,
                                            blurRadius: 5,
                                            offset: const Offset(
                                              0,
                                              3,
                                            ), // changes position of shadow
                                          ),
                                        ],
                                        border: Border.all(
                                          width: 1.w,
                                          color: Colors.grey.shade200,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10).r,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                            recipes['photo'],
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
                      }
                      return const SizedBox();
                    },
                  ),
                );
        },
      ),
    );
  }
}
