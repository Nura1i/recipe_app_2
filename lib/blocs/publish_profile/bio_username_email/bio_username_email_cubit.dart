import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app/models/user%20Model/user_model.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';

TextEditingController? controllerUserName =
    TextEditingController(text: username1111.toString());
TextEditingController? controllerBio =
    TextEditingController(text: bio.toString());
TextEditingController? controllerEmail =
    TextEditingController(text: email.toString());
Future<bool?> yourProfileSetting() async {
  userModel model = const userModel();

  try {
    model = model.copyWith(
        avatarImage: avatarImage,
        bio: controllerBio!.text,
        email: controllerEmail!.text,
        username: controllerUserName!.text);
    FireDatabaseService.updateItemCollection(usermodelll: model);

    log('your settings sets');
  } catch (e) {
    log(e.toString());
  }
  return null;
}
