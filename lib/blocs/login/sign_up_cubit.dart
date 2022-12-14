import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/blocs/login/sign_up_state.dart';
import 'package:recipe_app/pages/Menu/menu_page.dart';
import 'package:recipe_app/pages/home_page.dart';

import '../../models/user_model.dart';
import '../../repositories/fire_service.dart';

TextEditingController controllerUsername = TextEditingController();
TextEditingController controllerEmail = TextEditingController();
TextEditingController controllerPassword = TextEditingController();

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInit());

  void signUp(BuildContext context) async {
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
        print('Saved');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
