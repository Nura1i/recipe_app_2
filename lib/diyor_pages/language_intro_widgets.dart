
import 'package:flutter/material.dart';
Widget LanguageIntro(Text text1, String text2, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        text1,
        const SizedBox(
          width: 3),
        Flexible(
          child: Text(
            text2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}
