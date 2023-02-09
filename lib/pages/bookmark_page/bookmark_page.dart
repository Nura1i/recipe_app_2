import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/bookmark_page/categories_page.dart';
import 'package:recipe_app/pages/bookmark_page/constants_page.dart';
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
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = FOOD_DATA;
    List<Widget> listItems = [];
    for (var post in responseList) {
      listItems.add(
        Container(
          height: 130.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              const Radius.circular(20.0).r,
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      post["name"],
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Lora",
                      ),
                    ),
                    Text(
                      post["brand"],
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
                      "\$ ${post["price"]}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Lora",
                      ),
                    )
                  ],
                ),
                Image.asset(
                  "assets/images/${post["image"]}",
                  height: double.infinity,
                )
              ],
            ),
          ),
        ),
      );
    }
    setState(
      () {
        itemsData = listItems;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(
      () {
        double value = controller.offset / 135;

        setState(
          () {
            topContainer = value;
            closeTopContainer = controller.offset > 60;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.orange,
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
        body: Column(
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
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                                borderRadius: BorderRadius.circular(25).r,
                              ),
                              // Icon Search qismi...!
                              child: TextField(
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
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                controller: controller,
                itemCount: itemsData.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  ScreenUtil.init(context, designSize: const Size(360, 690));
                  double scale = 1.0;
                  if (topContainer > 0.5) {
                    scale = index + 0.5 - topContainer;
                    if (scale < 0) {
                      scale = 0;
                    } else if (scale > 1) {
                      scale = 1;
                    }
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Opacity(
                      opacity: scale,
                      child: Transform(
                        transform: Matrix4.identity()..scale(scale, scale),
                        alignment: Alignment.bottomCenter,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: itemsData[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
