import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/login/sign_up_cubit.dart';
import 'package:recipe_app/pages/sign_in_page.dart';
import 'package:recipe_app/pages/sign_up_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/widgets/pageAnimationFade.dart';

signUpView(BuildContext context, resultt, loading, passwordObse) {
  Size size = MediaQuery.of(context).size;

  return Scaffold(
    backgroundColor: Colors.white,
    resizeToAvoidBottomInset: true,
    body: SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  child: Image.asset(
                    'assets/images/wallpaper.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      border: Border.all(
                        width: 1,
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 2,
                          sigmaY: 2,
                          tileMode: TileMode.mirror,
                        ),
                        child: SizedBox(
                          width: size.width * .9,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.width * .12,
                                  bottom: size.width * .05,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    translation(context).signup,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: component(
                                  context,
                                  Icons.account_circle_outlined,
                                  translation(context).enterYourName,
                                  false,
                                  false,
                                  false,
                                  signUpUsername,
                                  false,
                                ),
                              ),
                              component(
                                context,
                                Icons.email,
                                translation(context).enterEmail,
                                false,
                                false,
                                false,
                                signUpEmail,
                                false,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: component(
                                  context,
                                  Icons.lock,
                                  translation(context).enterAPassword,
                                  false,
                                  false,
                                  false,
                                  signUpPassword,
                                  true,
                                ),
                              ),
                              SizedBox(height: size.width * .1),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    bottom: size.width * .05,
                                  ),
                                  height: size.width / 8,
                                  width: size.width / 1.25,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(.7),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (signUpUsername.text == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                duration: Duration(seconds: 1),
                                                elevation: 100,
                                                shape: StadiumBorder(),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                    bottom: 40,
                                                    right: 20,
                                                    left: 20),
                                                backgroundColor: Colors.green,
                                                content:
                                                    Text("Username is empty")));
                                        return;
                                      }
                                      if (signUpEmail.text == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                duration: Duration(seconds: 1),
                                                elevation: 100,
                                                shape: StadiumBorder(),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                    bottom: 40,
                                                    right: 20,
                                                    left: 20),
                                                backgroundColor: Colors.green,
                                                content:
                                                    Text("Email is empty")));
                                        return;
                                      }
                                      if (!signUpEmail.text
                                              .contains('@mail.ru') &&
                                          !signUpEmail.text
                                              .contains('@gmail.com')) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                duration: Duration(seconds: 1),
                                                elevation: 100,
                                                shape: StadiumBorder(),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                    bottom: 40,
                                                    right: 20,
                                                    left: 20),
                                                backgroundColor: Colors.green,
                                                content:
                                                    Text("Bad format Email")));
                                        return;
                                      }
                                      if (signUpPassword.text == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                duration: Duration(seconds: 1),
                                                elevation: 100,
                                                shape: StadiumBorder(),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                    bottom: 40,
                                                    right: 20,
                                                    left: 20),
                                                backgroundColor: Colors.green,
                                                content:
                                                    Text("Password is empty")));
                                        return;
                                      }
                                      if (signUpPassword.text.length < 6) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                duration: Duration(seconds: 1),
                                                elevation: 100,
                                                shape: StadiumBorder(),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                    bottom: 40,
                                                    right: 20,
                                                    left: 20),
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    "Password is less then 6 characters")));
                                        return;
                                      }
                                      if (signUpPassword.text != '' &&
                                          signUpEmail.text != '' &&
                                          signUpUsername.text != '') {
                                        loading = true;
                                        BlocProvider.of<SignUpCubit>(context)
                                            .signUp(context);
                                      }
                                      if (resultt == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                duration: Duration(seconds: 2),
                                                elevation: 100,
                                                shape: StadiumBorder(),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                    bottom: 40,
                                                    right: 20,
                                                    left: 20),
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    "The email address is already in use by another account")));
                                      }
                                    },
                                    child: Text(
                                      translation(context).signup,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Allready has account ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: size.width * .03,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: const BeveledRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            shadowColor: Colors.red,
                            elevation: 5,
                            // padding: MaterialStateProperty.all<EdgeInsets>(
                            //     const EdgeInsets.fromLTRB(5, 0, 5, 0)),
                            // backgroundColor: MaterialStateProperty.all(
                            //   Colors.red.withOpacity(0.8),
                            // ),
                          ),
                          child: Text(
                            translation(context).signIn,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () =>
                              Navigator.of(context).pushAndRemoveUntil(
                                  SizeTransition1(
                                    const SignInPage(),
                                  ),
                                  (route) => false),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.014,
                  )
                ],
              ),
            ),
            Center(
                child: loading
                    ? const CircularProgressIndicator()
                    : const SizedBox())
          ],
        ),
      ),
    ),
  );
}

Widget component(
  BuildContext context,
  IconData icon,
  String hintText,
  bool isPassword,
  bool isEmail,
  bool isNumber,
  TextEditingController controller,
  bool obsuretext,
) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.width / 7.6,
    width: size.width / 1.25,
    alignment: Alignment.center,
    padding: EdgeInsets.only(right: size.width / 30),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(.9),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(width: 1.4, color: Colors.green),
    ),
    child: TextField(
      autocorrect: false,
      enableSuggestions: false,
      maxLength: controller == signUpUsername ? 25 : 55,
      obscureText: obsuretext == true ? passwordObs : false,
      controller: controller,
      style: TextStyle(
        color: Colors.black.withOpacity(.9),
      ),
      decoration: InputDecoration(
        counterText: '',
        suffixIconConstraints: const BoxConstraints(maxHeight: 50),
        suffixIcon: obsuretext
            ? IconButton(
                onPressed: () {
                  BlocProvider.of<SignUpCubit>(context).changeIcon(passwordObs);
                },
                icon: passwordObs == true
                    ? const Icon(
                        Icons.remove_red_eye,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.black,
                      ))
            : const SizedBox(),
        prefixIcon: Icon(
          icon,
          color: Colors.green.withOpacity(.9),
        ),
        border: InputBorder.none,
        hintMaxLines: 1,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.black.withOpacity(.7),
        ),
      ),
    ),
  );
}
