import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/bookmark_page/constants_page.dart';

class CategoriesScroller extends StatefulWidget {
  const CategoriesScroller({super.key});

  @override
  State<CategoriesScroller> createState() => _CategoriesScrollerState();
}

class _CategoriesScrollerState extends State<CategoriesScroller> {
  ScrollController controller = ScrollController();
  List<dynamic> responseList = CATEGORIA_DATA;
  List<dynamic> responseList2 = FOOD_DATA;

  categoria(List response) {
    List<Widget> ItemsList = [];
    ItemsList.add(const SizedBox(
      width: 10,
    ));
    response.forEach((card) {
      ItemsList.add(FittedBox(
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  //color: Color.fromARGB(255, 236, 236, 236),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                margin: const EdgeInsets.only(top: 80),
                width: 210.w,
                height: 130.h,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 60),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        card["name"],
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 130.h,
                width: 130.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/${card["image"]}",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    });
    ItemsList;
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: ItemsList.length,
        itemBuilder: (context, index) {
          return ItemsList[index];
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        categoria(responseList),
        categoria(responseList2),
      ],
    );
  }
}
