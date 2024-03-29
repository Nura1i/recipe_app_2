import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/blocs/search%20Page/searchCubit.dart';
import 'package:recipe_app/blocs/search%20Page/searchState.dart';
import 'package:recipe_app/pages/On%20open/into_recipe.dart';
import 'package:recipe_app/pages/bookmark_page/categories_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  final CategoriesScroller categoriesScroller = const CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainerr = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchCubit>(context).getData();
    BlocProvider.of<SearchCubit>(context)
        .scroll(controller, topContainerr, closeTopContainer);
  }

  var allRecipes;
  @override
  Widget build(BuildContext context) {
    String searchedRecipe = '';
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        // AppBar qismi...!
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              translation(context).popularcategory,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Lora",
                  ),
            ),
          ),

          //  Text(translation(context).recipecategory,
          //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
          //           fontSize: 16.sp,
          //           fontWeight: FontWeight.bold,
          //           fontFamily: "Lora",
          //         )),
        ),
        // Body qismi ...!
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, scrolState) {
            if (scrolState is scrolled) {
              controller = scrolState.controller;
            }
            if (scrolState is topContainer) {
              topContainerr = scrolState.top;
            }
            if (scrolState is closeContainer) {
              closeTopContainer = scrolState.closeCon;
            }
            if (scrolState is getRecipeData) {
              allRecipes = scrolState.data;
            }
            if (scrolState is onRecipeSearched) {
              searchedRecipe = scrolState.result;
            }
            return Column(
              children: <Widget>[
                Stack(
                  children: [
                    // AppBar tegidi contanier...!
                    Container(
                      color: Theme.of(context).colorScheme.onSecondary,
                      height: size.height * 0.1,
                    ),
                    // AppBar tegidi umumiy Search qismi...!
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(40).r,
                          topRight: const Radius.circular(40).r,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text qismi...!
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15.h),
                              child: Text(
                                translation(context).findrecipe,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Lora",
                                    ),
                              ),
                            ),
                            // Search qismi...!
                            SizedBox(
                              child: Container(
                                height: size.height * 0.06,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.03),
                                  border: Border.all(
                                    width: 1.5.w,
                                    color: Colors.orange,
                                  ),
                                  borderRadius: BorderRadius.circular(25).r,
                                ),
                                // Icon And Search qismi...!
                                child: TextField(
                                  textAlign: TextAlign.start,
                                  maxLength: 35,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  onChanged: (recipe) {
                                    searchedRecipe = recipe;
                                    BlocProvider.of<SearchCubit>(context)
                                        .recipeSearch(searchedRecipe);
                                  },
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontSize: 14.sp,
                                        fontFamily: "Lora",
                                      ),
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: translation(context).search,
                                    hintStyle: TextStyle(
                                      color: Colors.orange.shade500,
                                      fontSize: 14.sp,
                                      fontFamily: "Lora",
                                    ),
                                    isDense: false,
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.orange.shade600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Popular Categoriya qismi...!
                if (searchedRecipe.isEmpty)
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 50),
                    opacity: closeTopContainer ? 0 : 1,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 50),
                      width: size.width,
                      alignment: Alignment.topCenter,
                      height: closeTopContainer ? 0 : size.height * 0.31,
                      child: categoriesScroller,
                    ),
                  ),
                // categoriyani tegidigi opshi categoriya qismi...!
                if (searchedRecipe.isEmpty)
                  allRecipes != null
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: controller,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemCount: allRecipes!.docs.length,
                            itemBuilder: (context, index) {
                              double scale = 1.0;
                              if (topContainerr > 0.5) {
                                log('1');
                                scale = index + 0.5 - topContainerr;
                                if (scale < 0) {
                                  scale = 0;
                                } else if (scale > 1) {
                                  scale = 1;
                                }
                              }
                              final recipes = allRecipes!.docs[index].data();
                              return RecipeWidget(scale, recipes);
                            },
                          ),
                        )
                      : const SizedBox(),
                if (searchedRecipe.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: allRecipes.docs.length,
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        if (topContainerr > 0.5) {
                          scale = index + 0.5 - topContainerr;
                          if (scale < 0) {
                            scale = 0;
                          } else if (scale > 1) {
                            scale = 1;
                          }
                        }
                        final data = allRecipes.docs[index].data()
                            as Map<String, dynamic>;

                        if (data['head'].toString().toLowerCase().contains(
                                searchedRecipe.toLowerCase().toString())
                            // startsWith(
                            //     searchedRecipe.toLowerCase().toString())

                            ) {
                          return RecipeWidget(scale, data);
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget RecipeWidget(scale, recipes) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Opacity(
        opacity: scale,
        child: Transform(
          transform: Matrix4.identity()..scale(scale, scale),
          alignment: Alignment.bottomCenter,
          child: Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () async {
                DocumentSnapshot userDoc = await FirebaseFirestore.instance
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
                padding: const EdgeInsets.only(right: 5, left: 5),
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
                    color: Theme.of(context).splashColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // Text Head Name...!
                            SizedBox(
                              width: 200.w,
                              height: 20.h,
                              child: Text(recipes["head"],
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontFamily: "Lora",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                      )),
                            ),
                            // Text Percon...!
                            Text(
                                "${recipes["serves"]} : ${translation(context).kishilik}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontFamily: "Lora",
                                      fontSize: 14.sp,
                                    )),
                            SizedBox(
                              height: 30.h,
                            ),
                            // Text Cook Time...!
                            Text(
                                "${translation(context).cookTime} : ${recipes["cookTime"]}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontFamily: "Lora",
                                      fontSize: 14.sp,
                                    ))
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
            ),
          ),
        ),
      ),
    );
  }
}
