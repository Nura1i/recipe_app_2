import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/On%20open/into_recipe.dart';
import 'package:recipe_app/pages/profile_page/profile_page.dart';

class profielOnOpen extends StatelessWidget {
  final data;
  const profielOnOpen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.orange,
          elevation: .0,
          title: Text(
            data['username'] ?? 'username',
            style: const TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CircleAvatar(
                radius: 45,
                foregroundImage: CachedNetworkImageProvider(data[
                        'avatarImage'] ??
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                data['username'] ?? 'username',
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                data['bio'] ?? 'bio',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 85,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                counter(
                    data['recepts'] != null
                        ? data['recepts'].length.toString()
                        : '0',
                    'Recipes',
                    context),
                SizedBox(
                  width: size.width * 0.2,
                ),
                counter(
                    data['totalLikes'] != null
                        ? data['totalLikes'].length.toString()
                        : '0',
                    'Likes',
                    context),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 2,
              color: Colors.blueGrey,
            ),
            Container(
              width: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  SizedBox(
                    height: 500,
                    child: data['recepts'] != null
                        ? GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data['recepts'].length,
                            itemBuilder: (contex, index) {
                              return showPersonsPosts(
                                  data['recepts'][index], data);
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                          )
                        : const SizedBox(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget showPersonsPosts(dataaId, userdata) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('Recipes').snapshots(),
    builder: (context, snapshots) {
      return (snapshots.connectionState == ConnectionState.waiting)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                var data =
                    snapshots.data!.docs[index].data() as Map<String, dynamic>;
                if (data['id'] == dataaId) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => recipeOpen(
                          postData: data,
                          userData: userdata,
                        ),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      child: Container(
                        height: 120.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    CachedNetworkImageProvider(data['photo'])),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                      ),
                    ),
                  );
                }

                return const SizedBox();
              });
    },
  );
}
