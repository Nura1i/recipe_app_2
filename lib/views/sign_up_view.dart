import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/blocs/login/sign_up_cubit.dart';

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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        //reverse: true,
        //physics: NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              SizedBox(
                height: size.height,
                child: Image.asset(
                  'assets/images/wallpaper.jpg',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 70,
                              sigmaY: 70,
                              tileMode: TileMode.mirror),
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
                                      'SIGN UP',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(.8),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: component(
                                      Icons.account_circle_outlined,
                                      'Ismingizni kiriting...',
                                      false,
                                      false,
                                      false,
                                      controllerUsername),
                                ),
                                component(Icons.email, 'Email kiriting', false,
                                    false, false, controllerEmail),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: component(Icons.lock, "Parol qo'ying",
                                      false, false, false, controllerPassword),
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
                                      color: Colors.black.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        SignUpCubit().signUp(context);
                                      },
                                      child: const Text(
                                        "Ro'yhatdan o'tish",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
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
                    const Expanded(
                      child: SizedBox(),
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
      height: size.width / 8,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.white.withOpacity(.9),
        ),
        keyboardType:
            !isNumber ? TextInputType.emailAddress : TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.8),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
