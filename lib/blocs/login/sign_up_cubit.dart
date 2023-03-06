import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/blocs/login/sign_up_state.dart';
import 'package:recipe_app/pages/Menu/menu_page.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';
import 'package:uuid/uuid.dart';
import '../../models/user Model/user_model.dart';
import '../../repositories/services/fire_service.dart';

TextEditingController signUpUsername = TextEditingController();
TextEditingController signUpEmail = TextEditingController();
TextEditingController signUpPassword = TextEditingController();

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInit());

  changeIcon(check) {
    check = !check;
    emit(passwordCheck(check));
  }

  // checkEmail() {
  //   result = false;
  //   emit(alreadyHasAccount(result));
  // }

  signUp(BuildContext context) async {
    try {
      // log('loading');
      // isLoading = true;
      // emit(SignUpLoading(isLoading));
      if (signUpUsername.text.isEmpty &&
          signUpPassword.text.isEmpty &&
          signUpEmail.text.isEmpty) return;

      final UserCredential credentional = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: signUpEmail.text, password: signUpPassword.text);

      assert(credentional.user != null);

      userModel? userMod = userModel(
          id: credentional.user!.uid,
          username: signUpUsername.text,
          email: signUpEmail.text,
          password: signUpPassword.text);

      final userSavedToDatabase =
          await FireDatabaseService.saveUserToCollection(user: userMod);

      if (credentional.user != null && userSavedToDatabase!) {
        log('Saved');

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MenuPage()),
            (route) => false);
      }
      final token = const Uuid().v1();
      await Prefs.updateData<String>(key: 'email', data: signUpEmail.text);
      await Prefs.updateData<String>(
          key: 'password', data: signUpPassword.text);
      final isSaved = await Prefs.updateData<String>(key: 'token', data: token);
      if (isSaved!) {
        return token;
      }

      return null;
    } catch (e) {
      log(e.toString());
      if (e.toString() ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        result = true;
        emit(alreadyHasAccount(result));
      }
      Timer(const Duration(seconds: 2), () {
        result = false;
        emit(alreadyHasAccount(result));
      });
    }
  }
}

bool isLoading = false;
bool? result = false;
