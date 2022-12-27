import 'package:flutter/material.dart';

// Counter
counter(String count, String field) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          field,
          style: const TextStyle(color: Color(0xffA9A9A9)),
        ),
      ),
      Text(
        count,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      )
    ],
  );
}
