import 'dart:developer';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_app/blocs/add_cubits/add_cubit.dart';
import 'package:recipe_app/blocs/add_cubits/add_state.dart';
import 'package:recipe_app/models/ingredient%20Model/ingredient_model.dart';
import 'package:recipe_app/widgets/alert_dialog_serves.dart';
import 'package:recipe_app/widgets/bottomsheet.dart';
import 'package:uuid/uuid.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cam = false;
    var gal = false;
    bool choosed = false;
    int serves = 0;
    var image;
    var time;
    bool? load = false;
    List<IngredientModel>? items;

    return ThemeSwitchingArea(
      child: Scaffold(body:
          BlocBuilder<CameraCubit, CameraState>(builder: (context, cameraState) {
        if (cameraState is CameraOpen) {
          cam = cameraState.cameraOpen;
        }
        if (cameraState is imagePick) {
          image = cameraState.imagepick;
        }
        if (cameraState is choose) {
          choosed = cameraState.choosed;
        }
        if (cameraState is AcceptCount) {
          serves = cameraState.accept;
        }
        if (cameraState is AcceptTime) {
          time = cameraState.acceptTime;
        }
        if (cameraState is addItemState) {
          items = cameraState.items;
        }
        if (cameraState is loading) {
          load = cameraState.load;
        }
    
        return add(context, cam, gal, image, choosed, serves, time, items, load);
      })),
    );
  }
}

