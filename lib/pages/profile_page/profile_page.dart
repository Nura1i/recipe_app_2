import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/pages/profile_page/profile_page_showdialog.dart';
import '../../utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/pages/profile_page/profile_page_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: .0,
        title: Text(
          translation(context).homePage,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.03),
            child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/svg/ProfileUnion.svg',
                  height: size.width * 0.015,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.015,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                // child: Container(
                //   color: Colors.red,
                // ),
              ),
              SizedBox(
                width: size.width * 0.23,
              ),
              MaterialButton(
                onPressed: () {
                  showdialogg(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.015,
                        bottom: size.height * 0.015,
                        right: size.width * 0.05,
                        left: size.width * 0.05),
                    child: Text(translation(context).settings,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 17),
            child: Text(
              'Alessandra Blair',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17.0, top: 12),
            child: SizedBox(
              width: size.width * 0.60,
              child: const Text(
                "Hello world I'm Alessandra Blair, I'm from Italy 🇮🇹 I love cooking so much!",
                style: TextStyle(
                  color: Color(0xffA9A9A9),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.10,
                    ),
                    counter('12', translation(context).recipes),
                    SizedBox(
                      width: size.width * 0.2,
                    ),
                    counter('37', translation(context).saved),
                    SizedBox(
                      width: size.width * 0.2,
                    ),
                    counter('1389', translation(context).likes),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, bottom: 5),
                          child: TabBar(
                            labelStyle:
                                const TextStyle(fontWeight: FontWeight.w600),
                            controller: tabController,
                            tabs: [
                              Tab(
                                text: translation(context).recipes,
                              ),
                              Tab(
                                text: translation(context).savedRecipes,
                              )
                            ],
                            unselectedLabelColor: Colors.red,
                            labelColor: Colors.white,
                            indicatorColor: Colors.orange,
                            indicatorWeight: 2,
                            padding: const EdgeInsets.all(4),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red,
                            ),
                          ))
                    ],
                  ),
                ),
                //   Expanded(
                //       child: Padding(
                //           padding: const EdgeInsets.all(1),
                //           child: TabBarView(
                //             controller: tabController,
                //             // Pagelar berilmagan
                //             children: const [VideoPage(), RecipeMarkPage()],
                //      )
                //    )
                //  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Diolog widgets