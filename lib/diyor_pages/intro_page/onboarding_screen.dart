// import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:recipe_app/diyor_pages/intro_page/intro_page_4.dart';
// import 'package:recipe_app/pages/login_page.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import '../diyor.dart';
// import 'intro_page_1.dart';
// import 'intro_page_2.dart';
// import 'intro_page_3.dart';

// void main() {
//   // Native Splash
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//   runApp(const MyApp());
// }

// class OnBoardingScreen extends StatefulWidget {
//   const OnBoardingScreen({Key? key}) : super(key: key);

//   @override
//   State<OnBoardingScreen> createState() => _OnBoardingScreenState();
// }

// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   @override
//   // Native Splash
//   void initState() {
//     super.initState();

//     Future.delayed(const Duration(seconds: 1))
//         .then((value) => {FlutterNativeSplash.remove()});
//   }

//   final PageController _controller = PageController();

//   bool onLastPage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           PageView(
//             physics: const BouncingScrollPhysics(),
//             controller: _controller,
//             onPageChanged: (index) {
//               setState(() {
//                 onLastPage = (index == 3);
//               });
//             },
//             children: const [
//               IntroPage1(),
//               IntroPage2(),
//               IntroPage3(),
//               IntroPage4(),
//             ],
//           ),

//           /// Indicator ...!
//           Container(
//               alignment: const Alignment(0, 0.8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   /// Skip ...!
//                   GestureDetector(
//                     onTap: () {
//                       _controller.animateToPage(_controller.page!.round() - 1,
//                           duration: const Duration(milliseconds: 350),
//                           curve: Curves.easeIn);
//                     },
//                     child: const Text('Back'),
//                   ),

//                   /// Dot Indicator ...!
//                   SmoothPageIndicator(
//                     controller: _controller,
//                     count: 4,
//                     //effect: JumpingDotEffect(),
//                   ),

//                   /// Next or Done ...!
//                   onLastPage
//                       ? GestureDetector(
//                           onTap: () {
//                             Navigator.push(context,
//                                 MaterialPageRoute(builder: (context) {
//                               return const loginPage();
//                             }));
//                           },
//                           child: const Text('Done'),
//                         )
//                       : GestureDetector(
//                           onTap: () {
//                             _controller.nextPage(
//                                 duration: const Duration(milliseconds: 350),
//                                 curve: Curves.easeIn);
//                           },
//                           child: const Text('Next'),
//                         ),
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
// }
