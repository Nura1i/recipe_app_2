import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/settings_profile.dart';
import 'package:recipe_app/pages/profile_page/tabbar_profile/create.dart';
import 'package:recipe_app/pages/profile_page/tabbar_profile/save.dart';
import 'package:recipe_app/pages/profile_page/zoom_drawer_page.dart';
import '../../utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/pages/profile_page/profile_page_widgets.dart';

final uid = FirebaseAuth.instance.currentUser!.uid.toString();

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  @override
  @override
  Widget build(BuildContext context) {
    var stream =
        FirebaseFirestore.instance.collection('users').doc(uid).snapshots();

    var size = MediaQuery.of(context).size;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: .0,
              title: Text(
                translation(context).homePage,
                style: Theme.of(context).textTheme.bodySmall,
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
                        color: Theme.of(context).iconTheme.color,
                      )),
                )
              ],
            ),
            body: StreamBuilder(
                stream: stream,
                builder: (context, snapshot) {
                  var data = snapshot.data;

                  return (snapshot.connectionState != ConnectionState.waiting)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      backgroundColor:
                                          Theme.of(context).backgroundColor,
                                      radius: 50,
                                      foregroundImage: NetworkImage(data![
                                              'avatarImage'] ??
                                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')),
                                  SizedBox(
                                    width: size.width * 0.23,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfilePage(),
                                      ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.orange),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.015,
                                              bottom: size.height * 0.015,
                                              right: size.width * 0.05,
                                              left: size.width * 0.05),
                                          child: Text('Edit profile',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(fontSize: 20))),
                                    ),
                                  )
                                ]),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 17),
                              child: Text(data['username'] ?? '',
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12, left: 17),
                              child: SizedBox(
                                width: size.width * 0.60,
                                child: data['bio'] != null
                                    ? Text(data['bio'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall)
                                    : Text('Aqlli gap yoq',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
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
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              bottom: 5,
                                              top: 5),
                                          child: TabBar(
                                            labelStyle: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                            tabs: const [
                                              Tab(
                                                text: 'Recipes',
                                              ),
                                              Tab(
                                                text: 'Saved Recipes',
                                              )
                                            ],
                                            unselectedLabelColor: Colors.orange,
                                            labelColor:
                                         Theme.of(context).focusColor,indicatorColor: Colors.orange,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: TabBarView(
                                    children: [CreateRecipe(), SavedPecipe()],
                                  )),
                            )
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                })));
  }
}
