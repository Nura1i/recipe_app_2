import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/blocs/login/sign_in_state.dart';
import 'package:recipe_app/pages/Menu/menu_page.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';
import 'package:uuid/uuid.dart';

TextEditingController controllerEmail = TextEditingController();
TextEditingController controllerPassword = TextEditingController();

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInit());

  signIn(BuildContext context) async {
    try {
      if (controllerEmail.text.isEmpty || controllerPassword.text.isEmpty) {
        return;
      }

      final UserCredential credentionall =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );
      bool? checkPassword = controllerPassword.text ==
          await Prefs.loadData<String>(key: 'password');
      bool? checkLogin =
          controllerEmail.text == await Prefs.loadData<String>(key: 'email');

      if (checkLogin && checkPassword) {
        final token = const Uuid().v1();
        final succes = await Prefs.saveData(key: 'token', data: token);
        if (succes!) return token;
      }
      if (credentionall.user != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MenuPage()),
            (route) => false);
      }
      

      return null;
    } catch (e) {
      log(e.toString());
    }
  }
}
