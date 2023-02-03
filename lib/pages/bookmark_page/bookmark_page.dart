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
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.orange.shade600,
          title: Text(
            translation(context).recipecategory,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              fontFamily: "Lora",
            ),
          ),
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
                    color: Colors.orange.shade600,
                    height: 100.h,
                  ),
                  // AppBar tegidi umumiy Search qismi...!
                  Column(
                    children: <Widget>[
                      Container(
                        height: 120.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(40).r,
                            topRight: const Radius.circular(40).r,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text qismi...!
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Text(
                                  translation(context).findrecipe,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontFamily: "Lora",
                                      ),
                                ),
                              ),
                              // Search qismi...!
                              Container(
                                height: 40.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.03),
                                  border: Border.all(
                                    width: 1.5.w,
                                    color: Colors.orange,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                // Icon Search qismi...!
                                child: TextField(
                                  onChanged: (recipe) {
                                    searchedRecipe = recipe;
                                    BlocProvider.of<SearchCubit>(context)
                                        .recipeSearch(searchedRecipe);
                                  },
                                  decoration: InputDecoration(
                                    hintText: translation(context).search,
                                    hintStyle: TextStyle(
                                      color: Colors.orange.shade500,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Popular Category...!
              if (searchedRecipe.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text(
                    translation(context).popularcategory,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "Lora",
                        ),
                  ),
                ),

              // Popular Categoriya qismi...!
              if (searchedRecipe.isEmpty)
                AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity: closeTopContainer ? 0 : 1,
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: double.infinity,
                      alignment: Alignment.topCenter,
                      height: closeTopContainer ? 0 : 200.h,
                      child: categoriesScroller),
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
                            ScreenUtil.init(context,
                                designSize: const Size(360, 690));
                            double scale = 1.0;
                            if (topContainerr > 0.5) {
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

                        if (data.isEmpty) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.yellow,
                          );
                        }
                        if (data['head'].toString().toLowerCase().contains(
                                searchedRecipe.toLowerCase().toString())
                            // startsWith(
                            //     searchedRecipe.toLowerCase().toString())

                            ) {
                          return RecipeWidget(scale, data);
                        }
                        return const SizedBox();
                      }),
                )
            ],
          );
        }),
      ),
    );
  }

  Widget RecipeWidget(scale, recipes) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
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
                  padding: const EdgeInsets.all(20.0),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
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
              )),
        ),
      ),
    );
  }
}
