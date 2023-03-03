import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/On%20open/into_recipe.dart';

class onChoosedCategorie extends StatelessWidget {
  final categorie;
  const onChoosedCategorie({super.key, this.categorie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange.shade600,
        title: Text(
          categorie['name'],
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Lora",
          ),
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

                      if (recipes['categorie'] == categorie['name']) {
                        return GestureDetector(
                          onTap: () async {
                            DocumentSnapshot userDoc = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .doc(recipes['userId'])
                                .get();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return recipeOpen(
                                  postData: recipes,
                                  userData: userDoc,
                                );
                              },
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 130.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    const Radius.circular(20.0).r,
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withAlpha(100),
                                        blurRadius: 10.0),
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0.w, vertical: 10.h),
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
                                          width: 200,
                                          child: Text(
                                            recipes["head"],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontFamily: "Lora",
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'kishiga:  ${recipes["serves"].toString()}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.grey,
                                            fontFamily: "Lora",
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          'cookTime:  ${recipes["cookTime"]}',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Lora",
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 100.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                  recipes['photo']))),
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
