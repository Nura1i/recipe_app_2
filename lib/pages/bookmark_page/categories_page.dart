import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/bookmark_page/constants_page.dart';
import 'package:recipe_app/pages/bookmark_page/onChoosed_categorie.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

class CategoriesScroller extends StatefulWidget {
  const CategoriesScroller({super.key});

  @override
  State<CategoriesScroller> createState() => _CategoriesScrollerState();
}

class _CategoriesScrollerState extends State<CategoriesScroller> {
  ScrollController controller = ScrollController();

  categoria(List response) {
    List<Widget> ItemsList = [];
    ItemsList.add(
      SizedBox(width: 10.w),
    );
    var item;
    for (var card in response) {
      item = card;
      ItemsList.add(
        FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(right: 10).r,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange.shade400,
                    borderRadius: BorderRadius.all(
                      const Radius.circular(30).r,
                    ),
                  ),
                  margin: EdgeInsets.only(top: 70.w),
                  width: 230.w,
                  height: 200.h,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 60).r,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Text(
                          card["name"],
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 30.sp,
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
                  width: 150.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100).r,
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
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return onChoosedCategorie(
                      categorie: response[index - 1],
                    );
                  },
                ));
              },
              child: ItemsList[index]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
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
