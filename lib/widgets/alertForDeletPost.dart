import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

// Postni O'chirish qismi...!
DeletePostDialog(BuildContext context, postData) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: .0,
        title: Text(
          translation(context).deletePost,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: "Lora",
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          translation(context).deletePost2,
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: "Lora",
            fontWeight: FontWeight.bold,
          ),
        ),
        titleTextStyle: Theme.of(context).textTheme.bodySmall,
        contentTextStyle: Theme.of(context).textTheme.bodySmall,
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15).r,
          borderSide: BorderSide(color: Colors.white, width: 1.w),
        ),
        actions: [
          MaterialButton(
            color: Colors.grey.shade200,
            onPressed: () {
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
          SizedBox(
            width: 90,
            child: MaterialButton(
              color: Colors.grey.shade200,
              onPressed: () {
                FireDatabaseService.deletePost(postData, true);
                var count = 0;
                Navigator.popUntil(
                  context,
                  (route) {
                    return count++ == 2;
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translation(context).yes,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontFamily: "Lora",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(width: 10.w),
                  const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
