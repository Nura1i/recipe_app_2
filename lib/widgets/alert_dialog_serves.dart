import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/blocs/add_cubits/add_cubit.dart';
import 'package:recipe_app/pages/add_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

// Serves Page...!
Widget choosePers(ctx, count) {
  return AlertDialog(
    insetPadding: EdgeInsets.only(
      top: scrolController.offset < 0 ? 100 : scrolController.offset + 50,
      left: 40,
      right: 40,
    ),
    actions: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 25.h),
        height: 280.h,
        width: 350.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(17).r,
            topRight: const Radius.circular(17).r,
            bottomLeft: const Radius.circular(35).r,
            bottomRight: const Radius.circular(35).r,
          ),
        ),
        // Text Index "Person"...!
        child: Column(
          children: [
            BlocProvider.of<CameraCubit>(ctx).acceptCount(ctx, count),
            Expanded(
              child: ListWheelScrollView.useDelegate(
                physics: const FixedExtentScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                onSelectedItemChanged: (index) {
                  final player = AudioPlayer();
                  player.play(AssetSource('sounds/choosingNumber.wav'),
                      volume: 0.1);
                  player.stop();

                  count = index;

                  BlocProvider.of<CameraCubit>(ctx).acceptCount(ctx, count);
                },
                perspective: 0.002,
                diameterRatio: 0.9,
                itemExtent: 30,
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (ctx, int index) {
                    if (index < 0 || index > 30) {
                      return null;
                    }
                    return Container(
                      width: 230.w,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$index  ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                translation(ctx).personn,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      // text Button "Accept"...!
      TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.orange),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () {
          BlocProvider.of<CameraCubit>(ctx).isCloseServes();
        },
        child: Text(
          translation(ctx).accept,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontFamily: "Lora",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
