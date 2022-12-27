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
        backgroundColor: Colors.purple,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(
            left: 5,
          ),
          child: Text(
            'Cooking App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text qismi.
          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, right: 22, left: 22),
            child: Text(
              translation(context).findrecipe,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          // Search qismi.
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Container(
              width: size.width / 0.7.w,
              height: size.height / 13.h,
              decoration: BoxDecoration(
                border: Border.all(width: 1.w, color: Colors.purple),
                borderRadius: BorderRadius.circular(15),
              ),
              // Icon Search qismi.
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 15),
                  hintText: translation(context).search,
                  hintStyle: const TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.w500),
                  isDense: false,
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          ),
          // Text qismlari. See all, Trending Now.
          Expanded(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 22,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // text
                    Text(translation(context).milliytaom,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
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
                      child: Row(
                        children: [
                          Text(
                            translation(context).seeAll,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.red),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/svg/Belgi.svg',
                              width: 30,
                              height: 20,
                            ),
                            color: Colors.red,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Text qisimlari. Trending Now, See All.
              Expanded(child: builder(posts)),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translation(context).trendingNow,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    //Text See All.
                    Row(
                      children: [
                        Text(
                          translation(context).seeAll,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/svg/Belgi.svg',
                            width: 30,
                            height: 20,
                          ),
                          color: Colors.red,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => Container(
                      height: 50,
                      width: 50,
                      color: Colors.red,
                    ),
                  ))
            ]),
          )
        ],
      ),
    );
  }
}
