import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/dropdownbutton.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/croppPage.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/widgets.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 1,
          title: Text(controllerUserName!.text.toString(),
              style: Theme.of(context).textTheme.bodySmall),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: dropdown(context),
            ),
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .snapshots(),
                    builder: (_, snapshot) {
                      var data = snapshot.data;
                      return (snapshot.connectionState ==
                              ConnectionState.waiting)
                          ? const SizedBox()
                          : Container(
                              color: Theme.of(_).backgroundColor,
                              // const Color.fromARGB(255, 201, 187, 146),
                              padding: const EdgeInsets.only(
                                  left: 16, top: 25, right: 16),
                              child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  Text(
                                    "Edit Profile",
                                    style: Theme.of(_).textTheme.titleLarge,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                      child: Stack(
                                    children: [
                                      Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    const CropperScreenn(),
                                              ));
                                            },
                                            child: Container(
                                              width: 130,
                                              height: 130,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 4,
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        spreadRadius: 2,
                                                        blurRadius: 10,
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset:
                                                            const Offset(0, 10))
                                                  ],
                                                  shape: BoxShape.circle,
                                                  image: data!['avatarImage'] !=
                                                          null
                                                      ? DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              data[
                                                                  'avatarImage']))
                                                      : const DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                                          ))),
                                            ),
                                          ),
                                          Positioned(
                                              bottom: 0,
                                              right: 0,
                                              left: 90,
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    width: 4,
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                  ),
                                                  color: Colors.green,
                                                ),
                                                child: const Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buildTextField(context, 'UserName', ' UserName',
                    controllerUserName!, true, true),
                buildTextField(
                    context, 'Bio', ' Bio', controllerBio!, false, true),
                buildTextField(
                    context, 'Email', ' Email', controllerEmail!, true, false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        disabledTextColor: Theme.of(context).backgroundColor,
                        color: Colors.green,
                        child: const Text('Saved'),
                        onPressed: () async {
                          yourProfileSetting();
                          Navigator.of(context).pop();
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
