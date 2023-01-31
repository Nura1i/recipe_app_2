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

buildTextField(
  BuildContext context,
  String labelText,
  String placeholder,
  TextEditingController controller,
  bool? maxlength,
  bool? emaillength,
) {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: 25.0,
    ),
    child: TextField(
        textAlign: TextAlign.left,
        cursorColor: Colors.blueAccent,
        maxLines: maxlength == false ? 2 : 1,
        maxLength: maxlength == emaillength
            ? 15
            : emaillength == false
                ? 35
                : 50,
        style: Theme.of(context).textTheme.bodyMedium,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3, left: 2),
            labelText: labelText,
            labelStyle: Theme.of(context).textTheme.bodySmall,
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
