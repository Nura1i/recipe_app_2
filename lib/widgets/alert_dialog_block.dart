import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/blocs/blockRecipe/block_cubit.dart';
import 'package:recipe_app/blocs/blockRecipe/block_state.dart';

import '../utils/shared_pref/language_prefs/preferences_2.dart';

int? blocN;

alertForBlockRecipe(context, count, recipeData) {
  return showDialog(
    context: context,
    builder: (context) {
      return BlocBuilder<blockCubit, blockState>(builder: (context, state) {
        if (state is blockRecipe) {
          blocN = state.data;
        }

        return AlertDialog(
            content: Column(
              children: [
                rulesBloc('Boshqa kontent', 1, context),
                rulesBloc('18+ kontent', 2, context),
                rulesBloc('Boshqa sabab', 3, context),
              ],
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  color: Colors.grey.shade200,
                  onPressed: () {
                    blocN = 0;
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    translation(context).cancel,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 13.sp,
                          fontFamily: "Lora",
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.grey.shade200,
                onPressed: () async {
                  await BlocProvider.of<blockCubit>(context)
                      .blockRecipeFromId(recipeData, blocN);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(milliseconds: 1000),
                      elevation: 100,
                      shape: const StadiumBorder(),
                      behavior: SnackBarBehavior.floating,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 30.h),
                      backgroundColor: Colors.red,
                      content: Text(
                        'Shikoyat yuborildi',
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
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10.w),
                    Text(
                      "Jo'natish",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontFamily: "Lora",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(width: 10.w),
                    const Icon(
                      Icons.send,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ]);
      });
    },
  );
}

rulesBloc(text, n, context) {
  return Row(
    children: [
      Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
            color: n == blocN ? Colors.red : Colors.white,
            border: Border.all(width: 1, color: Colors.red),
            shape: BoxShape.circle),
      ),
      GestureDetector(
        onTap: () {
          blocN = n;

          BlocProvider.of<blockCubit>(context).blockRecipeFromRules(blocN);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(5),
            child: Text(text),
          ),
        ),
      ),
    ],
  );
}
