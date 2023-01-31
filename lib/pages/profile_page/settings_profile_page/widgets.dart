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

bool showPassword = false;
bool set = true;
buildTextField(
  BuildContext context,
  String labelText,
  String placeholder,
  TextEditingController controller,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0),
    child: TextField(
        style: Theme.of(context).textTheme.bodyMedium,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            hintText: placeholder,
            hintStyle: Theme.of(context).textTheme.bodySmall)),
  );
}

List<String> items = ['Delete  Image'];
Widget deleteImage() {
  return DropdownButton<String>(
    icon: const Icon(Icons.delete),
    items: const [],
    onChanged: (value) {},
  );
}
