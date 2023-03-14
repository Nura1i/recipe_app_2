import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/blocs/add_cubits/add_cubit.dart';
import 'package:recipe_app/blocs/add_cubits/add_state.dart';
import 'package:recipe_app/pages/bookmark_page/constants_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

class chooseCategorie extends StatelessWidget {
  final headText;
  final serves;
  final time;
  final bodyText;
  final img;
  final allIngredients;
  chooseCategorie(
      {super.key,
      this.allIngredients,
      this.bodyText,
      this.headText,
      this.img,
      this.serves,
      this.time});
  bool? load = false;
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

    return BlocBuilder<CameraCubit, CameraState>(
      builder: (context, cameraState) {
        if (cameraState is loadingg) {
          load = cameraState.load;
        }

        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: !load!,
              elevation: 0,
              centerTitle: true,
              title: load == false
                  ? Text(
                      translation(context).chooseCategorie,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Lora'),
                    )
                  : const Text(''),
              shadowColor: Colors.orange,
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              toolbarHeight: 40,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                load == false
                    ? chooseCategoriWidget(responseList!, context,
                        [Colors.orange, Colors.deepOrangeAccent])
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    translation(context).deserts,
                    style: const TextStyle(
                        fontFamily: 'Lora',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 2.h,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.orange,
                                Colors.white,
                              ],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 2.h,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.orange,
                                Colors.white,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                load == false
                    ? chooseCategoriWidget(responseList2!, context, [
                        Colors.red.shade400,
                        Colors.deepOrangeAccent,
                      ])
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      ),
              ],
            ));
      },
    );
  }

  chooseCategoriWidget(List response, context, List<Color> lnColor) {
    List<Widget> ItemsList = [];

    for (var card in response) {
      ItemsList.add(Padding(
        padding: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(seconds: 2),
                elevation: 100,
                shape: const StadiumBorder(),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.only(bottom: 40, right: 20, left: 20),
                backgroundColor: Colors.orange,
                content: Row(
                  children: [
                    Image(
                        height: 30,
                        width: 30,
                        image: AssetImage(
                          "assets/images/${card["image"]}",
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      card["name"],
                    ),
                  ],
                )));

            BlocProvider.of<CameraCubit>(context).postRecipe(context, headText,
                serves, time, bodyText, img, allIngredients, card['name']);
            //BlocProvider.of<CameraCubit>(context).clearItems(context);
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: lnColor),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(top: 20, left: 4),
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/${card["image"]}",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    card["name"],
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Lora",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }
    ItemsList;
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: ItemsList.length,
        itemBuilder: (context, index) {
          return ItemsList[index];
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            mainAxisExtent: 70),
      ),
    );
  }
}
