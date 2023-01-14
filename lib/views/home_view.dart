import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/pages/On%20open/into_recipe.dart';
import 'package:recipe_app/pages/On%20open/see_all.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

class HomeView2 extends StatelessWidget {
  const HomeView2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: .0,
      // ),
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
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

                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Recipes')
                            .snapshots(),
                        builder: (context, snapshots) {
                          return (snapshots.connectionState ==
                                  ConnectionState.waiting)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: snapshots.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        var data = snapshots.data!.docs[index]
                                            .data() as Map<String, dynamic>;

                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  recipeOpen(data: data),
                                            ));
                                          },
                                          child: Card(
                                            child: ListTile(
                                                title: RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: '${data['head']}',
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20)),
                                                    TextSpan(
                                                        text:
                                                            '   ${data['serves']} kishi',
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15))
                                                  ]),
                                                ),
                                                subtitle: Text(data['text']),
                                                leading: Text(data['cookTime']),
                                                trailing: data['photo'] != null
                                                    ? Image(
                                                        image: NetworkImage(
                                                            data['photo']),
                                                      )
                                                    : const SizedBox()),
                                          ),
                                        );
                                      }),
                                );
                        },
                      ),
                      // lsRecipes != null
                      //     ? ListOfRecipesWidget(lsRecipes)
                      //     : Container(
                      //         width: 100,
                      //         height: 100,
                      //         color: Colors.red,
                      //       )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
