import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/blocs/login/sign_up_cubit.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/views/sign_in_view.dart';
import 'package:recipe_app/widgets/pageAnimationFade.dart';

class signUpView extends StatefulWidget {
  const signUpView({super.key});

  @override
  State<signUpView> createState() => _signUpViewState();
}

class _signUpViewState extends State<signUpView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        //reverse: false,
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      translation(context).signup,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green,
                                        fontFamily: "Lora",
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: component(
                                      Icons.account_circle_outlined,
                                      translation(context).enterYourName,
                                      false,
                                      false,
                                      false,
                                      signUpUsername),
                                ),
                                component(
                                    Icons.email,
                                    translation(context).enterEmail,
                                    false,
                                    false,
                                    false,
                                    signUpEmail),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: component(
                                      Icons.lock,
                                      translation(context).enterAPassword,
                                      false,
                                      false,
                                      false,
                                      signUpPassword),
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
                                        SignUpCubit().signUp(context);
                                      },
                                      child: Text(
                                        translation(context).signup,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Lora",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    bottom: size.width * .03,
                                  ),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Colors.red.withOpacity(0.8),
                                      ),
                                    ),
                                    child: Text(
                                      translation(context).signIn,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Lora",
                                      ),
                                    ),
                                    onPressed: () => Navigator.of(context)
                                        .pushAndRemoveUntil(
                                            SizeTransition1(
                                              const SignInView(),
                                            ),
                                            (route) => false),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget component(IconData icon, String hintText, bool isPassword,
      bool isEmail, bool isNumber, TextEditingController controller) {
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
        controller: controller,
        style: TextStyle(
          color: Colors.black.withOpacity(.9),
          fontFamily: "Lora",
        ),
        keyboardType:
            !isNumber ? TextInputType.emailAddress : TextInputType.number,
        decoration: InputDecoration(
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
            fontFamily: "Lora",
          ),
        ),
      ),
    );
  }
}
