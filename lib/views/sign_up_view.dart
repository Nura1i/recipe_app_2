import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/blocs/login/sign_up_cubit.dart';
import 'package:recipe_app/pages/sign_in_page.dart';
import 'package:recipe_app/pages/sign_up_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/widgets/pageAnimationFade.dart';

// Sign Up View Page qismi...!
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
            // Imeges qismi Backround...!
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
                        width: 1.w,
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(50).r,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50).r,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 2,
                          sigmaY: 2,
                          tileMode: TileMode.mirror,
                        ),
                        // Contanier size...!
                        child: SizedBox(
                          width: size.width * .9,
                          child: Column(
                            children: [
                              // Tepadagi Text Sign Up...!
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.width * .12,
                                  bottom: size.width * .03,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    translation(context).signup,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Lora",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              // Text Enter Your Name...!
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
                              // Text Enter Email...!
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
                              // Text Enter A Password...!
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
                              // Buttonlar Is Emti..!
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                },
                                // Button SIGN UP qismi...!
                                child: Container(
                                  margin: EdgeInsets.only(
                                    bottom: size.width * .05,
                                  ),
                                  height: size.width / 8,
                                  width: size.width / 1.25,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(.7),
                                    borderRadius: BorderRadius.circular(20).r,
                                    border: Border.all(
                                      width: 1.5.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Text User Name Is Empty....!
                                      if (signUpUsername.text == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration:
                                                const Duration(seconds: 1),
                                            elevation: 100,
                                            shape: const StadiumBorder(),
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.only(
                                              bottom: 20,
                                              right: 20,
                                              left: 20,
                                            ),
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              translation(context)
                                                  .userNameIsEmpty,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontFamily: "Lora",
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      // Text Email is empty...!
                                      if (signUpEmail.text == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration:
                                                const Duration(seconds: 1),
                                            elevation: 100,
                                            shape: const StadiumBorder(),
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.only(
                                              bottom: 20,
                                              right: 20,
                                              left: 20,
                                            ),
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              translation(context).emailIsEmpty,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontFamily: "Lora",
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      // Text Bad format Email...!
                                      if (!signUpEmail.text
                                              .contains('@mail.ru') &&
                                          !signUpEmail.text
                                              .contains('@gmail.com')) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration:
                                                const Duration(seconds: 1),
                                            elevation: 100,
                                            shape: const StadiumBorder(),
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.only(
                                              bottom: 20,
                                              right: 20,
                                              left: 20,
                                            ),
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              translation(context)
                                                  .badFormatEmail,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontFamily: "Lora",
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      // Text Password is empty...!
                                      if (signUpPassword.text == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration:
                                                const Duration(seconds: 1),
                                            elevation: 100,
                                            shape: const StadiumBorder(),
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.only(
                                              bottom: 20,
                                              right: 20,
                                              left: 20,
                                            ),
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              translation(context)
                                                  .passwordIsEmpty,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontFamily: "Lora",
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      // Text Password must be more than 6!...!
                                      if (signUpPassword.text.length < 6) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration:
                                                const Duration(seconds: 1),
                                            elevation: 100,
                                            shape: const StadiumBorder(),
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.only(
                                              bottom: 20,
                                              right: 20,
                                              left: 20,
                                            ),
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              translation(context)
                                                  .passwordMustBeMoreThan6,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontFamily: "Lora",
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      if (signUpPassword.text != '' &&
                                          signUpEmail.text != '' &&
                                          signUpUsername.text != '') {
                                        loading = true;
                                        BlocProvider.of<SignUpCubit>(context)
                                            .signUp(context);
                                      }
                                      // Text Email address is already in use by another account...!
                                      if (resultt == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration:
                                                const Duration(seconds: 2),
                                            elevation: 100,
                                            shape: const StadiumBorder(),
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.only(
                                              bottom: 20,
                                              right: 20,
                                              left: 20,
                                            ),
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              translation(context)
                                                  .theEmailAddressIsAlreadyInUseByAnotherAccount,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontFamily: "Lora",
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    // text SIGN UP...!
                                    child: Text(
                                      translation(context).signup,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
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
                      // text Allready has account...!
                      Text(
                        translation(context).allreadyhasaccount,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontFamily: "Lora",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      // ElevatedButton qismi...!
                      Container(
                        margin: EdgeInsets.only(
                          bottom: size.width * .03,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.all(
                                const Radius.circular(14).r,
                              ),
                            ),
                            shadowColor: Colors.red,
                            elevation: 5,
                          ),
                          child: Text(
                            translation(context).signIn,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // SIGN IN page ga kirish qismi...!
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
                  : const SizedBox(),
            )
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
  // Button qismi...!
  return Container(
    height: size.width / 7.6,
    width: size.width / 1.25,
    alignment: Alignment.center,
    padding: EdgeInsets.only(right: size.width / 30),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(.9),
      borderRadius: BorderRadius.circular(20).r,
      border: Border.all(
        width: 1.4.w,
        color: Colors.green,
      ),
    ),
    // Text qismi...!
    child: TextField(
      autocorrect: false,
      enableSuggestions: false,
      maxLength: controller == signUpUsername ? 25 : 55,
      obscureText: obsuretext == true ? passwordObs : false,
      controller: controller,
      style: TextStyle(
        color: Colors.black.withOpacity(.9),
        fontSize: 15.sp,
        fontFamily: "Lora",
        fontWeight: FontWeight.bold,
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
                      ),
              )
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
