import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/blocs/login/sign_in_state.dart';
import 'package:recipe_app/pages/Menu/menu_page.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';
import 'package:uuid/uuid.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInit());

  signIn(BuildContext context, controllerEm, controllerPw) async {
    try {
      if (controllerEm.text.isEmpty || controllerPw.text.isEmpty) {
        return;
      }

      final UserCredential credentionall =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: controllerEm.text,
        password: controllerPw.text,
      );
      if (credentionall.user != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MenuPage()),
            (route) => false);
      }
      final token = const Uuid().v1();
      await Prefs.updateData<String>(key: 'email', data: controllerEm.text);
      await Prefs.updateData<String>(key: 'password', data: controllerPw.text);
      final isSaved = await Prefs.updateData<String>(key: 'token', data: token);
      if (isSaved!) {
        return token;
      }

      // bool? checkPassword =
      //     controllerPw.text == await Prefs.loadData<String>(key: 'password');
      // bool? checkLogin =
      //     controllerEm.text == await Prefs.loadData<String>(key: 'email');

      // if (checkLogin && checkPassword) {
      //   final token = const Uuid().v1();
      //   final succes = await Prefs.updateData(key: 'token', data: token);
      //   if (succes!) return token;
      // }

      return null;
    } catch (e) {
      log(e.toString());
    }
  }
}
