import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/settings_profile.dart';
import 'package:recipe_app/pages/profile_page/zoom_drawer_page.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import '../../utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/pages/profile_page/profile_page_widgets.dart';

import '../bookmark_page/recipe_page.dart';
import '../bookmark_page/video_pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController tabController1;
  @override
  void initState() {
    tabController1 = TabController(length: 2, vsync: this);
    // tabController1.addListener(() {
    //   setState(() {});
    // }
    // );
    super.initState();
  }

  // @override
  // void dispose() {
  //   tabController1.dispose();
  //   super.dispose();
  // }
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
                onPressed: () {
                  z.toggle!();
                },
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            CircleAvatar(
              foregroundImage: avatarImage != null
                  ? NetworkImage(avatarImage!)
                  : const NetworkImage('asd'),
              radius: 50,
              backgroundColor: Colors.grey,
            ),
            SizedBox(
              width: size.width * 0.23,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                ));
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
                    child: const Text(
                      'Edit profile',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 17),
            child: username1111 != null
                ? Text(
                    username1111!,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            // style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17.0, top: 12),
            child: SizedBox(
              width: size.width * 0.60,
              child: const Text(
                'Hello world I’m Alessandra Blair, I’m from Italy 🇮🇹 I love cooking so much!',
                style: TextStyle(
                  color: Color(0xffA9A9A9),
                ),
              ),
            ),
          ),
          Column(
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
                  counter('12', 'Recipes'),
                  SizedBox(
                    width: size.width * 0.2,
                  ),
                  counter('37', 'Saved'),
                  SizedBox(
                    width: size.width * 0.2,
                  ),
                  counter('1389', 'Likes'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 5, top: 5),
                        child: TabBar(
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
                          controller: tabController1,
                          tabs: const [
                            Tab(
                              text: 'Recipes',
                            ),
                            Tab(
                              text: 'Saved Recipes',
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
                        )),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(1),
                child: TabBarView(
                  controller: tabController1,
                  children: const [VideoPage(), RecipeMarkPage()],
                )),
          )
        ],
      ),
    );
  }
}
