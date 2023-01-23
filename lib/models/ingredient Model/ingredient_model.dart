import 'package:flutter/material.dart';

class IngredientModel {
  String? uuid;
  Widget? widget;
  String? dataName;
  String? dataQuant;
  TextEditingController? textController;
  TextEditingController? quantController;
  IngredientModel(
      {required this.uuid,
      required this.widget,
      this.dataName,
      this.dataQuant,
      this.textController,
      this.quantController});

  IngredientModel copyWidth(
      {String? uuid, Widget? widget, String? dataName, String? dataQuant}) {
    return IngredientModel(
        uuid: uuid ?? this.uuid,
        widget: widget ?? this.widget,
        dataName: dataName ?? this.dataName,
        dataQuant: dataQuant ?? this.dataQuant);
  }
}

class Item {
  String? ItemName;
  String? ItemQuanity;

  Item({
    required this.ItemName,
    required this.ItemQuanity,
  });
  Map<String, dynamic> toMap() {
    return {
      'ItemName': ItemName,
      'ItemQuanity': ItemQuanity,
    };
  }
}
