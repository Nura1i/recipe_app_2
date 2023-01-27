import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/bookmark_page/constants_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

class CategoriesScroller extends StatefulWidget {
  const CategoriesScroller({super.key});

  @override
  State<CategoriesScroller> createState() => _CategoriesScrollerState();
}

class _CategoriesScrollerState extends State<CategoriesScroller> {
  ScrollController controller = ScrollController();

  categoria(List response) {
    final Size size = MediaQuery.of(context).size;
    List<Widget> ItemsList = [];
    ItemsList.add(
      SizedBox(width: 10.w),
    );
    for (var card in response) {
      ItemsList.add(
        FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange.shade400,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 65.w),
                  width: size.width * 0.55.w,
                  height: size.width * 0.45.w,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 60.w),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Text(
                          card["name"],
                          style: TextStyle(
                            fontSize: 28.w,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Lora",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.width * 0.35.w,
                  width: size.width * 0.35.w,
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
        ),
      );
    }
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
    List<dynamic>? responseList;
    List<dynamic>? responseList2;
    if (translation(context).all == 'All') {
      responseList = CATEGORIA_DATA_EN;
      responseList2 = CATEGORIA_DATA_DISERT_EN;
    }
    if (translation(context).all == 'Все') {
      responseList = CATEGORIA_DATA_RU;
      responseList2 = CATEGORIA_DATA_DISERT_RU;
    }
    if (translation(context).all == 'Hammasi') {
      responseList = CATEGORIA_DATA_UZ;
      responseList2 = CATEGORIA_DATA_DISERT_UZ;
    }
    return Column(
      children: [
        categoria(responseList!),
        categoria(responseList2!),
      ],
    );
  }
}
