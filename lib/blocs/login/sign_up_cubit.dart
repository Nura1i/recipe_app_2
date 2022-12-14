import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/blocs/login/sign_up_state.dart';
import 'package:recipe_app/pages/Menu/menu_page.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';
import 'package:uuid/uuid.dart';
import '../../models/user_model.dart';
import '../../repositories/fire_service.dart';

TextEditingController controllerUsername = TextEditingController();
TextEditingController controllerEmail = TextEditingController();
TextEditingController controllerPassword = TextEditingController();

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInit());

  signUp(BuildContext context) async {
    try {
      if (controllerEmail.text.isEmpty ||
          controllerPassword.text.isEmpty ||
          controllerUsername.text.isEmpty) return;

      final UserCredential credentional = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: controllerEmail.text, password: controllerPassword.text);
      assert(credentional.user != null);

      userModel? userMod = userModel(
          id: credentional.user!.uid,
          username: controllerUsername.text,
          email: controllerEmail.text,
          password: controllerPassword.text);

      final userSavedToDatabase =
          await FireDatabaseService.saveUserToCollection(user: userMod);
      if (credentional.user != null && userSavedToDatabase!) {
        log('Saved');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MenuPage()),
            (route) => false);
      }
      final token = const Uuid().v1();
      await Prefs.updateData<String>(key: 'email', data: controllerEmail.text);
      await Prefs.updateData<String>(
          key: 'password', data: controllerPassword.text);
      final isSaved = await Prefs.updateData<String>(key: 'token', data: token);
      if (isSaved!) {
        return token;
      }
      return null;
    } catch (e) {
      log(e.toString());
    }
  }
}
