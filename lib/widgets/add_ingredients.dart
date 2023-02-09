import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/blocs/add_cubits/add_cubit.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

class IngredientsWidget extends StatelessWidget {
  const IngredientsWidget(
      {super.key,
      required this.clear,
      required this.uuid,
      required this.controllerName,
      required this.controllerQuant});
  @override
  final bool clear;
  final controllerName;
  final controllerQuant;
  final String uuid;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(),
        // Indgredients Text "Item name"...!
        Container(
          width: 160.w,
          height: 40.h,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(10).r,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: TextField(
              maxLength: 20,
              controller: controllerName,
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                hintText: translation(context).itemName,
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12.sp,
                  fontFamily: "Lora",
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontFamily: "Lora",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Indgredients Text "Quantity"...!
        Container(
          width: 100.w,
          height: 40.h,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.w,
              color: Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(10).r,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: TextField(
              maxLength: 20,
              controller: controllerQuant,
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                hintText: translation(context).quantity,
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12.sp,
                  fontFamily: "Lora",
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "Lora",
              ),
            ),
          ),
        ),
        // Icon Clear Button...!
        clear == true
            ? IconButton(
                onPressed: () {
                  BlocProvider.of<CameraCubit>(context)
                      .removeItem(context, uuid);
                },
                icon: Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.clear,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
