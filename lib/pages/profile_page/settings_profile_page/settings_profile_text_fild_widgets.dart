import 'package:flutter/material.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';

bool showPassword = false;
bool set=true;
buildTextField(
  BuildContext context,
  String labelText,
  String placeholder,
  TextEditingController controller,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0),
    child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            hintText: placeholder,
            hintStyle: Theme.of(context).textTheme.bodySmall)),
  );
}
