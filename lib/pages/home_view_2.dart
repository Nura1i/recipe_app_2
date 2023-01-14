import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/pages/On%20open/see_all.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

class HomeView2 extends StatefulWidget {
  const HomeView2({
    super.key,
  });

  @override
  State<HomeView2> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: true,
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 64, right: 146, left: 20),
                child: Text(translation(context).findrecipe,
                    style: Theme.of(context).textTheme.bodyMedium)),
            Padding(
              padding: const EdgeInsets.only(
                  top: 28, right: 20, left: 20, bottom: 20),
              child: Container(
                width: size.width / 0.7.w,
                height: size.height / 13.h,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: const TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 13),
                    hintText: 'Search recipes',
                    isDense: false,
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(translation(context).milliytaom,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15),
                          textAlign: TextAlign.center),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const see_all(),
                          ));
                          // Navigator.of(context)
                          //     .push(SlideTransition1(const see_all()));
                        },
                        child: Row(
                          children: [
                            const Text(
                              'See All',
                              style: TextStyle(
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
              ]),
              SizedBox(height: 250, child: builder(posts)),
              SizedBox(height: 250, child: builder(posts)),
              SizedBox(height: 250, child: builder(posts))
            ],
          ),
        )
      ]),
    );
  }
}
