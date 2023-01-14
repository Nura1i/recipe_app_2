import 'package:flutter/material.dart';

class IngredientModel {
  final String uuid;
  final Widget widget;
  const IngredientModel({required this.uuid, required this.widget});
}

class Item {
  String? ItemName;
  String? ItemQuanity;
  String? uuid;
  Item({required this.ItemName, required this.ItemQuanity, required this.uuid});
  Map<String, dynamic> toMap() {
    return {
      'ItemName': ItemName,
      'ItemQuanity': ItemQuanity,
      'uuid': uuid,
    };
  }
}
