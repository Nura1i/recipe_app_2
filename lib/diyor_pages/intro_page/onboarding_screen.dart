import 'package:flutter/material.dart';
import 'package:recipe_app/diyor_pages/intro_language_page.dart';
import 'package:recipe_app/pages/sign_up_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'intro_page_1.dart';
import 'intro_page_2.dart';
import 'intro_page_3.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // Native Splash second qismi !
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),

          /// Indicator ...!
          Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Skip ...!
                GestureDetector(
                  onTap: () {
                    _controller.animateToPage(_controller.page!.round() - 1,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeIn);
                  },
                  child: GestureDetector(
                    onTap: () {
                      _controller.animateToPage(_controller.page!.round() - 1,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeIn);
                      if (_controller.page!.round() == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LanguageIntroPage(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: size.height / 17,
                      width: size.width / 3.5,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        translation(context).back,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Lora",
                        ),
                      ),
                    ),
                  ),
                ),

                /// Dot Indicator ...!
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: JumpingDotEffect(
                    spacing: 8,
                    radius: 10,
                    dotWidth: 12,
                    dotHeight: 12,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    dotColor: Colors.black,
                    activeDotColor: Colors.green.shade300,
                  ),
                ),

                /// Next or Done ...!
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignUpPage();
                              },
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height / 17,
                          width: size.width / 3.5,
                          decoration: BoxDecoration(
                            color: Colors.green.shade300,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            translation(context).done,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Lora",
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height / 17,
                          width: size.width / 3.5,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            translation(context).next,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Lora",
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
