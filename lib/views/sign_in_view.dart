import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/blocs/login/sign_up_cubit.dart';
import 'package:recipe_app/pages/sign_up_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/widgets/pageAnimationFade.dart';
import '../blocs/login/sign_in_cubit.dart';

// SIGN IN page...!
class SignInView extends StatelessWidget {
  final context;
  final pass;
  final UserResult;

  const SignInView({
    super.key,
    required this.context,
    this.pass,
    this.UserResult,
  });

  @override
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                        borderRadius: BorderRadius.circular(30).r,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30).r,
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
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.width * .12,
                                    bottom: size.width * .05,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      translation(context).signIn,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontFamily: "Lora",
                                      ),
                                    ),
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
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
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
                                      color: Colors.green.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(20).r,
                                      border: Border.all(
                                        width: 1.5.w,
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        // Text Email is empty...!
                                        if (signUpEmail.text == '') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration:
                                                  const Duration(seconds: 1),
                                              elevation: 100,
                                              shape: const StadiumBorder(),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: const EdgeInsets.only(
                                                bottom: 20,
                                                right: 20,
                                                left: 20,
                                              ),
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                translation(context)
                                                    .emailIsEmpty,
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
                                              behavior:
                                                  SnackBarBehavior.floating,
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
                                        BlocProvider.of<SignInCubit>(context)
                                            .signIn(
                                          context,
                                          signUpEmail,
                                          signUpPassword,
                                        );
                                        // Text There is no user record corresponding to this identifier. The user may have been deleted...!
                                        if (UserResult == false) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration:
                                                  const Duration(seconds: 2),
                                              elevation: 100,
                                              shape: const StadiumBorder(),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: const EdgeInsets.only(
                                                bottom: 20,
                                                right: 20,
                                                left: 20,
                                              ),
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                translation(context)
                                                    .thereIsNoUserRecordCorrespondingToThisIdentifierTheUserMayHaveBeendeleted,
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
                                      },
                                      // Text
                                      child: Text(
                                        translation(context).signIn,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
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
                      height: size.height * 0.22,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text Create new Account...!
                        Text(
                          translation(context).createNewAccount,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontFamily: "Lora",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.03,
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
                            // Text SIGN UP...!
                            child: Text(
                              translation(context).signup,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // SIGN UP page ga kirish qismi...!
                            onPressed: () =>
                                Navigator.of(context).pushAndRemoveUntil(
                                    SizeTransition1(
                                      const SignUpPage(),
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
        borderRadius: BorderRadius.circular(20).r,
        border: Border.all(
          width: 1.4.w,
          color: Colors.green,
        ),
      ),
      child: TextField(
        autocorrect: false,
        enableSuggestions: false,
        obscureText: obsuretext == true ? pass : false,
        controller: controller,
        style: TextStyle(
          color: Colors.black.withOpacity(.9),
          fontSize: 15.sp,
          fontFamily: "Lora",
          fontWeight: FontWeight.bold,
        ),
        keyboardType:
            !isNumber ? TextInputType.emailAddress : TextInputType.number,
        decoration: InputDecoration(
          suffixIconConstraints: const BoxConstraints(maxHeight: 50),
          suffixIcon: obsuretext
              ? IconButton(
                  onPressed: () {
                    BlocProvider.of<SignInCubit>(context).changeIcon(pass);
                  },
                  icon: pass == true
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
}
