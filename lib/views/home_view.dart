import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/pages/On%20open/see_all.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // AppBar qismi.
      appBar: AppBar(
        backgroundColor: Colors.orange.shade600,
        elevation: 0,
        title: const Text(
          'Best Cooking App ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ScrollConfiguration(
                  behavior: const MaterialScrollBehavior()
                      .copyWith(overscroll: false),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 150.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // text
                                Text(translation(context).milliytaom,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    textAlign: TextAlign.center),
                                //Text See All qism!
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const see_all(),
                                      ),
                                    );
                                  },
                                  // See All Text
                                  child: Row(
                                    children: [
                                      Text(
                                        translation(context).seeAll,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.orange.shade400),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: SvgPicture.asset(
                                          'assets/svg/Belgi.svg',
                                          height: 13.h,
                                          color: Colors.orange.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Trending Now !!!
                          SizedBox(height: 200, child: builder(posts)),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  translation(context).trendingNow,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                //Text See All.
                                Row(
                                  children: [
                                    Text(
                                      translation(context).seeAll,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.orange.shade600),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                        'assets/svg/Belgi.svg',
                                        height: 13.h,
                                        color: Colors.orange.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 200, child: builder(posts)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // AppBar tegidigi Contanier
          Container(
            decoration: BoxDecoration(
              color: Colors.orange.shade600,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            height: 45,
          ),
          //AppBar tegidi Search qismi!
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Container(
              height: 140.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 188, 146, 146),
                    Colors.grey.withOpacity(0.98),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text qismi.
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 15,
                      right: 22,
                      left: 22,
                    ),
                    child: Text(
                      translation(context).findrecipe,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.yellow.shade100,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  //Search qismi.
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    child: Container(
                      width: size.width / 0.7.w,
                      height: size.height / 13.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.w,
                          color: Colors.orange.shade300,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      // Icon Search qismi.
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.only(top: 15),
                            hintText: translation(context).search,
                            hintStyle: TextStyle(
                              color: Colors.yellow.shade100,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            isDense: false,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.yellow.shade200,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
