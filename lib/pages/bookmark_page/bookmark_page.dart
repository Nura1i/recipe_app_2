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
          height: 120.w,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post["name"],
                      style: TextStyle(
                        fontSize: 28.w,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Lora",
                      ),
                    ),
                    Text(
                      post["brand"],
                      style: TextStyle(
                        fontSize: 17.w,
                        color: Colors.grey,
                        fontFamily: "Lora",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\$ ${post["price"]}",
                      style: TextStyle(
                        fontSize: 20.w,
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
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 70;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.335.w;

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
              fontSize: 20.w,
              fontWeight: FontWeight.w600,
              fontFamily: "Lora",
            ),
          ),
        ),
        // Body qismi ...!
        body: SizedBox(
          height: size.height,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  // AppBar tegidi contanier...!
                  Container(
                    color: Colors.orange.shade600,
                    height: size.height * 0.1.w,
                  ),
                  // AppBar tegidi umumiy Search qismi...!
                  Column(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.20.w,
                        width: size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text qismi...!
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  translation(context).findrecipe,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 20.w,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontFamily: "Lora",
                                      ),
                                ),
                              ),
                              // Search qismi...!
                              Container(
                                height: size.width * 0.12.w,
                                width: size.width * 1.w,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.05),
                                  border: Border.all(
                                    width: 1.5.w,
                                    color: Colors.orange,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                // Icon Search qismi...!
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: translation(context).search,
                                    hintStyle: TextStyle(
                                      color: Colors.orange.shade500,
                                      fontSize: 16.w,
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
              // Popular Category
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  translation(context).popularcategory,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20.w,
                        color: Colors.black,
                        fontFamily: "Lora",
                      ),
                ),
              ),

              // Categoriya qismi !
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: closeTopContainer ? 0 : 1,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: size.width,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer ? 0 : categoryHeight,
                    child: categoriesScroller),
              ),

              // categoriyani tegidigi opshi categoriya qismi !
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: itemsData.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    double scale = 1.0;
                    if (topContainer > 0.5) {
                      scale = index + 0.5 - topContainer;
                      if (scale < 0) {
                        scale = 0;
                      } else if (scale > 1) {
                        scale = 1;
                      }
                    }
                    return Opacity(
                      opacity: scale,
                      child: Transform(
                        transform: Matrix4.identity()..scale(scale, scale),
                        alignment: Alignment.bottomCenter,
                        child: Align(
                            heightFactor: 0.9,
                            alignment: Alignment.topCenter,
                            child: itemsData[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