ScrollController scrolController = ScrollController();
String? headText;
String? bodyText;
Widget add(BuildContext context, bool cam, gal, img, choosed, serves, time,
    items, load) {
  var size = MediaQuery.of(context).size;
  TextEditingController? controlerMain;
  TextEditingController? controllerBody;
  var uuid;

  String? ItemName;
  String? ItemQuanity;
  List itNameQuant = [];
  bool succes = false;

  return GestureDetector(
    onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    },
    child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: !load,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          )),
          title: load == true
              ? Lottie.asset('assets/lottie/lf30_editor_oqvqyznb.json')
              : const SizedBox(),
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
          elevation: .0,
          actions: [
            load == false
                ? GestureDetector(
                    onTap: () {
                      if (img == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 1),
                                elevation: 100,
                                shape: StadiumBorder(),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    bottom: 40, right: 20, left: 20),
                                backgroundColor: Colors.orange,
                                content: Text("Image is empty")));
                        return;
                      }
                      if (headText == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 1),
                                elevation: 100,
                                shape: StadiumBorder(),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    bottom: 40, right: 20, left: 20),
                                backgroundColor: Colors.orange,
                                content: Text("Main text is empty")));
                        return;
                      }
                      if (time == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 1),
                                elevation: 100,
                                shape: StadiumBorder(),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    bottom: 40, right: 20, left: 20),
                                backgroundColor: Colors.orange,
                                content: Text("time is empty")));
                        return;
                      }
                      if (serves == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 1),
                                elevation: 100,
                                shape: StadiumBorder(),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    bottom: 40, right: 20, left: 20),
                                backgroundColor: Colors.orange,
                                content: Text("serves is empty")));
                        return;
                      }
                      if (bodyText == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 1),
                                elevation: 100,
                                shape: StadiumBorder(),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    bottom: 40, right: 20, left: 20),
                                backgroundColor: Colors.orange,
                                content: Text("bodyText is empty")));
                        return;
                      }

                      if (headText != null &&
                          serves != 0 &&
                          time != null &&
                          bodyText != null) {
                        List? allIngredients;
                        if (items != null) {
                          for (var element in items) {
                            itNameQuant.add(Item(
                                ItemName: element.textController.text,
                                ItemQuanity: element.quantController.text));
                          }

                          allIngredients = [
                            for (var e in itNameQuant)
                              {
                                "ItemName": e.ItemName,
                                'ItemQuantity': e.ItemQuanity
                              },
                          ];

                          log(allIngredients.toString());
                        }

                        BlocProvider.of<CameraCubit>(context).postRecipe(
                            context,
                            headText,
                            serves,
                            time,
                            bodyText,
                            img,
                            allIngredients);

                        headText = null;
                        serves = 0;
                        time = null;
                        bodyText = null;
                        items = null;
                        log('POSTED SUCCESSFULY');
                      }
                    },
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.all(11),
                      alignment: Alignment.center,
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: scrolController,
          child: SafeArea(
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.05),
                    child: const Text(
                      'Create recipe',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 20, right: 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: img != null ? null : size.height / 3.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[300],
                          ),
                          child: img != null
                              ? Image.file(
                                  img,
                                  // width: 500,
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: IconButton(
                                      onPressed: () {
                                        displayBottomSheet(context);
                                      },
                                      icon: Icon(
                                        size: 45.sp,
                                        Icons.camera_alt_sharp,
                                        color: Colors.orange,
                                      )),
                                ),
                        ),
                        img != null
                            ? Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          displayBottomSheet(context);
                                        },
                                        icon: const Icon(
                                          size: 50,
                                          Icons.camera_alt_sharp,
                                          color: Colors.white,
                                        )),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          BlocProvider.of<CameraCubit>(context)
                                              .deletePhoto();
                                        },
                                        icon: const Icon(
                                          size: 50,
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 28, right: 20, left: 20, bottom: 16),
                    child: Container(
                      width: size.width / 0.7.w,
                      height: size.height / 13.h,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.orange),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        onChanged: (value) {
                          headText = value;
                        },
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            color: Colors.black),
                        maxLines: 2,
                        controller: controlerMain,
                        maxLength: 60,
                        showCursor: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10, top: 2),
                          hintText: ' Main text',
                          counterText: ' ',
                          hintStyle: TextStyle(fontSize: 17),
                          isDense: false,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<CameraCubit>(context).isOpenServes();
                      },
                      child: Container(
                        width: size.width / 0.7.w,
                        height: size.height / 16.h,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                            leading: Container(
                              height: 37,
                              width: 37,
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                'assets/svg/People.svg',
                                width: 30,
                                height: 30,
                                color: Colors.orange,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Serves',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: const EdgeInsets.only(
                                      left: 13, right: 13, bottom: 8, top: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    serves == 0 ? '0' : serves.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<CameraCubit>(context).cookTime(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 20),
                      child: Container(
                        width: size.width / 0.7.w,
                        height: size.height / 16.h,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                            leading: Container(
                              height: 37,
                              width: 37,
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                'assets/svg/Hour.svg',
                                color: Colors.orange,
                                width: 27,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Cook Time',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: const EdgeInsets.only(
                                      left: 13, right: 13, bottom: 8, top: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    time != null ? '$time'.toString() : '0',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: size.width / 1.w,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        onChanged: (value) {
                          bodyText = value;
                        },
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            color: Colors.black),
                        maxLines: 2,
                        controller: controllerBody,
                        showCursor: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10, top: 2),
                          hintText: ' Body text',
                          counterText: ' ',
                          hintStyle: TextStyle(fontSize: 17),
                          isDense: false,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.width * 0.01, left: size.width * 0.05),
                    child: const Text(
                      'Ingredients',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // IngredientsWidget(
                  //   // controllerItemName: itemNameController,
                  //   // controllerItemQuanity: itemQuanityController,
                  //   clear: false,
                  //   uuid: const Uuid().v1(),
                  //   index: -1,
                  // ),
                  // IngredientsWidget(
                  //   // controllerItemName: itemNameController,
                  //   // controllerItemQuanity: itemQuanityController,
                  //   clear: false,
                  //   uuid: const Uuid().v1(),
                  //   index: -2,
                  // ),
                  // IngredientsWidget(
                  //   // controllerItemName: itemNameController,
                  //   // controllerItemQuanity: itemQuanityController,
                  //   clear: false,
                  //   uuid: const Uuid().v1(),
                  //   index: -3,
                  // ),
                  items != null
                      ? ListView.builder(
                          itemCount: items.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return items[index].widget;
                          })
                      : const SizedBox(),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        scrolController.jumpTo(scrolController.offset + 100);
                        final uuid = const Uuid().v1();
                        BlocProvider.of<CameraCubit>(context)
                            .addItem(context, uuid);
                      },
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 17,
                          ),
                          Icon(
                            Icons.add,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Add new Ingredient',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              choosed == true ? choosePers(context, serves) : const SizedBox()
            ]),
          ),
        )),
  );
}
