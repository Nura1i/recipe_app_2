import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/blocs/add_cubits/add_cubit.dart';
import 'package:recipe_app/blocs/add_cubits/add_state.dart';
import 'package:recipe_app/models/ingredient%20Model/ingredient_model.dart';
import 'package:recipe_app/widgets/add_ingredients.dart';
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
    int accept = 0;
    var image;
    var time;
    List<IngredientModel>? items;

    return Scaffold(body:
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
        accept = cameraState.accept;
      }
      if (cameraState is AcceptTime) {
        time = cameraState.acceptTime;
      }
      if (cameraState is addItemState) {
        items = cameraState.items;
      }

      return add(context, cam, gal, image, choosed, accept, time, items);
    }));
  }
}

Widget add(
    BuildContext context, bool cam, gal, img, choosed, accept, time, items) {
  var size = MediaQuery.of(context).size;

  var uuid;
  String? headText;
  String? bodyText;
  String? ItemName;
  String? ItemQuanity;

  bool succes = false;
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .0,
        actions: [
          GestureDetector(
            onTap: () {
              log('tapped');
              log(itNameQuant!.toString());
              // log('Tapped NExt');

              // if (headText == null) {
              //   {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(content: Text("Main text is empty")));
              //   }
              // }
              // if (time == null) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(content: Text("time is empty")));
              // }
              // if (accept == 0) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(content: Text("serves is empty")));
              // }
              // if (bodyText == null) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(content: Text("bodyText is empty")));
              // }
              // if (headText != null &&
              //     accept != 0 &&
              //     time != null &&
              //     bodyText != null) {
              //   BlocProvider.of<CameraCubit>(context).postRecipe(
              //       context, headText, accept, time, bodyText, img, items);
              //   log('POSTED SUCCESSFULY');
              // }
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.all(11),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(100)),
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
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
                                    onPressed: () async {
                                      displayBottomSheet(context);
                                    },
                                    icon: const Icon(
                                      size: 50,
                                      Icons.camera_alt_sharp,
                                      color: Colors.red,
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
                        border: Border.all(width: 1, color: Colors.red),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      onChanged: (value) {
                        headText = value;

                        //   BlocProvider.of<CameraCubit>(context).
                      },
                      // validator: (text) {
                      //   if (text == null || text.isEmpty) {
                      //     return 'Text is empty';
                      //   }
                      //   return null;
                      // },
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 21),
                      maxLines: 2,
                      controller: controlerMain,
                      maxLength: 60,
                      showCursor: true,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, top: 2),
                        hintText: ' Main text',
                        counterText: ' ',
                        // errorText: controlerMain == null
                        //     ? 'Value Can\'t Be Empty'
                        //     : null,
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
                      height: size.height / 13.h,
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
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Serves',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                padding: const EdgeInsets.only(
                                    left: 13, right: 13, bottom: 8, top: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child:
                                    Text(accept == 0 ? '0' : accept.toString()),
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
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: Container(
                      width: size.width / 0.7.w,
                      height: size.height / 13.h,
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
                              width: 27,
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Cook Time',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                padding: const EdgeInsets.only(
                                    left: 13, right: 13, bottom: 8, top: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                    time != null ? '$time'.toString() : '0'),
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
                    // height: size.height / 6.h,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      onChanged: (value) {
                        bodyText = value;
                        //   BlocProvider.of<CameraCubit>(context).
                      },
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 21),
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
                          // BlocProvider.of<CameraCubit>(context)
                          //     .getItmInd(index);

                          return items[index].widget;
                        })
                    : const SizedBox(),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () {
                      final uuid = const Uuid().v1();
                      final TextEditingController controllerItemName =
                          TextEditingController();
                      final TextEditingController controllerItemAmount =
                          TextEditingController();
                      log(uuid.toString());
                      BlocProvider.of<CameraCubit>(context).addItem(context,
                          uuid, controllerItemName, controllerItemAmount);
                    },
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 17,
                        ),
                        Icon(Icons.add),
                        Text('Add new Ingredient')
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            choosed == true ? choosePers(context, accept) : const SizedBox()
          ]),
        ),
      ));
}
