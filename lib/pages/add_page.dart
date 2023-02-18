import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/blocs/add_cubits/add_cubit.dart';
import 'package:recipe_app/blocs/add_cubits/add_state.dart';
import 'package:recipe_app/models/ingredient%20Model/ingredient_model.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/widgets/alert_dialog_serves.dart';
import 'package:recipe_app/widgets/bottomsheet.dart';
import 'package:recipe_app/pages/chooseCategorie.dart';
import 'package:uuid/uuid.dart';

String? headText;
String? bodyTextt;

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
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
    bool isPosted = false;

    return Scaffold(
      body: BlocBuilder<CameraCubit, CameraState>(
        builder: (context, cameraState) {
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
          if (cameraState is successPost) {
            isPosted = cameraState.isPosted;
          }

          return add(
              context, cam, gal, image, choosed, serves, time, items, isPosted);
        },
      ),
    );
  }
}

ScrollController scrolController = ScrollController();

Widget add(BuildContext context, bool cam, gal, img, choosed, serves, time,
    items, isPosted) {
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
      FocusScope.of(context).requestFocus(
        FocusNode(),
      );
    },
    child: Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      // AppBar...!
      appBar: AppBar(
        scrolledUnderElevation: 10,
        leading: GestureDetector(
          onTap: () {
            // controlerMain!.clear();
            // controllerBody!.clear();
            headText = null;
            bodyTextt = null;
            // itNameQuant = [];
            // items = null;

            BlocProvider.of<CameraCubit>(context).clearItems(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20.w,
          ),
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: const Radius.circular(40).r,
          ),
        ),
        title: Text(
          translation(context).createRecipe,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontFamily: "Lora",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.orange,
        elevation: .0,
        // Next ni bosganda to'ldirilmasa chiqadigan Buttonlar...!
        actions: [
          GestureDetector(
            onTap: () {
              // Next "Image Is Empty"...!
              if (img == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(milliseconds: 1000),
                    elevation: 100,
                    shape: const StadiumBorder(),
                    behavior: SnackBarBehavior.floating,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                    backgroundColor: Colors.red,
                    content: Text(
                      translation(context).imageIsEmpty,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: "Lora",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                return;
              }
              // Next "Main Text Is Empty"...!
              if (headText == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(milliseconds: 1000),
                    elevation: 100,
                    shape: const StadiumBorder(),
                    behavior: SnackBarBehavior.floating,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                    backgroundColor: Colors.red,
                    content: Text(
                      translation(context).mainTextIsEmpty,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: "Lora",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                return;
              }
              // Next "Serves Is Empty"...!
              if (serves == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(milliseconds: 1000),
                    elevation: 100,
                    shape: const StadiumBorder(),
                    behavior: SnackBarBehavior.floating,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                    backgroundColor: Colors.red,
                    content: Text(
                      translation(context).servesIsEmpty,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: "Lora",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                return;
              }
              // Next "Time Is Empty"...!
              if (time == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(milliseconds: 1000),
                    elevation: 100,
                    shape: const StadiumBorder(),
                    behavior: SnackBarBehavior.floating,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                    backgroundColor: Colors.red,
                    content: Text(
                      translation(context).timeIsEmpty,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: "Lora",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                return;
              }
              // Next "Body text Is Empty"...!
              if (bodyTextt == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(milliseconds: 1000),
                    elevation: 100,
                    shape: const StadiumBorder(),
                    behavior: SnackBarBehavior.floating,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                    backgroundColor: Colors.red,
                    content: Text(
                      translation(context).bodyTextIsEmpty,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: "Lora",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                return;
              }

              if (headText != null &&
                  serves != 0 &&
                  time != null &&
                  bodyTextt != null) {
                List? allIngredients;
                if (items != null) {
                  for (var element in items) {
                    itNameQuant.add(
                      Item(
                          ItemName: element.textController.text,
                          ItemQuanity: element.quantController.text),
                    );
                  }

                  allIngredients = [
                    for (var e in itNameQuant)
                      {"ItemName": e.ItemName, 'ItemQuantity': e.ItemQuanity},
                  ];
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return chooseCategorie(
                        allIngredients: allIngredients,
                        bodyText: bodyTextt,
                        headText: headText,
                        img: img,
                        serves: serves,
                        time: time,
                      );
                    },
                  ),
                );
                if (isPosted == true) {
                  controlerMain!.clear();
                  controllerBody!.clear();
                  headText = null;
                  bodyTextt = null;
                  allIngredients = null;
                  img = null;
                  serves = null;
                  time = null;
                  log('POSTED SUCCESSFULY And Cleaned');
                  isPosted = false;
                } else {
                  log('not posted yet await');
                }
              }
            },
            //Appbardagi Text "Next"...!
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                border: Border.all(
                  width: 1.w,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(15).r,
              ),
              width: 65.w,
              margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translation(context).next,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: "Lora",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  SizedBox(
                    width: 10.w,
                    child: SvgPicture.asset(
                      'assets/svg/Belgi.svg',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: scrolController,
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rasim qo'yadigan qismi...!
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 15.h,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: img != null ? null : size.height / 3.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15).r,
                              color: Colors.grey.shade200,
                            ),
                            child: img != null
                                ? Image.file(
                                    img,
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
                                        color: Colors.orange.shade400,
                                      ),
                                    ),
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
                                        icon: Icon(
                                          size: 50.sp,
                                          Icons.camera_alt_sharp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50.w,
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
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                    // Button Text "Main Text"...!
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 25,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(
                                width: 1.w,
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(15).r,
                            ),
                            child: TextFormField(
                              onChanged: (value) {
                                headText = value;
                              },
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontFamily: "Lora",
                              ),
                              maxLines: 2,
                              controller: controlerMain,
                              maxLength: 60,
                              showCursor: true,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10.w),
                                hintText: translation(context).mainText,
                                counterText: ' ',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12.sp,
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.bold,
                                ),
                                isDense: false,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Text "Serves" add...!
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 15.h,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<CameraCubit>(context).isOpenServes();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(
                              width: 1.w,
                              color: Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(20).r,
                          ),
                          child: ListTile(
                            leading: Container(
                              height: 35.h,
                              width: 35.w,
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10).r,
                              ),
                              child: SvgPicture.asset(
                                'assets/svg/People.svg',
                                width: 30.w,
                                height: 30.h,
                                color: Colors.orange.shade400,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    translation(context).serves,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey.shade700,
                                      fontFamily: "Lora",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10).r,
                                  ),
                                  child: Text(
                                    serves == 0 ? '0' : serves.toString(),
                                    style: TextStyle(
                                      color: Colors.orange.shade400,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Lora",
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Text "Cook Time" add...!
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<CameraCubit>(context).cookTime(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          left: 20,
                          bottom: 20,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(
                              width: 1.w,
                              color: Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(20).r,
                          ),
                          child: ListTile(
                            leading: Container(
                              height: 35.h,
                              width: 35.w,
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10).r,
                              ),
                              child: SvgPicture.asset(
                                'assets/svg/Hour.svg',
                                color: Colors.orange.shade400,
                                width: 30.w,
                                height: 30.h,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    translation(context).cookTime,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: "Lora",
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10).r,
                                  ),
                                  child: Text(
                                    time != null ? '$time'.toString() : '0',
                                    style: TextStyle(
                                      color: Colors.orange.shade400,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Lora",
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // text "Body Text" add ...!
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(
                            width: 1.w,
                            color: Colors.grey.shade400,
                          ),
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                        child: TextField(
                          onChanged: (value) {
                            bodyTextt = value;
                          },
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: "Lora",
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 4,
                          controller: controllerBody,
                          showCursor: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h,
                            ),
                            hintText: translation(context).bodyText,
                            counterText: ' ',
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade700,
                              fontFamily: "Lora",
                              fontWeight: FontWeight.bold,
                            ),
                            isDense: false,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    // Text "Ingredients"...!
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 23.w,
                        vertical: 15.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            translation(context).ingredients,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey.shade700,
                              fontFamily: "Lora",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    items != null
                        ? ListView.builder(
                            itemCount: items.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return items[index].widget;
                            },
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    // Add New Ingredient + Text qismi...!
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 45.w),
                      child: Container(
                        height: 40.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          border: Border.all(
                            width: 1.w,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(15).r,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            scrolController
                                .jumpTo(scrolController.offset + 100);
                            final uuid = const Uuid().v1();
                            BlocProvider.of<CameraCubit>(context)
                                .addItem(context, uuid);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                translation(context).addNewIngredient,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2.w, color: Colors.white),
                                  borderRadius: BorderRadius.circular(30).r,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                choosed == true ? choosePers(context, serves) : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
